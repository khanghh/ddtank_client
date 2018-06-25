package ddt.view.chat.chatBall
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.geom.Point;
   import times.utils.timerManager.TimerManager;
   
   public class ChatBallPlayer extends ChatBallBase
   {
       
      
      private var _currentPaopaoType:int = 0;
      
      private var _field2:ChatBallTextAreaBuff;
      
      public function ChatBallPlayer()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _field = new ChatBallTextAreaPlayer();
         _field2 = new ChatBallTextAreaBuff();
      }
      
      override protected function get field() : ChatBallTextAreaBase
      {
         if(_currentPaopaoType != 9)
         {
            return _field;
         }
         return _field2;
      }
      
      override public function setText(s:String, paopaoType:int = 0) : void
      {
         clear();
         if(paopaoType == 9)
         {
            _popupTimer = TimerManager.getInstance().addTimerJuggler(2700,1);
         }
         else
         {
            _popupTimer = TimerManager.getInstance().addTimerJuggler(4000,1);
         }
         if(_currentPaopaoType != paopaoType || paopaoMC == null)
         {
            _currentPaopaoType = paopaoType;
            newPaopao();
         }
         var temp:int = this.globalToLocal(new Point(500,10)).x;
         field.x = temp < 0?0:temp;
         field.text = s;
         fitSize(field);
         show();
      }
      
      override public function show() : void
      {
         super.show();
         beginPopDelay();
      }
      
      override public function hide() : void
      {
         super.hide();
         if(field && field.parent)
         {
            field.parent.removeChild(field);
         }
      }
      
      override public function set width(value:Number) : void
      {
         .super.width = value;
      }
      
      private function newPaopao() : void
      {
         if(paopao)
         {
            removeChild(paopao);
         }
         if(_currentPaopaoType == 9)
         {
            paopaoMC = ComponentFactory.Instance.creat("SpecificBall001");
         }
         else
         {
            paopaoMC = ComponentFactory.Instance.creat("ChatBall1600" + String(_currentPaopaoType));
         }
         _chatballBackground = new ChatBallBackground(paopaoMC);
         addChild(paopao);
      }
      
      override public function dispose() : void
      {
         _field2.dispose();
         super.dispose();
      }
   }
}
