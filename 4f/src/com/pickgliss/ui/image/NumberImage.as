package com.pickgliss.ui.image{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.utils.ObjectUtils;      public class NumberImage extends Component   {                   private var _countList:Vector.<ScaleFrameImage>;            private var _count:String;            private var _stylename:String;            private var _countWidth:int;            private var _space:int;            public function NumberImage() { super(); }
            public function set imageStyle(stylename:String) : void { }
            public function set countWidth(value:int) : void { }
            public function set space(value:int) : void { }
            public function set count(value:int) : void { }
            public function set countStr(value:String) : void { }
            public function get count() : int { return 0; }
            private function updateView() : void { }
            private function createCountImage(frame:int = 0) : ScaleFrameImage { return null; }
            override public function dispose() : void { }
   }}