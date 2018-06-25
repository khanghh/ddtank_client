package ddt.view.chat{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ComboBox;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.list.VectorListModel;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.data.player.FriendListPlayer;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;      public class ChatPrivateFrame extends BaseAlerFrame   {                   private var _friendList:Array;            private var _comBox:ComboBox;            private var _textField:FilterFrameText;            public function ChatPrivateFrame() { super(); }
            override protected function init() : void { }
            private function __setFocus(event:Event) : void { }
            private function __comChange(event:InteractiveEvent) : void { }
            private function __keyDownHandler(e:KeyboardEvent) : void { }
            private function __playSound(e:MouseEvent) : void { }
            override protected function addChildren() : void { }
            public function get currentFriend() : String { return null; }
            override public function dispose() : void { }
   }}