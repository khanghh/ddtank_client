package{   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.events.Event;   import flash.geom.Point;   import flash.geom.Rectangle;   import mx.events.PropertyChangeEvent;      public class BitmapRendItem extends Bitmap   {            public static const BASE:int = -1;            public static const FRAME_BY_FRAME:int = 0;            public static const CROSS_FRAME:int = 1;            public static const COMPLEX:int = 2;                   private var _925155509reference:int = 0;            private var _playing:Boolean = true;            private var _rendMode:String;            protected var _itemWidth:Number;            protected var _itemHeight:Number;            protected var _selfRect:Rectangle;            protected var _totalFrames:int;            protected var _type:int;            protected var _disposed:Boolean;            protected var _realRender:Boolean = true;            public function BitmapRendItem(itemWidth:Number, itemHeight:Number, $rendmode:String = "original", pixelSnapping:String = "auto", smoothing:Boolean = false) { super(null,null,null); }
            private function set _2146088563itemWidth(value:Number) : void { }
            private function set _1671241242itemHeight(value:Number) : void { }
            public function get totalFrames() : int { return 0; }
            private function onEnterFrame(evt:Event) : void { }
            public function play() : void { }
            public function stop() : void { }
            public function reset() : void { }
            protected function get copyInfo() : Array { return null; }
            protected function update() : void { }
            public function dispose() : void { }
            public function get rendMode() : String { return null; }
            public function get itemWidth() : Number { return 0; }
            public function get itemHeight() : Number { return 0; }
            public function toXml() : XML { return null; }
            public function get type() : int { return 0; }
            public function get typeToString() : String { return null; }
            public function get realRender() : Boolean { return false; }
            private function set _2032707372realRender(value:Boolean) : void { }
            [Bindable(event="propertyChange")]      public function get reference() : int { return 0; }
            public function set reference(param1:int) : void { }
            [Bindable(event="propertyChange")]      public function set itemWidth(param1:Number) : void { }
            [Bindable(event="propertyChange")]      public function set itemHeight(param1:Number) : void { }
            [Bindable(event="propertyChange")]      public function set realRender(param1:Boolean) : void { }
   }}