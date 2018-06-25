package ddt.view.chat.chatBall
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class ChatBallBoss extends ChatBallBase
   {
       
      
      public function ChatBallBoss()
      {
         POP_DELAY = 2000;
         super();
         init();
      }
      
      private function init() : void
      {
         _field = new ChatBallTextAreaBoss();
         _field.addEventListener("complete",__onTextDisplayCompleted);
      }
      
      override public function setText(s:String, paopaoType:int = 0) : void
      {
         clear();
         if(paopaoMC == null)
         {
            newPaopao();
         }
         if(paopaoType == 1)
         {
            (_field as ChatBallTextAreaBoss).animation = false;
         }
         else
         {
            (_field as ChatBallTextAreaBoss).animation = true;
         }
         var temp:int = this.globalToLocal(new Point(500,10)).x;
         _field.x = temp < 0?0:temp;
         _field.text = s;
         fitSize(_field);
         show();
      }
      
      override public function show() : void
      {
         super.show();
      }
      
      private function newPaopao() : void
      {
         paopaoMC = ComponentFactory.Instance.creat("ChatBall16000");
         _chatballBackground = new ChatBallBackground(paopaoMC);
         addChild(paopao);
      }
      
      private function __onTextDisplayCompleted(e:Event) : void
      {
         beginPopDelay();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
