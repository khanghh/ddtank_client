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
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         setChild(param1);
         param1.addEventListener("resize",onResize);
         super.addChild(param1);
         changeItems();
         return param1;
      }
      
      private function setChild(param1:DisplayObject) : void
      {
         if(param1 is Component)
         {
            if(param1.x == 0)
            {
               _maxX = _maxX + 1;
               param1.x = _maxX + 1;
            }
            if(param1.y == 0)
            {
               _maxY = _maxY + 1;
               param1.y = _maxY + 1;
            }
         }
      }
      
      private function onResize(param1:Event) : void
      {
         changeItems();
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         setChild(param1);
         param1.addEventListener("resize",onResize);
         super.addChildAt(param1,param2);
         changeItems();
         return param1;
      }
      
      override public function removeChild(param1:DisplayObject, param2:Boolean = false) : DisplayObject
      {
         param1.removeEventListener("resize",onResize);
         changeItems();
         return super.removeChild(param1,param2);
      }
      
      override public function removeChildAt(param1:int, param2:Boolean = false) : DisplayObject
      {
         getChildAt(param1).removeEventListener("resize",onResize);
         changeItems();
         return super.removeChildAt(param1,param2);
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
      
      public function set space(param1:Number) : void
      {
         _space = param1;
         changeItems();
      }
      
      public function get align() : String
      {
         return _align;
      }
      
      public function set align(param1:String) : void
      {
         _align = param1;
         changeItems();
      }
   }
}
