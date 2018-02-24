package room
{
   import BraveDoor.BraveDoorManager;
   import bombKing.BombKingManager;
   import bombKing.event.BombKingEvent;
   import braveDoor.BraveDoorControl;
   import campbattle.CampBattleManager;
   import catchInsect.CatchInsectManager;
   import christmas.ChristmasCoreManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.BuffInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.RoomEvent;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PetInfoManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddtKingFloat.DDTKingFloatIconManager;
   import demonChiYou.DemonChiYouManager;
   import drgnBoat.DrgnBoatManager;
   import escort.EscortManager;
   import fightLib.FightLibManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import floatParade.FloatParadeIconManager;
   import gameCommon.GameControl;
   import hall.GameLoadingManager;
   import invite.InviteManager;
   import labyrinth.LabyrinthManager;
   import pet.data.PetInfo;
   import road7th.comm.PackageIn;
   import room.model.RoomInfo;
   import room.model.RoomPlayer;
   import room.view.roomView.SingleRoomView;
   import roomList.pvpRoomList.RoomListManager;
   import sevenDouble.SevenDoubleManager;
   import survival.SurvivalModeControl;
   import trainer.controller.NewHandGuideManager;
   import worldboss.WorldBossManager;
   
   public class RoomControl extends EventDispatcher
   {
      
      private static var _ins:RoomControl;
       
      
      private var _isShowGameLoading:Boolean;
      
      private var _isSingleBattleAndForcedExit:Boolean = false;
      
      public var fightTypeLastSelected:int;
      
      private var _singleRoomView:SingleRoomView;
      
      public function RoomControl(){super();}
      
      public static function get instance() : RoomControl{return null;}
      
      public function setup() : void{}
      
      protected function __updateBattleTimesRemain(param1:CEvent) : void{}
      
      private function __updateDataHandler(param1:Event) : void{}
      
      private function checkData() : void{}
      
      private function __createRoom(param1:CrazyTankSocketEvent) : void{}
      
      private function enterFightLib() : void{}
      
      private function __paymentFailed(param1:CrazyTankSocketEvent) : void{}
      
      private function _responseI(param1:FrameEvent) : void{}
      
      private function _responseII(param1:FrameEvent) : void{}
      
      private function __toPaymentTryagainHandler() : void{}
      
      private function __cancelPaymenttryagainHandler() : void{}
      
      protected function __createSingleRoom(param1:CrazyTankSocketEvent) : void{}
      
      protected function __startLoading(param1:Event) : void{}
      
      public function showSingleRoomView(param1:int = 6) : void{}
      
      protected function __onSingleRoomEvent(param1:FrameEvent) : void{}
      
      private function hideSingleRoomView() : void{}
      
      private function __showSingleRoomViewHandler(param1:CEvent) : void{}
      
      private function __loginRoomResult(param1:CrazyTankSocketEvent) : void{}
      
      private function __settingRoom(param1:CrazyTankSocketEvent) : void{}
      
      private function __updateRoomPlaces(param1:CrazyTankSocketEvent) : void{}
      
      private function __playerStateChange(param1:CrazyTankSocketEvent) : void{}
      
      private function __updateGameStyle(param1:CrazyTankSocketEvent) : void{}
      
      private function __setPlayerTeam(param1:CrazyTankSocketEvent) : void{}
      
      private function __netWork(param1:CrazyTankSocketEvent) : void{}
      
      private function __buffObtain(param1:CrazyTankSocketEvent) : void{}
      
      private function __buffUpdate(param1:CrazyTankSocketEvent) : void{}
      
      private function __waitGameFailed(param1:CrazyTankSocketEvent) : void{}
      
      private function __waitGameRecv(param1:CrazyTankSocketEvent) : void{}
      
      private function __waitCancel(param1:CrazyTankSocketEvent) : void{}
      
      private function __addPlayerInRoom(param1:CrazyTankSocketEvent) : void{}
      
      private function __removePlayerInRoom(param1:CrazyTankSocketEvent) : void{}
      
      protected function __forcedExitHandler(param1:Event) : void{}
   }
}
