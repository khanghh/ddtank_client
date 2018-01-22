package gameStarling.chat
{
   import com.pickgliss.utils.StarlingObjectUtils;
   import flash.text.TextFormat;
   import starling.display.Sprite;
   import starlingui.core.text.TextLabel;
   
   public class ChatBallTextAreaBase3D extends Sprite
   {
       
      
      protected var _text:String;
      
      protected var tf:TextLabel;
      
      public function ChatBallTextAreaBase3D(){super();}
      
      protected function initView() : void{}
      
      public function set text(param1:String) : void{}
      
      public function set format(param1:TextFormat) : void{}
      
      protected function clear() : void{}
      
      override public function dispose() : void{}
   }
}
