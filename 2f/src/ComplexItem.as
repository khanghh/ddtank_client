package{   import flash.geom.Point;   import flash.geom.Rectangle;      public class ComplexItem extends BitmapRendItem   {                   protected var _items:Vector.<BitmapRendItem>;            private var item:BitmapRendItem;            private var tempcopyInfo:Array;            public function ComplexItem($width:Number, $height:Number, $rendmode:String = "original", pixelSnapping:String = "auto", smoothing:Boolean = false) { super(null,null,null,null,null); }
            public function addItem(item:FrameByFrameItem) : void { }
            public function removeItem(item:FrameByFrameItem) : void { }
            override public function set scaleX(value:Number) : void { }
            override protected function update() : void { }
            override protected function get copyInfo() : Array { return null; }
            override public function dispose() : void { }
            override public function get typeToString() : String { return null; }
            override public function toXml() : XML { return null; }
   }}