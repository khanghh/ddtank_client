package morn.core.components{   import flash.display.Bitmap;   import flash.display.BitmapData;   import morn.core.utils.BitmapUtils;      public final class AutoBitmap extends Bitmap   {                   private var _width:Number;            private var _height:Number;            private var _sizeGrid:Array;            private var _source:Vector.<BitmapData>;            private var _clips:Vector.<BitmapData>;            private var _index:int;            private var _smoothing:Boolean;            private var _anchorX:Number;            private var _anchorY:Number;            public function AutoBitmap() { super(); }
            override public function get width() : Number { return 0; }
            override public function set width(value:Number) : void { }
            override public function get height() : Number { return 0; }
            override public function set height(value:Number) : void { }
            public function get sizeGrid() : Array { return null; }
            public function set sizeGrid(value:Array) : void { }
            override public function set bitmapData(value:BitmapData) : void { }
            public function get clips() : Vector.<BitmapData> { return null; }
            public function set clips(value:Vector.<BitmapData>) : void { }
            public function get index() : int { return 0; }
            public function set index(value:int) : void { }
            private function changeSize() : void { }
            private function disposeTempBitmapdata() : void { }
            override public function get smoothing() : Boolean { return false; }
            override public function set smoothing(value:Boolean) : void { }
            public function get anchorX() : Number { return 0; }
            public function set anchorX(value:Number) : void { }
            public function get anchorY() : Number { return 0; }
            public function set anchorY(value:Number) : void { }
            public function callLater(method:Function, args:Array = null) : void { }
            public function dispose() : void { }
   }}