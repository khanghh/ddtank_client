package ddt.view.chat.chatBall
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.geom.Point;
   import times.utils.timerManager.TimerManager;
   
   public class ChatBallPlayer extends ChatBallBase
   {
       
      
      private var _currentPaopaoType:int = 0;
      
      private var _field2:ChatBallTextAreaBuff;
      
      public function ChatBallPlayer(){super();}
      
      private function init() : void{}
      
      override protected function get field() : ChatBallTextAreaBase{return null;}
      
      override public function setText(param1:String, param2:int = 0) : void{}
      
      override public function show() : void{}
      
      override public function hide() : void{}
      
      override public function set width(param1:Number) : void{}
      
      private function newPaopao() : void{}
      
      override public function dispose() : void{}
   }
}
