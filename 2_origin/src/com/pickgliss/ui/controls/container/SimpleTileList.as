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
      
      public function SimpleTileList(columnNum:int = 1, arrangeType:int = 0)
      {
         startPos = new Point(0,0);
         super();
         _column = columnNum;
         _arrangeType = arrangeType;
      }
      
      public function get selectedIndex() : int
      {
         return _selectedIndex;
      }
      
      public function set selectedIndex(value:int) : void
      {
         if(_selectedIndex == value)
         {
            return;
         }
         _selectedIndex = value;
      }
      
      public function get hSpace() : Number
      {
         return _hSpace;
      }
      
      public function set hSpace(value:Number) : void
      {
         _hSpace = value;
         onProppertiesUpdate();
      }
      
      public function get vSpace() : Number
      {
         return _vSpace;
      }
      
      public function set vSpace(value:Number) : void
      {
         _vSpace = value;
         onProppertiesUpdate();
      }
      
      override public function addChild(child:DisplayObject) : DisplayObject
      {
         child.addEventListener("click",__itemClick);
         super.addChild(child);
         return child;
      }
      
      private function __itemClick(e:MouseEvent) : void
      {
         var item:DisplayObject = e.currentTarget as DisplayObject;
         _selectedIndex = getChildIndex(item);
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
         var i:int = 0;
         var maxHeight:int = 0;
         var j:int = 0;
         var ch:* = null;
         var n:int = 0;
         var posX:int = startPos.x;
         var posY:int = startPos.y;
         var tempWidth:int = 0;
         var tempHeight:int = 0;
         for(i = 0; i < _rowNum; )
         {
            maxHeight = 0;
            for(j = 0; j < _column; )
            {
               n++;
               ch = getChildAt(n);
               ch.x = posX;
               ch.y = posY;
               tempWidth = Math.max(tempWidth,posX + ch.width);
               tempHeight = Math.max(tempHeight,posY + ch.height);
               posX = posX + (ch.width + _hSpace);
               if(maxHeight < ch.height)
               {
                  maxHeight = ch.height;
               }
               if(n >= numChildren)
               {
                  changeSize(tempWidth,tempHeight);
                  return;
               }
               j++;
            }
            posX = startPos.x;
            posY = posY + (maxHeight + _vSpace);
            i++;
         }
         changeSize(tempWidth,tempHeight);
         dispatchEvent(new Event("resize"));
      }
      
      private function verticalArrange() : void
      {
         var i:int = 0;
         var maxWidth:int = 0;
         var j:int = 0;
         var ch:* = null;
         var n:int = 0;
         var posX:int = startPos.x;
         var posY:int = startPos.y;
         var tempWidth:int = 0;
         var tempHeight:int = 0;
         for(i = 0; i < _rowNum; )
         {
            maxWidth = 0;
            for(j = 0; j < _column; )
            {
               n++;
               ch = getChildAt(n);
               ch.x = posX;
               ch.y = posY;
               tempWidth = Math.max(tempWidth,posX + ch.width);
               tempHeight = Math.max(tempHeight,posY + ch.height);
               posY = posY + (ch.height + _vSpace);
               if(maxWidth < ch.width)
               {
                  maxWidth = ch.width;
               }
               if(n >= numChildren)
               {
                  changeSize(tempWidth,tempHeight);
                  return;
               }
               j++;
            }
            posX = posX + (maxWidth + _hSpace);
            posY = startPos.y;
            i++;
         }
         changeSize(tempWidth,tempHeight);
         dispatchEvent(new Event("resize"));
      }
      
      private function changeSize(w:int, h:int) : void
      {
         if(w != _width || h != _height)
         {
            width = w;
            height = h;
         }
      }
      
      private function caculateRows() : void
      {
         _rowNum = Math.ceil(numChildren / _column);
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         var item:* = null;
         for(i = 0; i < numChildren; )
         {
            item = getChildAt(i) as DisplayObject;
            item.removeEventListener("click",__itemClick);
            i++;
         }
         super.dispose();
      }
   }
}
