package yzhkof.ui
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import yzhkof.MyGraphy;
   
   public class DragPanel extends BackGroudContainer
   {
       
      
      protected var _dragContainer:DisplayObjectContainer;
      
      protected var _content:DisplayObjectContainer;
      
      public function DragPanel(){super();}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function __onStartDrag(param1:Event) : void{}
      
      private function __onStopDrag(param1:Event) : void{}
      
      public function get content() : DisplayObjectContainer{return null;}
   }
}
