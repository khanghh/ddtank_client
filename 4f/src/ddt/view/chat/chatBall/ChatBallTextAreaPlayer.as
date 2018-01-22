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
      
      public function ChatBallTextAreaPlayer(){super();}
      
      override protected function initView() : void{}
      
      override public function set text(param1:String) : void{}
      
      protected function chooseSize(param1:String) : void{}
      
      override public function get width() : Number{return 0;}
      
      override public function get height() : Number{return 0;}
      
      public function setTextField(param1:TextField) : void{}
      
      override public function dispose() : void{}
   }
}
