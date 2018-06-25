package bones.loader
{
   import bones.BoneMovieFactory;
   import bones.model.BoneVo;
   import com.crypto.NewCrypto;
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
   
   public class BonesResourceLoader extends EventDispatcher implements Disposeable
   {
       
      
      protected var _vo:BoneVo;
      
      private var _skeletonList:Array;
      
      private var _loader:Loader;
      
      private var _loadRes:BaseLoader;
      
      private var _image:Bitmap = null;
      
      private var _atlas:XML;
      
      private var _fzip:FZip;
      
      public var module:String = "default";
      
      public function BonesResourceLoader(vo:BoneVo)
      {
         super();
         _vo = vo;
         _skeletonList = [];
      }
      
      public function load() : void
      {
         if(_loadRes == null)
         {
            _loadRes = LoadResourceManager.Instance.createLoader(getLoaderPath(_vo),10);
            _loadRes.addEventListener("complete",__onLoadComplete);
            LoadResourceManager.Instance.startLoad(_loadRes);
         }
      }
      
      private function __onLoadComplete(e:LoaderEvent) : void
      {
         var byteArray:* = null;
         var fzip:* = null;
         e.loader.removeEventListener("complete",__onLoadComplete);
         if(!BonesLoaderManager.instance.getBoneLoaderComplete(_vo))
         {
            BonesLoaderManager.instance.saveBoneLoaderData(vo);
            byteArray = NewCrypto.decry(_loadRes.content);
            fzip = new FZip();
            fzip.addEventListener("complete",__onZipParaComplete);
            fzip.loadBytes(byteArray);
         }
         _loadRes = null;
      }
      
      private function __onZipParaComplete(e:Event) : void
      {
         _fzip = e.currentTarget as FZip;
         _fzip.removeEventListener("complete",__onZipParaComplete);
         _loader = new Loader();
         _loader.contentLoaderInfo.addEventListener("complete",__onLoadBitmapComplete);
         _loader.loadBytes(_fzip.getFileByName(_vo.atlasName + ".png").content);
      }
      
      private function __onLoadBitmapComplete(e:Event) : void
      {
         var i:int = 0;
         var name:* = null;
         var json:* = null;
         _loader.contentLoaderInfo.removeEventListener("complete",__onLoadBitmapComplete);
         _image = _loader.content as Bitmap;
         _atlas = new XML(_fzip.getFileByName(_vo.atlasName + ".xml").content.toString());
         var list:Array = BoneMovieFactory.instance.model.getBoneVoListByAtlasName(_vo.atlasName);
         for(i = 0; i < list.length; )
         {
            name = (list[i] as BoneVo).styleName;
            json = _fzip.getFileByName(name + ".json").content.toString();
            _skeletonList.push({
               "name":name,
               "data":json
            });
            i++;
         }
         _fzip.close();
         _loader.unload();
         _loader = null;
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
         if(_loadRes)
         {
            _loadRes.removeEventListener("complete",__onLoadComplete);
         }
         if(_loader)
         {
            _loader.contentLoaderInfo.removeEventListener("complete",__onLoadBitmapComplete);
         }
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
         _loadRes = null;
         _loader = null;
      }
   }
}
