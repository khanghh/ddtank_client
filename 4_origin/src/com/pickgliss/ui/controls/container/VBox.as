package com.pickgliss.ui.controls.container
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class VBox extends BoxContainer
   {
       
      
      public function VBox()
      {
         super();
      }
      
      override public function arrange() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         _width = 0;
         _height = 0;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _loc4_ = 0;
         while(_loc4_ < _childrenList.length)
         {
            _loc1_ = _childrenList[_loc4_];
            _loc1_.y = _loc3_;
            _loc3_ = Number(_loc3_ + getItemHeight(_loc1_));
            _loc3_ = Number(_loc3_ + _spacing);
            if(_autoSize == 2 && _loc4_ != 0)
            {
               _loc2_ = Number(_childrenList[0].x - (_loc1_.width - _childrenList[0].width) / 2);
            }
            else if(_autoSize == 1 && _loc4_ != 0)
            {
               _loc2_ = Number(_childrenList[0].x - (_loc1_.width - _childrenList[0].width));
            }
            else
            {
               _loc2_ = Number(_loc1_.x);
            }
            _loc1_.x = _loc2_;
            _height = _height + getItemHeight(_loc1_);
            _width = Math.max(_width,_loc1_.width);
            _loc4_++;
         }
         _height = _height + _spacing * (numChildren - 1);
         _height = Math.max(0,_height);
         dispatchEvent(new Event("resize"));
      }
      
      private function getItemHeight(param1:DisplayObject) : Number
      {
         if(isStrictSize)
         {
            return _strictSize;
         }
         return param1.height;
      }
   }
}
