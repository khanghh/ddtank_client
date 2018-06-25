package gameCommon.model{   import ddt.data.map.MissionInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.GameEvent;   import ddt.loader.MapLoader;   import ddt.manager.PlayerManager;   import flash.events.EventDispatcher;   import guardCore.GuardCoreManager;   import guardCore.data.GuardCoreInfo;   import road7th.data.DictionaryData;   import room.RoomManager;   import room.model.RoomPlayer;      public class GameInfo extends EventDispatcher   {            public static const ADD_ROOM_PLAYER:String = "addRoomPlayer";            public static const REMOVE_ROOM_PLAYER:String = "removeRoomPlayer";                   private var _mapIndex:int;            public var roomType:int;            public var showAllCard:Array;            public var startEvent:CrazyTankSocketEvent;            public var GainRiches:int;            public var PlayerCount:int;            public var startPlayer:int;            public var hasNextSession:Boolean;            public var neededMovies:Array;            public var neededPetSkillResource:Array;            private var _selfGamePlayer:LocalPlayer;            public var roomPlayers:Array;            public var timeType:int;            public var maxTime:int;            public var outBombs:DictionaryData;            public var outBoxs:DictionaryData;            public var loaderMap:MapLoader;            public var livings:DictionaryData;            private var _teams:DictionaryData;            public var startTime:Date;            public var exitTimes:int;            public var exitTimeLimit:int;            private var _weatherType:int;            public var viewers:DictionaryData;            public var currentLiving:Living;            public var IsOneOnOne:Boolean;            private var _gameMode:int;            private var _resultCard:Array;            private var _missionInfo:MissionInfo;            public var missionCount:int;            public var gameOverNpcMovies:Array;            private var _wind:Number = 0;            private var _windRate:Number = 0;            private var _hasNextMission:Boolean;            private var _guardCoreEnable:Boolean = true;            public function GameInfo() { super(); }
            public function get mapIndex() : int { return 0; }
            public function set mapIndex(value:int) : void { }
            public function get isWeather() : Boolean { return false; }
            public function get teams() : DictionaryData { return null; }
            public function set teams(value:DictionaryData) : void { }
            public function set gameMode(value:int) : void { }
            public function get gameMode() : int { return 0; }
            public function get resultCard() : Array { return null; }
            public function set resultCard(arr:Array) : void { }
            public function get missionInfo() : MissionInfo { return null; }
            public function set missionInfo(value:MissionInfo) : void { }
            public function resetBossCardCnt() : void { }
            public function addGamePlayer(info:Living) : void { }
            public function addGameViewer(info:Living) : void { }
            public function viewerToLiving(playerID:int) : void { }
            public function livingToViewer(playerID:int, zoneID:int) : void { }
            public function addTeamPlayer(info:Living) : void { }
            public function removeTeamPlayer(info:Living) : void { }
            public function setSelfGamePlayer(info:Living) : void { }
            public function removeGamePlayer(livingID:int) : Living { return null; }
            public function removeGamePlayerByPlayerID(zoneID:int, playerID:int) : void { }
            public function isAllReady() : Boolean { return false; }
            public function findPlayer(livingID:int) : Player { return null; }
            public function findPlayerByPlayerID(playerid:int) : Player { return null; }
            public function findGamerbyPlayerId(playerid:int) : Player { return null; }
            public function get haveAllias() : Boolean { return false; }
            public function get allias() : Vector.<Player> { return null; }
            public function findLiving(livingID:int) : Living { return null; }
            public function findLivingByName(name:String) : Living { return null; }
            public function findTeam(id:int) : DictionaryData { return null; }
            public function resetWithinTheMap() : void { }
            public function findLivingByPlayerID(playerID:int, zoneID:int) : Player { return null; }
            public function removeAllMonsters() : void { }
            public function removeAllTeam() : void { }
            public function get selfGamePlayer() : LocalPlayer { return null; }
            public function addRoomPlayer(info:RoomPlayer) : void { }
            public function removeRoomPlayer(zoneID:int, playerID:int) : void { }
            public function findRoomPlayer(userID:int, zoneID:int) : RoomPlayer { return null; }
            public function setWind(value:Number, isSelfTurn:Boolean = false, arr:Array = null) : void { }
            public function get wind() : Number { return 0; }
            public function set windRate(value:Number) : void { }
            public function get windRate() : Number { return 0; }
            public function get hasNextMission() : Boolean { return false; }
            public function set hasNextMission(value:Boolean) : void { }
            public function resetResultCard() : void { }
            public function getRoomPlayerByID(id:int, zoneID:int) : RoomPlayer { return null; }
            public function getOutBombsIdList() : Array { return null; }
            public function get isHasOneDead() : Boolean { return false; }
            public function getGuardCoreBuffList() : Array { return null; }
            public function get guardCoreEnable() : Boolean { return false; }
            public function set guardCoreEnable(value:Boolean) : void { }
            public function dispose() : void { }
            public function get togetherShoot() : Boolean { return false; }
            public function get weatherType() : int { return 0; }
            public function set weatherType(value:int) : void { }
   }}