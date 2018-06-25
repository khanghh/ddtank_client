package phy.math
{
   public class PhysicalObjMovePosVo
   {
       
      
      private var _x:int;
      
      private var _minY:int;
      
      private var _maxY:int;
      
      public function PhysicalObjMovePosVo()
      {
         super();
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function set x(value:int) : void
      {
         _x = value;
      }
      
      public function get minY() : int
      {
         return _minY;
      }
      
      public function set minY(value:int) : void
      {
         _minY = value;
      }
      
      public function get maxY() : int
      {
         return _maxY;
      }
      
      public function set maxY(value:int) : void
      {
         _maxY = value;
      }
      
      public function isIntersect(yPos:int) : Boolean
      {
         return yPos >= minY && yPos <= maxY;
      }
   }
}
