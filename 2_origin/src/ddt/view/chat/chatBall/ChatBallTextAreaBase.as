package ddt.view.chat.chatBall
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ChatBallTextAreaBase extends MovieClip
   {
       
      
      protected var _text:String;
      
      protected var tf:TextField;
      
      public function ChatBallTextAreaBase()
      {
         super();
         tf = new TextField();
         tf.multiline = true;
         tf.mouseEnabled = false;
         tf.wordWrap = true;
         initView();
      }
      
      protected function initView() : void
      {
         addChild(tf);
      }
      
      public function set text(value:String) : void
      {
         clear();
         _text = value;
         tf.text = _text;
      }
      
      public function set format(value:TextFormat) : void
      {
         tf.defaultTextFormat = value;
      }
      
      protected function clear() : void
      {
         _text = "";
         tf.text = "";
      }
      
      public function drawEdge() : void
      {
         graphics.clear();
         graphics.moveTo(tf.x,tf.y);
         graphics.lineStyle(1,16763921);
         graphics.lineTo(tf.x + tf.width,tf.y);
         graphics.lineTo(tf.x + tf.width,tf.y + tf.height);
         graphics.lineTo(tf.x,tf.y + tf.height);
         graphics.lineTo(tf.x,tf.y);
      }
      
      public function dispose() : void
      {
         tf = null;
      }
   }
}
