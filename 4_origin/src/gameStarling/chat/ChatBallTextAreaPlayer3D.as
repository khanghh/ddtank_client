package gameStarling.chat
{
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ChatBallTextAreaPlayer3D extends ChatBallTextAreaBase3D
   {
       
      
      private const _SMALL_W:int = 80;
      
      private const _MIDDLE_W:int = 100;
      
      private const _BIG_H:int = 70;
      
      private const _BIG_W:int = 120;
      
      protected var hiddenTF:TextField;
      
      private var _textWidth:int;
      
      private var _indexOfEnd:int;
      
      public function ChatBallTextAreaPlayer3D()
      {
         super();
      }
      
      override protected function initView() : void
      {
         tf.fText.filters = [new GlowFilter(16777215,1,2,2,10)];
         tf.fText.autoSize = "left";
         tf.fText.multiline = true;
         tf.fText.wordWrap = true;
         addChild(tf);
         tf.x = 0;
         tf.y = 0;
      }
      
      override public function set text(param1:String) : void
      {
         tf.text = param1;
         param1 = tf.text;
         chooseSize(param1);
         tf.text = param1;
         tf.width = _textWidth;
         if(tf.height >= 70)
         {
            tf.height = 70;
         }
         _indexOfEnd = 0;
         if(tf.fText.numLines > 4)
         {
            _indexOfEnd = tf.fText.getLineOffset(4) - 3;
            param1 = param1.substring(0,_indexOfEnd) + "...";
         }
         tf.text = param1;
      }
      
      protected function chooseSize(param1:String) : void
      {
         _indexOfEnd = -1;
         var _loc3_:TextFormat = tf.fText.defaultTextFormat;
         hiddenTF = new TextField();
         setTextField(hiddenTF);
         _loc3_.letterSpacing = 1;
         hiddenTF.defaultTextFormat = _loc3_;
         _loc3_.align = "center";
         tf.fText.defaultTextFormat = _loc3_;
         hiddenTF.text = param1;
         var _loc2_:int = hiddenTF.textWidth;
         if(_loc2_ < 80)
         {
            _textWidth = 80;
            return;
         }
         if(_loc2_ < 170)
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
      
      public function setTextField(param1:TextField) : void
      {
         param1.autoSize = "left";
      }
      
      override public function dispose() : void
      {
         hiddenTF = null;
      }
   }
}
