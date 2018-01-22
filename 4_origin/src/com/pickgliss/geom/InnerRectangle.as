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
      
      public function InnerRectangle(param1:int, param2:int, param3:int, param4:int, param5:int = 0)
      {
         super();
         this.para1 = param1;
         this.para2 = param2;
         this.para3 = param3;
         this.para4 = param4;
         this.lockDirection = param5;
      }
      
      public function equals(param1:InnerRectangle) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return para4 == param1.para4 && para1 == param1.para1 && lockDirection == param1.lockDirection && para2 == param1.para2 && para3 == param1.para3;
      }
      
      public function getInnerRect(param1:int, param2:int) : Rectangle
      {
         _outerWidth = param1;
         _outerHeight = param2;
         return calculateCurrent();
      }
      
      private function calculateCurrent() : Rectangle
      {
         var _loc1_:Rectangle = new Rectangle();
         if(lockDirection == 0)
         {
            _loc1_.x = para1;
            _loc1_.y = para3;
            _loc1_.width = _outerWidth - para1 - para2;
            _loc1_.height = _outerHeight - para3 - para4;
         }
         else if(lockDirection == 1)
         {
            _loc1_.x = para1;
            _loc1_.y = para3;
            _loc1_.width = _outerWidth - para1 - para2;
            _loc1_.height = para4;
         }
         else if(lockDirection == 2)
         {
            _loc1_.x = para1;
            _loc1_.y = para3;
            _loc1_.width = para2;
            _loc1_.height = _outerHeight - para3 - para4;
         }
         else if(lockDirection == 3)
         {
            _loc1_.x = _outerWidth - para1 - para2;
            _loc1_.y = para3;
            _loc1_.width = para1;
            _loc1_.height = _outerHeight - para3 - para4;
         }
         else if(lockDirection == 4)
         {
            _loc1_.x = para1;
            _loc1_.y = _outerHeight - para3 - para4;
            _loc1_.width = _outerWidth - para1 - para2;
            _loc1_.height = para3;
         }
         else if(lockDirection == 9)
         {
            _loc1_.x = (_outerWidth - para1) / 2 + para4;
            _loc1_.y = para3;
            _loc1_.width = para1;
            _loc1_.height = para2;
         }
         else if(lockDirection == 10)
         {
            _loc1_.x = (_outerWidth - para1) / 2 + para3;
            _loc1_.y = _outerHeight - para4 - para2;
            _loc1_.width = para1;
            _loc1_.height = para2;
         }
         else if(lockDirection == 11)
         {
            _loc1_.x = para1;
            _loc1_.y = (_outerHeight - para4) / 2 + para2;
            _loc1_.width = para3;
            _loc1_.height = para4;
         }
         else if(lockDirection == 12)
         {
            _loc1_.x = _outerWidth - para2 - para3;
            _loc1_.y = (_outerHeight - para3) / 2 + para1;
            _loc1_.width = para3;
            _loc1_.height = para4;
         }
         else if(lockDirection == 13)
         {
            _loc1_.x = para1;
            _loc1_.y = para3;
            _loc1_.width = para2;
            _loc1_.height = para4;
         }
         else if(lockDirection == 14)
         {
            _loc1_.x = _outerWidth - para1 - para2;
            _loc1_.y = para3;
            _loc1_.width = para1;
            _loc1_.height = para4;
         }
         else if(lockDirection == 15)
         {
            _loc1_.x = para1;
            _loc1_.y = _outerHeight - para4 - para3;
            _loc1_.width = para2;
            _loc1_.height = para3;
         }
         else if(lockDirection == 16)
         {
            _loc1_.x = _outerWidth - para1 - para2;
            _loc1_.y = _outerHeight - para4 - para3;
            _loc1_.width = para1;
            _loc1_.height = para3;
         }
         else if(lockDirection == -1)
         {
            _loc1_.x = -para1;
            _loc1_.y = -para3;
            _loc1_.width = _outerWidth + para1 + para2;
            _loc1_.height = _outerHeight + para4 + para3;
         }
         else if(lockDirection == 17)
         {
            _loc1_.x = (_outerWidth - para2) / 2 + para1;
            _loc1_.y = (_outerHeight - para4) / 2 + para3;
            _loc1_.width = para2;
            _loc1_.height = para4;
         }
         else if(lockDirection == 5)
         {
            _loc1_.x = para1;
            _loc1_.y = para2;
            _loc1_.width = _outerWidth - para3;
            _loc1_.height = _outerHeight - para4;
         }
         else if(lockDirection == 18)
         {
            _loc1_.x = para1;
            _loc1_.y = para2;
            _loc1_.width = _outerWidth - para3;
            _loc1_.height = para4;
         }
         return _loc1_;
      }
   }
}
