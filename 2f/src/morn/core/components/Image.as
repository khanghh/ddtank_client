package morn.core.components{   import com.pickgliss.loader.BitmapLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import flash.display.BitmapData;   import morn.core.utils.StringUtils;      [Event(name="imageLoaded",type="morn.core.events.UIEvent")]   public class Image extends Component   {                   protected var _bitmap:AutoBitmap;            protected var _url:String;            protected var _bitmapLoader:BitmapLoader;            public function Image(url:String = null) { super(); }
            override protected function createChildren() : void { }
            public function get url() : String { return null; }
            public function set url(value:String) : void { }
            private function __onLoaderComplete(e:LoaderEvent) : void { }
            private function __onLoaderError(e:LoaderEvent) : void { }
            private function clearBitmapLoader() : void { }
            public function get skin() : String { return null; }
            public function set skin(value:String) : void { }
            public function get bitmapData() : BitmapData { return null; }
            public function set bitmapData(value:BitmapData) : void { }
            protected function setBitmapData(url:String, bmd:BitmapData) : void { }
            protected function setBitmapDataError(url:String) : void { }
            override public function set width(value:Number) : void { }
            override public function set height(value:Number) : void { }
            public function get sizeGrid() : String { return null; }
            public function set sizeGrid(value:String) : void { }
            public function get bitmap() : AutoBitmap { return null; }
            public function get smoothing() : Boolean { return false; }
            public function set smoothing(value:Boolean) : void { }
            public function get anchorX() : Number { return 0; }
            public function set anchorX(value:Number) : void { }
            public function get anchorY() : Number { return 0; }
            public function set anchorY(value:Number) : void { }
            override public function set dataSource(value:Object) : void { }
            override public function dispose() : void { }
            public function destroy(clearFromLoader:Boolean = false) : void { }
   }}