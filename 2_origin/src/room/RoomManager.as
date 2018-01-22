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
      
      public function RoomManager()
      {
         pkgs = [];
         super();
      }
      
      public static function getTurnTimeByType(param1:int) : int
      {
         switch(int(param1) - 1)
         {
            case 0:
               return 6;
            case 1:
               return 8;
            case 2:
               return 11;
            case 3:
               return 16;
            case 4:
               return 21;
            case 5:
               return 31;
         }
      }
      
      public static function get Instance() : RoomManager
      {
         if(_instance == null)
         {
            _instance = new RoomManager();
         }
         return _instance;
      }
      
      public function set current(param1:RoomInfo) : void
      {
         setCurrent(param1);
      }
      
      public function get current() : RoomInfo
      {
         if(!_current)
         {
            return null;
         }
         return _current;
      }
      
      public function isReset(param1:int) : Boolean
      {
         return param1 != 15 && param1 != 56;
      }
      
      public function setCurrent(param1:RoomInfo) : void
      {
         if(_current)
         {
            _current.dispose();
         }
         _current = param1;
      }
      
      public function isChristmasFight() : Boolean
      {
         return RoomManager._instance.current.type == 40;
      }
      
      public function createTrainerRoom() : void
      {
         setCurrent(new RoomInfo());
         _current.timeType = 3;
      }
      
      public function setRoomDefyInfo(param1:Array) : void
      {
         if(_current)
         {
            _current.defyInfo = param1;
         }
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener("gameRoomCreate",dataHandler);
         SocketManager.Instance.addEventListener("SINGLE_ROOM_BEGIN",dataHandler);
         SocketManager.Instance.addEventListener("gameLogin",dataHandler);
         SocketManager.Instance.addEventListener("gameRoomSetUp",dataHandler);
         SocketManager.Instance.addEventListener("gameRoomOpen",dataHandler);
         SocketManager.Instance.addEventListener("playerState",dataHandler);
         SocketManager.Instance.addEventListener("GameStyleRecv",dataHandler);
         SocketManager.Instance.addEventListener("gameTeam",dataHandler);
         SocketManager.Instance.addEventListener("netWork",dataHandler);
         SocketManager.Instance.addEventListener("buffObtain",dataHandler);
         SocketManager.Instance.addEventListener("buffUpdate",dataHandler);
         SocketManager.Instance.addEventListener("GameWaitFailed",dataHandler);
         SocketManager.Instance.addEventListener("recvGameWait",dataHandler);
         SocketManager.Instance.addEventListener("GameWaitCancel",dataHandler);
         SocketManager.Instance.addEventListener("gamePlayerEnter",dataHandler);
         SocketManager.Instance.addEventListener("GamePlayerExit",dataHandler);
         SocketManager.Instance.addEventListener("insufficientMoney",dataHandler);
         SocketManager.Instance.addEventListener("passed_warriorsarena_10",__hasPassedWarriorsarena);
         SocketManager.Instance.addEventListener("warriorsarenaLastMission",__isLastForWarriorsarena);
         SocketManager.Instance.addEventListener("no_Warriorsarena_ticket",__noWarriorsarenaTicket);
         SocketManager.Instance.addEventListener("singleBattle_forecdExit",dataHandler);
         SocketManager.Instance.addEventListener("gameReconnection",__onReconnection);
      }
      
      private function __hasPassedWarriorsarena(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert("",LanguageMgr.GetTranslation("ddt.dungeonroom.pass.warriorsArena",10),LanguageMgr.GetTranslation("ok"),"",false,true,true,2);
         _loc2_.addEventListener("response",__onResponse);
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onResponse);
         ObjectUtils.disposeObject(_loc2_);
         _loc2_ = null;
      }
      
      private function __isLastForWarriorsarena(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         IsLastMisstion = _loc2_.readBoolean();
      }
      
      private function __noWarriorsarenaTicket(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:String = _loc3_.readUTF();
         if(_alert)
         {
            _alert.removeEventListener("response",__alertResponse);
            ObjectUtils.disposeObject(_alert);
            _alert.dispose();
            _alert = null;
         }
         _alert = AlertManager.Instance.simpleAlert("",_loc2_,LanguageMgr.GetTranslation("ok"),"",false,true,true,1);
         _alert.moveEnable = false;
         _alert.addEventListener("response",__alertResponse);
      }
      
      private function __alertResponse(param1:FrameEvent) : void
      {
         if(_alert)
         {
            _alert.removeEventListener("response",__alertResponse);
            ObjectUtils.disposeObject(_alert);
            _alert.dispose();
         }
         _alert = null;
      }
      
      protected function __onReconnection(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:CoreManager = new CoreManager();
         _loc2_.addEventListener("complete",__onLoadCoreComplete);
         _loc2_.show();
      }
      
      protected function __onLoadCoreComplete(param1:Event) : void
      {
         var _loc2_:CoreManager = param1.currentTarget as CoreManager;
         _loc2_.removeEventListener("complete",__onLoadCoreComplete);
         SocketManager.Instance.out.sendReconnection();
      }
      
      private function dataHandler(param1:CrazyTankSocketEvent) : void
      {
         pkgs.push(param1);
         dispatchEvent(new Event("updateData"));
      }
      
      private function getSecondType(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         if(param1 == 1001 || param1 == 1002 || param1 == 1003)
         {
            if(param2 == 0)
            {
               _loc3_ = 6;
            }
            else if(param2 == 1)
            {
               _loc3_ = 5;
            }
            else
            {
               _loc3_ = 3;
            }
         }
         else if(param1 == 1004)
         {
            if(param2 == 0)
            {
               _loc3_ = 5;
            }
            else if(param2 == 1)
            {
               _loc3_ = 4;
            }
            else
            {
               _loc3_ = 3;
            }
         }
         return _loc3_;
      }
      
      public function set tempInventPlayerID(param1:int) : void
      {
         _tempInventPlayerID = param1;
      }
      
      public function get tempInventPlayerID() : int
      {
         return _tempInventPlayerID;
      }
      
      public function haveTempInventPlayer() : Boolean
      {
         return _tempInventPlayerID != -1;
      }
      
      public function updateBattleSingleRoom() : void
      {
         dispatchEvent(new CEvent("update_battle_remain"));
      }
      
      public function addBattleSingleRoom(param1:int = 6) : void
      {
         _battleType = param1;
         new HelperUIModuleLoad().loadUIModule(["ddtroom"],enconterUIOnLoaded);
      }
      
      private function enconterUIOnLoaded() : void
      {
         dispatchEvent(new CEvent("showSingleRoomView"));
      }
      
      public function findRoomPlayer(param1:int) : RoomPlayer
      {
         var _loc2_:* = null;
         if(_current)
         {
            _loc2_ = _current.players[param1] as RoomPlayer;
            if(_loc2_ == null && param1 == this._current.selfRoomPlayer.playerInfo.ID)
            {
               _loc2_ = this._current.selfRoomPlayer;
            }
            return _loc2_;
         }
         return null;
      }
      
      public function resetAllPlayerState() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _current.players;
         for each(var _loc1_ in _current.players)
         {
            _loc1_.isReady = false;
            _loc1_.progress = 0;
            if(_current.type != 1)
            {
               _loc1_.team = 1;
            }
         }
      }
      
      public function isIdenticalRoom(param1:int = 0, param2:String = "") : Boolean
      {
         var _loc3_:DictionaryData = current.players;
         var _loc4_:SelfInfo = PlayerManager.Instance.Self;
         if(param1 == _loc4_.ID)
         {
            return false;
         }
         var _loc7_:int = 0;
         var _loc6_:* = _loc3_;
         for each(var _loc5_ in _loc3_)
         {
            if(_loc5_.playerInfo.ID == param1 || _loc5_.playerInfo.NickName == param2)
            {
               return true;
            }
         }
         return false;
      }
      
      public function reset() : void
      {
         if(_current)
         {
            _current.dispose();
            _current = null;
         }
      }
      
      public function set battleType(param1:int) : void
      {
         _battleType = param1;
      }
      
      public function get battleType() : int
      {
         return _battleType;
      }
      
      public function canCloseItem(param1:*) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:int = param1.place;
         var _loc3_:uint = 4;
         var _loc2_:Array = RoomManager.Instance.current.placesState;
         _loc5_ = 0;
         while(_loc5_ < 8)
         {
            if(_loc5_ % 2 == _loc4_ % 2)
            {
               if(_loc2_[_loc5_] == 0)
               {
                  _loc3_--;
               }
            }
            _loc5_++;
         }
         if(_loc3_ <= 1)
         {
            return false;
         }
         return true;
      }
   }
}
