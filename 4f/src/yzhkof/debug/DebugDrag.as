package yzhkof.debug
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   
   public class DebugDrag
   {
       
      
      public var data;
      
      private var _target:DisplayObject;
      
      private var state:int = 1;
      
      private var preX:Number;
      
      private var preY:Number;
      
      public function DebugDrag(param1:DisplayObject = null){super();}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __enterFrame(param1:Event) : void{}
      
      public function stop() : void{}
      
      private function __mouseDown(param1:MouseEvent) : void{}
      
      protected final function callBackFunction(param1:Function) : void{}
      
      public function get target() : DisplayObject{return null;}
      
      public function set target(param1:DisplayObject) : void{}
      
      private function __onKeyDown(param1:KeyboardEvent) : void{}
   }
}
