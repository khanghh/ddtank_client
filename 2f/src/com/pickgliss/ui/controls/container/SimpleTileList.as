package com.pickgliss.ui.controls.container{   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;      public class SimpleTileList extends BoxContainer   {                   public var startPos:Point;            protected var _column:int;            protected var _arrangeType:int;            protected var _hSpace:Number = 0;            protected var _rowNum:int;            protected var _vSpace:Number = 0;            private var _selectedIndex:int;            public function SimpleTileList(columnNum:int = 1, arrangeType:int = 0) { super(); }
            public function get selectedIndex() : int { return 0; }
            public function set selectedIndex(value:int) : void { }
            public function get hSpace() : Number { return 0; }
            public function set hSpace(value:Number) : void { }
            public function get vSpace() : Number { return 0; }
            public function set vSpace(value:Number) : void { }
            override public function addChild(child:DisplayObject) : DisplayObject { return null; }
            private function __itemClick(e:MouseEvent) : void { }
            override public function arrange() : void { }
            private function horizontalArrange() : void { }
            private function verticalArrange() : void { }
            private function changeSize(w:int, h:int) : void { }
            private function caculateRows() : void { }
            override public function dispose() : void { }
   }}