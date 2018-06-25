package morn.core.components
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class LayoutBox extends Box
   {
       
      
      protected var _space:Number = 0;
      
      protected var _align:String = "none";
      
      protected var _maxX:Number = 0;
      
      protected var _maxY:Number = 0;
      
      public function LayoutBox()
      {
         super();
      }
      
      override public function addChild(child:DisplayObject) : DisplayObject
      {
         setChild(child);
         child.addEventListener("resize",onResize);
         callLater(changeItems);
         return super.addChild(child);
      }
      
      private function setChild(child:DisplayObject) : void
      {
         if(child is Component)
         {
            if(child.x == 0)
            {
               _maxX = _maxX + 1;
               child.x = _maxX + 1;
            }
            if(child.y == 0)
            {
               _maxY = _maxY + 1;
               child.y = _maxY + 1;
            }
         }
      }
      
      private function onResize(e:Event) : void
      {
         callLater(changeItems);
      }
      
      override public function addChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         setChild(child);
         child.addEventListener("resize",onResize);
         callLater(changeItems);
         return super.addChildAt(child,index);
      }
      
      override public function removeChild(child:DisplayObject) : DisplayObject
      {
         child.removeEventListener("resize",onResize);
         callLater(changeItems);
         return super.removeChild(child);
      }
      
      override public function removeChildAt(index:int) : DisplayObject
      {
         getChildAt(index).removeEventListener("resize",onResize);
         callLater(changeItems);
         return super.removeChildAt(index);
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(changeItems);
      }
      
      public function refresh() : void
      {
         callLater(changeItems);
      }
      
      protected function changeItems() : void
      {
      }
      
      public function get space() : Number
      {
         return _space;
      }
      
      public function set space(value:Number) : void
      {
         _space = value;
         callLater(changeItems);
      }
      
      public function get align() : String
      {
         return _align;
      }
      
      public function set align(value:String) : void
      {
         _align = value;
         callLater(changeItems);
      }
   }
}
