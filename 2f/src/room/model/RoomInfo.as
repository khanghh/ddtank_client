package room.model{   import ddt.events.RoomEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import road7th.data.DictionaryData;      public class RoomInfo extends EventDispatcher   {            public static const MATCH_ROOM:int = 0;            public static const CHALLENGE_ROOM:int = 1;            public static const DUNGEON_ROOM:int = 4;            public static const FIGHT_LIB_ROOM:int = 5;            public static const FRESHMAN_ROOM:int = 10;            public static const ACADEMY_DUNGEON_ROOM:int = 11;            public static const LEAGE_ROOM:int = 12;            public static const GUILD_LEAGE_MODE:int = 13;            public static const SCORE_ROOM:int = 12;            public static const RANK_ROOM:int = 13;            public static const WORLD_BOSS_FIGHT:int = 14;            public static const LANBYRINTH_ROOM:int = 15;            public static const ENCOUNTER_ROOM:int = 16;            public static const FIGHTGROUND_ROOM:int = 18;            public static const CONSORTIA_BOSS:int = 17;            public static const CONSORTIA_BATTLE:int = 19;            public static const CAMPBATTLE_BATTLE:int = 20;            public static const ACTIVITY_DUNGEON_ROOM:int = 21;            public static const SPECIAL_ACTIVITY_DUNGEON:int = 23;            public static const RING_STATION:int = 24;            public static const SEVEN_DOUBLE:int = 31;            public static const SINGLE_BATTLE:int = 25;            public static const CATCH_BEAST:int = 26;            public static const BOMB_KING:int = 27;            public static const FARM_BOSS:int = 28;            public static const RESCUE:int = 29;            public static const CHRISTMAS_ROOM:int = 40;            public static const ENTERTAINMENT_ROOM:int = 41;            public static const ENTERTAINMENT_ROOM_PK:int = 42;            public static const CRYPTBOSS_ROOM:int = 51;            public static const CATCH_INSECT_ROOM:int = 52;            public static const RENSHEN_ROOM:int = 67;            public static const POLARREGION:int = 68;            public static const SURVIVALMODE:int = 121;            public static const STONEEXPLORE_ROOM:int = 56;            public static const CONSORTIA_MATCH_SCORE:int = 43;            public static const CONSORTIA_MATCH_RANK:int = 44;            public static const CONSORTIA_MATCH_SCORE_WHOLE:int = 45;            public static const CONSORTIA_MATCH_RANK_WHOLE:int = 46;            public static const BATTLE_ROOM:int = 120;            public static const DEMON_CHI_YOU_ROOM:int = 48;            public static const NEW_DUNGEON_1:int = 47;            public static const NEW_DUNGEON_2:int = 48;            public static const HERO_AUTO:int = 49;            public static const CONSORTIA_DOMAIN_ROOM:int = 150;            public static const TEAM_ROOM:int = 58;            public static const DREAM_LAND:int = 70;            public static const DUNGEON_TESTMODE:int = 120;            public static const CONSORTIA_GUARD_ROOM:int = 151;            public static const DEFEND_ISLAND:int = 155;            public static const BATTLE_DUNGEON_ROOM:int = 123;            public static const FREE_MODE:int = 0;            public static const GUILD_MODE:int = 1;            public static const BOTH_MODE:int = 4;            public static const MATCH_NPC:int = 9;            public static const EASY:int = 0;            public static const NORMAL:int = 1;            public static const HARD:int = 2;            public static const HERO:int = 3;            public static const EPIC:int = 5;            public static const NIGHTMARE:int = 4;            public static const DUNGEONTYPE_NO:int = 1;            public static const DUNGEONTYPE_SP:int = 2;            public static const DUNGEONTYPE_AC:int = 3;            public static const DUNGEONTYPE_NI:int = 4;            public static const DUNGEONTYPE_SI:int = 5;            public static const NULL_ROOM:int = -100;                   public var ID:int;            public var Name:String;            public var maxViewerCnt:int = 2;            public var isWithinLeageTime:Boolean;            private var _type:int;            private var _players:DictionaryData;            private var _gameMode:int;            private var _mapId:int;            private var _timeType:int = -1;            private var _hardLevel:int;            private var _levelLimits:int;            private var _totalPlayer:int;            private var _viewerCnt:int;            private var _placeCount:int;            public var isLocked:Boolean;            private var _started:Boolean;            private var _isCrossZone:Boolean;            private var _isPlaying:Boolean;            private var _isLocked:Boolean;            private var _changedCount:int;            private var _isOpenBoss:Boolean;            private var _pic:String;            private var _roomPass:String = "";            private var _dungeonType:int;            private var _dungeonMode:int;            private var _placesState:Array;            private var _defyInfo:Array;            public function RoomInfo() { super(); }
            public function get pic() : String { return null; }
            public function set pic(value:String) : void { }
            public function get isOpenBoss() : Boolean { return false; }
            public function set isOpenBoss(value:Boolean) : void { }
            public function get roomPass() : String { return null; }
            public function set roomPass(value:String) : void { }
            public function get roomName() : String { return null; }
            public function set roomName(value:String) : void { }
            public function get defyInfo() : Array { return null; }
            public function set defyInfo(value:Array) : void { }
            public function get placesState() : Array { return null; }
            public function updatePlaceState(states:Array) : void { }
            public function updatePlayerState(states:Array) : void { }
            public function setPlayerReadyState(id:int, isReady:Boolean) : void { }
            public function updatePlayerTeam(id:int, team:int, place:int) : void { }
            public function addPlayer(player:RoomPlayer) : void { }
            public function removePlayer(zoneID:int, id:int) : RoomPlayer { return null; }
            public function findPlayerByID(id:int, zoneID:int = -1) : RoomPlayer { return null; }
            public function findPlayerByPlace(place:int) : RoomPlayer { return null; }
            public function dispose() : void { }
            public function get players() : DictionaryData { return null; }
            public function startPickup() : void { }
            public function cancelPickup() : void { }
            public function pickupFailed() : void { }
            public function get selfRoomPlayer() : RoomPlayer { return null; }
            public function get type() : int { return 0; }
            public function set type(value:int) : void { }
            public function isYellowBg() : Boolean { return false; }
            public function canShowTitle() : Boolean { return false; }
            public function get gameMode() : int { return 0; }
            public function set gameMode(value:int) : void { }
            public function canPlayGuidMode() : Boolean { return false; }
            public function isAllReady() : Boolean { return false; }
            public function getDifficulty(hardlevel:int) : String { return null; }
            public function get mapId() : int { return 0; }
            public function set mapId(value:int) : void { }
            public function get timeType() : int { return 0; }
            public function set timeType(value:int) : void { }
            public function get hardLevel() : int { return 0; }
            public function set hardLevel(value:int) : void { }
            public function get levelLimits() : int { return 0; }
            public function set levelLimits(value:int) : void { }
            public function get totalPlayer() : int { return 0; }
            public function set totalPlayer(value:int) : void { }
            public function get currentViewerCnt() : int { return 0; }
            public function get currentPlayerCount() : int { return 0; }
            public function get currentPlayers() : Array { return null; }
            public function get viewerCnt() : int { return 0; }
            public function set viewerCnt(value:int) : void { }
            public function get placeCount() : int { return 0; }
            public function set placeCount(value:int) : void { }
            public function get started() : Boolean { return false; }
            public function set started(value:Boolean) : void { }
            public function get isCrossZone() : Boolean { return false; }
            public function set isCrossZone(value:Boolean) : void { }
            public function resetStates() : void { }
            public function get isPlaying() : Boolean { return false; }
            public function set isPlaying(value:Boolean) : void { }
            public function get IsLocked() : Boolean { return false; }
            public function set IsLocked(value:Boolean) : void { }
            public function get dungeonType() : int { return 0; }
            public function set dungeonType(value:int) : void { }
            public function get isDungeonType() : Boolean { return false; }
            public function get isLeagueRoom() : Boolean { return false; }
            public function get dungeonMode() : int { return 0; }
            public function set dungeonMode(value:int) : void { }
   }}