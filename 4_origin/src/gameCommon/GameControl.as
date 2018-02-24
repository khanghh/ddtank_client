package gameCommon
{
   import bombKing.BombKingManager;
   import campbattle.CampBattleManager;
   import catchbeast.CatchBeastManager;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import cryptBoss.CryptBossManager;
   import ddt.data.BallInfo;
   import ddt.data.BuffInfo;
   import ddt.data.PathInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.map.MissionInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.GameEvent;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.BallManager;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.PathManager;
   import ddt.manager.PetInfoManager;
   import ddt.manager.PetSkillManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.QueueManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.view.chat.ChatData;
   import ddt.view.chat.ChatFormats;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import game.view.DropGoods;
   import gameCommon.model.Bomb;
   import gameCommon.model.FightBuffInfo;
   import gameCommon.model.GameInfo;
   import gameCommon.model.GameNeedMovieInfo;
   import gameCommon.model.GameNeedPetSkillInfo;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.Pet;
   import gameCommon.model.Player;
   import gameCommon.model.SimpleBoxInfo;
   import gameCommon.view.experience.ExpTweenManager;
   import pet.data.PetInfo;
   import pet.data.PetSkillTemplateInfo;
   import ringStation.RingStationManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import room.RoomManager;
   import room.model.RoomPlayer;
   import trainer.controller.WeakGuildManager;
   
   public class GameControl extends EventDispatcher
   {
      
      public static var OBJECT:Object;
      
      public static const CAMP_BATTLE_MODEL_PVE:int = 24;
      
      public static const CAMP_BATTLE_MODEL_PVP:int = 23;
      
      public static const RING_STATION_MODEL:int = 26;
      
      public static const BOMB_KING_FIRST_MODEL:int = 28;
      
      public static const BOMB_KING_FINAL_MODEL:int = 29;
      
      public static const FARM_BOSS_MODEL:int = 30;
      
      public static const CHRISTMAS_MODEL:int = 40;
      
      public static const CRYPTBOSS_MODEL:int = 41;
      
      public static const RESCUE_MODEL:int = 31;
      
      public static const CATCH_INSECT_MODEL:int = 42;
      
      public static const DEMON_CHI_YOU_MODEL:int = 47;
      
      public static const CONSORTIA_DOMAIN_MODEL:int = 49;
      
      public static const CONSORTIA_GUARD:int = 151;
      
      public static const ESCAPE_BATTLE_ROOM:int = 56;
      
      public static const FLAG_BATTLE_ROOM:int = 57;
      
      public static const START_MATCH:String = "StartMatch";
      
      public static const RENSHEN_MODEL:int = 43;
      
      public static const ENTER_MISSION_RESULT:String = "EnterMissionResult";
      
      public static const ENTER_ROOM:String = "EnterRoom";
      
      public static const LEAVE_MISSION:String = "leaveMission";
      
      public static const ENTER_DUNGEON:String = "EnterDungeon";
      
      public static const PLAYER_CLICK_PAY:String = "PlayerClickPay";
      
      public static const SKILL_INFO_INIT_GAME:String = "skillInfoInitGame";
      
      public static const EXIT_ROOM_TYPE_ARRAY:Array = [10,14,19,20,31,24,40,26,27,52,21,48,150,151];
      
      public static const EXTI_GAME_MODE_ARRAY:Array = [56,57];
      
      private static var _instance:GameControl;
      
      public static const MissionGiveup:int = 0;
      
      public static const MissionAgain:int = 1;
      
      public static const MissionTimeout:int = 2;
       
      
      private var _current:GameInfo;
      
      public var currentNum:int = 0;
      
      public var bossName:String = "";
      
      public var isAddTerrce:Boolean;
      
      public var terrceX:int;
      
      public var terrceY:int;
      
      public var terrceID:int;
      
      private var _loaderArray:Array;
      
      private var _gameView:IGameView;
      
      private var _addLivingEvtVec:Vector.<CrazyTankSocketEvent>;
      
      private var _setPropertyEvtVec:Vector.<CrazyTankSocketEvent>;
      
      private var _livingFallingEvtVec:Vector.<CrazyTankSocketEvent>;
      
      private var _livingShowBloodEvtVec:Vector.<CrazyTankSocketEvent>;
      
      private var _addMapThingEvtVec:Vector.<CrazyTankSocketEvent>;
      
      private var _livingActionMappingEvtVec:Vector.<CrazyTankSocketEvent>;
      
      private var _updatePhysicObjectEvtVec:Vector.<CrazyTankSocketEvent>;
      
      private var _playerBloodEvtVec:Vector.<CrazyTankSocketEvent>;
      
      public var viewCompleteFlag:Boolean;
      
      public var randomSmallLivingShape:int = -1;
      
      public var teamColorData:DictionaryData;
      
      private var _pathInfo:PathInfo;
      
      public var selectList:Array;
      
      public var TryAgain:int = 0;
      
      private var _recevieLoadSocket:Boolean;
      
      private var _outBombs:DictionaryData;
      
      public var petSkillList:Array;
      
      public var horseSkillList:Array;
      
      private var _specialSkillType:String = null;
      
      public var dropGoodslist:Vector.<DropGoods>;
      
      public var dropData:Array;
      
      public var dropGlod:int;
      
      public function GameControl()
      {
         dropGoodslist = new Vector.<DropGoods>();
         dropData = [];
         super();
         _pathInfo = PathManager.getPathInfo();
      }
      
      public static function isAcademyRoom(param1:GameInfo) : Boolean
      {
         return param1.roomType == 11;
      }
      
      public static function isDungeonRoom(param1:GameInfo) : Boolean
      {
         return param1.roomType == 4 || param1.roomType == 15 || param1.roomType == 23 || param1.roomType == 123;
      }
      
      public static function isFightLib(param1:GameInfo) : Boolean
      {
         return param1.roomType == 5;
      }
      
      public static function isFreshMan(param1:GameInfo) : Boolean
      {
         return param1.roomType == 10;
      }
      
      public static function get Instance() : GameControl
      {
         if(_instance == null)
         {
            _instance = new GameControl();
         }
         return _instance;
      }
      
      public function get Current() : GameInfo
      {
         return _current;
      }
      
      public function set Current(param1:GameInfo) : void
      {
         _current = param1;
      }
      
      private function initData() : void
      {
         _loaderArray = [];
         _addLivingEvtVec = new Vector.<CrazyTankSocketEvent>();
         _setPropertyEvtVec = new Vector.<CrazyTankSocketEvent>();
         _livingFallingEvtVec = new Vector.<CrazyTankSocketEvent>();
         _livingShowBloodEvtVec = new Vector.<CrazyTankSocketEvent>();
         _addMapThingEvtVec = new Vector.<CrazyTankSocketEvent>();
         _livingActionMappingEvtVec = new Vector.<CrazyTankSocketEvent>();
         _updatePhysicObjectEvtVec = new Vector.<CrazyTankSocketEvent>();
         _playerBloodEvtVec = new Vector.<CrazyTankSocketEvent>();
      }
      
      public function setup() : void
      {
         initData();
         SocketManager.Instance.addEventListener("addLiving",__addLiving);
         SocketManager.Instance.addEventListener("playerProperty",__objectSetProperty);
         SocketManager.Instance.addEventListener("livingFalling",__livingFalling);
         SocketManager.Instance.addEventListener("livingShowBlood",__livingShowBlood);
         SocketManager.Instance.addEventListener("gameCreate",__createGame);
         SocketManager.Instance.addEventListener("gameStart",__gameStart);
         SocketManager.Instance.addEventListener("singleBattleStartMatch",__singleBattleStartMatch);
         SocketManager.Instance.addEventListener("gameLoad",__beginLoad);
         SocketManager.Instance.addEventListener("load",__loadprogress);
         SocketManager.Instance.addEventListener("gameAllMissionOver",__missionAllOver);
         SocketManager.Instance.addEventListener("gameTakeOut",__takeOut);
         SocketManager.Instance.addEventListener("showCard",__showAllCard);
         SocketManager.Instance.addEventListener("gameMissionInfo",__gameMissionInfo);
         SocketManager.Instance.addEventListener("gameMissionStart",__gameMissionStart);
         SocketManager.Instance.addEventListener("gameMissionPrepare",__gameMissionPrepare);
         SocketManager.Instance.addEventListener("gameRoomInfo",__missionInviteRoomInfo);
         SocketManager.Instance.addEventListener("playInfoInGame",__updatePlayInfoInGame);
         SocketManager.Instance.addEventListener("gameMissionTryAgain",__missionTryAgain);
         SocketManager.Instance.addEventListener("loadResource",__loadResource);
         SocketManager.Instance.addEventListener("selectObject",__selectObject);
         SocketManager.Instance.addEventListener("buffUpdate",__buffUpdate);
         SocketManager.Instance.addEventListener("add_new_player",addNewPlayerHander);
         SocketManager.Instance.addEventListener("add_terrace",addTerrace);
         SocketManager.Instance.addEventListener("addMapThing",__addMapThing);
         SocketManager.Instance.addEventListener("skillInfoInit",__skillInfoInit);
         SocketManager.Instance.addEventListener("actionMapping",__livingActionMapping);
         SocketManager.Instance.addEventListener("updateBoardState",__updatePhysicObject);
         SocketManager.Instance.addEventListener("playerBlood",__playerBlood);
      }
      
      private function __disposeCmd(param1:CrazyTankSocketEvent) : void
      {
         if(_addLivingEvtVec)
         {
            _addLivingEvtVec.splice(0,_addLivingEvtVec.length);
         }
         if(_setPropertyEvtVec)
         {
            _setPropertyEvtVec.splice(0,_setPropertyEvtVec.length);
         }
         if(_livingFallingEvtVec)
         {
            _livingFallingEvtVec.splice(0,_livingFallingEvtVec.length);
         }
         if(_livingShowBloodEvtVec)
         {
            _livingShowBloodEvtVec.splice(0,_livingShowBloodEvtVec.length);
         }
         if(_addMapThingEvtVec)
         {
            _addMapThingEvtVec.splice(0,_addMapThingEvtVec.length);
         }
         if(_livingActionMappingEvtVec)
         {
            _livingActionMappingEvtVec.splice(0,_livingActionMappingEvtVec.length);
         }
         if(_updatePhysicObjectEvtVec)
         {
            _updatePhysicObjectEvtVec.splice(0,_updatePhysicObjectEvtVec.length);
         }
         if(_playerBloodEvtVec)
         {
            _playerBloodEvtVec.splice(0,_playerBloodEvtVec.length);
         }
      }
      
      public function ClearAllCrazyTankSocketEvent() : void
      {
         _addLivingEvtVec.length = 0;
         _setPropertyEvtVec.length = 0;
         _livingFallingEvtVec.length = 0;
         _livingShowBloodEvtVec.length = 0;
         _addMapThingEvtVec.length = 0;
         _livingActionMappingEvtVec.length = 0;
         _updatePhysicObjectEvtVec.length = 0;
         _playerBloodEvtVec.length = 0;
      }
      
      protected function __playerBlood(param1:CrazyTankSocketEvent) : void
      {
         if(!viewCompleteFlag)
         {
            _playerBloodEvtVec.push(param1);
         }
         else
         {
            _gameView.playerBlood(param1);
         }
      }
      
      protected function __updatePhysicObject(param1:CrazyTankSocketEvent) : void
      {
         if(!viewCompleteFlag)
         {
            _updatePhysicObjectEvtVec.push(param1);
         }
         else
         {
            _gameView.updatePhysicObject(param1);
         }
      }
      
      protected function __livingActionMapping(param1:CrazyTankSocketEvent) : void
      {
         if(!viewCompleteFlag)
         {
            _livingActionMappingEvtVec.push(param1);
         }
         else
         {
            _gameView.livingActionMapping(param1);
         }
      }
      
      protected function __addMapThing(param1:CrazyTankSocketEvent) : void
      {
         if(!viewCompleteFlag)
         {
            _addMapThingEvtVec.push(param1);
         }
         else
         {
            _gameView.addMapThing(param1);
         }
      }
      
      protected function __addLiving(param1:CrazyTankSocketEvent) : void
      {
         if(!viewCompleteFlag)
         {
            _addLivingEvtVec.push(param1);
         }
         else
         {
            _gameView.addliving(param1);
         }
      }
      
      protected function __objectSetProperty(param1:CrazyTankSocketEvent) : void
      {
         if(!viewCompleteFlag)
         {
            _setPropertyEvtVec.push(param1);
         }
         else
         {
            _gameView.objectSetProperty(param1);
         }
      }
      
      protected function __livingFalling(param1:CrazyTankSocketEvent) : void
      {
         if(!viewCompleteFlag)
         {
            _livingFallingEvtVec.push(param1);
         }
         else
         {
            _gameView.livingFalling(param1);
         }
      }
      
      protected function __livingShowBlood(param1:CrazyTankSocketEvent) : void
      {
         if(!viewCompleteFlag)
         {
            _livingShowBloodEvtVec.push(param1);
         }
         else
         {
            _gameView.livingShowBlood(param1);
         }
      }
      
      private function addTerrace(param1:CrazyTankSocketEvent) : void
      {
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc4_:Boolean = false;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         if(!Current || Current.gameMode != 23)
         {
            return;
         }
         var _loc5_:int = param1.pkg.readInt();
         var _loc3_:int = 0;
         _loc9_ = 0;
         while(_loc9_ < _loc5_)
         {
            _loc7_ = param1.pkg.readInt();
            _loc8_ = Current.findPlayer(_loc7_);
            _loc4_ = param1.pkg.readBoolean();
            _loc2_ = param1.pkg.readInt();
            _loc6_ = param1.pkg.readInt();
            _loc8_.isLocked = _loc4_;
            terrceID = _loc7_;
            if(_loc4_)
            {
               isAddTerrce = true;
               terrceX = _loc2_;
               terrceY = _loc6_ + 10;
               dispatchEvent(new GameEvent("addTerrace",[terrceX,terrceY,_loc7_]));
            }
            else
            {
               isAddTerrce = false;
               dispatchEvent(new GameEvent("delTerrace",[_loc7_]));
            }
            _loc9_++;
         }
      }
      
      private function addNewPlayerHander(param1:CrazyTankSocketEvent) : void
      {
         var _loc29_:Boolean = false;
         var _loc41_:int = 0;
         var _loc4_:* = null;
         var _loc18_:* = null;
         var _loc47_:* = null;
         var _loc56_:int = 0;
         var _loc53_:* = null;
         var _loc33_:* = null;
         var _loc54_:int = 0;
         var _loc11_:int = 0;
         var _loc57_:* = null;
         var _loc23_:int = 0;
         var _loc38_:int = 0;
         var _loc55_:int = 0;
         var _loc24_:int = 0;
         var _loc46_:int = 0;
         var _loc49_:int = 0;
         var _loc48_:int = 0;
         var _loc13_:int = 0;
         var _loc27_:int = 0;
         var _loc36_:int = 0;
         var _loc26_:* = null;
         var _loc32_:int = 0;
         var _loc52_:int = 0;
         var _loc43_:* = null;
         var _loc34_:int = 0;
         var _loc37_:* = null;
         var _loc14_:* = null;
         var _loc22_:GameInfo = Current;
         var _loc17_:PackageIn = param1.pkg;
         var _loc35_:int = _loc17_.readInt();
         var _loc20_:String = _loc17_.readUTF();
         var _loc39_:int = _loc17_.readInt();
         var _loc15_:PlayerInfo = new PlayerInfo();
         _loc15_.beginChanges();
         var _loc12_:RoomPlayer = RoomManager.Instance.current.findPlayerByID(_loc39_,_loc35_);
         if(_loc12_ == null)
         {
            _loc12_ = new RoomPlayer(_loc15_);
         }
         _loc15_.ID = _loc39_;
         _loc15_.ZoneID = _loc35_;
         var _loc9_:String = _loc17_.readUTF();
         var _loc31_:Boolean = _loc17_.readBoolean();
         if(_loc31_ && _loc12_.place < 8)
         {
            _loc12_.place = 8;
         }
         _loc15_.NickName = _loc9_;
         _loc15_.typeVIP = _loc17_.readByte();
         _loc15_.VIPLevel = _loc17_.readInt();
         if(PlayerManager.Instance.isChangeStyleTemp(_loc15_.ID))
         {
            _loc17_.readBoolean();
            _loc17_.readInt();
            _loc17_.readUTF();
            _loc17_.readUTF();
            _loc17_.readUTF();
         }
         else
         {
            _loc29_ = _loc17_.readBoolean();
            _loc41_ = _loc17_.readInt();
            _loc4_ = _loc17_.readUTF();
            _loc18_ = _loc17_.readUTF();
            _loc47_ = _loc17_.readUTF();
            _loc15_.Sex = _loc29_;
            _loc15_.Hide = _loc41_;
            _loc15_.Style = _loc4_;
            _loc15_.Colors = _loc18_;
            _loc15_.Skin = _loc47_;
         }
         _loc15_.Grade = _loc17_.readInt();
         _loc15_.Repute = _loc17_.readInt();
         _loc15_.WeaponID = _loc17_.readInt();
         if(_loc15_.WeaponID != 0)
         {
            _loc56_ = _loc17_.readInt();
            _loc53_ = _loc17_.readUTF();
            _loc33_ = _loc17_.readDateString();
         }
         _loc15_.DeputyWeaponID = _loc17_.readInt();
         _loc15_.pvpBadgeId = _loc17_.readInt();
         _loc15_.Nimbus = _loc17_.readInt();
         _loc15_.IsShowConsortia = _loc17_.readBoolean();
         _loc15_.ConsortiaID = _loc17_.readInt();
         _loc15_.ConsortiaName = _loc17_.readUTF();
         _loc15_.badgeID = _loc17_.readInt();
         var _loc45_:int = _loc17_.readInt();
         var _loc40_:int = _loc17_.readInt();
         _loc15_.WinCount = _loc17_.readInt();
         _loc15_.TotalCount = _loc17_.readInt();
         _loc15_.FightPower = _loc17_.readInt();
         _loc15_.apprenticeshipState = _loc17_.readInt();
         _loc15_.masterID = _loc17_.readInt();
         _loc15_.setMasterOrApprentices(_loc17_.readUTF());
         _loc15_.AchievementPoint = _loc17_.readInt();
         _loc15_.honor = _loc17_.readUTF();
         _loc15_.Offer = _loc17_.readInt();
         _loc15_.DailyLeagueFirst = _loc17_.readBoolean();
         _loc15_.DailyLeagueLastScore = _loc17_.readInt();
         _loc15_.guardCoreID = _loc17_.readInt();
         _loc15_.commitChanges();
         _loc12_.playerInfo.IsMarried = _loc17_.readBoolean();
         if(_loc12_.playerInfo.IsMarried)
         {
            _loc12_.playerInfo.SpouseID = _loc17_.readInt();
            _loc12_.playerInfo.SpouseName = _loc17_.readUTF();
         }
         _loc17_.readInt();
         _loc17_.readInt();
         _loc17_.readInt();
         _loc17_.readInt();
         _loc17_.readInt();
         _loc17_.readInt();
         var _loc3_:int = _loc17_.readInt();
         _loc12_.team = _loc17_.readInt();
         _loc22_.addRoomPlayer(_loc12_);
         var _loc44_:int = _loc17_.readInt();
         var _loc19_:int = _loc17_.readInt();
         var _loc6_:Player = new Player(_loc12_.playerInfo,_loc44_,_loc12_.team,_loc19_,_loc3_);
         var _loc2_:int = _loc17_.readInt();
         _loc54_ = 0;
         while(_loc54_ < _loc2_)
         {
            _loc11_ = _loc17_.readInt();
            _loc57_ = _loc15_.pets[_loc11_];
            _loc23_ = _loc17_.readInt();
            if(_loc57_ == null)
            {
               _loc57_ = new PetInfo();
               _loc57_.TemplateID = _loc23_;
               PetInfoManager.fillPetInfo(_loc57_);
            }
            _loc57_.ID = _loc17_.readInt();
            _loc57_.Name = _loc17_.readUTF();
            _loc57_.UserID = _loc17_.readInt();
            _loc57_.Level = _loc17_.readInt();
            _loc57_.IsEquip = true;
            _loc57_.clearEquipedSkills();
            _loc38_ = _loc17_.readInt();
            _loc55_ = 0;
            while(_loc55_ < _loc38_)
            {
               _loc24_ = _loc17_.readInt();
               _loc46_ = _loc17_.readInt();
               _loc57_.equipdSkills.add(_loc24_,_loc46_);
               _loc55_++;
            }
            _loc57_.Place = _loc11_;
            _loc15_.pets.add(_loc57_.Place,_loc57_);
            _loc54_++;
         }
         _loc12_.horseSkillEquipList = [];
         var _loc5_:int = _loc17_.readInt();
         _loc49_ = 0;
         while(_loc49_ < _loc5_)
         {
            _loc12_.horseSkillEquipList.push(_loc17_.readInt());
            _loc49_++;
         }
         var _loc58_:int = _loc17_.readInt();
         _loc48_ = 0;
         while(_loc48_ < _loc58_)
         {
            _loc13_ = _loc17_.readInt();
            _loc48_++;
         }
         _loc6_.IsRobot = _loc17_.readBoolean();
         _loc6_.zoneName = _loc20_;
         _loc6_.currentWeapInfo.refineryLevel = _loc56_;
         _loc6_.ringFlag = _loc17_.readBoolean();
         _loc6_.loveBuffLevel = _loc17_.readInt();
         _loc6_.turnCount = _loc17_.readInt();
         var _loc30_:int = _loc17_.readInt();
         var _loc63_:int = _loc17_.readInt();
         var _loc60_:int = _loc17_.readInt();
         _loc6_.pos = new Point(_loc63_,_loc60_);
         _loc6_.energy = 1;
         _loc6_.direction = _loc17_.readInt();
         var _loc21_:int = _loc17_.readInt();
         var _loc25_:int = _loc17_.readInt();
         _loc6_.team = _loc17_.readInt();
         var _loc28_:int = _loc17_.readInt();
         if(_loc6_ is LocalPlayer)
         {
            (_loc6_ as LocalPlayer).deputyWeaponCount = _loc17_.readInt();
         }
         else
         {
            _loc27_ = _loc17_.readInt();
         }
         _loc6_.powerRatio = _loc17_.readInt();
         _loc6_.dander = _loc17_.readInt();
         _loc6_.maxBlood = _loc25_;
         _loc6_.updateBlood(_loc19_,0,0);
         _loc6_.wishKingCount = _loc17_.readInt();
         _loc6_.wishKingEnergy = _loc17_.readInt();
         _loc6_.currentWeapInfo.refineryLevel = _loc28_;
         var _loc59_:int = _loc17_.readInt();
         _loc36_ = 0;
         while(_loc36_ < _loc59_)
         {
            _loc26_ = BuffManager.creatBuff(_loc17_.readInt());
            _loc32_ = _loc17_.readInt();
            if(_loc26_)
            {
               _loc26_.data = _loc32_;
               _loc6_.addBuff(_loc26_);
            }
            _loc36_++;
         }
         var _loc50_:int = _loc17_.readInt();
         var _loc8_:Vector.<FightBuffInfo> = new Vector.<FightBuffInfo>();
         _loc52_ = 0;
         while(_loc52_ < _loc50_)
         {
            _loc43_ = BuffManager.creatBuff(_loc17_.readInt());
            _loc6_.outTurnBuffs.push(_loc43_);
            _loc52_++;
         }
         var _loc10_:Boolean = _loc17_.readBoolean();
         var _loc62_:Boolean = _loc17_.readBoolean();
         var _loc7_:Boolean = _loc17_.readBoolean();
         var _loc61_:Boolean = _loc17_.readBoolean();
         var _loc51_:int = _loc17_.readInt();
         var _loc42_:Dictionary = new Dictionary();
         _loc34_ = 0;
         while(_loc34_ < _loc51_)
         {
            _loc37_ = _loc17_.readUTF();
            _loc14_ = _loc17_.readUTF();
            _loc42_[_loc37_] = _loc14_;
            _loc34_++;
         }
         if(_loc10_)
         {
            _loc10_ = false;
         }
         _loc6_.isFrozen = _loc10_;
         _loc6_.isHidden = _loc62_;
         _loc6_.isNoNole = _loc7_;
         _loc6_.outProperty = _loc42_;
         if(RoomManager.Instance.current.type != 5 && _loc6_.playerInfo.currentPet)
         {
            _loc6_.currentPet = new Pet(_loc6_.playerInfo.currentPet);
            petResLoad(_loc6_.playerInfo.currentPet);
         }
         var _loc16_:Array = [_loc12_];
         LoadBombManager.Instance.loadFullRoomPlayersBomb(_loc16_);
         if(!_loc12_.isViewer)
         {
            _loc22_.addGamePlayer(_loc6_);
         }
         else
         {
            if(_loc12_.isSelf)
            {
               _loc22_.setSelfGamePlayer(_loc6_);
            }
            _loc22_.addGameViewer(_loc6_);
         }
      }
      
      protected function __selectObject(param1:CrazyTankSocketEvent) : void
      {
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         selectList = [];
         var _loc5_:int = param1.pkg.readInt();
         while(_loc8_ < _loc5_)
         {
            _loc2_ = param1.pkg.readInt();
            _loc7_ = param1.pkg.readInt();
            Current.getRoomPlayerByID(_loc2_,_loc7_).team = param1.pkg.readInt();
            _loc6_ = param1.pkg.readInt();
            _loc3_ = param1.pkg.readInt();
            _loc4_ = {};
            _loc4_["id"] = _loc2_;
            _loc4_["zoneID"] = _loc7_;
            _loc4_["selectID"] = _loc6_;
            _loc4_["selectZoneID"] = _loc3_;
            selectList.push(_loc4_);
            _loc8_++;
         }
         dispatchEvent(new GameEvent("selectComplete",null));
      }
      
      private function petResLoad(param1:PetInfo) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1)
         {
            LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetGameAssetUrl(param1.GameAssetUrl),4);
            var _loc6_:int = 0;
            var _loc5_:* = param1.equipdSkills;
            for each(var _loc4_ in param1.equipdSkills)
            {
               if(_loc4_ > 0)
               {
                  _loc3_ = PetSkillManager.getSkillByID(_loc4_);
                  if(_loc3_.EffectPic)
                  {
                     LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetSkillEffect(_loc3_.EffectPic),4);
                  }
                  if(_loc3_.NewBallID != -1)
                  {
                     _loc2_ = BallManager.instance.findBall(_loc3_.NewBallID);
                     _loc2_.loadBombAsset();
                     _loc2_.loadCraterBitmap();
                  }
               }
            }
         }
      }
      
      private function __missionTryAgain(param1:CrazyTankSocketEvent) : void
      {
         TryAgain = param1.pkg.readInt();
         dispatchEvent(new GameEvent("missionAgain",TryAgain));
      }
      
      private function __updatePlayInfoInGame(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:* = null;
         if(RoomManager.Instance.current == null)
         {
            return;
         }
         var _loc6_:PackageIn = param1.pkg;
         var _loc9_:int = _loc6_.readInt();
         var _loc2_:int = _loc6_.readInt();
         var _loc8_:int = _loc6_.readInt();
         var _loc5_:int = _loc6_.readInt();
         var _loc7_:int = _loc6_.readInt();
         var _loc3_:Boolean = _loc6_.readBoolean();
         var _loc10_:RoomPlayer = RoomManager.Instance.current.findPlayerByID(_loc2_);
         if(_loc9_ != PlayerManager.Instance.Self.ZoneID || _loc10_ == null || Current == null)
         {
            return;
         }
         if(_loc10_.isSelf)
         {
            _loc4_ = new LocalPlayer(PlayerManager.Instance.Self,_loc5_,_loc8_,_loc7_);
         }
         else
         {
            _loc4_ = new Player(_loc10_.playerInfo,_loc5_,_loc8_,_loc7_);
         }
         _loc4_.isReady = _loc3_;
         if(_loc4_.movie)
         {
            _loc4_.movie.setDefaultAction(_loc4_.movie.standAction);
         }
         Current.addRoomPlayer(_loc10_);
         if(_loc10_.isViewer)
         {
            Current.addGameViewer(_loc4_);
         }
         else
         {
            Current.addGamePlayer(_loc4_);
         }
         if(_loc10_.isSelf && Current.roomType != 20)
         {
            StateManager.setState("missionResult");
         }
      }
      
      private function __missionInviteRoomInfo(param1:CrazyTankSocketEvent) : void
      {
         var _loc7_:* = null;
         var _loc14_:* = null;
         var _loc9_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc5_:* = null;
         var _loc20_:* = null;
         var _loc6_:Boolean = false;
         var _loc17_:int = 0;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc19_:int = 0;
         var _loc16_:int = 0;
         var _loc4_:int = 0;
         var _loc18_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:* = null;
         var _loc15_:* = null;
         if(RoomManager.Instance.current)
         {
            _loc7_ = param1.pkg;
            _loc14_ = new GameInfo();
            _loc14_.mapIndex = _loc7_.readInt();
            _loc14_.roomType = _loc7_.readInt();
            _loc14_.gameMode = _loc7_.readInt();
            _loc14_.timeType = _loc7_.readInt();
            RoomManager.Instance.current.timeType = _loc14_.timeType;
            _loc9_ = _loc7_.readInt();
            _loc12_ = 0;
            while(_loc12_ < _loc9_)
            {
               _loc13_ = _loc7_.readInt();
               _loc5_ = PlayerManager.Instance.findPlayer(_loc13_);
               _loc5_.beginChanges();
               _loc20_ = RoomManager.Instance.current.findPlayerByID(_loc13_);
               if(_loc20_ == null)
               {
                  _loc20_ = new RoomPlayer(_loc5_);
                  _loc5_.ID = _loc13_;
               }
               _loc5_.ZoneID = PlayerManager.Instance.Self.ZoneID;
               _loc5_.NickName = _loc7_.readUTF();
               _loc6_ = _loc7_.readBoolean();
               _loc5_.typeVIP = _loc7_.readByte();
               _loc5_.VIPLevel = _loc7_.readInt();
               _loc5_.Sex = _loc7_.readBoolean();
               _loc5_.Hide = _loc7_.readInt();
               _loc5_.Style = _loc7_.readUTF();
               _loc5_.Colors = _loc7_.readUTF();
               _loc5_.Skin = _loc7_.readUTF();
               _loc5_.Grade = _loc7_.readInt();
               _loc5_.Repute = _loc7_.readInt();
               _loc5_.WeaponID = _loc7_.readInt();
               if(_loc5_.WeaponID > 0)
               {
                  _loc17_ = _loc7_.readInt();
                  _loc10_ = _loc7_.readUTF();
                  _loc11_ = _loc7_.readDateString();
               }
               _loc5_.DeputyWeaponID = _loc7_.readInt();
               _loc5_.ConsortiaID = _loc7_.readInt();
               _loc5_.ConsortiaName = _loc7_.readUTF();
               _loc5_.badgeID = _loc7_.readInt();
               _loc19_ = _loc7_.readInt();
               _loc16_ = _loc7_.readInt();
               _loc5_.DailyLeagueFirst = _loc7_.readBoolean();
               _loc5_.DailyLeagueLastScore = _loc7_.readInt();
               _loc5_.commitChanges();
               _loc4_ = _loc7_.readInt();
               _loc20_.team = _loc7_.readInt();
               _loc14_.addRoomPlayer(_loc20_);
               _loc18_ = _loc7_.readInt();
               _loc8_ = _loc7_.readInt();
               _loc2_ = _loc7_.readBoolean();
               if(_loc20_.isSelf)
               {
                  _loc3_ = new LocalPlayer(PlayerManager.Instance.Self,_loc18_,_loc20_.team,_loc8_,_loc4_);
               }
               else
               {
                  _loc3_ = new Player(_loc20_.playerInfo,_loc18_,_loc20_.team,_loc8_,_loc4_);
               }
               _loc3_.isReady = _loc2_;
               _loc3_.currentWeapInfo.refineryLevel = _loc17_;
               if(!_loc6_)
               {
                  _loc14_.addGamePlayer(_loc3_);
               }
               else
               {
                  if(_loc20_.isSelf)
                  {
                     _loc14_.setSelfGamePlayer(_loc3_);
                  }
                  _loc14_.addGameViewer(_loc3_);
               }
               _loc12_++;
            }
            Current = _loc14_;
            _loc15_ = new MissionInfo();
            _loc15_.name = _loc7_.readUTF();
            _loc15_.pic = _loc7_.readUTF();
            _loc15_.success = _loc7_.readUTF();
            _loc15_.failure = _loc7_.readUTF();
            _loc15_.description = _loc7_.readUTF();
            _loc15_.totalMissiton = _loc7_.readInt();
            _loc15_.missionIndex = _loc7_.readInt();
            _loc15_.nextMissionIndex = _loc15_.missionIndex + 1;
            Current.missionInfo = _loc15_;
            Current.hasNextMission = true;
         }
      }
      
      private function __createGame(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:* = null;
         if(RoomManager.Instance.current)
         {
            _loc2_ = param1.pkg;
            __disposeCmd(null);
            createGameInfo(_loc2_);
         }
      }
      
      private function createGameInfo(param1:PackageIn, param2:Boolean = false) : void
      {
         var _loc33_:int = 0;
         var _loc11_:int = 0;
         var _loc32_:* = null;
         var _loc13_:int = 0;
         var _loc23_:* = null;
         var _loc20_:* = null;
         var _loc15_:* = null;
         var _loc6_:Boolean = false;
         var _loc38_:int = 0;
         var _loc27_:* = null;
         var _loc9_:* = null;
         var _loc8_:Boolean = false;
         var _loc17_:int = 0;
         var _loc14_:int = 0;
         var _loc3_:int = 0;
         var _loc18_:* = 0;
         var _loc28_:int = 0;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc29_:int = 0;
         var _loc16_:int = 0;
         var _loc41_:* = null;
         var _loc35_:int = 0;
         var _loc12_:int = 0;
         var _loc31_:int = 0;
         var _loc37_:int = 0;
         var _loc21_:int = 0;
         var _loc10_:int = 0;
         var _loc25_:int = 0;
         var _loc40_:int = 0;
         var _loc22_:int = 0;
         var _loc19_:int = 0;
         var _loc30_:int = 0;
         var _loc34_:int = 0;
         var _loc39_:* = null;
         var _loc7_:* = null;
         var _loc24_:int = 0;
         var _loc36_:GameInfo = new GameInfo();
         _loc36_.roomType = param1.readInt();
         _loc36_.gameMode = param1.readInt();
         if(_loc36_.gameMode == 20)
         {
            _loc36_.roomType = 18;
         }
         if(_loc36_.roomType == 20 || _loc36_.roomType == 24 || _loc36_.roomType == 27 || _loc36_.roomType == 65 || _loc36_.roomType == 66)
         {
            _loc36_.missionInfo = new MissionInfo();
         }
         _loc36_.timeType = param1.readInt();
         RoomManager.Instance.current.timeType = _loc36_.timeType;
         var _loc26_:int = param1.readInt();
         _loc33_ = 0;
         while(_loc33_ < _loc26_)
         {
            _loc11_ = param1.readInt();
            _loc32_ = param1.readUTF();
            _loc13_ = param1.readInt();
            _loc23_ = PlayerManager.Instance.findPlayer(_loc13_,_loc11_);
            _loc23_.beginChanges();
            _loc20_ = RoomManager.Instance.current.findPlayerByID(_loc13_,_loc11_);
            if(_loc20_ == null)
            {
               _loc20_ = new RoomPlayer(_loc23_);
            }
            _loc23_.ID = _loc13_;
            _loc23_.ZoneID = _loc11_;
            _loc15_ = param1.readUTF();
            _loc6_ = param1.readBoolean();
            if(_loc6_ && _loc20_.place < 8)
            {
               _loc20_.place = 8;
            }
            if(!(_loc20_ is SelfInfo))
            {
               _loc23_.NickName = _loc15_;
            }
            _loc23_.typeVIP = param1.readByte();
            _loc23_.VIPLevel = param1.readInt();
            if(PlayerManager.Instance.isChangeStyleTemp(_loc23_.ID))
            {
               param1.readBoolean();
               param1.readInt();
               param1.readUTF();
               param1.readUTF();
               param1.readUTF();
            }
            else
            {
               _loc23_.Sex = param1.readBoolean();
               _loc23_.Hide = param1.readInt();
               _loc23_.Style = param1.readUTF();
               _loc23_.Colors = param1.readUTF();
               _loc23_.Skin = param1.readUTF();
            }
            _loc23_.Grade = param1.readInt();
            _loc23_.Repute = param1.readInt();
            _loc23_.WeaponID = param1.readInt();
            if(_loc23_.WeaponID != 0)
            {
               _loc38_ = param1.readInt();
               _loc27_ = param1.readUTF();
               _loc9_ = param1.readDateString();
            }
            _loc23_.DeputyWeaponID = param1.readInt();
            _loc23_.pvpBadgeId = param1.readInt();
            _loc23_.Nimbus = param1.readInt();
            _loc8_ = param1.readBoolean();
            _loc23_.ConsortiaID = param1.readInt();
            _loc23_.ConsortiaName = param1.readUTF();
            _loc23_.badgeID = param1.readInt();
            _loc17_ = param1.readInt();
            _loc14_ = param1.readInt();
            _loc23_.WinCount = param1.readInt();
            _loc23_.TotalCount = param1.readInt();
            _loc23_.FightPower = param1.readInt();
            _loc23_.apprenticeshipState = param1.readInt();
            _loc23_.masterID = param1.readInt();
            _loc23_.setMasterOrApprentices(param1.readUTF());
            _loc23_.AchievementPoint = param1.readInt();
            _loc23_.honor = param1.readUTF();
            _loc23_.Offer = param1.readInt();
            _loc23_.DailyLeagueFirst = param1.readBoolean();
            _loc23_.DailyLeagueLastScore = param1.readInt();
            _loc23_.guardCoreID = param1.readInt();
            _loc23_.fightStatus = 0;
            _loc23_.isTrusteeship = false;
            _loc23_.commitChanges();
            _loc20_.playerInfo.IsMarried = param1.readBoolean();
            if(_loc20_.playerInfo.IsMarried)
            {
               _loc20_.playerInfo.SpouseID = param1.readInt();
               _loc20_.playerInfo.SpouseName = param1.readUTF();
            }
            param1.readInt();
            param1.readInt();
            param1.readInt();
            param1.readInt();
            param1.readInt();
            param1.readInt();
            _loc3_ = param1.readInt();
            _loc20_.team = param1.readInt();
            _loc36_.addRoomPlayer(_loc20_);
            _loc18_ = int(param1.readInt());
            if(param2)
            {
               _loc18_ = _loc33_;
            }
            _loc28_ = param1.readInt();
            if(_loc28_ <= 0)
            {
               SocketManager.Instance.out.sendErrorMsg(_loc15_ + " 的进入战斗程序鬼混状态！ 血量是: " + _loc28_);
            }
            if(_loc20_.isSelf)
            {
               _loc4_ = new LocalPlayer(PlayerManager.Instance.Self,_loc18_,_loc20_.team,_loc28_,_loc3_);
            }
            else
            {
               _loc4_ = new Player(_loc20_.playerInfo,_loc18_,_loc20_.team,_loc28_,_loc3_);
            }
            _loc4_.autoOnHook = _loc36_.roomType == 49;
            _loc5_ = param1.readInt();
            _loc29_ = 0;
            while(_loc29_ < _loc5_)
            {
               _loc16_ = param1.readInt();
               _loc41_ = _loc23_.pets[_loc16_];
               _loc35_ = param1.readInt();
               if(_loc41_ == null)
               {
                  _loc41_ = new PetInfo();
                  _loc41_.TemplateID = _loc35_;
                  PetInfoManager.fillPetInfo(_loc41_);
               }
               _loc41_.ID = param1.readInt();
               _loc41_.Name = param1.readUTF();
               _loc41_.UserID = param1.readInt();
               _loc41_.Level = param1.readInt();
               _loc41_.IsEquip = true;
               _loc41_.clearEquipedSkills();
               _loc12_ = param1.readInt();
               _loc31_ = 0;
               while(_loc31_ < _loc12_)
               {
                  _loc37_ = param1.readInt();
                  _loc21_ = param1.readInt();
                  _loc41_.equipdSkills.add(_loc37_,_loc21_);
                  _loc31_++;
               }
               _loc41_.Place = _loc16_;
               _loc23_.pets.add(_loc41_.Place,_loc41_);
               _loc29_++;
            }
            _loc20_.horseSkillEquipList = [];
            _loc10_ = param1.readInt();
            _loc25_ = 0;
            while(_loc25_ < _loc10_)
            {
               _loc20_.horseSkillEquipList.push(param1.readInt());
               _loc25_++;
            }
            _loc20_.battleSkillEquipList = [];
            _loc40_ = param1.readInt();
            _loc22_ = 0;
            while(_loc22_ < _loc40_)
            {
               _loc19_ = param1.readInt();
               _loc20_.battleSkillEquipList.push(_loc19_);
               _loc22_++;
            }
            _loc4_.IsRobot = param1.readBoolean();
            _loc4_.ringFlag = param1.readBoolean();
            _loc4_.loveBuffLevel = param1.readInt();
            _loc4_.turnCount = param1.readInt();
            _loc23_.teamID = param1.readInt();
            _loc23_.teamDivision = param1.readInt();
            _loc23_.teamName = param1.readUTF();
            _loc23_.teamTag = param1.readUTF();
            _loc23_.teamGrade = param1.readInt();
            _loc23_.teamWinTime = param1.readInt();
            _loc23_.teamTotalTime = param1.readInt();
            _loc23_.teamPersonalScore = param1.readInt();
            _loc4_.zoneName = _loc32_;
            _loc4_.currentWeapInfo.refineryLevel = _loc38_;
            if(!_loc20_.isViewer)
            {
               _loc36_.addGamePlayer(_loc4_);
            }
            else
            {
               if(_loc20_.isSelf)
               {
                  _loc36_.setSelfGamePlayer(_loc4_);
               }
               _loc36_.addGameViewer(_loc4_);
            }
            _loc33_++;
         }
         if(!param2)
         {
            _loc36_.guardCoreEnable = param1.readBoolean();
            _loc30_ = param1.readInt();
            _loc34_ = 0;
            while(_loc34_ < _loc30_)
            {
               _loc39_ = new Bomb();
               _loc39_.Id = param1.readInt();
               _loc39_.X = param1.readInt();
               _loc39_.Y = param1.readInt();
               _loc36_.outBombs.add(_loc34_,_loc39_);
               _loc34_++;
            }
            _loc7_ = param1.readUTF();
            _loc24_ = param1.readInt();
            setSmallMapEnable(_loc7_,_loc24_);
         }
         if(BombKingManager.instance.Recording)
         {
            setSelfPlayerInfo(_loc36_);
         }
         Current = _loc36_;
         if(!param2)
         {
            QueueManager.setLifeTime(0);
         }
         RingStationManager.instance.RoomType = _loc36_.roomType;
         CatchBeastManager.instance.RoomType = _loc36_.roomType;
         CryptBossManager.instance.RoomType = _loc36_.roomType;
         SocketManager.Instance.out.sendGameTrusteeship(false);
      }
      
      private function setSelfPlayerInfo(param1:GameInfo) : void
      {
         var _loc3_:* = null;
         var _loc2_:SelfInfo = PlayerManager.Instance.Self;
         if(param1.findPlayerByPlayerID(_loc2_.ID) == null)
         {
            _loc3_ = new LocalPlayer(_loc2_,0,0,0);
            param1.setSelfGamePlayer(_loc3_);
            param1.addGameViewer(_loc3_);
         }
      }
      
      private function __singleBattleStartMatch(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:* = null;
         if(RoomManager.Instance.current)
         {
            _loc2_ = param1.pkg;
            createGameInfo(_loc2_,true);
            dispatchEvent(new Event("StartMatch"));
         }
      }
      
      private function __buffObtain(param1:CrazyTankSocketEvent) : void
      {
         var _loc7_:* = null;
         var _loc2_:int = 0;
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:Boolean = false;
         var _loc6_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:* = null;
         if(Current)
         {
            _loc7_ = param1.pkg;
            if(_loc7_.extend1 == Current.selfGamePlayer.LivingID)
            {
               return;
            }
            if(Current.findPlayer(_loc7_.extend1) != null)
            {
               _loc2_ = _loc7_.readInt();
               _loc10_ = 0;
               while(_loc10_ < _loc2_)
               {
                  _loc9_ = _loc7_.readInt();
                  _loc3_ = _loc7_.readBoolean();
                  _loc6_ = _loc7_.readDate();
                  _loc4_ = _loc7_.readInt();
                  _loc5_ = _loc7_.readInt();
                  _loc8_ = new BuffInfo(_loc9_,_loc3_,_loc6_,_loc4_,_loc5_);
                  Current.findPlayer(_loc7_.extend1).playerInfo.buffInfo.add(_loc8_.Type,_loc8_);
                  _loc10_++;
               }
               param1.stopImmediatePropagation();
            }
         }
      }
      
      private function __buffUpdate(param1:CrazyTankSocketEvent) : void
      {
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc9_:Boolean = false;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:* = null;
         if(Current)
         {
            _loc7_ = param1.pkg;
            if(_loc7_.extend1 == Current.selfGamePlayer.LivingID)
            {
               return;
            }
            if(Current.findPlayer(_loc7_.extend1) != null)
            {
               _loc8_ = _loc7_.readInt();
               _loc2_ = _loc7_.readInt();
               _loc9_ = _loc7_.readBoolean();
               _loc4_ = _loc7_.readDate();
               _loc5_ = _loc7_.readInt();
               _loc3_ = _loc7_.readInt();
               _loc6_ = new BuffInfo(_loc2_,_loc9_,_loc4_,_loc5_,_loc3_);
               if(_loc9_)
               {
                  Current.findPlayer(_loc7_.extend1).playerInfo.buffInfo.add(_loc6_.Type,_loc6_);
               }
               else
               {
                  Current.findPlayer(_loc7_.extend1).playerInfo.buffInfo.remove(_loc6_.Type);
               }
               param1.stopImmediatePropagation();
            }
         }
      }
      
      private function __beginLoad(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:* = null;
         StateManager.getInGame_Step_3 = true;
         _recevieLoadSocket = true;
         if(Current)
         {
            StateManager.getInGame_Step_4 = true;
            Current.maxTime = param1.pkg.readInt();
            Current.mapIndex = param1.pkg.readInt();
            _loc2_ = param1.pkg.readInt();
            _loc7_ = 1;
            while(_loc7_ <= _loc2_)
            {
               _loc5_ = new GameNeedMovieInfo();
               _loc5_.type = param1.pkg.readInt();
               _loc5_.path = param1.pkg.readUTF();
               _loc5_.classPath = param1.pkg.readUTF();
               Current.neededMovies.push(_loc5_);
               _loc7_++;
            }
            _loc3_ = param1.pkg.readInt();
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc6_ = new GameNeedPetSkillInfo();
               _loc6_.pic = param1.pkg.readUTF();
               _loc6_.effect = param1.pkg.readUTF();
               Current.neededPetSkillResource.push(_loc6_);
               _loc4_++;
            }
         }
         checkCanToLoader();
      }
      
      private function checkCanToLoader() : void
      {
         if(_recevieLoadSocket && Current && (Current.missionInfo || !getRoomTypeNeedMissionInfo(Current.roomType)))
         {
            dispatchEvent(new Event("StartLoading"));
            StateManager.getInGame_Step_5 = true;
            _recevieLoadSocket = false;
         }
      }
      
      private function getRoomTypeNeedMissionInfo(param1:int) : Boolean
      {
         return param1 == 2 || param1 == 3 || param1 == 4 || param1 == 5 || param1 == 8 || param1 == 10 || param1 == 11 || param1 == 14 || param1 == 17 || param1 == 20 || param1 == 21;
      }
      
      private function __gameMissionStart(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:Object = {};
         _loc4_.id = _loc3_.clientId;
         var _loc2_:Boolean = _loc3_.readBoolean();
      }
      
      public function dispatchAllGameReadyState(param1:Array) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc2_:int = 0;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc9_:int = 0;
         var _loc8_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc6_ = _loc3_.pkg;
            _loc7_ = {};
            _loc2_ = _loc6_.clientId;
            if(Current)
            {
               _loc5_ = Current.findPlayerByPlayerID(_loc2_);
               _loc5_.isReady = _loc6_.readBoolean();
               if(!_loc5_.isSelf && _loc5_.isReady)
               {
                  _loc4_ = RoomManager.Instance.current.findPlayerByID(_loc2_);
                  _loc4_.isReady = true;
               }
            }
            _loc6_.position = 20;
         }
      }
      
      private function __gameMissionPrepare(param1:CrazyTankSocketEvent) : void
      {
         if(RoomManager.Instance.current)
         {
            RoomManager.Instance.current.setPlayerReadyState(param1.pkg.clientId,param1.pkg.readBoolean());
         }
      }
      
      private function __gameMissionInfo(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(Current == null)
         {
            return;
         }
         if(!Current.missionInfo)
         {
            var _loc4_:* = new MissionInfo();
            Current.missionInfo = _loc4_;
            _loc2_ = _loc4_;
         }
         else
         {
            _loc2_ = Current.missionInfo;
         }
         _loc2_.id = param1.pkg.readInt();
         _loc2_.name = param1.pkg.readUTF();
         _loc2_.success = param1.pkg.readUTF();
         _loc2_.failure = param1.pkg.readUTF();
         _loc2_.description = param1.pkg.readUTF();
         _loc3_ = param1.pkg.readUTF();
         _loc2_.totalMissiton = param1.pkg.readInt();
         _loc2_.missionIndex = param1.pkg.readInt();
         _loc2_.totalValue1 = param1.pkg.readInt();
         _loc2_.totalValue2 = param1.pkg.readInt();
         _loc2_.totalValue3 = param1.pkg.readInt();
         _loc2_.totalValue4 = param1.pkg.readInt();
         _loc2_.nextMissionIndex = _loc2_.missionIndex + 1;
         _loc2_.parseString(_loc3_);
         _loc2_.tryagain = param1.pkg.readInt();
         _loc2_.pic = param1.pkg.readUTF();
         checkCanToLoader();
      }
      
      private function __loadprogress(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:* = null;
         if(Current)
         {
            _loc3_ = param1.pkg.readInt();
            _loc4_ = param1.pkg.readInt();
            _loc2_ = param1.pkg.readInt();
            _loc5_ = Current.findRoomPlayer(_loc2_,_loc4_);
            if(_loc5_ && !_loc5_.isSelf)
            {
               _loc5_.progress = _loc3_;
            }
         }
      }
      
      private function __gameStart(param1:CrazyTankSocketEvent) : void
      {
         var _loc21_:* = null;
         var _loc26_:int = 0;
         var _loc30_:int = 0;
         var _loc16_:int = 0;
         var _loc9_:* = null;
         var _loc25_:int = 0;
         var _loc31_:int = 0;
         var _loc2_:int = 0;
         var _loc34_:int = 0;
         var _loc3_:int = 0;
         var _loc33_:* = null;
         var _loc27_:int = 0;
         var _loc5_:int = 0;
         var _loc22_:int = 0;
         var _loc11_:* = undefined;
         var _loc23_:int = 0;
         var _loc15_:Boolean = false;
         var _loc36_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc37_:Boolean = false;
         var _loc24_:int = 0;
         var _loc17_:* = null;
         var _loc8_:int = 0;
         var _loc10_:* = null;
         var _loc19_:* = null;
         var _loc14_:int = 0;
         var _loc35_:* = null;
         var _loc6_:int = 0;
         var _loc13_:int = 0;
         var _loc29_:int = 0;
         var _loc28_:int = 0;
         var _loc32_:* = null;
         var _loc4_:int = 0;
         var _loc20_:* = 0;
         var _loc18_:* = null;
         var _loc7_:int = 0;
         setGameSmallData();
         TryAgain = -1;
         ExpTweenManager.Instance.deleteTweens();
         if(Current)
         {
            param1.executed = false;
            _loc21_ = param1.pkg;
            _loc26_ = _loc21_.readInt();
            _loc30_ = 1;
            while(_loc30_ <= _loc26_)
            {
               _loc16_ = _loc21_.readInt();
               _loc9_ = Current.findPlayer(_loc16_);
               if(_loc9_ != null)
               {
                  _loc9_.reset();
                  _loc9_.pos = new Point(_loc21_.readInt(),_loc21_.readInt());
                  _loc9_.energy = 1;
                  _loc9_.direction = _loc21_.readInt();
                  _loc25_ = _loc21_.readInt();
                  _loc31_ = _loc21_.readInt();
                  _loc9_.team = _loc21_.readInt();
                  _loc2_ = _loc21_.readInt();
                  if(_loc9_ is LocalPlayer)
                  {
                     (_loc9_ as LocalPlayer).deputyWeaponCount = _loc21_.readInt();
                  }
                  else
                  {
                     _loc34_ = _loc21_.readInt();
                  }
                  _loc9_.powerRatio = _loc21_.readInt();
                  _loc9_.dander = _loc21_.readInt();
                  _loc9_.maxBlood = _loc31_;
                  _loc9_.updateBlood(_loc25_,0,0);
                  _loc9_.wishKingCount = _loc21_.readInt();
                  _loc9_.wishKingEnergy = _loc21_.readInt();
                  _loc9_.currentWeapInfo.refineryLevel = _loc2_;
                  _loc3_ = _loc21_.readInt();
                  _loc27_ = 0;
                  while(_loc27_ < _loc3_)
                  {
                     _loc33_ = BuffManager.creatBuff(_loc21_.readInt());
                     _loc5_ = _loc21_.readInt();
                     if(_loc33_)
                     {
                        _loc33_.data = _loc5_;
                        _loc9_.addBuff(_loc33_);
                     }
                     _loc27_++;
                  }
                  _loc22_ = _loc21_.readInt();
                  _loc11_ = new Vector.<FightBuffInfo>();
                  _loc23_ = 0;
                  while(_loc23_ < _loc22_)
                  {
                     _loc33_ = BuffManager.creatBuff(_loc21_.readInt());
                     _loc9_.addBuff(_loc33_);
                     _loc23_++;
                  }
                  _loc15_ = _loc21_.readBoolean();
                  _loc36_ = _loc21_.readBoolean();
                  _loc12_ = _loc21_.readBoolean();
                  _loc37_ = _loc21_.readBoolean();
                  _loc24_ = _loc21_.readInt();
                  _loc17_ = new Dictionary();
                  _loc8_ = 0;
                  while(_loc8_ < _loc24_)
                  {
                     _loc10_ = _loc21_.readUTF();
                     _loc19_ = _loc21_.readUTF();
                     _loc17_[_loc10_] = _loc19_;
                     _loc8_++;
                  }
                  _loc9_.isFrozen = _loc15_;
                  _loc9_.isHidden = _loc36_;
                  _loc9_.isNoNole = _loc12_;
                  _loc9_.outProperty = _loc17_;
                  if(RoomManager.Instance.current.type != 5 && _loc9_.playerInfo.currentPet)
                  {
                     _loc9_.currentPet = new Pet(_loc9_.playerInfo.currentPet);
                  }
                  _loc14_ = _loc21_.readInt();
                  _loc35_ = Current.findPlayerByPlayerID(_loc14_);
                  if(_loc35_)
                  {
                     _loc9_.markMeHide = true;
                     if(Current.selfGamePlayer == _loc35_)
                     {
                        _loc9_.markMeHideDest = true;
                     }
                  }
                  _loc6_ = _loc21_.readInt();
                  _loc13_ = _loc21_.readInt();
                  if(_loc9_.isSelf)
                  {
                     Current.exitTimes = _loc6_;
                     Current.exitTimeLimit = _loc13_ * 60000;
                  }
               }
               _loc30_++;
            }
            _loc29_ = _loc21_.readInt();
            _loc28_ = 0;
            while(_loc28_ < _loc29_)
            {
               _loc32_ = new Bomb();
               _loc32_.Id = _loc21_.readInt();
               _loc32_.X = _loc21_.readInt();
               _loc32_.Y = _loc21_.readInt();
               Current.outBombs.add(_loc28_,_loc32_);
               _loc28_++;
            }
            _loc4_ = _loc21_.readInt();
            _loc20_ = uint(0);
            while(_loc20_ < _loc4_)
            {
               _loc18_ = new SimpleBoxInfo();
               _loc18_.bid = _loc21_.readInt();
               _loc18_.bx = _loc21_.readInt();
               _loc18_.by = _loc21_.readInt();
               _loc18_.subType = _loc21_.readInt();
               Current.outBoxs.add(_loc18_.bid,_loc18_);
               _loc20_++;
            }
            Current.startTime = _loc21_.readDate();
            MapManager.Instance.curMapCardLabelType = _loc21_.readInt();
            _loc7_ = RoomManager.Instance.current.type;
            if(_loc7_ == 5)
            {
               StateManager.setState("fightLabGameView",Current);
               if(PathManager.isStatistics)
               {
                  WeakGuildManager.Instance.statistics(4,TimeManager.Instance.enterFightTime);
               }
            }
            else if(_loc7_ == 10)
            {
               if(StartupResourceLoader.firstEnterHall)
               {
                  StateManager.setState("trainer2",Current);
               }
               else
               {
                  StateManager.setState("trainer1",Current);
               }
               if(PathManager.isStatistics)
               {
                  WeakGuildManager.Instance.statistics(4,TimeManager.Instance.enterFightTime);
               }
            }
            else if(_loc26_ == 0)
            {
               if(RoomManager.Instance.current.type == 4)
               {
                  StateManager.setState("dungeon");
               }
               else
               {
                  StateManager.setState("roomlist");
               }
            }
            else
            {
               if(RoomManager.Instance.current.type == 120 || RoomManager.Instance.current.type == 123 || RoomManager.Instance.current.type == 1 && RoomManager.Instance.current.dungeonMode == 120)
               {
                  StateManager.setState("fighting3d",Current);
               }
               else
               {
                  StateManager.setState("fighting",Current);
               }
               Current.IsOneOnOne = _loc26_ == 2;
               if(PathManager.isStatistics)
               {
                  WeakGuildManager.Instance.statistics(4,TimeManager.Instance.enterFightTime);
               }
            }
            RoomManager.Instance.resetAllPlayerState();
         }
         CampBattleManager.instance.isFighting = true;
      }
      
      private function __missionAllOver(param1:CrazyTankSocketEvent) : void
      {
         var _loc10_:int = 0;
         var _loc7_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc8_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         var _loc9_:int = _loc4_.readInt();
         if(Current == null)
         {
            return;
         }
         while(_loc10_ < _loc9_)
         {
            _loc2_ = _loc4_.readInt();
            _loc3_ = Current.findPlayerByPlayerID(_loc2_);
            if(_loc3_)
            {
               if(_loc3_.expObj)
               {
                  _loc7_ = _loc3_.expObj;
               }
               else
               {
                  _loc7_ = {};
               }
               _loc7_.killGP = _loc4_.readInt();
               _loc7_.hertGP = _loc4_.readInt();
               _loc7_.fightGP = _loc4_.readInt();
               _loc7_.ghostGP = _loc4_.readInt();
               _loc7_.gpForVIP = _loc4_.readInt();
               _loc7_.gpForConsortia = _loc4_.readInt();
               _loc7_.gpForSpouse = _loc4_.readInt();
               _loc7_.gpForServer = _loc4_.readInt();
               _loc7_.gpForApprenticeOnline = _loc4_.readInt();
               _loc7_.gpForApprenticeTeam = _loc4_.readInt();
               _loc7_.gpForDoubleCard = _loc4_.readInt();
               _loc7_.gpForPower = _loc4_.readInt();
               _loc7_.consortiaSkill = _loc4_.readInt();
               _loc7_.luckyExp = _loc4_.readInt();
               _loc7_.gainGP = _loc4_.readInt();
               _loc7_.gpCSMUser = _loc4_.readInt();
               _loc7_.gpAddWell = _loc4_.readInt();
               trace("gpCSMUser:" + _loc7_.gpCSMUser);
               _loc3_.isWin = _loc4_.readBoolean();
               _loc3_.expObj = _loc7_;
            }
            _loc10_++;
         }
         if(PathManager.solveExternalInterfaceEnabel() && Current.selfGamePlayer.isWin)
         {
            _loc6_ = PlayerManager.Instance.Self;
         }
         Current.missionInfo.missionOverNPCMovies = [];
         var _loc5_:int = _loc4_.readInt();
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            Current.missionInfo.missionOverNPCMovies.push(_loc4_.readUTF());
            _loc8_++;
         }
      }
      
      private function __takeOut(param1:CrazyTankSocketEvent) : void
      {
         if(Current)
         {
            Current.resultCard.push(param1);
         }
      }
      
      private function __showAllCard(param1:CrazyTankSocketEvent) : void
      {
         if(Current)
         {
            Current.showAllCard.push(param1);
         }
      }
      
      public function reset() : void
      {
         if(Current)
         {
            Current.dispose();
            Current = null;
         }
      }
      
      public function startLoading() : void
      {
         StateManager.setState("gameLoading");
      }
      
      public function dispatchEnterRoom() : void
      {
         dispatchEvent(new Event("EnterRoom"));
      }
      
      public function dispatchLeaveMission() : void
      {
         dispatchEvent(new Event("leaveMission"));
      }
      
      public function dispatchPaymentConfirm() : void
      {
         dispatchEvent(new Event("PlayerClickPay"));
      }
      
      public function selfGetItemShowAndSound(param1:Dictionary) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc7_:Boolean = false;
         var _loc9_:int = 0;
         var _loc8_:* = param1;
         for each(var _loc6_ in param1)
         {
            _loc4_ = new ChatData();
            _loc4_.channel = 6;
            _loc5_ = LanguageMgr.GetTranslation("tank.data.player.FightingPlayerInfo.your");
            _loc2_ = ChatFormats.getTagsByChannel(_loc4_);
            _loc3_ = ChatFormats.creatGoodTag(_loc6_.Property1 != "31"?"[" + _loc6_.Name + "]":"[" + _loc6_.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(_loc6_.TemplateID).Name + "Lv" + BeadTemplateManager.Instance.GetBeadInfobyID(_loc6_.TemplateID).BaseLevel + "]",2,_loc6_.TemplateID,_loc6_.Quality,_loc6_.IsBinds,_loc4_);
            _loc4_.htmlMessage = _loc2_[0] + _loc5_ + _loc3_ + _loc2_[1] + "<BR>";
            ChatManager.Instance.chat(_loc4_,false);
            if(_loc6_.Quality >= 3)
            {
               _loc7_ = true;
            }
         }
         return _loc7_;
      }
      
      public function isIdenticalGame(param1:int = 0) : Boolean
      {
         var _loc2_:DictionaryData = RoomManager.Instance.current.players;
         var _loc3_:SelfInfo = PlayerManager.Instance.Self;
         if(param1 == _loc3_.ID)
         {
            return false;
         }
         var _loc6_:int = 0;
         var _loc5_:* = _loc2_;
         for each(var _loc4_ in _loc2_)
         {
            if(_loc4_.playerInfo.ID == param1 && _loc4_.playerInfo.ZoneID == _loc3_.ZoneID)
            {
               return true;
            }
         }
         return false;
      }
      
      private function __loadResource(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         setLoaderStop();
         var _loc2_:int = param1.pkg.readInt();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new GameNeedMovieInfo();
            _loc3_.type = param1.pkg.readInt();
            _loc3_.path = param1.pkg.readUTF();
            _loc3_.classPath = param1.pkg.readUTF();
            _loc3_.startLoad();
            _loc4_++;
         }
      }
      
      public function setLoaderStop() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_loaderArray != null)
         {
            _loc1_ = _loaderArray.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               if(!(_loaderArray[_loc2_] as BaseLoader).isComplete)
               {
                  (_loaderArray[_loc2_] as BaseLoader).unload();
               }
               _loc2_++;
            }
            _loaderArray.length = 0;
         }
      }
      
      public function get gameView() : IGameView
      {
         return _gameView;
      }
      
      public function set gameView(param1:IGameView) : void
      {
         _gameView = param1;
      }
      
      public function get addLivingEvtVec() : Vector.<CrazyTankSocketEvent>
      {
         return _addLivingEvtVec;
      }
      
      public function get setPropertyEvtVec() : Vector.<CrazyTankSocketEvent>
      {
         return _setPropertyEvtVec;
      }
      
      public function get livingFallingEvtVec() : Vector.<CrazyTankSocketEvent>
      {
         return _livingFallingEvtVec;
      }
      
      public function get livingShowBloodEvtVec() : Vector.<CrazyTankSocketEvent>
      {
         return _livingShowBloodEvtVec;
      }
      
      public function get addMapThingEvtVec() : Vector.<CrazyTankSocketEvent>
      {
         return _addMapThingEvtVec;
      }
      
      public function get livingActionMappingEvtVec() : Vector.<CrazyTankSocketEvent>
      {
         return _livingActionMappingEvtVec;
      }
      
      public function get updatePhysicObjectEvtVec() : Vector.<CrazyTankSocketEvent>
      {
         return _updatePhysicObjectEvtVec;
      }
      
      public function get playerBloodEvtVec() : Vector.<CrazyTankSocketEvent>
      {
         return _playerBloodEvtVec;
      }
      
      private function __skillInfoInit(param1:CrazyTankSocketEvent) : void
      {
         var _loc10_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.pkg;
         petSkillList = [];
         var _loc2_:int = _loc5_.readInt();
         _loc10_ = 0;
         while(_loc10_ < _loc2_)
         {
            _loc6_ = _loc5_.readInt();
            _loc9_ = _loc5_.readInt();
            petSkillList.push({
               "id":_loc6_,
               "cd":_loc9_
            });
            _loc5_.readInt();
            _loc10_++;
         }
         horseSkillList = [];
         _loc2_ = _loc5_.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc2_)
         {
            _loc8_ = _loc5_.readInt();
            _loc3_ = _loc5_.readInt();
            _loc4_ = _loc5_.readInt();
            horseSkillList.push({
               "id":_loc8_,
               "cd":_loc3_,
               "count":_loc4_
            });
            _loc7_++;
         }
         dispatchEvent(new Event("skillInfoInitGame"));
      }
      
      private function setGameSmallData() : void
      {
         var _loc2_:Number = NaN;
         randomSmallLivingShape = int(Math.random() * 3);
         if(teamColorData)
         {
            teamColorData.clear();
         }
         teamColorData = new DictionaryData();
         var _loc3_:Array = [];
         var _loc1_:int = 1;
         do
         {
            teamColorData.add(_loc1_,[16777215 * Math.random(),16777215 * Math.random()]);
            _loc2_ = teamColorData[_loc1_][0];
            if(_loc3_.indexOf(_loc2_) == -1)
            {
               _loc3_[_loc1_] = teamColorData[_loc1_][0];
               _loc1_++;
            }
         }
         while(_loc1_ <= 8);
         
      }
      
      private function setSmallMapEnable(param1:String, param2:int) : void
      {
         var _loc11_:int = 0;
         var _loc3_:Boolean = false;
         var _loc10_:Array = ["0","SMALLMAP_BORDER_ENABLE","SMALLMAP_ALPHA","SMALLMAP_POINT_ENABLE","SMALLMAP_GRID_ENABLE","SMALLMAP_SHAPE_ENABLE"];
         var _loc9_:int = int(Math.random() * (_loc10_.length - 1)) + 1;
         var _loc7_:Object = {};
         _loc7_["SMALLMAP_ENABLE"] = false;
         _loc11_ = 1;
         while(_loc11_ < _loc10_.length)
         {
            if(_pathInfo.BOMBKing_KILL_CHEAT)
            {
               if(_loc11_ == _loc9_)
               {
                  _loc7_[_loc10_[_loc11_]] = true;
               }
               else
               {
                  _loc7_[_loc10_[_loc11_]] = Math.random() < 0.5?false:true;
               }
            }
            else
            {
               _loc7_[_loc10_[_loc11_]] = false;
            }
            _loc11_++;
         }
         _pathInfo.BOMBKing_KILL_CHEAT_MAP = _loc7_;
         var _loc4_:int = 0;
         var _loc8_:* = param2;
         var _loc6_:Array = param1.split(",");
         var _loc5_:Array = [];
         _pathInfo.SMALLMAP_ENABLE = Boolean(int(_loc6_[0]));
         if(_pathInfo.SMALLMAP_ENABLE)
         {
            return;
         }
         _loc11_ = 1;
         while(_loc11_ < _loc6_.length)
         {
            _loc3_ = int(_loc6_[_loc11_]);
            _pathInfo[_loc10_[_loc11_]] = _loc3_;
            if(_loc3_)
            {
               _loc5_.push(_loc10_[_loc11_]);
               _loc4_++;
            }
            _loc11_++;
         }
         if(_loc8_ > 0 && _loc4_ >= _loc8_)
         {
            setRandomSmallMapEnalbe(_loc5_,_loc4_,_loc8_);
         }
      }
      
      private function setRandomSmallMapEnalbe(param1:Array, param2:int, param3:int) : void
      {
         var _loc7_:int = 0;
         var _loc6_:int = Math.floor(param2 / 2);
         var _loc5_:int = (param3 - _loc6_) * Math.random() + _loc6_;
         var _loc4_:int = param1.length;
         while(_loc4_)
         {
            _loc4_--;
            param1.push(param1.splice(int(Math.random() * _loc4_),1)[0]);
         }
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            if(_loc7_ >= _loc5_)
            {
               _pathInfo[param1[_loc7_]] = false;
            }
            _loc7_++;
         }
      }
      
      private function isInBOMBKingGame() : Boolean
      {
         var _loc1_:int = GameControl.Instance.Current.gameMode;
         return _loc1_ == 28 || _loc1_ == 29;
      }
      
      public function smallMapEnable() : Boolean
      {
         if(isInBOMBKingGame())
         {
            return _pathInfo.BOMBKing_KILL_CHEAT_MAP["SMALLMAP_ENABLE"];
         }
         return _pathInfo.SMALLMAP_ENABLE;
      }
      
      public function smallMapBorderEnable() : Boolean
      {
         if(isInBOMBKingGame())
         {
            return _pathInfo.BOMBKing_KILL_CHEAT_MAP["SMALLMAP_BORDER_ENABLE"];
         }
         return _pathInfo.SMALLMAP_BORDER_ENABLE;
      }
      
      public function smallMapAlpha() : Boolean
      {
         if(isInBOMBKingGame())
         {
            return _pathInfo.BOMBKing_KILL_CHEAT_MAP["SMALLMAP_ALPHA"];
         }
         return _pathInfo.SMALLMAP_ALPHA;
      }
      
      public function smallMapPoint() : Boolean
      {
         if(isInBOMBKingGame())
         {
            return _pathInfo.BOMBKing_KILL_CHEAT_MAP["SMALLMAP_POINT_ENABLE"];
         }
         return _pathInfo.SMALLMAP_POINT_ENABLE;
      }
      
      public function smallMapGrid() : Boolean
      {
         if(isInBOMBKingGame())
         {
            return _pathInfo.BOMBKing_KILL_CHEAT_MAP["SMALLMAP_GRID_ENABLE"];
         }
         return _pathInfo.SMALLMAP_GRID_ENABLE;
      }
      
      public function smallMapShape() : Boolean
      {
         if(isInBOMBKingGame())
         {
            return _pathInfo.BOMBKing_KILL_CHEAT_MAP["SMALLMAP_SHAPE_ENABLE"];
         }
         return _pathInfo.SMALLMAP_SHAPE_ENABLE;
      }
      
      public function get is3DGame() : Boolean
      {
         var _loc1_:Boolean = false;
         if(_current && _current.roomType == 120 || _current.roomType == 123 || RoomManager.Instance.current.type == 1 && RoomManager.Instance.current.dungeonMode == 120)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get specialSkillType() : String
      {
         if(_specialSkillType == null)
         {
            _specialSkillType = Math.random() * 10 > 5?"A":"B";
         }
         return _specialSkillType;
      }
      
      public function setDropData(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = false;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         _loc5_ = 0;
         while(_loc5_ < dropData.length)
         {
            if(dropData[_loc5_].itemId == param1)
            {
               dropData[_loc5_].count = dropData[_loc5_].count + param2;
               _loc3_ = true;
               break;
            }
            _loc5_++;
         }
         if(!_loc3_)
         {
            _loc4_ = {};
            _loc4_.count = param2;
            _loc4_.itemId = param1;
            dropData.push(_loc4_);
         }
      }
      
      public function get isShowSelfBuffBar() : Boolean
      {
         if(_current.roomType == 18 || _current.gameMode == 56 || _current.gameMode == 57 || GameControl.Instance.Current.mapIndex == 140)
         {
            return false;
         }
         return true;
      }
      
      public function get playerNotDie() : Boolean
      {
         if(_current.gameMode == 56 || _current.gameMode == 57)
         {
            return true;
         }
         return false;
      }
   }
}
