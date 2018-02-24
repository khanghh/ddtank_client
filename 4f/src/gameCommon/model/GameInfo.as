package gameCommon.model
{
   import ddt.data.map.MissionInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.GameEvent;
   import ddt.loader.MapLoader;
   import ddt.manager.PlayerManager;
   import flash.events.EventDispatcher;
   import guardCore.GuardCoreManager;
   import guardCore.data.GuardCoreInfo;
   import road7th.data.DictionaryData;
   import room.RoomManager;
   import room.model.RoomPlayer;
   
   public class GameInfo extends EventDispatcher
   {
      
      public static const ADD_ROOM_PLAYER:String = "addRoomPlayer";
      
      public static const REMOVE_ROOM_PLAYER:String = "removeRoomPlayer";
       
      
      private var _mapIndex:int;
      
      public var roomType:int;
      
      public var showAllCard:Array;
      
      public var startEvent:CrazyTankSocketEvent;
      
      public var GainRiches:int;
      
      public var PlayerCount:int;
      
      public var startPlayer:int;
      
      public var hasNextSession:Boolean;
      
      public var neededMovies:Array;
      
      public var neededPetSkillResource:Array;
      
      private var _selfGamePlayer:LocalPlayer;
      
      public var roomPlayers:Array;
      
      public var timeType:int;
      
      public var maxTime:int;
      
      public var outBombs:DictionaryData;
      
      public var outBoxs:DictionaryData;
      
      public var loaderMap:MapLoader;
      
      public var livings:DictionaryData;
      
      private var _teams:DictionaryData;
      
      public var startTime:Date;
      
      public var exitTimes:int;
      
      public var exitTimeLimit:int;
      
      private var _weatherType:int;
      
      public var viewers:DictionaryData;
      
      public var currentLiving:Living;
      
      public var IsOneOnOne:Boolean;
      
      private var _gameMode:int;
      
      private var _resultCard:Array;
      
      private var _missionInfo:MissionInfo;
      
      public var missionCount:int;
      
      public var gameOverNpcMovies:Array;
      
      private var _wind:Number = 0;
      
      private var _windRate:Number = 0;
      
      private var _hasNextMission:Boolean;
      
      private var _guardCoreEnable:Boolean = true;
      
      public function GameInfo(){super();}
      
      public function get mapIndex() : int{return 0;}
      
      public function set mapIndex(param1:int) : void{}
      
      public function get isWeather() : Boolean{return false;}
      
      public function get teams() : DictionaryData{return null;}
      
      public function set teams(param1:DictionaryData) : void{}
      
      public function set gameMode(param1:int) : void{}
      
      public function get gameMode() : int{return 0;}
      
      public function get resultCard() : Array{return null;}
      
      public function set resultCard(param1:Array) : void{}
      
      public function get missionInfo() : MissionInfo{return null;}
      
      public function set missionInfo(param1:MissionInfo) : void{}
      
      public function resetBossCardCnt() : void{}
      
      public function addGamePlayer(param1:Living) : void{}
      
      public function addGameViewer(param1:Living) : void{}
      
      public function viewerToLiving(param1:int) : void{}
      
      public function livingToViewer(param1:int, param2:int) : void{}
      
      public function addTeamPlayer(param1:Living) : void{}
      
      public function removeTeamPlayer(param1:Living) : void{}
      
      public function setSelfGamePlayer(param1:Living) : void{}
      
      public function removeGamePlayer(param1:int) : Living{return null;}
      
      public function removeGamePlayerByPlayerID(param1:int, param2:int) : void{}
      
      public function isAllReady() : Boolean{return false;}
      
      public function findPlayer(param1:int) : Player{return null;}
      
      public function findPlayerByPlayerID(param1:int) : Player{return null;}
      
      public function findGamerbyPlayerId(param1:int) : Player{return null;}
      
      public function get haveAllias() : Boolean{return false;}
      
      public function get allias() : Vector.<Player>{return null;}
      
      public function findLiving(param1:int) : Living{return null;}
      
      public function findLivingByName(param1:String) : Living{return null;}
      
      public function findTeam(param1:int) : DictionaryData{return null;}
      
      public function resetWithinTheMap() : void{}
      
      public function findLivingByPlayerID(param1:int, param2:int) : Player{return null;}
      
      public function removeAllMonsters() : void{}
      
      public function removeAllTeam() : void{}
      
      public function get selfGamePlayer() : LocalPlayer{return null;}
      
      public function addRoomPlayer(param1:RoomPlayer) : void{}
      
      public function removeRoomPlayer(param1:int, param2:int) : void{}
      
      public function findRoomPlayer(param1:int, param2:int) : RoomPlayer{return null;}
      
      public function setWind(param1:Number, param2:Boolean = false, param3:Array = null) : void{}
      
      public function get wind() : Number{return 0;}
      
      public function set windRate(param1:Number) : void{}
      
      public function get windRate() : Number{return 0;}
      
      public function get hasNextMission() : Boolean{return false;}
      
      public function set hasNextMission(param1:Boolean) : void{}
      
      public function resetResultCard() : void{}
      
      public function getRoomPlayerByID(param1:int, param2:int) : RoomPlayer{return null;}
      
      public function getOutBombsIdList() : Array{return null;}
      
      public function get isHasOneDead() : Boolean{return false;}
      
      public function getGuardCoreBuffList() : Array{return null;}
      
      public function get guardCoreEnable() : Boolean{return false;}
      
      public function set guardCoreEnable(param1:Boolean) : void{}
      
      public function dispose() : void{}
      
      public function get togetherShoot() : Boolean{return false;}
      
      public function get weatherType() : int{return 0;}
      
      public function set weatherType(param1:int) : void{}
   }
}
