package gameStarling.chat
{
   import com.pickgliss.utils.StarlingObjectUtils;
   import flash.events.Event;
   import flash.geom.Point;
   import starling.display.Sprite;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ChatBallBase3D extends Sprite
   {
       
      
      protected var POP_REPEAT:int = 1;
      
      protected var POP_DELAY:int = 2300;
      
      protected var _popupTimer:TimerJuggler;
      
      protected var _chatballBackground:ChatBallBackground3D;
      
      protected var _field:ChatBallTextAreaBase3D;
      
      public function ChatBallBase3D()
      {
         super();
         _popupTimer = TimerManager.getInstance().addTimerJuggler(POP_DELAY,POP_REPEAT);
         hide();
      }
      
      public function setText(param1:String, param2:int = 0) : void
      {
      }
      
      protected function get field() : ChatBallTextAreaBase3D
      {
         return _field;
      }
      
      public function set direction(param1:Point) : void
      {
         paopao.direction = param1;
         fitSize(field);
      }
      
      public function set directionX(param1:Number) : void
      {
         direction = new Point(param1,paopao.direction.y);
      }
      
      public function set directionY(param1:Number) : void
      {
         direction = new Point(paopao.direction.x,param1);
      }
      
      protected function get paopao() : ChatBallBackground3D
      {
         return _chatballBackground;
      }
      
      protected function fitSize(param1:ChatBallTextAreaBase3D) : void
      {
         paopao.fitSize(new Point(param1.width,param1.height));
         param1.x = paopao.textArea.x;
         param1.y = paopao.textArea.y;
         if(paopao.textArea.width / param1.width > paopao.textArea.height / param1.height)
         {
            param1.x = paopao.textArea.x + (paopao.textArea.width - param1.width) / 2;
         }
         else
         {
            param1.y = paopao.textArea.y + (paopao.textArea.height - param1.height) / 2;
         }
         addChild(param1);
      }
      
      protected function beginPopDelay() : void
      {
         _popupTimer.addEventListener("timerComplete",__onPopupTimer,false,0,true);
         _popupTimer.reset();
         _popupTimer.start();
      }
      
      protected function __onPopupTimer(param1:flash.events.Event) : void
      {
         _popupTimer.removeEventListener("timerComplete",__onPopupTimer);
         _popupTimer.stop();
         hide();
      }
      
      public function hide() : void
      {
         visible = false;
         StarlingObjectUtils.removeObject(field);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         dispatchEvent(new starling.events.Event("complete"));
      }
      
      public function show() : void
      {
         visible = true;
      }
      
      public function clear() : void
      {
         _popupTimer.removeEventListener("timerComplete",__onPopupTimer);
         _popupTimer.stop();
      }
      
      override public function dispose() : void
      {
         if(_popupTimer)
         {
            _popupTimer.stop();
            _popupTimer.removeEventListener("timerComplete",__onPopupTimer);
            TimerManager.getInstance().removeJugglerByTimer(_popupTimer);
            _popupTimer = null;
         }
         StarlingObjectUtils.disposeObject(_chatballBackground);
         _chatballBackground = null;
         StarlingObjectUtils.disposeObject(_field);
         _field = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
