package phy.math
{
   public class EulerVector
   {
       
      
      private var _x0:Number;
      
      public var x1:Number;
      
      public var x2:Number;
      
      public var addx2:Number = 0;
      
      public function EulerVector(param1:Number, param2:Number, param3:Number, param4:Number = 0)
      {
         super();
         this.x0 = param1;
         this.x1 = param2;
         this.x2 = param3;
         this.addx2 = param4;
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
      
      public function ComputeOneEulerStep(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         x2 = (param3 - param2 * x1) / param1 + addx2;
         x1 = x1 + x2 * param4;
         x0 = x0 + x1 * param4;
      }
      
      public function set x0(param1:Number) : void
      {
         _x0 = param1;
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
