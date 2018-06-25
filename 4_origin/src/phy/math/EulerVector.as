package phy.math
{
   public class EulerVector
   {
       
      
      private var _x0:Number;
      
      public var x1:Number;
      
      public var x2:Number;
      
      public var addx2:Number = 0;
      
      public function EulerVector(x0:Number, x1:Number, x2:Number, addx2:Number = 0)
      {
         super();
         this.x0 = x0;
         this.x1 = x1;
         this.x2 = x2;
         this.addx2 = addx2;
      }
      
      public function clear() : void
      {
         x0 = 0;
         x1 = 0;
         x2 = 0;
         addx2 = 0;
      }
      
      public function clearMotion() : void
      {
         x1 = 0;
         x2 = 0;
         addx2 = 0;
      }
      
      public function ComputeOneEulerStep(m:Number, af:Number, f:Number, dt:Number) : void
      {
         x2 = (f - af * x1) / m + addx2;
         x1 = x1 + x2 * dt;
         x0 = x0 + x1 * dt;
      }
      
      public function set x0(value:Number) : void
      {
         _x0 = value;
      }
      
      public function get x0() : Number
      {
         return _x0;
      }
      
      public function toString() : String
      {
         return "x:" + x0 + ",v:" + x1 + ",a" + x2;
      }
   }
}
