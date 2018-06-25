package starlingui.core.components
{
   import starling.display.DisplayObject;
   import starling.events.Event;
   
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
         super.addChild(child);
         changeItems();
         return child;
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
         changeItems();
      }
      
      override public function addChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         setChild(child);
         child.addEventListener("resize",onResize);
         super.addChildAt(child,index);
         changeItems();
         return child;
      }
      
      override public function removeChild(child:DisplayObject, dispose:Boolean = false) : DisplayObject
      {
         child.removeEventListener("resize",onResize);
         changeItems();
         return super.removeChild(child,dispose);
      }
      
      override public function removeChildAt(index:int, dispose:Boolean = false) : DisplayObject
      {
         getChildAt(index).removeEventListener("resize",onResize);
         changeItems();
         return super.removeChildAt(index,dispose);
      }
      
      override public function commitMeasure() : void
      {
         changeItems();
      }
      
      public function refresh() : void
      {
         changeItems();
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
         changeItems();
      }
      
      public function get align() : String
      {
         return _align;
      }
      
      public function set align(value:String) : void
      {
         _align = value;
         changeItems();
      }
   }
}
