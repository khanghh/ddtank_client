package im{   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.DoubleClickManager;   import ddt.data.CMFriendInfo;   import ddt.data.player.ConsortiaPlayerInfo;   import ddt.data.player.PlayerInfo;   import ddt.manager.ChatManager;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.PlayerTipManager;   import ddt.manager.SoundManager;   import ddt.view.common.SexIcon;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.geom.Point;      public class IMLookupItem extends Sprite implements Disposeable   {            public static const OUT:int = 1;            public static const OVER:int = 2;                   private var _info:Object;            private var _sex_icon:SexIcon;            private var _selected:Boolean;            private var _bg:ScaleFrameImage;            private var _name:FilterFrameText;            private var _privateChatBtn:SimpleBitmapButton;            private var _deleteBtn:SimpleBitmapButton;            private var _addFriendBtn:BaseButton;            private var _inviteBtn:BaseButton;            public function IMLookupItem(info:Object) { super(); }
            private function init() : void { }
            public function styleForJustName() : void { }
            private function initEvent() : void { }
            private function __addFriend(event:MouseEvent) : void { }
            private function __invite(event:MouseEvent) : void { }
            private function __bgClick(event:InteractiveEvent) : void { }
            private function _deleteBtnClick(event:MouseEvent) : void { }
            private function __privateChatClick(event:InteractiveEvent) : void { }
            private function __privateChatBtnClick(event:MouseEvent) : void { }
            private function __itemOut(event:MouseEvent) : void { }
            private function __itemOver(event:MouseEvent) : void { }
            public function get info() : Object { return null; }
            public function get text() : String { return null; }
            public function dispose() : void { }
   }}