package com.pickgliss.ui.controls.container
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class SimpleTileList extends BoxContainer
   {
       
      
      public var startPos:Point;
      
      protected var _column:int;
      
      protected var _arrangeType:int;
      
      protected var _hSpace:Number = 0;
      
      protected var _rowNum:int;
      
      protected var _vSpace:Number = 0;
      
      private var _selectedIndex:int;
      
      public function SimpleTileList(param1:int = 1, param2:int = 0)
      {
         startPos = new Point(0,0);
         super();
         _column = param1;
         _arrangeType = param2;
      }
      
      public function get selectedIndex() : int
      {
         return _selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         if(_selectedIndex == param1)
         {
            return;
         }
         _selectedIndex = param1;
      }
      
      public function get hSpace() : Number
      {
         return _hSpace;
      }
      
      public function set hSpace(param1:Number) : void
      {
         _hSpace = param1;
         onProppertiesUpdate();
      }
      
      public function get vSpace() : Number
      {
         return _vSpace;
      }
      
      public function set vSpace(param1:Number) : void
      {
         _vSpace = param1;
         onProppertiesUpdate();
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         param1.addEventListener("click",__itemClick);
         super.addChild(param1);
         return param1;
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.currentTarget as DisplayObject;
         _selectedIndex = getChildIndex(_loc2_);
      }
      
      override public function arrange() : void
      {
         caculateRows();
         if(_arrangeType == 0)
         {
            horizontalArrange();
         }
         else
         {
            verticalArrange();
         }
      }
      
      private function horizontalArrange() : void
      {
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc3_:int = startPos.x;
         var _loc2_:int = startPos.y;
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         _loc9_ = 0;
         while(_loc9_ < _rowNum)
         {
            _loc4_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _column)
            {
               _loc6_++;
               _loc7_ = getChildAt(_loc6_);
               _loc7_.x = _loc3_;
               _loc7_.y = _loc2_;
               _loc5_ = Math.max(_loc5_,_loc3_ + _loc7_.width);
               _loc1_ = Math.max(_loc1_,_loc2_ + _loc7_.height);
               _loc3_ = _loc3_ + (_loc7_.width + _hSpace);
               if(_loc4_ < _loc7_.height)
               {
                  _loc4_ = _loc7_.height;
               }
               if(_loc6_ >= numChildren)
               {
                  changeSize(_loc5_,_loc1_);
                  return;
               }
               _loc8_++;
            }
            _loc3_ = startPos.x;
            _loc2_ = _loc2_ + (_loc4_ + _vSpace);
            _loc9_++;
         }
         changeSize(_loc5_,_loc1_);
         dispatchEvent(new Event("resize"));
      }
      
      private function verticalArrange() : void
      {
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc3_:int = startPos.x;
         var _loc2_:int = startPos.y;
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         _loc9_ = 0;
         while(_loc9_ < _rowNum)
         {
            _loc4_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _column)
            {
               _loc6_++;
               _loc7_ = getChildAt(_loc6_);
               _loc7_.x = _loc3_;
               _loc7_.y = _loc2_;
               _loc5_ = Math.max(_loc5_,_loc3_ + _loc7_.width);
               _loc1_ = Math.max(_loc1_,_loc2_ + _loc7_.height);
               _loc2_ = _loc2_ + (_loc7_.height + _vSpace);
               if(_loc4_ < _loc7_.width)
               {
                  _loc4_ = _loc7_.width;
               }
               if(_loc6_ >= numChildren)
               {
                  changeSize(_loc5_,_loc1_);
                  return;
               }
               _loc8_++;
            }
            _loc3_ = _loc3_ + (_loc4_ + _hSpace);
            _loc2_ = startPos.y;
            _loc9_++;
         }
         changeSize(_loc5_,_loc1_);
         dispatchEvent(new Event("resize"));
      }
      
      private function changeSize(param1:int, param2:int) : void
      {
         if(param1 != _width || param2 != _height)
         {
            width = param1;
            height = param2;
         }
      }
      
      private function caculateRows() : void
      {
         _rowNum = Math.ceil(numChildren / _column);
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < numChildren)
         {
            _loc1_ = getChildAt(_loc2_) as DisplayObject;
            _loc1_.removeEventListener("click",__itemClick);
            _loc2_++;
         }
         super.dispose();
      }
   }
}
