package bones.loader{   import bones.BoneMovieFactory;   import bones.model.BoneVo;   import com.crypto.NewCrypto;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.core.Disposeable;   import deng.fzip.FZip;   import flash.display.Bitmap;   import flash.display.Loader;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.utils.ByteArray;      public class BonesResourceLoader extends EventDispatcher implements Disposeable   {                   protected var _vo:BoneVo;            private var _skeletonList:Array;            private var _loader:Loader;            private var _loadRes:BaseLoader;            private var _image:Bitmap = null;            private var _atlas:XML;            private var _fzip:FZip;            public var module:String = "default";            public function BonesResourceLoader(vo:BoneVo) { super(); }
            public function load() : void { }
            private function __onLoadComplete(e:LoaderEvent) : void { }
            private function __onZipParaComplete(e:Event) : void { }
            private function __onLoadBitmapComplete(e:Event) : void { }
            public function loaderComplete() : void { }
            private function getLoaderPath(vo:BoneVo) : String { return null; }
            public function get image() : Bitmap { return null; }
            public function get atlas() : XML { return null; }
            public function get skeletonList() : Array { return null; }
            public function get vo() : BoneVo { return null; }
            public function dispose() : void { }
   }}