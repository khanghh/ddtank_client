package ddt.view.chat{   import bagAndInfo.info.PlayerInfoViewControl;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.IconButton;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.image.Image;   import ddt.data.player.PlayerInfo;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.ChatManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import flash.events.MouseEvent;   import game.GameManager;   import room.RoomManager;   import room.model.RoomInfo;      public class ChatNamePanel extends ChatBasePanel   {                   public var _playerName:String;            public var channel:String = "";            public var message:String = "";            private var _bg:Image;            private var _blackListBtn:IconButton;            private var _viewInfoBtn:IconButton;            private var _addFriendBtn:IconButton;            private var _privateChat:IconButton;            private var _reportBtn:IconButton;            private var _inviteBtn:IconButton;            private var _btnContainer:VBox;            private var _data:PlayerInfo;            public function ChatNamePanel() { super(); }
            override protected function init() : void { }
            override protected function initEvent() : void { }
            public function get getHeight() : int { return 0; }
            private function __onBtnClicked(event:MouseEvent) : void { }
            private function exeInvite() : void { }
            public function set playerName(value:String) : void { }
            public function get playerName() : String { return null; }
            private function update() : void { }
            private function checkLevel(level:int) : Boolean { return false; }
            private function inviteLvTip(lv:int) : Boolean { return false; }
            override protected function removeEvent() : void { }
   }}