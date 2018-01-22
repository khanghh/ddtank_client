package com.pickgliss.geom
{
   import flash.geom.Point;
   
   public class OuterRectPos
   {
       
      
      private var _posX:int;
      
      private var _posY:int;
      
      private var _lockDirection:int;
      
      public function OuterRectPos(param1:int, param2:int, param3:int)
      {
         super();
         _posX = param1;
         _posY = param2;
         _lockDirection = param3;
      }
      
      public function getPos(param1:int, param2:int, param3:int, param4:int) : Point
      {
         var _loc5_:Point = new Point();
         if(_lockDirection == 1)
         {
            _loc5_.x = (param3 - param1) / 2 + _posX;
            _loc5_.y = _posY;
         }
         else if(_lockDirection == 5)
         {
            _loc5_.x = _posX;
            _loc5_.y = _posY;
         }
         else if(_lockDirection == 6)
         {
         }
         return _loc5_;
      }
   }
}
