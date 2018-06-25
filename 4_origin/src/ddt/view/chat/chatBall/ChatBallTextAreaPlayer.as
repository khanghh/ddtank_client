package ddt.view.chat.chatBall
{
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ChatBallTextAreaPlayer extends ChatBallTextAreaBase
   {
       
      
      private const _SMALL_W:int = 80;
      
      private const _MIDDLE_W:int = 100;
      
      private const _BIG_H:int = 70;
      
      private const _BIG_W:int = 120;
      
      protected var hiddenTF:TextField;
      
      private var _textWidth:int;
      
      private var _indexOfEnd:int;
      
      public function ChatBallTextAreaPlayer()
      {
         super();
      }
      
      override protected function initView() : void
      {
         tf.filters = [new GlowFilter(16777215,1,2,2,10)];
         tf.autoSize = "left";
         tf.multiline = true;
         tf.wordWrap = true;
         addChild(tf);
         tf.x = 0;
         tf.y = 0;
      }
      
      override public function set text(value:String) : void
      {
         tf.htmlText = value;
         chooseSize(value);
         tf.width = _textWidth;
         if(tf.height >= 70)
         {
            tf.height = 70;
         }
         _indexOfEnd = 0;
         if(tf.numLines > 4)
         {
            _indexOfEnd = tf.getLineOffset(4) - 3;
            value = value.substring(0,_indexOfEnd) + "...";
         }
         tf.htmlText = value;
      }
      
      protected function chooseSize(message:String) : void
      {
         _indexOfEnd = -1;
         var format:TextFormat = tf.defaultTextFormat;
         hiddenTF = new TextField();
         setTextField(hiddenTF);
         format.letterSpacing = 1;
         hiddenTF.defaultTextFormat = format;
         format.align = "center";
         tf.defaultTextFormat = format;
         hiddenTF.text = message;
         var _width:int = hiddenTF.textWidth;
         if(_width < 80)
         {
            _textWidth = 80;
            return;
         }
         if(_width < 170)
         {
            _textWidth = 100;
            return;
         }
         _textWidth = 120;
      }
      
      override public function get width() : Number
      {
         return tf.width;
      }
      
      override public function get height() : Number
      {
         return tf.height;
      }
      
      public function setTextField(tf:TextField) : void
      {
         tf.autoSize = "left";
      }
      
      override public function dispose() : void
      {
         hiddenTF = null;
      }
   }
}
