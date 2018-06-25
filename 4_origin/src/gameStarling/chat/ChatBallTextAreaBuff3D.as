package gameStarling.chat
{
   import flash.filters.GlowFilter;
   import flash.text.TextFormat;
   
   public class ChatBallTextAreaBuff3D extends ChatBallTextAreaBase3D
   {
       
      
      public function ChatBallTextAreaBuff3D()
      {
         super();
      }
      
      override protected function initView() : void
      {
         var format:TextFormat = new TextFormat("Arial",20,16777062,"Bold",null,null,null,null,"left",null,null,null,2);
         var filter:GlowFilter = new GlowFilter(5443595,1,4,4,2);
         tf.fText.setTextFormat(format);
         tf.fText.filters = [filter];
         tf.fText.wordWrap = false;
         tf.fText.autoSize = "left";
         tf.fText.multiline = false;
         tf.x = 0;
         tf.y = 0;
         addChild(tf);
      }
      
      override public function set text(value:String) : void
      {
         clear();
         _text = value;
         tf.text = _text;
         tf.width = tf.fText.textWidth;
         tf.height = tf.fText.textHeight;
      }
   }
}
