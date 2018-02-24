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
      
      public function ChatBallBase3D(){super();}
      
      public function setText(param1:String, param2:int = 0) : void{}
      
      protected function get field() : ChatBallTextAreaBase3D{return null;}
      
      public function set direction(param1:Point) : void{}
      
      public function set directionX(param1:Number) : void{}
      
      public function set directionY(param1:Number) : void{}
      
      protected function get paopao() : ChatBallBackground3D{return null;}
      
      protected function fitSize(param1:ChatBallTextAreaBase3D) : void{}
      
      protected function beginPopDelay() : void{}
      
      protected function __onPopupTimer(param1:flash.events.Event) : void{}
      
      public function hide() : void{}
      
      public function show() : void{}
      
      public function clear() : void{}
      
      override public function dispose() : void{}
   }
}
