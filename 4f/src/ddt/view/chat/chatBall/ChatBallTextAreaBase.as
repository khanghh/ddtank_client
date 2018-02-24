package ddt.view.chat.chatBall
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ChatBallTextAreaBase extends MovieClip
   {
       
      
      protected var _text:String;
      
      protected var tf:TextField;
      
      public function ChatBallTextAreaBase(){super();}
      
      protected function initView() : void{}
      
      public function set text(param1:String) : void{}
      
      public function set format(param1:TextFormat) : void{}
      
      protected function clear() : void{}
      
      public function drawEdge() : void{}
      
      public function dispose() : void{}
   }
}
