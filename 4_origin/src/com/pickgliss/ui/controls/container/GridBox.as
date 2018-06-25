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
      
      public function set checkAlignForFirstRow(value:Boolean) : void
      {
         value = value;
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
         var i:int = 0;
         var child:* = null;
         var last:* = null;
         var offset:int = 0;
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
         var xpos:* = 0;
         var ypos:* = 0;
         for(i = 0; i < _childrenList.length; )
         {
            child = _childrenList[i];
            if(i % columnNumber == 0)
            {
               xpos = 0;
            }
            child.x = xpos;
            xpos = Number(xpos + getItemWidth(child));
            xpos = Number(xpos + _spacing);
            if(_autoSize == 2 && i != 0)
            {
               ypos = Number(_childrenList[0].y - (child.height - _childrenList[0].height) / 2);
            }
            else if(_autoSize == 1 && i != 0)
            {
               ypos = Number(_childrenList[0].y - (child.height - _childrenList[0].height));
            }
            else if(_autoSize == 3)
            {
               ypos = 0;
            }
            else
            {
               ypos = Number(_childrenList[0].y);
            }
            ypos = Number(ypos + cellHeght * (int(i / columnNumber)));
            child.y = ypos;
            if(i < columnNumber)
            {
               _width = _width + (getItemWidth(child) + _spacing);
            }
            _height = Math.max(_height,(int(i / columnNumber) + (i % columnNumber > 0?1:0)) * cellHeght);
            i++;
         }
         if(align == "right" && __checkAlignFunction())
         {
            last = _childrenList[_childrenList.length - 1] as DisplayObject;
            offset = lastRowWidthMax - last.x - last.width;
            i = int(_childrenList.length / columnNumber) * columnNumber;
            while(i < _childrenList.length)
            {
               _childrenList[i].x = _childrenList[i].x + offset;
               i++;
            }
         }
         _width = Math.max(0,_width);
         dispatchEvent(new Event("resize"));
      }
      
      private function getItemHeight(child:DisplayObject) : Number
      {
         if(isStrictSize)
         {
            return _strictSize;
         }
         return child.height;
      }
      
      private function getItemWidth(child:DisplayObject) : Number
      {
         if(isStrictSize)
         {
            return _strictSize;
         }
         return child.width;
      }
   }
}
