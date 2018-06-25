package com.pickgliss.ui.controls.container{   import flash.display.DisplayObject;   import flash.events.Event;      public class GridBox extends BoxContainer   {                   public var alwaysLast:DisplayObject;            public var lastRowWidthMax:Number = 320;            public var columnNumber:int = 5;            public var cellHeght:Number = 100;            public var align:String = "right";            private var __checkAlignFunction:Function;            public function GridBox() { super(); }
            public function set checkAlignForFirstRow(value:Boolean) : void { }
            override public function arrange() : void { }
            private function getItemHeight(child:DisplayObject) : Number { return 0; }
            private function getItemWidth(child:DisplayObject) : Number { return 0; }
   }}