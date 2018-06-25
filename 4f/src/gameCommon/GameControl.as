package gameCommon{   import bombKing.BombKingManager;   import campbattle.CampBattleManager;   import catchbeast.CatchBeastManager;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import cryptBoss.CryptBossManager;   import ddt.data.BallInfo;   import ddt.data.BuffInfo;   import ddt.data.PathInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.map.MissionInfo;   import ddt.data.player.PlayerInfo;   import ddt.data.player.SelfInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.GameEvent;   import ddt.loader.StartupResourceLoader;   import ddt.manager.BallManager;   import ddt.manager.BeadTemplateManager;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MapManager;   import ddt.manager.PathManager;   import ddt.manager.PetInfoManager;   import ddt.manager.PetSkillManager;   import ddt.manager.PlayerManager;   import ddt.manager.QueueManager;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import ddt.manager.TimeManager;   import ddt.view.chat.ChatData;   import ddt.view.chat.ChatFormats;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.geom.Point;   import flash.utils.Dictionary;   import game.view.DropGoods;   import gameCommon.model.Bomb;   import gameCommon.model.FightBuffInfo;   import gameCommon.model.GameInfo;   import gameCommon.model.GameNeedMovieInfo;   import gameCommon.model.GameNeedPetSkillInfo;   import gameCommon.model.LocalPlayer;   import gameCommon.model.Pet;   import gameCommon.model.Player;   import gameCommon.model.SimpleBoxInfo;   import gameCommon.view.experience.ExpTweenManager;   import pet.data.PetInfo;   import pet.data.PetSkillTemplateInfo;   import ringStation.RingStationManager;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import room.RoomManager;   import room.model.RoomPlayer;   import trainer.controller.WeakGuildManager;      public class GameControl extends EventDispatcher   {            public static var OBJECT:Object;            public static const CAMP_BATTLE_MODEL_PVE:int = 24;            public static const CAMP_BATTLE_MODEL_PVP:int = 23;            public static const RING_STATION_MODEL:int = 26;            public static const BOMB_KING_FIRST_MODEL:int = 28;            public static const BOMB_KING_FINAL_MODEL:int = 29;            public static const FARM_BOSS_MODEL:int = 30;            public static const CHRISTMAS_MODEL:int = 40;            public static const CRYPTBOSS_MODEL:int = 41;            public static const RESCUE_MODEL:int = 31;            public static const CATCH_INSECT_MODEL:int = 42;            public static const DEMON_CHI_YOU_MODEL:int = 47;            public static const CONSORTIA_DOMAIN_MODEL:int = 49;            public static const CONSORTIA_GUARD:int = 151;            public static const ESCAPE_BATTLE_ROOM:int = 56;            public static const FLAG_BATTLE_ROOM:int = 57;            public static const START_MATCH:String = "StartMatch";            public static const RENSHEN_MODEL:int = 43;            public static const ENTER_MISSION_RESULT:String = "EnterMissionResult";            public static const ENTER_ROOM:String = "EnterRoom";            public static const LEAVE_MISSION:String = "leaveMission";            public static const ENTER_DUNGEON:String = "EnterDungeon";            public static const PLAYER_CLICK_PAY:String = "PlayerClickPay";            public static const SKILL_INFO_INIT_GAME:String = "skillInfoInitGame";            public static const EXIT_ROOM_TYPE_ARRAY:Array = [10,14,19,20,31,24,40,26,27,52,21,48,150,151,70];            public static const EXTI_GAME_MODE_ARRAY:Array = [56,57];            private static var _instance:GameControl;            public static const MissionGiveup:int = 0;            public static const MissionAgain:int = 1;            public static const MissionTimeout:int = 2;                   private var _current:GameInfo;            public var currentNum:int = 0;            public var bossName:String = "";            public var isAddTerrce:Boolean;            public var terrceX:int;            public var terrceY:int;            public var terrceID:int;            private var _loaderArray:Array;            private var _gameView:IGameView;            private var _addLivingEvtVec:Vector.<CrazyTankSocketEvent>;            private var _setPropertyEvtVec:Vector.<CrazyTankSocketEvent>;            private var _livingFallingEvtVec:Vector.<CrazyTankSocketEvent>;            private var _livingShowBloodEvtVec:Vector.<CrazyTankSocketEvent>;            private var _addMapThingEvtVec:Vector.<CrazyTankSocketEvent>;            private var _livingActionMappingEvtVec:Vector.<CrazyTankSocketEvent>;            private var _updatePhysicObjectEvtVec:Vector.<CrazyTankSocketEvent>;            private var _playerBloodEvtVec:Vector.<CrazyTankSocketEvent>;            private var _boxPhysicalEvtVec:Vector.<CrazyTankSocketEvent>;            public var viewCompleteFlag:Boolean;            public var randomSmallLivingShape:int = -1;            public var teamColorData:DictionaryData;            private var _pathInfo:PathInfo;            public var selectList:Array;            public var TryAgain:int = 0;            private var _recevieLoadSocket:Boolean;            private var _outBombs:DictionaryData;            public var petSkillList:Array;            public var horseSkillList:Array;            private var _specialSkillType:String = null;            public var dropGoodslist:Vector.<DropGoods>;            public var dropData:Array;            public var dropGlod:int;            public function GameControl() { super(); }
            public static function isAcademyRoom(gameInfo:GameInfo) : Boolean { return false; }
            public static function isDreamChallengeRoom(gameInfo:GameInfo) : Boolean { return false; }
            public static function isDungeonRoom(gameInfo:GameInfo) : Boolean { return false; }
            public static function isFightLib(gameInfo:GameInfo) : Boolean { return false; }
            public static function isFreshMan(gameInfo:GameInfo) : Boolean { return false; }
            public static function get Instance() : GameControl { return null; }
            public function get Current() : GameInfo { return null; }
            public function set Current(value:GameInfo) : void { }
            private function initData() : void { }
            public function setup() : void { }
            private function __onSimpleOejectMovePos(evt:CrazyTankSocketEvent) : void { }
            private function __disposeCmd(event:CrazyTankSocketEvent) : void { }
            public function ClearAllCrazyTankSocketEvent() : void { }
            protected function __playerBlood(event:CrazyTankSocketEvent) : void { }
            protected function __updatePhysicObject(event:CrazyTankSocketEvent) : void { }
            protected function __livingActionMapping(event:CrazyTankSocketEvent) : void { }
            protected function __addMapThing(event:CrazyTankSocketEvent) : void { }
            protected function __addLiving(event:CrazyTankSocketEvent) : void { }
            protected function __objectSetProperty(event:CrazyTankSocketEvent) : void { }
            protected function __livingFalling(event:CrazyTankSocketEvent) : void { }
            protected function __livingShowBlood(event:CrazyTankSocketEvent) : void { }
            private function addTerrace(event:CrazyTankSocketEvent) : void { }
            private function addNewPlayerHander(event:CrazyTankSocketEvent) : void { }
            protected function __selectObject(event:CrazyTankSocketEvent) : void { }
            private function petResLoad(currentPet:PetInfo) : void { }
            private function __missionTryAgain(e:CrazyTankSocketEvent) : void { }
            private function __updatePlayInfoInGame(e:CrazyTankSocketEvent) : void { }
            private function __missionInviteRoomInfo(e:CrazyTankSocketEvent) : void { }
            private function __createGame(event:CrazyTankSocketEvent) : void { }
            private function createGameInfo(pkg:PackageIn, isSingleBattle:Boolean = false) : void { }
            private function setSelfPlayerInfo(gm:GameInfo) : void { }
            private function __singleBattleStartMatch(event:CrazyTankSocketEvent) : void { }
            private function __buffObtain(evt:CrazyTankSocketEvent) : void { }
            private function __buffUpdate(evt:CrazyTankSocketEvent) : void { }
            private function __beginLoad(event:CrazyTankSocketEvent) : void { }
            private function checkCanToLoader() : void { }
            private function getRoomTypeNeedMissionInfo(roomType:int) : Boolean { return false; }
            private function __gameMissionStart(evt:CrazyTankSocketEvent) : void { }
            public function dispatchAllGameReadyState(array:Array) : void { }
            private function __gameMissionPrepare(e:CrazyTankSocketEvent) : void { }
            private function __gameMissionInfo(evt:CrazyTankSocketEvent) : void { }
            private function __loadprogress(evt:CrazyTankSocketEvent) : void { }
            private function __gameStart(event:CrazyTankSocketEvent) : void { }
            private function __missionAllOver(event:CrazyTankSocketEvent) : void { }
            private function __takeOut(event:CrazyTankSocketEvent) : void { }
            private function __showAllCard(event:CrazyTankSocketEvent) : void { }
            public function reset() : void { }
            public function startLoading() : void { }
            public function dispatchEnterRoom() : void { }
            public function dispatchLeaveMission() : void { }
            public function dispatchPaymentConfirm() : void { }
            public function selfGetItemShowAndSound(list:Dictionary) : Boolean { return false; }
            public function isIdenticalGame(id:int = 0) : Boolean { return false; }
            private function __loadResource(event:CrazyTankSocketEvent) : void { }
            public function setLoaderStop() : void { }
            public function get gameView() : IGameView { return null; }
            public function set gameView(value:IGameView) : void { }
            public function get addLivingEvtVec() : Vector.<CrazyTankSocketEvent> { return null; }
            public function get setPropertyEvtVec() : Vector.<CrazyTankSocketEvent> { return null; }
            public function get livingFallingEvtVec() : Vector.<CrazyTankSocketEvent> { return null; }
            public function get livingShowBloodEvtVec() : Vector.<CrazyTankSocketEvent> { return null; }
            public function get addMapThingEvtVec() : Vector.<CrazyTankSocketEvent> { return null; }
            public function get livingActionMappingEvtVec() : Vector.<CrazyTankSocketEvent> { return null; }
            public function get updatePhysicObjectEvtVec() : Vector.<CrazyTankSocketEvent> { return null; }
            public function get playerBloodEvtVec() : Vector.<CrazyTankSocketEvent> { return null; }
            public function get boxPhysicalEvtVec() : Vector.<CrazyTankSocketEvent> { return null; }
            private function __skillInfoInit(event:CrazyTankSocketEvent) : void { }
            private function setGameSmallData() : void { }
            private function setSmallMapEnable(value:String, random:int) : void { }
            private function setRandomSmallMapEnalbe(openKey:Array, enableCount:int, maxCount:int) : void { }
            private function isInBOMBKingGame() : Boolean { return false; }
            public function smallMapEnable() : Boolean { return false; }
            public function smallMapBorderEnable() : Boolean { return false; }
            public function smallMapAlpha() : Boolean { return false; }
            public function smallMapPoint() : Boolean { return false; }
            public function smallMapGrid() : Boolean { return false; }
            public function smallMapShape() : Boolean { return false; }
            public function get is3DGame() : Boolean { return false; }
            public function get specialSkillType() : String { return null; }
            public function setDropData(itemId:int, count:int) : void { }
            public function get isShowSelfBuffBar() : Boolean { return false; }
            public function get playerNotDie() : Boolean { return false; }
   }}