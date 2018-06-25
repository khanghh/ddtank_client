package consortion.guard{   import consortion.ConsortionModelManager;   import consortion.data.ConsortiaBossDataVo;   import ddt.data.player.PlayerInfo;   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.CheckWeaponManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import ddt.manager.TimeManager;   import flash.events.EventDispatcher;   import flash.events.TimerEvent;   import flash.geom.Point;   import flash.utils.Timer;   import road7th.comm.PackageIn;   import room.RoomManager;   import starling.display.player.FightPlayerVo;      public class ConsortiaGuardControl extends EventDispatcher   {            private static var _instance:ConsortiaGuardControl;                   public var notAlertAgain:Boolean = false;            public var bossRankShow:Boolean = false;            private var _showPlayer:Boolean = true;            private var _timer:Timer;            private var _model:ConsortiaGuardModel;            public function ConsortiaGuardControl() { super(); }
            public static function get Instance() : ConsortiaGuardControl { return null; }
            public function setup() : void { }
            public function enterGuradScene() : void { }
            private function checkCanStartGame() : Boolean { return false; }
            public function leaveGuardScene() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __onBossRankList(e:PkgEvent) : void { }
            public function bossLocation(point:Point) : void { }
            private function __onOpenActivity(e:PkgEvent) : void { }
            private function updateConsortia() : void { }
            private function __onBuyBuff(e:PkgEvent) : void { }
            private function __onInitScene(e:PkgEvent) : void { }
            private function __onPlayer(e:PkgEvent) : void { }
            private function addPlayer(id:int, pkg:PackageIn) : void { }
            private function __onUpdateBossState(e:PkgEvent) : void { }
            private function __onUpdatePlayerState(e:PkgEvent) : void { }
            private function __onRemovePlayer(e:PkgEvent) : void { }
            private function __onRankList(e:PkgEvent) : void { }
            private function __onGameState(e:PkgEvent) : void { }
            private function startCloseRoomTimer() : void { }
            private function __onTimer(e:TimerEvent) : void { }
            private function disposeTimer() : void { }
            private function addRankVo(e:PackageIn, isSelf:Boolean = false) : void { }
            public function get showPlayer() : Boolean { return false; }
            public function set showPlayer(value:Boolean) : void { }
            public function get model() : ConsortiaGuardModel { return null; }
   }}