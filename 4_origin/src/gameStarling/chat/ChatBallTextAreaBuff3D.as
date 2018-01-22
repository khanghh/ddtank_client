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
         var _loc1_:TextFormat = new TextFormat("Arial",20,16777062,"Bold",null,null,null,null,"left",null,null,null,2);
         var _loc2_:GlowFilter = new GlowFilter(5443595,1,4,4,2);
         tf.fText.setTextFormat(_loc1_);
         tf.fText.filters = [_loc2_];
         tf.fText.wordWrap = false;
         tf.fText.autoSize = "left";
         tf.fText.multiline = false;
         tf.x = 0;
         tf.y = 0;
         addChild(tf);
      }
      
      override public function set text(param1:String) : void
      {
         clear();
         _text = param1;
         tf.text = _text;
         tf.width = tf.fText.textWidth;
         tf.height = tf.fText.textHeight;
      }
   }
}
