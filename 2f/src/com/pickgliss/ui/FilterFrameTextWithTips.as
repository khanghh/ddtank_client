package com.pickgliss.ui{   import com.pickgliss.ui.core.ITipedDisplay;   import com.pickgliss.ui.text.FilterFrameText;   import flash.display.DisplayObject;      public class FilterFrameTextWithTips extends FilterFrameText implements ITipedDisplay   {                   private var _tipStyle:String;            private var _tipGapV:int;            private var _tipGapH:int;            private var _tipDirctions:String;            private var _tipData:Object;            public function FilterFrameTextWithTips() { super(); }
            public function get tipData() : Object { return null; }
            public function set tipData(value:Object) : void { }
            public function get tipDirctions() : String { return null; }
            public function set tipDirctions(value:String) : void { }
            public function get tipGapH() : int { return 0; }
            public function set tipGapH(value:int) : void { }
            public function get tipGapV() : int { return 0; }
            public function set tipGapV(value:int) : void { }
            public function get tipStyle() : String { return null; }
            public function set tipStyle(value:String) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            override public function dispose() : void { }
   }}