package com.pickgliss.ui.controls.container
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class HBox extends BoxContainer
   {
       
      
      public function HBox()
      {
         super();
      }
      
      override public function arrange() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         _width = 0;
         _height = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         _loc4_ = 0;
         while(_loc4_ < _childrenList.length)
         {
            _loc1_ = _childrenList[_loc4_];
            _loc1_.x = _loc2_;
            _loc2_ = Number(_loc2_ + getItemWidth(_loc1_));
            _loc2_ = Number(_loc2_ + _spacing);
            if(_autoSize == 2 && _loc4_ != 0)
            {
               _loc3_ = Number(_childrenList[0].y - (_loc1_.height - _childrenList[0].height) / 2);
            }
            else if(_autoSize == 1 && _loc4_ != 0)
            {
               _loc3_ = Number(_childrenList[0].y - (_loc1_.height - _childrenList[0].height));
            }
            else
            {
               _loc3_ = Number(_childrenList[0].y);
            }
            _loc1_.y = _loc3_;
            _width = _width + getItemWidth(_loc1_);
            _height = Math.max(_height,_loc1_.height);
            _loc4_++;
         }
         _width = _width + _spacing * (numChildren - 1);
         _width = Math.max(0,_width);
         dispatchEvent(new Event("resize"));
      }
      
      private function getItemWidth(param1:DisplayObject) : Number
      {
         if(isStrictSize)
         {
            return _strictSize;
         }
         return param1.width;
      }
   }
}
