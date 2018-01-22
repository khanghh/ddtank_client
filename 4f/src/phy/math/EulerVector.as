package phy.math
{
   public class EulerVector
   {
       
      
      private var _x0:Number;
      
      public var x1:Number;
      
      public var x2:Number;
      
      public var addx2:Number = 0;
      
      public function EulerVector(param1:Number, param2:Number, param3:Number, param4:Number = 0){super();}
      
      public function clear() : void{}
      
      public function clearMotion() : void{}
      
      public function ComputeOneEulerStep(param1:Number, param2:Number, param3:Number, param4:Number) : void{}
      
      public function set x0(param1:Number) : void{}
      
      public function get x0() : Number{return 0;}
      
      public function toString() : String{return null;}
   }
}
