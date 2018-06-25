package consortionBattle.view{   import com.pickgliss.manager.CacheSysManager;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import consortionBattle.ConsortiaBattleManager;   import ddt.manager.ChatManager;   import ddt.manager.KeyboardShortcutsManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.states.BaseStateView;   import ddt.view.MainToolBar;   import flash.display.Sprite;   import flash.events.Event;   import gameCommon.GameControl;   import invite.InviteManager;      public class ConsortiaBattleMainView extends BaseStateView   {                   private var _mapView:ConsortiaBattleMapView;            private var _exitBtn:ConsBatExitBtn;            private var _infoView:ConsBatInfoView;            private var _inTimerView:ConsBatInTimer;            private var _twoBtnView:ConsBatTwoBtnView;            private var _hideBtn:ConsBatHideBtn;            private var _helpBtn:ConsBatHelpBtn;            private var _socreView:ConsBatScoreView;            private var _broadcastView:ConsBatChatView;            private var _chatView:Sprite;            public function ConsortiaBattleMainView() { super(); }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function initView() : void { }
            private function initEvent() : void { }
            private function closeHandler(event:Event) : void { }
            private function initData() : void { }
            private function __startLoading(e:Event) : void { }
            override public function leaving(next:BaseStateView) : void { }
            override public function getType() : String { return null; }
            override public function dispose() : void { }
   }}