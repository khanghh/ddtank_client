package ddt.view.chat{   import com.pickgliss.events.ListItemEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.ListPanel;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.SelectedTextButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelManager;   import ddt.data.player.BasePlayer;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.events.MouseEvent;      public class ChatFriendListPanel extends ChatBasePanel implements Disposeable   {            public static const FRIEND:uint = 0;            public static const CONSORTIA:uint = 1;                   private var _bg:ScaleBitmapImage;            private var _btnGroup:SelectedButtonGroup;            private var _btnConsortia:SelectedTextButton;            private var _btnFriend:SelectedTextButton;            private var _func:Function;            private var _playerList:ListPanel;            private var _showOffLineList:Boolean;            private var _currentType:uint;            public function ChatFriendListPanel() { super(); }
            public function setup(fun:Function, showOffLineList:Boolean = true) : void { }
            public function set currentType(value:int) : void { }
            private function updateBtns() : void { }
            public function refreshAllList() : void { }
            override public function set visible(value:Boolean) : void { }
            override protected function __hideThis(event:MouseEvent) : void { }
            private function __btnsClick(e:MouseEvent) : void { }
            private function _scrollClick(e:MouseEvent) : void { }
            private function __onFriendListComplete(e:Event = null) : void { }
            private function __updateConsortiaList(e:Event) : void { }
            private function __updateFriendList(e:Event) : void { }
            override protected function init() : void { }
            override protected function initEvent() : void { }
            override protected function removeEvent() : void { }
            private function setList(list:Array) : void { }
            private function __itemClick(event:ListItemEvent) : void { }
            public function dispose() : void { }
   }}