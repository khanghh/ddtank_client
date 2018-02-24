package room
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.data.player.SelfInfo;
   import ddt.events.CEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import room.model.RoomInfo;
   import room.model.RoomPlayer;
   
   public class RoomManager extends EventDispatcher
   {
      
      public static const PAYMENT_TAKE_CARD:String = "PaymentCard";
      
      public static const LOGIN_ROOM_RESULT:String = "loginRoomResult";
      
      public static const PLAYER_ROOM_EXIT:String = "PlayerRoomExit";
      
      public static const UPDATE_ROOMLIST:String = "updateRoomList";
      
      public static const SHOW_SINGLEROOMVIEW:String = "showSingleRoomView";
      
      public static const UPDATE_DATA:String = "updateData";
      
      public static const UPDATE_BATTLE_REMAIN_TIMES:String = "update_battle_remain";
      
      public static const CAMP_BATTLE_ROOM:int = 5;
      
      public static const BATTLE_ROOM:int = 3;
      
      public static const ENCOUNTER_MODEL:int = 1;
      
      public static const BATTLE_MODEL:int = 2;
      
      public static const SINGLEBATTLE_MODEL:int = 6;
      
      public static const SURVIVAL_MODEL:int = 21;
      
      public static const HORSERACE_ROOM:int = 60;
      
      public static const DEMON_CHI_YOU_FIGHT:int = 21;
      
      public static const CONSORTIA_DOMAIN:int = 22;
      
      public static const SPECIAL_BOSS_MAPID:Array = [27,30];
      
      public static const CONSORTIA_GUARD:int = 23;
      
      private static var _instance:RoomManager;
       
      
      public var isPrepare:Boolean;
      
      public var isMatch:Boolean;
      
      private var _current:RoomInfo;
      
      public var _removeRoomMsg:String = "";
      
      private var _battleType:int;
      
      public var showSingleAlert:Boolean = false;
      
      public var pkgs:Array;
      
      public var isEnterTainmentRoom:Boolean;
      
      public var IsLastMisstion:Boolean = false;
      
      private var _alert:BaseAlerFrame;
      
      private var _tempInventPlayerID:int = -1;
      
      public var isNotAlertEnergyNotEnough:Boolean = false;
      
      public function RoomManager(){super();}
      
      public static function getTurnTimeByType(param1:int) : int{return 0;}
      
      public static function get Instance() : RoomManager{return null;}
      
      public function set current(param1:RoomInfo) : void{}
      
      public function get current() : RoomInfo{return null;}
      
      public function isReset(param1:int) : Boolean{return false;}
      
      public function setCurrent(param1:RoomInfo) : void{}
      
      public function isChristmasFight() : Boolean{return false;}
      
      public function createTrainerRoom() : void{}
      
      public function setRoomDefyInfo(param1:Array) : void{}
      
      public function setup() : void{}
      
      private function __hasPassedWarriorsarena(param1:CrazyTankSocketEvent) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function __isLastForWarriorsarena(param1:CrazyTankSocketEvent) : void{}
      
      private function __noWarriorsarenaTicket(param1:CrazyTankSocketEvent) : void{}
      
      private function __alertResponse(param1:FrameEvent) : void{}
      
      protected function __onReconnection(param1:CrazyTankSocketEvent) : void{}
      
      protected function __onLoadCoreComplete(param1:Event) : void{}
      
      private function dataHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function getSecondType(param1:int, param2:int) : int{return 0;}
      
      public function set tempInventPlayerID(param1:int) : void{}
      
      public function get tempInventPlayerID() : int{return 0;}
      
      public function haveTempInventPlayer() : Boolean{return false;}
      
      public function updateBattleSingleRoom() : void{}
      
      public function addBattleSingleRoom(param1:int = 6) : void{}
      
      private function enconterUIOnLoaded() : void{}
      
      public function findRoomPlayer(param1:int) : RoomPlayer{return null;}
      
      public function resetAllPlayerState() : void{}
      
      public function isIdenticalRoom(param1:int = 0, param2:String = "") : Boolean{return false;}
      
      public function reset() : void{}
      
      public function set battleType(param1:int) : void{}
      
      public function get battleType() : int{return 0;}
      
      public function canCloseItem(param1:*) : Boolean{return false;}
   }
}
