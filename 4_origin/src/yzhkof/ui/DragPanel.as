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
      
      public function DragPanel()
      {
         this._dragContainer = new Sprite();
         this._content = new Sprite();
         super();
         this.init();
         this.initEvent();
      }
      
      private function init() : void
      {
         addChild(this._dragContainer);
         addChild(this._content);
         this._dragContainer.addChild(MyGraphy.drawRectangle(20,20));
         this._content.y = 20;
         Sprite(this._dragContainer).buttonMode = true;
      }
      
      private function initEvent() : void
      {
         this._dragContainer.addEventListener(MouseEvent.MOUSE_DOWN,this.__onStartDrag);
         this._dragContainer.addEventListener(MouseEvent.MOUSE_UP,this.__onStopDrag);
      }
      
      private function __onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function __onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      public function get content() : DisplayObjectContainer
      {
         return this._content;
      }
   }
}
