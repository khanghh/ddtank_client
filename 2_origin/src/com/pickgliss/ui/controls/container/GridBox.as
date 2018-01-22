package com.pickgliss.ui.controls.container
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class GridBox extends BoxContainer
   {
       
      
      public var alwaysLast:DisplayObject;
      
      public var lastRowWidthMax:Number = 320;
      
      public var columnNumber:int = 5;
      
      public var cellHeght:Number = 100;
      
      public var align:String = "right";
      
      private var __checkAlignFunction:Function;
      
      public function GridBox()
      {
         super();
         checkAlignForFirstRow = false;
      }
      
      public function set checkAlignForFirstRow(param1:Boolean) : void
      {
         value = param1;
         if(value)
         {
            __checkAlignFunction = function():Boolean
            {
               return true;
            };
         }
         else
         {
            __checkAlignFunction = function():Boolean
            {
               return _childrenList.length > columnNumber;
            };
         }
      }
      
      override public function arrange() : void
      {
         var _loc6_:int = 0;
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         if(_childrenList == null)
         {
            return;
         }
         if(_childrenList.length <= 0)
         {
            return;
         }
         if(alwaysLast != null)
         {
            alwaysLast.parent && removeChild(alwaysLast);
            addChild(alwaysLast);
         }
         _width = 0;
         _height = 0;
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         _loc6_ = 0;
         while(_loc6_ < _childrenList.length)
         {
            _loc1_ = _childrenList[_loc6_];
            if(_loc6_ % columnNumber == 0)
            {
               _loc2_ = 0;
            }
            _loc1_.x = _loc2_;
            _loc2_ = Number(_loc2_ + getItemWidth(_loc1_));
            _loc2_ = Number(_loc2_ + _spacing);
            if(_autoSize == 2 && _loc6_ != 0)
            {
               _loc4_ = Number(_childrenList[0].y - (_loc1_.height - _childrenList[0].height) / 2);
            }
            else if(_autoSize == 1 && _loc6_ != 0)
            {
               _loc4_ = Number(_childrenList[0].y - (_loc1_.height - _childrenList[0].height));
            }
            else if(_autoSize == 3)
            {
               _loc4_ = 0;
            }
            else
            {
               _loc4_ = Number(_childrenList[0].y);
            }
            _loc4_ = Number(_loc4_ + cellHeght * (int(_loc6_ / columnNumber)));
            _loc1_.y = _loc4_;
            if(_loc6_ < columnNumber)
            {
               _width = _width + (getItemWidth(_loc1_) + _spacing);
            }
            _height = Math.max(_height,(int(_loc6_ / columnNumber) + (_loc6_ % columnNumber > 0?1:0)) * cellHeght);
            _loc6_++;
         }
         if(align == "right" && __checkAlignFunction())
         {
            _loc3_ = _childrenList[_childrenList.length - 1] as DisplayObject;
            _loc5_ = lastRowWidthMax - _loc3_.x - _loc3_.width;
            _loc6_ = int(_childrenList.length / columnNumber) * columnNumber;
            while(_loc6_ < _childrenList.length)
            {
               _childrenList[_loc6_].x = _childrenList[_loc6_].x + _loc5_;
               _loc6_++;
            }
         }
         _width = Math.max(0,_width);
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
