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
      
      public function DebugDrag(param1:DisplayObject = null)
      {
         super();
         this._target = param1;
         this.addEvent();
      }
      
      private function addEvent() : void
      {
         if(this.target == null)
         {
            return;
         }
         if(this.target.stage)
         {
            this.target.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.__mouseDown);
            this.target.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.__onKeyDown);
         }
         this.state = 1;
      }
      
      private function removeEvent() : void
      {
         if(this.target == null)
         {
            return;
         }
         if(this.target.stage)
         {
            this.target.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.__mouseDown);
            this.target.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.__onKeyDown);
         }
         this.target.removeEventListener(Event.ENTER_FRAME,this.__enterFrame);
      }
      
      private function __enterFrame(param1:Event) : void
      {
         this.target.x = this.target.x + (this.target.parent.mouseX - this.preX);
         this.target.y = this.target.y + (this.target.parent.mouseY - this.preY);
         this.preX = this.target.parent.mouseX;
         this.preY = this.target.parent.mouseY;
      }
      
      public function stop() : void
      {
         if(this.target && this.target.stage)
         {
            this.target.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.__onKeyDown);
            this.target.removeEventListener(Event.ENTER_FRAME,this.__enterFrame);
         }
      }
      
      private function __mouseDown(param1:MouseEvent) : void
      {
         if(this.state > 0)
         {
            this.state = 0;
            this.preX = this.target.parent.mouseX;
            this.preY = this.target.parent.mouseY;
            this.target.addEventListener(Event.ENTER_FRAME,this.__enterFrame);
         }
         else
         {
            this.stop();
         }
      }
      
      protected final function callBackFunction(param1:Function) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.length > 0)
         {
            param1(this);
         }
         else
         {
            param1();
         }
      }
      
      public function get target() : DisplayObject
      {
         return this._target;
      }
      
      public function set target(param1:DisplayObject) : void
      {
         this.removeEvent();
         this._target = param1;
         this.addEvent();
      }
      
      private function __onKeyDown(param1:KeyboardEvent) : void
      {
         this.state = 0;
         switch(param1.keyCode)
         {
            case Keyboard.UP:
               this._target.y--;
               break;
            case Keyboard.DOWN:
               this._target.y++;
               break;
            case Keyboard.LEFT:
               this._target.x--;
               break;
            case Keyboard.RIGHT:
               this._target.x++;
         }
      }
   }
}
