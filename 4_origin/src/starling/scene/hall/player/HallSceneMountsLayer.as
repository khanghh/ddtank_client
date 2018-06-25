package starling.scene.hall.player
{
   import com.crypto.NewCrypto;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   import ddt.view.character.ILayer;
   import deng.fzip.FZip;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.utils.ByteArray;
   
   public class HallSceneMountsLayer implements ILayer
   {
      
      private static const HORSE_PNG:String = "horse.png";
      
      private static const HORSE_XML:String = "horse.xml";
       
      
      private var _loader:Loader;
      
      private var _fzip:FZip;
      
      private var _isComplete:Boolean;
      
      private var _callBack:Function;
      
      private var _mountsType:int;
      
      private var _xml:Object;
      
      private var _image:Bitmap;
      
      public function HallSceneMountsLayer(mountsType:int)
      {
         super();
         _mountsType = mountsType;
      }
      
      public function load(callBack:Function) : void
      {
         _callBack = callBack;
         var url:String = PathManager.SITE_MAIN + "image/mounts/horse/" + _mountsType + "/horse.png";
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(url,3);
         loader.addEventListener("complete",__onLoadComplete);
         loader.addEventListener("loadError",__onLoadError);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function __onLoadComplete(e:LoaderEvent) : void
      {
         e.loader.removeEventListener("complete",__onLoadComplete);
         e.loader.removeEventListener("loadError",__onLoadError);
         _isComplete = true;
         var byteArray:ByteArray = NewCrypto.decry(e.loader.content);
         _fzip = new FZip();
         _fzip.addEventListener("complete",__onZipParaComplete);
         _fzip.loadBytes(byteArray);
      }
      
      private function __onZipParaComplete(e:Event) : void
      {
         _fzip.removeEventListener("complete",__onZipParaComplete);
         _xml = new XML(_fzip.getFileByName("horse.xml").content.toString());
         _loader = new Loader();
         _loader.contentLoaderInfo.addEventListener("complete",__onLoadBitmapComplete);
         _loader.loadBytes(_fzip.getFileByName("horse.png").content);
      }
      
      private function __onLoadBitmapComplete(e:Event) : void
      {
         _loader.contentLoaderInfo.removeEventListener("complete",__onLoadBitmapComplete);
         _image = _loader.content as Bitmap;
         _fzip.close();
         _loader.unload();
         loaderComplete();
      }
      
      private function __onLoadError(e:LoaderEvent) : void
      {
         e.loader.removeEventListener("complete",__onLoadComplete);
         e.loader.removeEventListener("loadError",__onLoadError);
         _isComplete = false;
      }
      
      public function loaderComplete() : void
      {
         if(_callBack)
         {
            _callBack(this);
         }
      }
      
      public function dispose() : void
      {
         _xml = null;
         _image.bitmapData.dispose();
         _image = null;
         _loader = null;
         _fzip = null;
      }
      
      public function get isComplete() : Boolean
      {
         return _isComplete;
      }
      
      public function get xml() : Object
      {
         return _xml;
      }
      
      public function get image() : Bitmap
      {
         return _image;
      }
      
      public function getContent() : DisplayObject
      {
         return null;
      }
      
      public function get info() : ItemTemplateInfo
      {
         return null;
      }
      
      public function set info(value:ItemTemplateInfo) : void
      {
      }
      
      public function set currentEdit(n:int) : void
      {
      }
      
      public function get currentEdit() : int
      {
         return 0;
      }
      
      public function get width() : Number
      {
         return 0;
      }
      
      public function get height() : Number
      {
         return 0;
      }
      
      public function setColor(color:*) : Boolean
      {
         return false;
      }
   }
}
