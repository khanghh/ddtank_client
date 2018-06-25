package ddt.view.chat{   import baglocked.BaglockedManager;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import ddt.data.player.FriendListPlayer;   import ddt.manager.ChatManager;   import ddt.manager.DebugManager;   import ddt.manager.IMEManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SoundManager;   import ddt.utils.FilterWordManager;   import ddt.utils.Helpers;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.geom.Point;   import flash.text.TextField;   import flash.text.TextFormat;   import road7th.utils.StringHelper;      public class ChatInputField extends Sprite   {            public static const INPUT_MAX_CHAT:int = 100;                   private var CHANNEL_KEY_SET:Array;            private var CHANNEL_SET:Array;            private var _channel:int = -1;            private var _currentHistoryOffset:int = 0;            private var _inputField:TextField;            private var _maxInputWidth:Number = 300;            private var _nameTextField:TextField;            private var _privateChatName:String;            private var _userID:int;            private var _privateChatInfo:Object;            public function ChatInputField() { super(); }
            public function get channel() : int { return 0; }
            public function set channel(channel:int) : void { }
            public function isFocus() : Boolean { return false; }
            public function set maxInputWidth($width:Number) : void { }
            public function get privateChatName() : String { return null; }
            public function get privateUserID() : int { return 0; }
            public function get privateChatInfo() : Object { return null; }
            public function sendCurrnetText() : void { }
            public function setFocus() : void { }
            public function setInputText(text:String) : void { }
            public function setPrivateChatName(name:String, useID:int = 0, info:Object = null) : void { }
            private function __onAddToStage(e:Event) : void { }
            private function __onFieldKeyDown(event:KeyboardEvent) : void { }
            private function canUseKeyboardSetFocus() : Boolean { return false; }
            private function __onInputFieldChange(e:Event) : void { }
            private function __setSelectIndexSync(event:Event) : void { }
            private function get currentHistoryOffset() : int { return 0; }
            private function set currentHistoryOffset(value:int) : void { }
            private function getHistoryChat(chatOffset:int) : String { return null; }
            private function initView() : void { }
            private function parasMsgs(fieldText:String) : String { return null; }
            private function setTextFocus() : void { }
            private function setTextFormat(textFormat:TextFormat) : void { }
            private function updatePosAndSize() : void { }
   }}