package com.pickgliss.geom{   public class IntDimension   {                   public var width:int = 0;            public var height:int = 0;            public function IntDimension(width:int = 0, height:int = 0) { super(); }
            public static function createBigDimension() : IntDimension { return null; }
            public function setSize(dim:IntDimension) : void { }
            public function setSizeWH(width:int, height:int) : void { }
            public function increaseSize(s:IntDimension) : IntDimension { return null; }
            public function decreaseSize(s:IntDimension) : IntDimension { return null; }
            public function change(deltaW:int, deltaH:int) : IntDimension { return null; }
            public function changedSize(deltaW:int, deltaH:int) : IntDimension { return null; }
            public function combine(d:IntDimension) : IntDimension { return null; }
            public function combineSize(d:IntDimension) : IntDimension { return null; }
            public function getBounds(x:int = 0, y:int = 0) : IntRectangle { return null; }
            public function equals(o:Object) : Boolean { return false; }
            public function clone() : IntDimension { return null; }
            public function toString() : String { return null; }
   }}