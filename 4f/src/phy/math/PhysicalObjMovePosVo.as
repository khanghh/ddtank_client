package phy.math{   public class PhysicalObjMovePosVo   {                   private var _x:int;            private var _minY:int;            private var _maxY:int;            public function PhysicalObjMovePosVo() { super(); }
            public function get x() : int { return 0; }
            public function set x(value:int) : void { }
            public function get minY() : int { return 0; }
            public function set minY(value:int) : void { }
            public function get maxY() : int { return 0; }
            public function set maxY(value:int) : void { }
            public function isIntersect(yPos:int) : Boolean { return false; }
   }}