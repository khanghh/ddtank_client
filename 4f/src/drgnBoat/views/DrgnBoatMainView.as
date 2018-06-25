package drgnBoat.views{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.manager.CacheSysManager;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ChatManager;   import ddt.manager.KeyboardShortcutsManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.states.BaseStateView;   import ddt.utils.PositionUtils;   import ddt.view.MainToolBar;   import drgnBoat.DrgnBoatManager;   import drgnBoat.event.DrgnBoatEvent;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.utils.getDefinitionByName;   import gameCommon.GameControl;   import invite.InviteManager;      public class DrgnBoatMainView extends BaseStateView   {                   private var _mapView:DrgnBoatMapView;            private var _exitBtn:DrgnBoatExitBtn;            private var _threeBtnView:DrgnBoatThreeBtnView;            private var _countDownView:DrgnBoatCountDown;            private var _rankView:DrgnBoatRankView;            private var _chatView:Sprite;            private var _waitMc:MovieClip;            private var _gameStartCountDownView:DrgnBoatStartCountDown;            private var _helpBtn:DrgnBoatHelpBtn;            private var _arriveCountDown:DrgnBoatArriveCountDown;            public function DrgnBoatMainView() { super(); }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function initView() : void { }
            private function initEvent() : void { }
            private function destroyHandler(e:Event) : void { }
            private function arriveHandler(event:DrgnBoatEvent) : void { }
            private function returnMainState(evt:FrameEvent) : void { }
            private function __startLoading(e:Event) : void { }
            private function allReadyHandler(event:DrgnBoatEvent) : void { }
            private function doStartGame(endTime:Date, sprintEndTime:Date) : void { }
            private function removeEvent() : void { }
            override public function leaving(next:BaseStateView) : void { }
            override public function getType() : String { return null; }
   }}