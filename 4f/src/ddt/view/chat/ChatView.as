package ddt.view.chat
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import flash.display.Sprite;
   
   use namespace chat_system;
   
   public class ChatView extends Sprite
   {
      
      public static const STATE_LENGTH:int = 37;
       
      
      private var _input:ChatInputView;
      
      private var _output:ChatOutputView;
      
      private var _state:int = -1;
      
      private var _stateArr:Vector.<ChatViewInfo>;
      
      public function ChatView(){super();}
      
      public function get input() : ChatInputView{return null;}
      
      public function get output() : ChatOutputView{return null;}
      
      public function get state() : int{return 0;}
      
      private function updateViewState(param1:int) : void{}
      
      public function set state(param1:int) : void{}
      
      private function init() : void{}
   }
}
