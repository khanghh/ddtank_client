package ddt.view.chat.chatBall
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ChatBallBase extends Sprite implements Disposeable
   {
       
      
      protected var POP_REPEAT:int = 1;
      
      protected var POP_DELAY:int = 2300;
      
      protected var paopaoMC:MovieClip;
      
      protected var _popupTimer:TimerJuggler;
      
      protected var _chatballBackground:ChatBallBackground;
      
      protected var _field:ChatBallTextAreaBase;
      
      public function ChatBallBase()
      {
         super();
         _popupTimer = TimerManager.getInstance().addTimerJuggler(POP_DELAY,POP_REPEAT);
         hide();
      }
      
      public function setText(content:String, chatball:int = 0) : void
      {
      }
      
      protected function get field() : ChatBallTextAreaBase
      {
         return _field;
      }
      
      public function set direction(value:Point) : void
      {
         paopao.direction = value;
         fitSize(field);
      }
      
      public function set directionX(value:Number) : void
      {
         direction = new Point(value,paopao.direction.y);
      }
      
      public function set directionY(value:Number) : void
      {
         direction = new Point(paopao.direction.x,value);
      }
      
      protected function get paopao() : ChatBallBackground
      {
         return _chatballBackground;
      }
      
      protected function fitSize(field:MovieClip) : void
      {
         paopao.fitSize(new Point(field.width,field.height));
         field.x = paopao.textArea.x;
         field.y = paopao.textArea.y;
         if(paopao.textArea.width / field.width > paopao.textArea.height / field.height)
         {
            field.x = paopao.textArea.x + (paopao.textArea.width - field.width) / 2;
         }
         else
         {
            field.y = paopao.textArea.y + (paopao.textArea.height - field.height) / 2;
         }
         addChild(field);
      }
      
      protected function beginPopDelay() : void
      {
         _popupTimer.addEventListener("timerComplete",__onPopupTimer,false,0,true);
         _popupTimer.reset();
         _popupTimer.start();
      }
      
      protected function __onPopupTimer(e:Event) : void
      {
         _popupTimer.removeEventListener("timerComplete",__onPopupTimer);
         _popupTimer.stop();
         hide();
      }
      
      public function hide() : void
      {
         visible = false;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         dispatchEvent(new Event("complete"));
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
      
      public function dispose() : void
      {
         if(_popupTimer)
         {
            _popupTimer.stop();
            _popupTimer.removeEventListener("timerComplete",__onPopupTimer);
            TimerManager.getInstance().removeJugglerByTimer(_popupTimer);
            _popupTimer = null;
         }
         if(paopao && paopao.parent)
         {
            this.removeChild(paopao);
         }
         if(_field)
         {
            _field.dispose();
         }
         _field = null;
         if(_chatballBackground)
         {
            _chatballBackground.dispose();
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
