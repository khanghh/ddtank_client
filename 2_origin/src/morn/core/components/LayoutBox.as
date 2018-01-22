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
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         this.setChild(param1);
         param1.addEventListener(Event.RESIZE,this.onResize);
         callLater(this.changeItems);
         return super.addChild(param1);
      }
      
      private function setChild(param1:DisplayObject) : void
      {
         if(param1 is Component)
         {
            if(param1.x == 0)
            {
               param1.x = ++this._maxX;
            }
            if(param1.y == 0)
            {
               param1.y = ++this._maxY;
            }
         }
      }
      
      private function onResize(param1:Event) : void
      {
         callLater(this.changeItems);
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         this.setChild(param1);
         param1.addEventListener(Event.RESIZE,this.onResize);
         callLater(this.changeItems);
         return super.addChildAt(param1,param2);
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         param1.removeEventListener(Event.RESIZE,this.onResize);
         callLater(this.changeItems);
         return super.removeChild(param1);
      }
      
      override public function removeChildAt(param1:int) : DisplayObject
      {
         getChildAt(param1).removeEventListener(Event.RESIZE,this.onResize);
         callLater(this.changeItems);
         return super.removeChildAt(param1);
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(this.changeItems);
      }
      
      public function refresh() : void
      {
         callLater(this.changeItems);
      }
      
      protected function changeItems() : void
      {
      }
      
      public function get space() : Number
      {
         return this._space;
      }
      
      public function set space(param1:Number) : void
      {
         this._space = param1;
         callLater(this.changeItems);
      }
      
      public function get align() : String
      {
         return this._align;
      }
      
      public function set align(param1:String) : void
      {
         this._align = param1;
         callLater(this.changeItems);
      }
   }
}
