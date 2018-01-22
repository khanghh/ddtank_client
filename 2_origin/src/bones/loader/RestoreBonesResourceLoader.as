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
      
      public function RestoreBonesResourceLoader(param1:BoneVo)
      {
         super();
         _vo = param1;
         _skeletonList = [];
      }
      
      public function load() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(getLoaderPath(_vo),3);
         _loc1_.addEventListener("complete",__onLoadComplete);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function __onLoadComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",__onLoadComplete);
         var _loc2_:ByteArray = param1.loader.content;
         var _loc3_:FZip = new FZip();
         _loc3_.addEventListener("complete",__onZipParaComplete);
         _loc3_.loadBytes(_loc2_);
      }
      
      private function __onZipParaComplete(param1:Event) : void
      {
         _fzip = param1.currentTarget as FZip;
         _fzip.removeEventListener("complete",__onZipParaComplete);
         _loader = new Loader();
         _loader.contentLoaderInfo.addEventListener("complete",onLoadBitmapComplete);
         var _loc2_:ByteArray = _fzip.getFileByName(_vo.atlasName + ".png").content;
         _loader.loadBytes(_loc2_);
      }
      
      private function onLoadBitmapComplete(param1:Event) : void
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
      
      private function getLoaderPath(param1:BoneVo) : String
      {
         var _loc2_:* = null;
         if(_vo.loadType == 1)
         {
            _loc2_ = BonesLoaderManager.FLASHSITE;
         }
         else
         {
            _loc2_ = BonesLoaderManager.SITE_MAIN;
         }
         return _loc2_ + param1.path + param1.atlasName + param1.ext;
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
