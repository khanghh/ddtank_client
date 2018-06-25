package im{   import com.pickgliss.loader.DisplayLoader;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.CMFriendInfo;   import ddt.manager.ChatManager;   import ddt.manager.DesktopManager;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.SoundManager;   import ddt.view.common.LevelIcon;   import ddt.view.common.SexIcon;   import flash.display.Bitmap;   import flash.display.Loader;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.IOErrorEvent;   import flash.events.MouseEvent;   import flash.external.ExternalInterface;   import flash.geom.Point;   import flash.net.URLRequest;   import flash.net.navigateToURL;   import flash.system.LoaderContext;   import road7th.utils.StringHelper;      public class CMFriendItem extends Sprite implements Disposeable   {                   private var _info:CMFriendInfo;            private var _bg:ScaleFrameImage;            private var _levelIcon:LevelIcon;            private var _sexIcon:SexIcon;            private var _nameText:FilterFrameText;            private var _CMNameText:FilterFrameText;            private var _iconBg:Bitmap;            private var _iconLight:Bitmap;            private var _loader:DisplayLoader;            private var _icon:Bitmap;            private var _iconSprite:Sprite;            private var _isSelected:Boolean;            private var _privateChatBtn:BaseButton;            private var _addFriendBtn:BaseButton;            private var _inviteBtn:BaseButton;            private var _load:Loader;            private var _loaderContext:LoaderContext;            public function CMFriendItem() { super(); }
            private function init() : void { }
            private function __loadIoErrorHandler(event:IOErrorEvent) : void { }
            private function __loadCompleteHandler(event:Event) : void { }
            protected function loadIcon() : void { }
            private function __complete(event:LoaderEvent) : void { }
            private function initEvent() : void { }
            private function __invite(event:MouseEvent) : void { }
            private function __addFriend(event:MouseEvent) : void { }
            private function __privateChat(event:MouseEvent) : void { }
            private function _iconClick(event:MouseEvent) : void { }
            private function __itemOver(event:MouseEvent) : void { }
            private function __itemOut(event:MouseEvent) : void { }
            public function itemOver() : void { }
            public function itemOut() : void { }
            private function update() : void { }
            public function set info(value:CMFriendInfo) : void { }
            public function get info() : CMFriendInfo { return null; }
            public function dispose() : void { }
   }}