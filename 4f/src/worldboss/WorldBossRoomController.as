package worldboss{   import com.pickgliss.manager.CacheSysManager;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.PlayerInfo;   import ddt.events.CEvent;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.PkgEvent;   import ddt.manager.KeyboardShortcutsManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import ddt.states.BaseStateView;   import ddt.utils.HelperUIModuleLoad;   import ddt.view.MainToolBar;   import flash.events.Event;   import flash.geom.Point;   import hall.GameLoadingManager;   import invite.InviteManager;   import road7th.comm.PackageIn;   import worldboss.model.WorldBossRoomModel;   import worldboss.player.PlayerVO;   import worldboss.player.RankingPersonInfo;   import worldboss.view.WaitingWorldBossView;   import worldboss.view.WorldBossRoomView;      public class WorldBossRoomController extends BaseStateView   {            private static var _instance:WorldBossRoomController;            private static var _isFirstCome:Boolean = true;                   private var _sceneModel:WorldBossRoomModel;            private var _view:WorldBossRoomView;            private var _waitingView:WaitingWorldBossView;            private var _callback:Function;            private var _callbackArg:int;            public function WorldBossRoomController() { super(); }
            public static function get Instance() : WorldBossRoomController { return null; }
            public function setup() : void { }
            private function __onOpenView(e:CEvent) : void { }
            private function loadComplete() : void { }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function init() : void { }
            protected function __onTimeOut(event:Event) : void { }
            private function addEvent() : void { }
            protected function __onUpdateBlood(event:Event) : void { }
            protected function __onGameInit(event:Event) : void { }
            protected function __onEnteringGame(event:Event) : void { }
            public function checkSelfStatus() : void { }
            private function __onSetSelfStatus(e:CEvent) : void { }
            public function setSelfStatus(value:int) : void { }
            private function removeEvent() : void { }
            override public function getBackType() : String { return null; }
            public function __addPlayer(event:CrazyTankSocketEvent) : void { }
            public function __removePlayer(event:CrazyTankSocketEvent) : void { }
            public function __movePlayer(event:CrazyTankSocketEvent) : void { }
            public function __updatePlayerStauts(event:CrazyTankSocketEvent) : void { }
            private function __playerRevive(event:CrazyTankSocketEvent) : void { }
            public function __updata(e:Event) : void { }
            public function __updataRanking(evt:CrazyTankSocketEvent) : void { }
            private function __onClose(e:CEvent) : void { }
            private function __onSetSlefStatus(e:CEvent) : void { }
            override public function getType() : String { return null; }
            override public function leaving(next:BaseStateView) : void { }
            override public function dispose() : void { }
   }}