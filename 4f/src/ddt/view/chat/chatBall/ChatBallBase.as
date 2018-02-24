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
      
      public function ChatBallBase(){super();}
      
      public function setText(param1:String, param2:int = 0) : void{}
      
      protected function get field() : ChatBallTextAreaBase{return null;}
      
      public function set direction(param1:Point) : void{}
      
      public function set directionX(param1:Number) : void{}
      
      public function set directionY(param1:Number) : void{}
      
      protected function get paopao() : ChatBallBackground{return null;}
      
      protected function fitSize(param1:MovieClip) : void{}
      
      protected function beginPopDelay() : void{}
      
      protected function __onPopupTimer(param1:Event) : void{}
      
      public function hide() : void{}
      
      public function show() : void{}
      
      public function clear() : void{}
      
      public function dispose() : void{}
   }
}
