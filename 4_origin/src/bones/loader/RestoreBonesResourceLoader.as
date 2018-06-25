package bones.loader
{
   import bones.model.BoneVo;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.core.Disposeable;
   import deng.fzip.FZip;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   
   public class RestoreBonesResourceLoader extends EventDispatcher implements Disposeable
   {
       
      
      protected var _vo:BoneVo;
      
      private var _skeletonList:Array;
      
      private var _loader:Loader;
      
      private var _image:Bitmap = null;
      
      private var _atlas:XML;
      
      private var _fzip:FZip;
      
      public function RestoreBonesResourceLoader(vo:BoneVo)
      {
         super();
         _vo = vo;
         _skeletonList = [];
      }
      
      public function load() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(getLoaderPath(_vo),3);
         loader.addEventListener("complete",__onLoadComplete);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function __onLoadComplete(e:LoaderEvent) : void
      {
         e.loader.removeEventListener("complete",__onLoadComplete);
         var byteArray:ByteArray = e.loader.content;
         var fzip:FZip = new FZip();
         fzip.addEventListener("complete",__onZipParaComplete);
         fzip.loadBytes(byteArray);
      }
      
      private function __onZipParaComplete(e:Event) : void
      {
         _fzip = e.currentTarget as FZip;
         _fzip.removeEventListener("complete",__onZipParaComplete);
         _loader = new Loader();
         _loader.contentLoaderInfo.addEventListener("complete",onLoadBitmapComplete);
         var byts:ByteArray = _fzip.getFileByName(_vo.atlasName + ".png").content;
         _loader.loadBytes(byts);
      }
      
      private function onLoadBitmapComplete(e:Event) : void
      {
         _loader.contentLoaderInfo.removeEventListener("complete",onLoadBitmapComplete);
         _image = _loader.content as Bitmap;
         _fzip.close();
         _loader.unload();
         loaderComplete();
      }
      
      public function loaderComplete() : void
      {
         dispatchEvent(new Event("complete"));
      }
      
      private function getLoaderPath(vo:BoneVo) : String
      {
         var path:* = null;
         if(_vo.loadType == 1)
         {
            path = BonesLoaderManager.FLASHSITE;
         }
         else
         {
            path = BonesLoaderManager.SITE_MAIN;
         }
         return path + vo.path + vo.atlasName + vo.ext;
      }
      
      public function get image() : Bitmap
      {
         return _image;
      }
      
      public function get atlas() : XML
      {
         return _atlas;
      }
      
      public function get skeletonList() : Array
      {
         return _skeletonList;
      }
      
      public function get vo() : BoneVo
      {
         return _vo;
      }
      
      public function dispose() : void
      {
         while(_skeletonList.length)
         {
            _skeletonList.pop();
         }
         if(_image && _image.bitmapData)
         {
            _image.bitmapData.dispose();
         }
         _vo = null;
         _atlas = null;
         _image = null;
         _skeletonList = null;
         _fzip = null;
         _loader = null;
      }
   }
}
