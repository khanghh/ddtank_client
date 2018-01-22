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
      
      override public function setText(param1:String, param2:int = 0) : void
      {
         clear();
         if(param2 == 9)
         {
            _popupTimer = TimerManager.getInstance().addTimerJuggler(2700,1);
         }
         else
         {
            _popupTimer = TimerManager.getInstance().addTimerJuggler(4000,1);
         }
         if(_currentPaopaoType != param2 || paopaoMC == null)
         {
            _currentPaopaoType = param2;
            newPaopao();
         }
         var _loc3_:int = this.globalToLocal(new Point(500,10)).x;
         field.x = _loc3_ < 0?0:_loc3_;
         field.text = param1;
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
      
      override public function set width(param1:Number) : void
      {
         .super.width = param1;
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
