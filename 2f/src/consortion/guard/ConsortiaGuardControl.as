package consortion.guard
{
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortiaBossDataVo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import room.RoomManager;
   import starling.display.player.FightPlayerVo;
   
   public class ConsortiaGuardControl extends EventDispatcher
   {
      
      private static var _instance:ConsortiaGuardControl;
       
      
      public var notAlertAgain:Boolean = false;
      
      public var bossRankShow:Boolean = false;
      
      private var _showPlayer:Boolean = true;
      
      private var _timer:Timer;
      
      private var _model:ConsortiaGuardModel;
      
      public function ConsortiaGuardControl(){super();}
      
      public static function get Instance() : ConsortiaGuardControl{return null;}
      
      public function setup() : void{}
      
      public function enterGuradScene() : void{}
      
      private function checkCanStartGame() : Boolean{return false;}
      
      public function leaveGuardScene() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __onBossRankList(param1:PkgEvent) : void{}
      
      public function bossLocation(param1:Point) : void{}
      
      private function __onOpenActivity(param1:PkgEvent) : void{}
      
      private function updateConsortia() : void{}
      
      private function __onBuyBuff(param1:PkgEvent) : void{}
      
      private function __onInitScene(param1:PkgEvent) : void{}
      
      private function __onPlayer(param1:PkgEvent) : void{}
      
      private function addPlayer(param1:int, param2:PackageIn) : void{}
      
      private function __onUpdateBossState(param1:PkgEvent) : void{}
      
      private function __onUpdatePlayerState(param1:PkgEvent) : void{}
      
      private function __onRemovePlayer(param1:PkgEvent) : void{}
      
      private function __onRankList(param1:PkgEvent) : void{}
      
      private function __onGameState(param1:PkgEvent) : void{}
      
      private function startCloseRoomTimer() : void{}
      
      private function __onTimer(param1:TimerEvent) : void{}
      
      private function disposeTimer() : void{}
      
      private function addRankVo(param1:PackageIn, param2:Boolean = false) : void{}
      
      public function get showPlayer() : Boolean{return false;}
      
      public function set showPlayer(param1:Boolean) : void{}
      
      public function get model() : ConsortiaGuardModel{return null;}
   }
}
