package{   import flash.display.BitmapData;   import flash.display.PixelSnapping;   import flash.geom.Point;   import flash.geom.Rectangle;      public class FrameByFrameItem extends BitmapRendItem   {                   protected var _source:BitmapData;            protected var _autoStop:Boolean;            protected var _rects:Vector.<Rectangle>;            protected var _moveInfo:Vector.<Point>;            protected var _index:int = 0;            protected var _offset:Point;            protected var _len:int;            protected var _sourceName:String;            public function FrameByFrameItem($width:Number, $height:Number, source:BitmapData, $rendmode:String = "original", autoStop:Boolean = false) { super(null,null,null,null,null); }
            public function set source(value:BitmapData) : void { }
            public function get sourceName() : String { return null; }
            public function set sourceName(value:String) : void { }
            public function get source() : BitmapData { return null; }
            override public function dispose() : void { }
            private function initRectangles() : void { }
            override public function get totalFrames() : int { return 0; }
            override protected function get copyInfo() : Array { return null; }
            override public function reset() : void { }
            public function set moveInfo(value:Vector.<Point>) : void { }
            override protected function update() : void { }
            public function get autoStop() : Boolean { return false; }
            public function set autoStop(value:Boolean) : void { }
            override public function toXml() : XML { return null; }
            override public function get typeToString() : String { return null; }
   }}