package room{   import BraveDoor.BraveDoorManager;   import bombKing.BombKingManager;   import bombKing.event.BombKingEvent;   import braveDoor.BraveDoorControl;   import campbattle.CampBattleManager;   import catchInsect.CatchInsectManager;   import christmas.ChristmasCoreManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelManager;   import ddt.data.BuffInfo;   import ddt.data.player.PlayerInfo;   import ddt.events.CEvent;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.RoomEvent;   import ddt.loader.StartupResourceLoader;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PetInfoManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddtKingFloat.DDTKingFloatIconManager;   import demonChiYou.DemonChiYouManager;   import drgnBoat.DrgnBoatManager;   import escort.EscortManager;   import fightLib.FightLibManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import floatParade.FloatParadeIconManager;   import gameCommon.GameControl;   import hall.GameLoadingManager;   import invite.InviteManager;   import labyrinth.LabyrinthManager;   import pet.data.PetInfo;   import road7th.comm.PackageIn;   import room.model.RoomInfo;   import room.model.RoomPlayer;   import room.view.roomView.SingleRoomView;   import roomList.pvpRoomList.RoomListManager;   import sevenDouble.SevenDoubleManager;   import survival.SurvivalModeControl;   import trainer.controller.NewHandGuideManager;   import worldboss.WorldBossManager;      public class RoomControl extends EventDispatcher   {            private static var _ins:RoomControl;                   private var _isShowGameLoading:Boolean;            private var _isSingleBattleAndForcedExit:Boolean = false;            public var fightTypeLastSelected:int;            private var _singleRoomView:SingleRoomView;            public function RoomControl() { super(); }
            public static function get instance() : RoomControl { return null; }
            public function setup() : void { }
            protected function __updateBattleTimesRemain(e:CEvent) : void { }
            private function __updateDataHandler(event:Event) : void { }
            private function checkData() : void { }
            private function __createRoom(evt:CrazyTankSocketEvent) : void { }
            private function enterFightLib() : void { }
            private function __paymentFailed(e:CrazyTankSocketEvent) : void { }
            private function _responseI(evt:FrameEvent) : void { }
            private function _responseII(evt:FrameEvent) : void { }
            private function __toPaymentTryagainHandler() : void { }
            private function __cancelPaymenttryagainHandler() : void { }
            protected function __createSingleRoom(event:CrazyTankSocketEvent) : void { }
            protected function __startLoading(e:Event) : void { }
            public function showSingleRoomView(type:int = 6) : void { }
            protected function __onSingleRoomEvent(event:FrameEvent) : void { }
            private function hideSingleRoomView() : void { }
            private function __showSingleRoomViewHandler(event:CEvent) : void { }
            private function __loginRoomResult(evt:CrazyTankSocketEvent) : void { }
            private function __settingRoom(evt:CrazyTankSocketEvent) : void { }
            private function __updateRoomPlaces(evt:CrazyTankSocketEvent) : void { }
            private function __playerStateChange(evt:CrazyTankSocketEvent) : void { }
            private function __updateGameStyle(evt:CrazyTankSocketEvent) : void { }
            private function __setPlayerTeam(evt:CrazyTankSocketEvent) : void { }
            private function __netWork(event:CrazyTankSocketEvent) : void { }
            private function __buffObtain(evt:CrazyTankSocketEvent) : void { }
            private function __buffUpdate(evt:CrazyTankSocketEvent) : void { }
            private function __waitGameFailed(evt:CrazyTankSocketEvent) : void { }
            private function __waitGameRecv(evt:CrazyTankSocketEvent) : void { }
            private function __waitCancel(evt:CrazyTankSocketEvent) : void { }
            private function __addPlayerInRoom(evt:CrazyTankSocketEvent) : void { }
            private function __removePlayerInRoom(evt:CrazyTankSocketEvent) : void { }
            protected function __forcedExitHandler(event:Event) : void { }
   }}