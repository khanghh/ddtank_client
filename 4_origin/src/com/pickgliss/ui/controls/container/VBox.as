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
         var i:int = 0;
         var child:* = null;
         _width = 0;
         _height = 0;
         var ypos:* = 0;
         var xpos:* = 0;
         for(i = 0; i < _childrenList.length; )
         {
            child = _childrenList[i];
            child.y = ypos;
            ypos = Number(ypos + getItemHeight(child));
            ypos = Number(ypos + _spacing);
            if(_autoSize == 2 && i != 0)
            {
               xpos = Number(_childrenList[0].x - (child.width - _childrenList[0].width) / 2);
            }
            else if(_autoSize == 1 && i != 0)
            {
               xpos = Number(_childrenList[0].x - (child.width - _childrenList[0].width));
            }
            else
            {
               xpos = Number(child.x);
            }
            child.x = xpos;
            _height = _height + getItemHeight(child);
            _width = Math.max(_width,child.width);
            i++;
         }
         _height = _height + _spacing * (numChildren - 1);
         _height = Math.max(0,_height);
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
   }
}
