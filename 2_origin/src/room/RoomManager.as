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
      
      public static function getTurnTimeByType(type:int) : int
      {
         switch(int(type) - 1)
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
      
      public function set current(val:RoomInfo) : void
      {
         setCurrent(val);
      }
      
      public function get current() : RoomInfo
      {
         if(!_current)
         {
            return null;
         }
         return _current;
      }
      
      public function isReset(type:int) : Boolean
      {
         return type != 15 && type != 56 && type != 70;
      }
      
      public function setCurrent(value:RoomInfo) : void
      {
         if(_current)
         {
            _current.dispose();
         }
         _current = value;
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
      
      public function setRoomDefyInfo(value:Array) : void
      {
         if(_current)
         {
            _current.defyInfo = value;
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
      
      private function __hasPassedWarriorsarena(event:CrazyTankSocketEvent) : void
      {
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert("",LanguageMgr.GetTranslation("ddt.dungeonroom.pass.warriorsArena",10),LanguageMgr.GetTranslation("ok"),"",false,true,true,2);
         alert.addEventListener("response",__onResponse);
      }
      
      private function __onResponse(event:FrameEvent) : void
      {
         var alert:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__onResponse);
         ObjectUtils.disposeObject(alert);
         alert = null;
      }
      
      private function __isLastForWarriorsarena(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         IsLastMisstion = pkg.readBoolean();
      }
      
      private function __noWarriorsarenaTicket(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var str:String = pkg.readUTF();
         if(_alert)
         {
            _alert.removeEventListener("response",__alertResponse);
            ObjectUtils.disposeObject(_alert);
            _alert.dispose();
            _alert = null;
         }
         _alert = AlertManager.Instance.simpleAlert("",str,LanguageMgr.GetTranslation("ok"),"",false,true,true,1);
         _alert.moveEnable = false;
         _alert.addEventListener("response",__alertResponse);
      }
      
      private function __alertResponse(event:FrameEvent) : void
      {
         if(_alert)
         {
            _alert.removeEventListener("response",__alertResponse);
            ObjectUtils.disposeObject(_alert);
            _alert.dispose();
         }
         _alert = null;
      }
      
      protected function __onReconnection(event:CrazyTankSocketEvent) : void
      {
         var core:CoreManager = new CoreManager();
         core.addEventListener("complete",__onLoadCoreComplete);
         core.show();
      }
      
      protected function __onLoadCoreComplete(event:Event) : void
      {
         var core:CoreManager = event.currentTarget as CoreManager;
         core.removeEventListener("complete",__onLoadCoreComplete);
         SocketManager.Instance.out.sendReconnection();
      }
      
      private function dataHandler(event:CrazyTankSocketEvent) : void
      {
         pkgs.push(event);
         dispatchEvent(new Event("updateData"));
      }
      
      private function getSecondType(infoId:int, difficulty:int) : int
      {
         var secondType:int = 0;
         if(infoId == 1001 || infoId == 1002 || infoId == 1003)
         {
            if(difficulty == 0)
            {
               secondType = 6;
            }
            else if(difficulty == 1)
            {
               secondType = 5;
            }
            else
            {
               secondType = 3;
            }
         }
         else if(infoId == 1004)
         {
            if(difficulty == 0)
            {
               secondType = 5;
            }
            else if(difficulty == 1)
            {
               secondType = 4;
            }
            else
            {
               secondType = 3;
            }
         }
         return secondType;
      }
      
      public function set tempInventPlayerID(id:int) : void
      {
         _tempInventPlayerID = id;
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
      
      public function addBattleSingleRoom(type:int = 6) : void
      {
         _battleType = type;
         new HelperUIModuleLoad().loadUIModule(["ddtroom"],enconterUIOnLoaded);
      }
      
      private function enconterUIOnLoaded() : void
      {
         dispatchEvent(new CEvent("showSingleRoomView"));
      }
      
      public function findRoomPlayer(id:int) : RoomPlayer
      {
         var roomPlayer:* = null;
         if(_current)
         {
            roomPlayer = _current.players[id] as RoomPlayer;
            if(roomPlayer == null && id == this._current.selfRoomPlayer.playerInfo.ID)
            {
               roomPlayer = this._current.selfRoomPlayer;
            }
            return roomPlayer;
         }
         return null;
      }
      
      public function resetAllPlayerState() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _current.players;
         for each(var player in _current.players)
         {
            player.isReady = false;
            player.progress = 0;
            if(_current.type != 1)
            {
               player.team = 1;
            }
         }
      }
      
      public function isIdenticalRoom(id:int = 0, name:String = "") : Boolean
      {
         var roomPlayers:DictionaryData = current.players;
         var selfInfo:SelfInfo = PlayerManager.Instance.Self;
         if(id == selfInfo.ID)
         {
            return false;
         }
         var _loc7_:int = 0;
         var _loc6_:* = roomPlayers;
         for each(var i in roomPlayers)
         {
            if(i.playerInfo.ID == id || i.playerInfo.NickName == name)
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
      
      public function set battleType(value:int) : void
      {
         _battleType = value;
      }
      
      public function get battleType() : int
      {
         return _battleType;
      }
      
      public function canCloseItem(target:*) : Boolean
      {
         var i:int = 0;
         var place:int = target.place;
         var openCount:uint = 4;
         var arr:Array = RoomManager.Instance.current.placesState;
         for(i = 0; i < 8; )
         {
            if(i % 2 == place % 2)
            {
               if(arr[i] == 0)
               {
                  openCount--;
               }
            }
            i++;
         }
         if(openCount <= 1)
         {
            return false;
         }
         return true;
      }
   }
}
