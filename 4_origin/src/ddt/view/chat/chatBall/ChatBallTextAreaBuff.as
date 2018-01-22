package ddt.view.chat.chatBall
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   
   public class ChatBallTextAreaBuff extends ChatBallTextAreaBase
   {
       
      
      private var _movie:MovieClip;
      
      public function ChatBallTextAreaBuff()
      {
         super();
      }
      
      override protected function initView() : void
      {
         _movie = ComponentFactory.Instance.creat("tank.view.ChatTextfieldAsset");
         tf = null;
         tf = _movie["tf"];
         tf.wordWrap = false;
         tf.autoSize = "left";
         tf.multiline = false;
         tf.x = 0;
         tf.y = 0;
         addChild(tf);
      }
      
      override public function set text(param1:String) : void
      {
         clear();
         _text = param1;
         tf.text = _text;
         tf.width = tf.textWidth;
         tf.height = tf.textHeight;
      }
      
      override public function dispose() : void
      {
         _movie = null;
         super.dispose();
      }
   }
}
