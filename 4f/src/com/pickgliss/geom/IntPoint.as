package com.pickgliss.geom{   import flash.geom.Point;      public class IntPoint   {                   public var x:int = 0;            public var y:int = 0;            public function IntPoint(x:int = 0, y:int = 0) { super(); }
            public static function creatWithPoint(p:Point) : IntPoint { return null; }
            public function toPoint() : Point { return null; }
            public function setWithPoint(p:Point) : void { }
            public function setLocation(p:IntPoint) : void { }
            public function setLocationXY(x:int = 0, y:int = 0) : void { }
            public function move(dx:int, dy:int) : IntPoint { return null; }
            public function moveRadians(direction:int, distance:int) : IntPoint { return null; }
            public function nextPoint(direction:Number, distance:Number) : IntPoint { return null; }
            public function distanceSq(p:IntPoint) : int { return 0; }
            public function distance(p:IntPoint) : int { return 0; }
            public function equals(o:Object) : Boolean { return false; }
            public function clone() : IntPoint { return null; }
            public function toString() : String { return null; }
   }}