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
         var i:int = 0;
         var child:* = null;
         _width = 0;
         _height = 0;
         var xpos:* = 0;
         var ypos:* = 0;
         for(i = 0; i < _childrenList.length; )
         {
            child = _childrenList[i];
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
            else
            {
               ypos = Number(_childrenList[0].y);
            }
            child.y = ypos;
            _width = _width + getItemWidth(child);
            _height = Math.max(_height,child.height);
            i++;
         }
         _width = _width + _spacing * (numChildren - 1);
         _width = Math.max(0,_width);
         dispatchEvent(new Event("resize"));
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
