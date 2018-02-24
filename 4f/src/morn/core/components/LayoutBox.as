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
      
      public function LayoutBox(){super();}
      
      override public function addChild(param1:DisplayObject) : DisplayObject{return null;}
      
      private function setChild(param1:DisplayObject) : void{}
      
      private function onResize(param1:Event) : void{}
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject{return null;}
      
      override public function removeChild(param1:DisplayObject) : DisplayObject{return null;}
      
      override public function removeChildAt(param1:int) : DisplayObject{return null;}
      
      override public function commitMeasure() : void{}
      
      public function refresh() : void{}
      
      protected function changeItems() : void{}
      
      public function get space() : Number{return 0;}
      
      public function set space(param1:Number) : void{}
      
      public function get align() : String{return null;}
      
      public function set align(param1:String) : void{}
   }
}
