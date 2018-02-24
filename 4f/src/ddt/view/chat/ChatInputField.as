package ddt.view.chat
{
   import baglocked.BaglockedManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.player.FriendListPlayer;
   import ddt.manager.ChatManager;
   import ddt.manager.DebugManager;
   import ddt.manager.IMEManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.Helpers;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import road7th.utils.StringHelper;
   
   public class ChatInputField extends Sprite
   {
      
      public static const INPUT_MAX_CHAT:int = 100;
       
      
      private var CHANNEL_KEY_SET:Array;
      
      private var CHANNEL_SET:Array;
      
      private var _channel:int = -1;
      
      private var _currentHistoryOffset:int = 0;
      
      private var _inputField:TextField;
      
      private var _maxInputWidth:Number = 300;
      
      private var _nameTextField:TextField;
      
      private var _privateChatName:String;
      
      private var _userID:int;
      
      private var _privateChatInfo:Object;
      
      public function ChatInputField(){super();}
      
      public function get channel() : int{return 0;}
      
      public function set channel(param1:int) : void{}
      
      public function isFocus() : Boolean{return false;}
      
      public function set maxInputWidth(param1:Number) : void{}
      
      public function get privateChatName() : String{return null;}
      
      public function get privateUserID() : int{return 0;}
      
      public function get privateChatInfo() : Object{return null;}
      
      public function sendCurrnetText() : void{}
      
      public function setFocus() : void{}
      
      public function setInputText(param1:String) : void{}
      
      public function setPrivateChatName(param1:String, param2:int = 0, param3:Object = null) : void{}
      
      private function __onAddToStage(param1:Event) : void{}
      
      private function __onFieldKeyDown(param1:KeyboardEvent) : void{}
      
      private function canUseKeyboardSetFocus() : Boolean{return false;}
      
      private function __onInputFieldChange(param1:Event) : void{}
      
      private function __setSelectIndexSync(param1:Event) : void{}
      
      private function get currentHistoryOffset() : int{return 0;}
      
      private function set currentHistoryOffset(param1:int) : void{}
      
      private function getHistoryChat(param1:int) : String{return null;}
      
      private function initView() : void{}
      
      private function parasMsgs(param1:String) : String{return null;}
      
      private function setTextFocus() : void{}
      
      private function setTextFormat(param1:TextFormat) : void{}
      
      private function updatePosAndSize() : void{}
   }
}
