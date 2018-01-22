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
      
      public function BonesResourceLoader(param1:BoneVo)
      {
         super();
         _vo = param1;
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
      
      private function __onLoadComplete(param1:LoaderEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         param1.loader.removeEventListener("complete",__onLoadComplete);
         if(!BonesLoaderManager.instance.getBoneLoaderComplete(_vo))
         {
            BonesLoaderManager.instance.saveBoneLoaderData(vo);
            _loc2_ = NewCrypto.decry(_loadRes.content);
            _loc3_ = new FZip();
            _loc3_.addEventListener("complete",__onZipParaComplete);
            _loc3_.loadBytes(_loc2_);
         }
         _loadRes = null;
      }
      
      private function __onZipParaComplete(param1:Event) : void
      {
         _fzip = param1.currentTarget as FZip;
         _fzip.removeEventListener("complete",__onZipParaComplete);
         _loader = new Loader();
         _loader.contentLoaderInfo.addEventListener("complete",__onLoadBitmapComplete);
         _loader.loadBytes(_fzip.getFileByName(_vo.atlasName + ".png").content);
      }
      
      private function __onLoadBitmapComplete(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         _loader.contentLoaderInfo.removeEventListener("complete",__onLoadBitmapComplete);
         _image = _loader.content as Bitmap;
         _atlas = new XML(_fzip.getFileByName(_vo.atlasName + ".xml").content.toString());
         var _loc4_:Array = BoneMovieFactory.instance.model.getBoneVoListByAtlasName(_vo.atlasName);
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc3_ = (_loc4_[_loc5_] as BoneVo).styleName;
            _loc2_ = _fzip.getFileByName(_loc3_ + ".json").content.toString();
            _skeletonList.push({
               "name":_loc3_,
               "data":_loc2_
            });
            _loc5_++;
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
