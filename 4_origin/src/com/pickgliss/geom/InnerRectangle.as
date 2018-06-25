package com.pickgliss.geom
{
   import flash.geom.Rectangle;
   
   public class InnerRectangle
   {
       
      
      public var lockDirection:int;
      
      public var para1:int;
      
      public var para2:int;
      
      public var para3:int;
      
      public var para4:int;
      
      private var _outerHeight:int;
      
      private var _outerWidth:int;
      
      private var _resultRect:Rectangle;
      
      public function InnerRectangle(para1:int, para2:int, para3:int, para4:int, lockDirection:int = 0)
      {
         super();
         this.para1 = para1;
         this.para2 = para2;
         this.para3 = para3;
         this.para4 = para4;
         this.lockDirection = lockDirection;
      }
      
      public function equals(innerRect:InnerRectangle) : Boolean
      {
         if(innerRect == null)
         {
            return false;
         }
         return para4 == innerRect.para4 && para1 == innerRect.para1 && lockDirection == innerRect.lockDirection && para2 == innerRect.para2 && para3 == innerRect.para3;
      }
      
      public function getInnerRect(outerWidth:int, outerHeight:int) : Rectangle
      {
         _outerWidth = outerWidth;
         _outerHeight = outerHeight;
         return calculateCurrent();
      }
      
      private function calculateCurrent() : Rectangle
      {
         var resultRect:Rectangle = new Rectangle();
         if(lockDirection == 0)
         {
            resultRect.x = para1;
            resultRect.y = para3;
            resultRect.width = _outerWidth - para1 - para2;
            resultRect.height = _outerHeight - para3 - para4;
         }
         else if(lockDirection == 1)
         {
            resultRect.x = para1;
            resultRect.y = para3;
            resultRect.width = _outerWidth - para1 - para2;
            resultRect.height = para4;
         }
         else if(lockDirection == 2)
         {
            resultRect.x = para1;
            resultRect.y = para3;
            resultRect.width = para2;
            resultRect.height = _outerHeight - para3 - para4;
         }
         else if(lockDirection == 3)
         {
            resultRect.x = _outerWidth - para1 - para2;
            resultRect.y = para3;
            resultRect.width = para1;
            resultRect.height = _outerHeight - para3 - para4;
         }
         else if(lockDirection == 4)
         {
            resultRect.x = para1;
            resultRect.y = _outerHeight - para3 - para4;
            resultRect.width = _outerWidth - para1 - para2;
            resultRect.height = para3;
         }
         else if(lockDirection == 9)
         {
            resultRect.x = (_outerWidth - para1) / 2 + para4;
            resultRect.y = para3;
            resultRect.width = para1;
            resultRect.height = para2;
         }
         else if(lockDirection == 10)
         {
            resultRect.x = (_outerWidth - para1) / 2 + para3;
            resultRect.y = _outerHeight - para4 - para2;
            resultRect.width = para1;
            resultRect.height = para2;
         }
         else if(lockDirection == 11)
         {
            resultRect.x = para1;
            resultRect.y = (_outerHeight - para4) / 2 + para2;
            resultRect.width = para3;
            resultRect.height = para4;
         }
         else if(lockDirection == 12)
         {
            resultRect.x = _outerWidth - para2 - para3;
            resultRect.y = (_outerHeight - para3) / 2 + para1;
            resultRect.width = para3;
            resultRect.height = para4;
         }
         else if(lockDirection == 13)
         {
            resultRect.x = para1;
            resultRect.y = para3;
            resultRect.width = para2;
            resultRect.height = para4;
         }
         else if(lockDirection == 14)
         {
            resultRect.x = _outerWidth - para1 - para2;
            resultRect.y = para3;
            resultRect.width = para1;
            resultRect.height = para4;
         }
         else if(lockDirection == 15)
         {
            resultRect.x = para1;
            resultRect.y = _outerHeight - para4 - para3;
            resultRect.width = para2;
            resultRect.height = para3;
         }
         else if(lockDirection == 16)
         {
            resultRect.x = _outerWidth - para1 - para2;
            resultRect.y = _outerHeight - para4 - para3;
            resultRect.width = para1;
            resultRect.height = para3;
         }
         else if(lockDirection == -1)
         {
            resultRect.x = -para1;
            resultRect.y = -para3;
            resultRect.width = _outerWidth + para1 + para2;
            resultRect.height = _outerHeight + para4 + para3;
         }
         else if(lockDirection == 17)
         {
            resultRect.x = (_outerWidth - para2) / 2 + para1;
            resultRect.y = (_outerHeight - para4) / 2 + para3;
            resultRect.width = para2;
            resultRect.height = para4;
         }
         else if(lockDirection == 5)
         {
            resultRect.x = para1;
            resultRect.y = para2;
            resultRect.width = _outerWidth - para3;
            resultRect.height = _outerHeight - para4;
         }
         else if(lockDirection == 18)
         {
            resultRect.x = para1;
            resultRect.y = para2;
            resultRect.width = _outerWidth - para3;
            resultRect.height = para4;
         }
         return resultRect;
      }
   }
}
