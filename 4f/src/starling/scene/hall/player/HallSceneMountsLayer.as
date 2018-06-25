package starling.scene.hall.player{   import com.crypto.NewCrypto;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.PathManager;   import ddt.view.character.ILayer;   import deng.fzip.FZip;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Loader;   import flash.events.Event;   import flash.utils.ByteArray;      public class HallSceneMountsLayer implements ILayer   {            private static const HORSE_PNG:String = "horse.png";            private static const HORSE_XML:String = "horse.xml";                   private var _loader:Loader;            private var _fzip:FZip;            private var _isComplete:Boolean;            private var _callBack:Function;            private var _mountsType:int;            private var _xml:Object;            private var _image:Bitmap;            public function HallSceneMountsLayer(mountsType:int) { super(); }
            public function load(callBack:Function) : void { }
            private function __onLoadComplete(e:LoaderEvent) : void { }
            private function __onZipParaComplete(e:Event) : void { }
            private function __onLoadBitmapComplete(e:Event) : void { }
            private function __onLoadError(e:LoaderEvent) : void { }
            public function loaderComplete() : void { }
            public function dispose() : void { }
            public function get isComplete() : Boolean { return false; }
            public function get xml() : Object { return null; }
            public function get image() : Bitmap { return null; }
            public function getContent() : DisplayObject { return null; }
            public function get info() : ItemTemplateInfo { return null; }
            public function set info(value:ItemTemplateInfo) : void { }
            public function set currentEdit(n:int) : void { }
            public function get currentEdit() : int { return 0; }
            public function get width() : Number { return 0; }
            public function get height() : Number { return 0; }
            public function setColor(color:*) : Boolean { return false; }
   }}