package phy.math{   public class EulerVector   {                   private var _x0:Number;            public var x1:Number;            public var x2:Number;            public var addx2:Number = 0;            public function EulerVector(x0:Number, x1:Number, x2:Number, addx2:Number = 0) { super(); }
            public function clear() : void { }
            public function clearMotion() : void { }
            public function ComputeOneEulerStep(m:Number, af:Number, f:Number, dt:Number) : void { }
            public function set x0(value:Number) : void { }
            public function get x0() : Number { return 0; }
            public function toString() : String { return null; }
   }}