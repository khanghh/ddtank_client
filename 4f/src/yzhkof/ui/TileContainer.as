package yzhkof.ui{   import flash.display.DisplayObject;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.utils.Dictionary;      public class TileContainer extends ComponentContainer   {                   private var _paddingH:Number = 10;            private var _paddingV:Number = 10;            private var _columnCount:uint = 2.147483647E9;            private var _rowCount:uint = 2.147483647E9;            private var _autoVSize:Boolean = true;            private var _scrollY:int = 0;            private var _scrollX:int = 0;            public var childBoundsSize:Boolean;            private var layoutMap:Dictionary;            public function TileContainer(childBoundsSize:Boolean = true) { super(); }
            private function init() : void { }
            public function removeAllChildren() : void { }
            override protected function onDraw() : void { }
            public function get columnCount() : uint { return null; }
            public function set columnCount(value:uint) : void { }
            public function get rowCount() : uint { return null; }
            public function set rowCount(value:uint) : void { }
            override public function addChild(child:DisplayObject) : DisplayObject { return null; }
            override public function removeChild(child:DisplayObject) : DisplayObject { return null; }
            public function removeItem(child:DisplayObject) : void { }
            public function appendItem(child:DisplayObject, itemLayout:Object = null) : void { }
            private function getItemLayout(child:DisplayObject) : Object { return null; }
            override public function get height() : Number { return 0; }
            public function get paddingH() : Number { return 0; }
            public function set paddingH(value:Number) : void { }
            public function get paddingV() : Number { return 0; }
            public function set paddingV(value:Number) : void { }
            public function get autoVSize() : Boolean { return false; }
            public function set autoVSize(value:Boolean) : void { }
   }}