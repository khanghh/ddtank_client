package ddt.loader{   import com.pickgliss.loader.DisplayLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.map.MapInfo;   import ddt.manager.PathManager;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.EventDispatcher;      public class MapLoader extends EventDispatcher   {                   private var _info:MapInfo;            private var _back:Bitmap;            private var _fore:Bitmap;            private var _dead:Bitmap;            private var _middle:DisplayObject;            private var _real:Bitmap;            private var _loaderBack:DisplayLoader;            private var _loaderFore:DisplayLoader;            private var _loaderDead:DisplayLoader;            private var _loaderMiddle:DisplayLoader;            private var _loaderReal:DisplayLoader;            private var _count:int;            private var _total:int;            private var _loadCompleted:Boolean;            public function MapLoader(info:MapInfo) { super(); }
            public function get info() : MapInfo { return null; }
            public function get backBmp() : Bitmap { return null; }
            public function get foreBmp() : Bitmap { return null; }
            public function get deadBmp() : Bitmap { return null; }
            public function get middle() : DisplayObject { return null; }
            public function get realBmp() : Bitmap { return null; }
            public function get completed() : Boolean { return false; }
            public function load() : void { }
            private function __backComplete(evt:LoaderEvent) : void { }
            private function __middleComplete(evt:LoaderEvent) : void { }
            private function __foreComplete(evt:LoaderEvent) : void { }
            private function __realComplete(evt:LoaderEvent) : void { }
            private function __deadComplete(evt:LoaderEvent) : void { }
            private function count() : void { }
            public function dispose() : void { }
   }}