package com.pickgliss.geom{   import flash.geom.Rectangle;      public class IntRectangle   {                   public var x:int = 0;            public var y:int = 0;            public var width:int = 0;            public var height:int = 0;            public function IntRectangle(x:int = 0, y:int = 0, width:int = 0, height:int = 0) { super(); }
            public static function creatWithRectangle(r:Rectangle) : IntRectangle { return null; }
            public function toRectangle() : Rectangle { return null; }
            public function setWithRectangle(r:Rectangle) : void { }
            public function setRect(rect:IntRectangle) : void { }
            public function setRectXYWH(x:int, y:int, width:int, height:int) : void { }
            public function setLocation(p:IntPoint) : void { }
            public function setSize(size:IntDimension) : void { }
            public function getSize() : IntDimension { return null; }
            public function getLocation() : IntPoint { return null; }
            public function union(r:IntRectangle) : IntRectangle { return null; }
            public function grow(h:int, v:int) : void { }
            public function move(dx:int, dy:int) : void { }
            public function resize(dwidth:int = 0, dheight:int = 0) : void { }
            public function leftTop() : IntPoint { return null; }
            public function rightTop() : IntPoint { return null; }
            public function leftBottom() : IntPoint { return null; }
            public function rightBottom() : IntPoint { return null; }
            public function containsPoint(p:IntPoint) : Boolean { return false; }
            public function equals(o:Object) : Boolean { return false; }
            public function clone() : IntRectangle { return null; }
            public function toString() : String { return null; }
   }}