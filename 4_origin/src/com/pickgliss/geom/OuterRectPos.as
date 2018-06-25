package com.pickgliss.geom
{
   import flash.geom.Point;
   
   public class OuterRectPos
   {
       
      
      private var _posX:int;
      
      private var _posY:int;
      
      private var _lockDirection:int;
      
      public function OuterRectPos(posX:int, posY:int, lockDirection:int)
      {
         super();
         _posX = posX;
         _posY = posY;
         _lockDirection = lockDirection;
      }
      
      public function getPos(sourceW:int, sourceH:int, outerW:int, outerH:int) : Point
      {
         var result:Point = new Point();
         if(_lockDirection == 1)
         {
            result.x = (outerW - sourceW) / 2 + _posX;
            result.y = _posY;
         }
         else if(_lockDirection == 5)
         {
            result.x = _posX;
            result.y = _posY;
         }
         else if(_lockDirection == 6)
         {
         }
         return result;
      }
   }
}
