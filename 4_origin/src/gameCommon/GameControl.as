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
      
      public static const EXIT_ROOM_TYPE_ARRAY:Array = [10,14,19,20,31,24,40,26,27,52,21,48,150,151,70];
      
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
      
      private var _boxPhysicalEvtVec:Vector.<CrazyTankSocketEvent>;
      
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
      
      public static function isAcademyRoom(gameInfo:GameInfo) : Boolean
      {
         return gameInfo.roomType == 11;
      }
      
      public static function isDreamChallengeRoom(gameInfo:GameInfo) : Boolean
      {
         return gameInfo.roomType == 70;
      }
      
      public static function isDungeonRoom(gameInfo:GameInfo) : Boolean
      {
         return gameInfo.roomType == 4 || gameInfo.roomType == 15 || gameInfo.roomType == 23 || gameInfo.roomType == 123;
      }
      
      public static function isFightLib(gameInfo:GameInfo) : Boolean
      {
         return gameInfo.roomType == 5;
      }
      
      public static function isFreshMan(gameInfo:GameInfo) : Boolean
      {
         return gameInfo.roomType == 10;
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
      
      public function set Current(value:GameInfo) : void
      {
         _current = value;
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
         _boxPhysicalEvtVec = new Vector.<CrazyTankSocketEvent>();
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
         SocketManager.Instance.addEventListener("simpleobjectMovePos",__onSimpleOejectMovePos);
      }
      
      private function __onSimpleOejectMovePos(evt:CrazyTankSocketEvent) : void
      {
         if(!viewCompleteFlag)
         {
            _boxPhysicalEvtVec.push(evt);
         }
         else
         {
            _gameView.boxPhysicalPos(evt);
         }
      }
      
      private function __disposeCmd(event:CrazyTankSocketEvent) : void
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
         if(_boxPhysicalEvtVec)
         {
            _boxPhysicalEvtVec.splice(0,_boxPhysicalEvtVec.length);
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
         boxPhysicalEvtVec.length = 0;
      }
      
      protected function __playerBlood(event:CrazyTankSocketEvent) : void
      {
         if(!viewCompleteFlag)
         {
            _playerBloodEvtVec.push(event);
         }
         else
         {
            _gameView.playerBlood(event);
         }
      }
      
      protected function __updatePhysicObject(event:CrazyTankSocketEvent) : void
      {
         if(!viewCompleteFlag)
         {
            _updatePhysicObjectEvtVec.push(event);
         }
         else
         {
            _gameView.updatePhysicObject(event);
         }
      }
      
      protected function __livingActionMapping(event:CrazyTankSocketEvent) : void
      {
         if(!viewCompleteFlag)
         {
            _livingActionMappingEvtVec.push(event);
         }
         else
         {
            _gameView.livingActionMapping(event);
         }
      }
      
      protected function __addMapThing(event:CrazyTankSocketEvent) : void
      {
         if(!viewCompleteFlag)
         {
            _addMapThingEvtVec.push(event);
         }
         else
         {
            _gameView.addMapThing(event);
         }
      }
      
      protected function __addLiving(event:CrazyTankSocketEvent) : void
      {
         if(!viewCompleteFlag)
         {
            _addLivingEvtVec.push(event);
         }
         else
         {
            _gameView.addliving(event);
         }
      }
      
      protected function __objectSetProperty(event:CrazyTankSocketEvent) : void
      {
         if(!viewCompleteFlag)
         {
            _setPropertyEvtVec.push(event);
         }
         else
         {
            _gameView.objectSetProperty(event);
         }
      }
      
      protected function __livingFalling(event:CrazyTankSocketEvent) : void
      {
         if(!viewCompleteFlag)
         {
            _livingFallingEvtVec.push(event);
         }
         else
         {
            _gameView.livingFalling(event);
         }
      }
      
      protected function __livingShowBlood(event:CrazyTankSocketEvent) : void
      {
         if(!viewCompleteFlag)
         {
            _livingShowBloodEvtVec.push(event);
         }
         else
         {
            _gameView.livingShowBlood(event);
         }
      }
      
      private function addTerrace(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var livingID:int = 0;
         var info:* = null;
         var bool:Boolean = false;
         var livingX:int = 0;
         var livingY:int = 0;
         if(!Current || Current.gameMode != 23)
         {
            return;
         }
         var conut:int = event.pkg.readInt();
         var falseCount:int = 0;
         for(i = 0; i < conut; )
         {
            livingID = event.pkg.readInt();
            info = Current.findPlayer(livingID);
            bool = event.pkg.readBoolean();
            livingX = event.pkg.readInt();
            livingY = event.pkg.readInt();
            info.isLocked = bool;
            terrceID = livingID;
            if(bool)
            {
               isAddTerrce = true;
               terrceX = livingX;
               terrceY = livingY + 10;
               dispatchEvent(new GameEvent("addTerrace",[terrceX,terrceY,livingID]));
            }
            else
            {
               isAddTerrce = false;
               dispatchEvent(new GameEvent("delTerrace",[livingID]));
            }
            i++;
         }
      }
      
      private function addNewPlayerHander(event:CrazyTankSocketEvent) : void
      {
         var sex:Boolean = false;
         var Hide:int = 0;
         var Style:* = null;
         var Colors:* = null;
         var Skin:* = null;
         var r:int = 0;
         var pic:* = null;
         var date:* = null;
         var j:int = 0;
         var place:int = 0;
         var p:* = null;
         var ptd:int = 0;
         var activedSkillCount:int = 0;
         var k:int = 0;
         var splace:int = 0;
         var sid:int = 0;
         var n:int = 0;
         var b:int = 0;
         var bsSkillId:int = 0;
         var deputyWeaponCount:int = 0;
         var t_j:int = 0;
         var buff:* = null;
         var data:int = 0;
         var l:int = 0;
         var Buff:* = null;
         var I:int = 0;
         var K:* = null;
         var Value:* = null;
         var gm:GameInfo = Current;
         var pkg:PackageIn = event.pkg;
         var zoneID:int = pkg.readInt();
         var zoneName:String = pkg.readUTF();
         var id:int = pkg.readInt();
         var sp:PlayerInfo = new PlayerInfo();
         sp.beginChanges();
         var fp:RoomPlayer = RoomManager.Instance.current.findPlayerByID(id,zoneID);
         if(fp == null)
         {
            fp = new RoomPlayer(sp);
         }
         sp.ID = id;
         sp.ZoneID = zoneID;
         var nickName:String = pkg.readUTF();
         var isViewer:Boolean = pkg.readBoolean();
         if(isViewer && fp.place < 8)
         {
            fp.place = 8;
         }
         sp.NickName = nickName;
         sp.typeVIP = pkg.readByte();
         sp.VIPLevel = pkg.readInt();
         if(PlayerManager.Instance.isChangeStyleTemp(sp.ID))
         {
            pkg.readBoolean();
            pkg.readInt();
            pkg.readUTF();
            pkg.readUTF();
            pkg.readUTF();
         }
         else
         {
            sex = pkg.readBoolean();
            Hide = pkg.readInt();
            Style = pkg.readUTF();
            Colors = pkg.readUTF();
            Skin = pkg.readUTF();
            sp.Sex = sex;
            sp.Hide = Hide;
            sp.Style = Style;
            sp.Colors = Colors;
            sp.Skin = Skin;
         }
         sp.Grade = pkg.readInt();
         sp.Repute = pkg.readInt();
         sp.WeaponID = pkg.readInt();
         if(sp.WeaponID != 0)
         {
            r = pkg.readInt();
            pic = pkg.readUTF();
            date = pkg.readDateString();
         }
         sp.DeputyWeaponID = pkg.readInt();
         sp.pvpBadgeId = pkg.readInt();
         sp.Nimbus = pkg.readInt();
         sp.IsShowConsortia = pkg.readBoolean();
         sp.ConsortiaID = pkg.readInt();
         sp.ConsortiaName = pkg.readUTF();
         sp.badgeID = pkg.readInt();
         var unknown1:int = pkg.readInt();
         var unknown2:int = pkg.readInt();
         sp.WinCount = pkg.readInt();
         sp.TotalCount = pkg.readInt();
         sp.FightPower = pkg.readInt();
         sp.apprenticeshipState = pkg.readInt();
         sp.masterID = pkg.readInt();
         sp.setMasterOrApprentices(pkg.readUTF());
         sp.AchievementPoint = pkg.readInt();
         sp.honor = pkg.readUTF();
         sp.Offer = pkg.readInt();
         sp.DailyLeagueFirst = pkg.readBoolean();
         sp.DailyLeagueLastScore = pkg.readInt();
         sp.guardCoreID = pkg.readInt();
         sp.commitChanges();
         fp.playerInfo.IsMarried = pkg.readBoolean();
         if(fp.playerInfo.IsMarried)
         {
            fp.playerInfo.SpouseID = pkg.readInt();
            fp.playerInfo.SpouseName = pkg.readUTF();
         }
         pkg.readInt();
         pkg.readInt();
         pkg.readInt();
         pkg.readInt();
         pkg.readInt();
         pkg.readInt();
         var templeId:int = pkg.readInt();
         fp.team = pkg.readInt();
         gm.addRoomPlayer(fp);
         var livingID:int = pkg.readInt();
         var blood:int = pkg.readInt();
         var info:Player = new Player(fp.playerInfo,livingID,fp.team,blood,templeId);
         var count:int = pkg.readInt();
         for(j = 0; j < count; )
         {
            place = pkg.readInt();
            p = sp.pets[place];
            ptd = pkg.readInt();
            if(p == null)
            {
               p = new PetInfo();
               p.TemplateID = ptd;
               PetInfoManager.fillPetInfo(p);
            }
            p.ID = pkg.readInt();
            p.Name = pkg.readUTF();
            p.UserID = pkg.readInt();
            p.Level = pkg.readInt();
            p.IsEquip = true;
            p.clearEquipedSkills();
            activedSkillCount = pkg.readInt();
            for(k = 0; k < activedSkillCount; )
            {
               splace = pkg.readInt();
               sid = pkg.readInt();
               p.equipdSkills.add(splace,sid);
               k++;
            }
            p.Place = place;
            sp.pets.add(p.Place,p);
            j++;
         }
         fp.horseSkillEquipList = [];
         var tmpCount:int = pkg.readInt();
         for(n = 0; n < tmpCount; )
         {
            fp.horseSkillEquipList.push(pkg.readInt());
            n++;
         }
         var bsCount:int = pkg.readInt();
         for(b = 0; b < bsCount; )
         {
            bsSkillId = pkg.readInt();
            b++;
         }
         info.IsRobot = pkg.readBoolean();
         info.zoneName = zoneName;
         info.currentWeapInfo.refineryLevel = r;
         info.ringFlag = pkg.readBoolean();
         info.loveBuffLevel = pkg.readInt();
         info.turnCount = pkg.readInt();
         var livingID1:int = pkg.readInt();
         var x:int = pkg.readInt();
         var y:int = pkg.readInt();
         info.pos = new Point(x,y);
         info.energy = 1;
         info.direction = pkg.readInt();
         var blood2:int = pkg.readInt();
         var maxBlood:int = pkg.readInt();
         info.team = pkg.readInt();
         var refineryLevel:int = pkg.readInt();
         if(info is LocalPlayer)
         {
            (info as LocalPlayer).deputyWeaponCount = pkg.readInt();
         }
         else
         {
            deputyWeaponCount = pkg.readInt();
         }
         info.powerRatio = pkg.readInt();
         info.dander = pkg.readInt();
         info.maxBlood = maxBlood;
         info.updateBlood(blood,0,0);
         info.wishKingCount = pkg.readInt();
         info.wishKingEnergy = pkg.readInt();
         info.currentWeapInfo.refineryLevel = refineryLevel;
         var count1:int = pkg.readInt();
         for(t_j = 0; t_j < count1; )
         {
            buff = BuffManager.creatBuff(pkg.readInt());
            data = pkg.readInt();
            if(buff)
            {
               buff.data = data;
               info.addBuff(buff);
            }
            t_j++;
         }
         var buffCount:int = pkg.readInt();
         var buffs:Vector.<FightBuffInfo> = new Vector.<FightBuffInfo>();
         for(l = 0; l < buffCount; )
         {
            Buff = BuffManager.creatBuff(pkg.readInt());
            info.outTurnBuffs.push(Buff);
            l++;
         }
         var isFrost:Boolean = pkg.readBoolean();
         var isHide:Boolean = pkg.readBoolean();
         var isNoHole:Boolean = pkg.readBoolean();
         var isBubble:Boolean = pkg.readBoolean();
         var sealSatesCount:int = pkg.readInt();
         var sealSates:Dictionary = new Dictionary();
         for(I = 0; I < sealSatesCount; )
         {
            K = pkg.readUTF();
            Value = pkg.readUTF();
            sealSates[K] = Value;
            I++;
         }
         if(isFrost)
         {
            isFrost = false;
         }
         info.isFrozen = isFrost;
         info.isHidden = isHide;
         info.isNoNole = isNoHole;
         info.outProperty = sealSates;
         if(RoomManager.Instance.current.type != 5 && info.playerInfo.currentPet)
         {
            info.currentPet = new Pet(info.playerInfo.currentPet);
            petResLoad(info.playerInfo.currentPet);
         }
         var arr:Array = [fp];
         LoadBombManager.Instance.loadFullRoomPlayersBomb(arr);
         if(!fp.isViewer)
         {
            gm.addGamePlayer(info);
         }
         else
         {
            if(fp.isSelf)
            {
               gm.setSelfGamePlayer(info);
            }
            gm.addGameViewer(info);
         }
      }
      
      protected function __selectObject(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var id:int = 0;
         var zoneID:int = 0;
         var selectID:int = 0;
         var selectZoneID:int = 0;
         var obj:* = null;
         selectList = [];
         var len:int = event.pkg.readInt();
         while(i < len)
         {
            id = event.pkg.readInt();
            zoneID = event.pkg.readInt();
            Current.getRoomPlayerByID(id,zoneID).team = event.pkg.readInt();
            selectID = event.pkg.readInt();
            selectZoneID = event.pkg.readInt();
            obj = {};
            obj["id"] = id;
            obj["zoneID"] = zoneID;
            obj["selectID"] = selectID;
            obj["selectZoneID"] = selectZoneID;
            selectList.push(obj);
            i++;
         }
         dispatchEvent(new GameEvent("selectComplete",null));
      }
      
      private function petResLoad(currentPet:PetInfo) : void
      {
         var skill:* = null;
         var ball:* = null;
         if(currentPet)
         {
            LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetGameAssetUrl(currentPet.GameAssetUrl),4);
            var _loc6_:int = 0;
            var _loc5_:* = currentPet.equipdSkills;
            for each(var skillid in currentPet.equipdSkills)
            {
               if(skillid > 0)
               {
                  skill = PetSkillManager.getSkillByID(skillid);
                  if(skill.EffectPic)
                  {
                     LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetSkillEffect(skill.EffectPic),4);
                  }
                  if(skill.NewBallID != -1)
                  {
                     ball = BallManager.instance.findBall(skill.NewBallID);
                     ball.loadBombAsset();
                     ball.loadCraterBitmap();
                  }
               }
            }
         }
      }
      
      private function __missionTryAgain(e:CrazyTankSocketEvent) : void
      {
         TryAgain = e.pkg.readInt();
         dispatchEvent(new GameEvent("missionAgain",TryAgain));
      }
      
      private function __updatePlayInfoInGame(e:CrazyTankSocketEvent) : void
      {
         var player:* = null;
         if(RoomManager.Instance.current == null)
         {
            return;
         }
         var pkg:PackageIn = e.pkg;
         var zoneID:int = pkg.readInt();
         var id:int = pkg.readInt();
         var team:int = pkg.readInt();
         var livingid:int = pkg.readInt();
         var blood:int = pkg.readInt();
         var isReady:Boolean = pkg.readBoolean();
         var fp:RoomPlayer = RoomManager.Instance.current.findPlayerByID(id);
         if(zoneID != PlayerManager.Instance.Self.ZoneID || fp == null || Current == null)
         {
            return;
         }
         if(fp.isSelf)
         {
            player = new LocalPlayer(PlayerManager.Instance.Self,livingid,team,blood);
         }
         else
         {
            player = new Player(fp.playerInfo,livingid,team,blood);
         }
         player.isReady = isReady;
         if(player.movie)
         {
            player.movie.setDefaultAction(player.movie.standAction);
         }
         Current.addRoomPlayer(fp);
         if(fp.isViewer)
         {
            Current.addGameViewer(player);
         }
         else
         {
            Current.addGamePlayer(player);
         }
         if(fp.isSelf && Current.roomType != 20)
         {
            StateManager.setState("missionResult");
         }
      }
      
      private function __missionInviteRoomInfo(e:CrazyTankSocketEvent) : void
      {
         var pkg:* = null;
         var gm:* = null;
         var len:int = 0;
         var i:int = 0;
         var id:int = 0;
         var sp:* = null;
         var fp:* = null;
         var isViewer:Boolean = false;
         var r:int = 0;
         var pic:* = null;
         var date:* = null;
         var unknown1:int = 0;
         var unknown2:int = 0;
         var templeId:int = 0;
         var livingID:int = 0;
         var blood:int = 0;
         var $isReady:Boolean = false;
         var player:* = null;
         var missionInfo:* = null;
         if(RoomManager.Instance.current)
         {
            pkg = e.pkg;
            gm = new GameInfo();
            gm.mapIndex = pkg.readInt();
            gm.roomType = pkg.readInt();
            gm.gameMode = pkg.readInt();
            gm.timeType = pkg.readInt();
            RoomManager.Instance.current.timeType = gm.timeType;
            len = pkg.readInt();
            for(i = 0; i < len; )
            {
               id = pkg.readInt();
               sp = PlayerManager.Instance.findPlayer(id);
               sp.beginChanges();
               fp = RoomManager.Instance.current.findPlayerByID(id);
               if(fp == null)
               {
                  fp = new RoomPlayer(sp);
                  sp.ID = id;
               }
               sp.ZoneID = PlayerManager.Instance.Self.ZoneID;
               sp.NickName = pkg.readUTF();
               isViewer = pkg.readBoolean();
               sp.typeVIP = pkg.readByte();
               sp.VIPLevel = pkg.readInt();
               sp.Sex = pkg.readBoolean();
               sp.Hide = pkg.readInt();
               sp.Style = pkg.readUTF();
               sp.Colors = pkg.readUTF();
               sp.Skin = pkg.readUTF();
               sp.Grade = pkg.readInt();
               sp.Repute = pkg.readInt();
               sp.WeaponID = pkg.readInt();
               if(sp.WeaponID > 0)
               {
                  r = pkg.readInt();
                  pic = pkg.readUTF();
                  date = pkg.readDateString();
               }
               sp.DeputyWeaponID = pkg.readInt();
               sp.ConsortiaID = pkg.readInt();
               sp.ConsortiaName = pkg.readUTF();
               sp.badgeID = pkg.readInt();
               unknown1 = pkg.readInt();
               unknown2 = pkg.readInt();
               sp.DailyLeagueFirst = pkg.readBoolean();
               sp.DailyLeagueLastScore = pkg.readInt();
               sp.commitChanges();
               templeId = pkg.readInt();
               fp.team = pkg.readInt();
               gm.addRoomPlayer(fp);
               livingID = pkg.readInt();
               blood = pkg.readInt();
               $isReady = pkg.readBoolean();
               if(fp.isSelf)
               {
                  player = new LocalPlayer(PlayerManager.Instance.Self,livingID,fp.team,blood,templeId);
               }
               else
               {
                  player = new Player(fp.playerInfo,livingID,fp.team,blood,templeId);
               }
               player.isReady = $isReady;
               player.currentWeapInfo.refineryLevel = r;
               if(!isViewer)
               {
                  gm.addGamePlayer(player);
               }
               else
               {
                  if(fp.isSelf)
                  {
                     gm.setSelfGamePlayer(player);
                  }
                  gm.addGameViewer(player);
               }
               i++;
            }
            Current = gm;
            missionInfo = new MissionInfo();
            missionInfo.name = pkg.readUTF();
            missionInfo.pic = pkg.readUTF();
            missionInfo.success = pkg.readUTF();
            missionInfo.failure = pkg.readUTF();
            missionInfo.description = pkg.readUTF();
            missionInfo.totalMissiton = pkg.readInt();
            missionInfo.missionIndex = pkg.readInt();
            missionInfo.nextMissionIndex = missionInfo.missionIndex + 1;
            Current.missionInfo = missionInfo;
            Current.hasNextMission = true;
         }
      }
      
      private function __createGame(event:CrazyTankSocketEvent) : void
      {
         var pkg:* = null;
         if(RoomManager.Instance.current)
         {
            pkg = event.pkg;
            __disposeCmd(null);
            createGameInfo(pkg);
         }
      }
      
      private function createGameInfo(pkg:PackageIn, isSingleBattle:Boolean = false) : void
      {
         var i:int = 0;
         var zoneID:int = 0;
         var zoneName:* = null;
         var id:int = 0;
         var sp:* = null;
         var fp:* = null;
         var nickName:* = null;
         var isViewer:Boolean = false;
         var r:int = 0;
         var pic:* = null;
         var date:* = null;
         var isHasConsortia:Boolean = false;
         var unknown1:int = 0;
         var unknown2:int = 0;
         var templeId:int = 0;
         var livingID:* = 0;
         var blood:int = 0;
         var player:* = null;
         var count:int = 0;
         var j:int = 0;
         var place:int = 0;
         var p:* = null;
         var ptd:int = 0;
         var activedSkillCount:int = 0;
         var k:int = 0;
         var splace:int = 0;
         var sid:int = 0;
         var tmpCount:int = 0;
         var n:int = 0;
         var bsCount:int = 0;
         var b:int = 0;
         var bsSkillId:int = 0;
         var bombLength:int = 0;
         var v:int = 0;
         var bomb:* = null;
         var enable:* = null;
         var random:int = 0;
         var gm:GameInfo = new GameInfo();
         gm.roomType = pkg.readInt();
         gm.gameMode = pkg.readInt();
         if(gm.gameMode == 20)
         {
            gm.roomType = 18;
         }
         if(gm.roomType == 20 || gm.roomType == 24 || gm.roomType == 27 || gm.roomType == 65 || gm.roomType == 66)
         {
            gm.missionInfo = new MissionInfo();
         }
         gm.timeType = pkg.readInt();
         RoomManager.Instance.current.timeType = gm.timeType;
         var len:int = pkg.readInt();
         for(i = 0; i < len; )
         {
            zoneID = pkg.readInt();
            zoneName = pkg.readUTF();
            id = pkg.readInt();
            sp = PlayerManager.Instance.findPlayer(id,zoneID);
            sp.beginChanges();
            fp = RoomManager.Instance.current.findPlayerByID(id,zoneID);
            if(fp == null)
            {
               fp = new RoomPlayer(sp);
            }
            sp.ID = id;
            sp.ZoneID = zoneID;
            nickName = pkg.readUTF();
            isViewer = pkg.readBoolean();
            if(isViewer && fp.place < 8)
            {
               fp.place = 8;
            }
            if(!(fp is SelfInfo))
            {
               sp.NickName = nickName;
            }
            sp.typeVIP = pkg.readByte();
            sp.VIPLevel = pkg.readInt();
            if(PlayerManager.Instance.isChangeStyleTemp(sp.ID))
            {
               pkg.readBoolean();
               pkg.readInt();
               pkg.readUTF();
               pkg.readUTF();
               pkg.readUTF();
            }
            else
            {
               sp.Sex = pkg.readBoolean();
               sp.Hide = pkg.readInt();
               sp.Style = pkg.readUTF();
               sp.Colors = pkg.readUTF();
               sp.Skin = pkg.readUTF();
            }
            sp.Grade = pkg.readInt();
            sp.Repute = pkg.readInt();
            sp.WeaponID = pkg.readInt();
            if(sp.WeaponID != 0)
            {
               r = pkg.readInt();
               pic = pkg.readUTF();
               date = pkg.readDateString();
            }
            sp.DeputyWeaponID = pkg.readInt();
            sp.pvpBadgeId = pkg.readInt();
            sp.Nimbus = pkg.readInt();
            isHasConsortia = pkg.readBoolean();
            sp.ConsortiaID = pkg.readInt();
            sp.ConsortiaName = pkg.readUTF();
            sp.badgeID = pkg.readInt();
            unknown1 = pkg.readInt();
            unknown2 = pkg.readInt();
            sp.WinCount = pkg.readInt();
            sp.TotalCount = pkg.readInt();
            sp.FightPower = pkg.readInt();
            sp.apprenticeshipState = pkg.readInt();
            sp.masterID = pkg.readInt();
            sp.setMasterOrApprentices(pkg.readUTF());
            sp.AchievementPoint = pkg.readInt();
            sp.honor = pkg.readUTF();
            sp.Offer = pkg.readInt();
            sp.DailyLeagueFirst = pkg.readBoolean();
            sp.DailyLeagueLastScore = pkg.readInt();
            sp.guardCoreID = pkg.readInt();
            sp.fightStatus = 0;
            sp.isTrusteeship = false;
            sp.commitChanges();
            fp.playerInfo.IsMarried = pkg.readBoolean();
            if(fp.playerInfo.IsMarried)
            {
               fp.playerInfo.SpouseID = pkg.readInt();
               fp.playerInfo.SpouseName = pkg.readUTF();
            }
            pkg.readInt();
            pkg.readInt();
            pkg.readInt();
            pkg.readInt();
            pkg.readInt();
            pkg.readInt();
            templeId = pkg.readInt();
            fp.team = pkg.readInt();
            gm.addRoomPlayer(fp);
            livingID = int(pkg.readInt());
            if(isSingleBattle)
            {
               livingID = i;
            }
            blood = pkg.readInt();
            if(blood <= 0)
            {
               SocketManager.Instance.out.sendErrorMsg(nickName + " 的进入战斗程序鬼混状态！ 血量是: " + blood);
            }
            if(fp.isSelf)
            {
               player = new LocalPlayer(PlayerManager.Instance.Self,livingID,fp.team,blood,templeId);
            }
            else
            {
               player = new Player(fp.playerInfo,livingID,fp.team,blood,templeId);
            }
            player.autoOnHook = gm.roomType == 49;
            count = pkg.readInt();
            for(j = 0; j < count; )
            {
               place = pkg.readInt();
               p = sp.pets[place];
               ptd = pkg.readInt();
               if(p == null)
               {
                  p = new PetInfo();
                  p.TemplateID = ptd;
                  PetInfoManager.fillPetInfo(p);
               }
               p.ID = pkg.readInt();
               p.Name = pkg.readUTF();
               p.UserID = pkg.readInt();
               p.Level = pkg.readInt();
               p.IsEquip = true;
               p.clearEquipedSkills();
               activedSkillCount = pkg.readInt();
               for(k = 0; k < activedSkillCount; )
               {
                  splace = pkg.readInt();
                  sid = pkg.readInt();
                  p.equipdSkills.add(splace,sid);
                  k++;
               }
               p.Place = place;
               sp.pets.add(p.Place,p);
               j++;
            }
            fp.horseSkillEquipList = [];
            tmpCount = pkg.readInt();
            for(n = 0; n < tmpCount; )
            {
               fp.horseSkillEquipList.push(pkg.readInt());
               n++;
            }
            fp.battleSkillEquipList = [];
            bsCount = pkg.readInt();
            for(b = 0; b < bsCount; )
            {
               bsSkillId = pkg.readInt();
               fp.battleSkillEquipList.push(bsSkillId);
               b++;
            }
            player.IsRobot = pkg.readBoolean();
            player.ringFlag = pkg.readBoolean();
            player.loveBuffLevel = pkg.readInt();
            player.turnCount = pkg.readInt();
            sp.teamID = pkg.readInt();
            sp.teamDivision = pkg.readInt();
            sp.teamName = pkg.readUTF();
            sp.teamTag = pkg.readUTF();
            sp.teamGrade = pkg.readInt();
            sp.teamWinTime = pkg.readInt();
            sp.teamTotalTime = pkg.readInt();
            sp.teamPersonalScore = pkg.readInt();
            player.zoneName = zoneName;
            player.currentWeapInfo.refineryLevel = r;
            if(!fp.isViewer)
            {
               gm.addGamePlayer(player);
            }
            else
            {
               if(fp.isSelf)
               {
                  gm.setSelfGamePlayer(player);
               }
               gm.addGameViewer(player);
            }
            i++;
         }
         if(!isSingleBattle)
         {
            gm.guardCoreEnable = pkg.readBoolean();
            bombLength = pkg.readInt();
            for(v = 0; v < bombLength; )
            {
               bomb = new Bomb();
               bomb.Id = pkg.readInt();
               bomb.X = pkg.readInt();
               bomb.Y = pkg.readInt();
               gm.outBombs.add(v,bomb);
               v++;
            }
            enable = pkg.readUTF();
            random = pkg.readInt();
            setSmallMapEnable(enable,random);
         }
         if(BombKingManager.instance.Recording)
         {
            setSelfPlayerInfo(gm);
         }
         Current = gm;
         if(!isSingleBattle)
         {
            QueueManager.setLifeTime(0);
         }
         RingStationManager.instance.RoomType = gm.roomType;
         CatchBeastManager.instance.RoomType = gm.roomType;
         CryptBossManager.instance.RoomType = gm.roomType;
         SocketManager.Instance.out.sendGameTrusteeship(false);
      }
      
      private function setSelfPlayerInfo(gm:GameInfo) : void
      {
         var selfPlayer:* = null;
         var selfPlayerInfo:SelfInfo = PlayerManager.Instance.Self;
         if(gm.findPlayerByPlayerID(selfPlayerInfo.ID) == null)
         {
            selfPlayer = new LocalPlayer(selfPlayerInfo,0,0,0);
            gm.setSelfGamePlayer(selfPlayer);
            gm.addGameViewer(selfPlayer);
         }
      }
      
      private function __singleBattleStartMatch(event:CrazyTankSocketEvent) : void
      {
         var pkg:* = null;
         if(RoomManager.Instance.current)
         {
            pkg = event.pkg;
            createGameInfo(pkg,true);
            dispatchEvent(new Event("StartMatch"));
         }
      }
      
      private function __buffObtain(evt:CrazyTankSocketEvent) : void
      {
         var pkg:* = null;
         var lth:int = 0;
         var i:int = 0;
         var type:int = 0;
         var isExist:Boolean = false;
         var beginData:* = null;
         var validDate:int = 0;
         var value:int = 0;
         var buff:* = null;
         if(Current)
         {
            pkg = evt.pkg;
            if(pkg.extend1 == Current.selfGamePlayer.LivingID)
            {
               return;
            }
            if(Current.findPlayer(pkg.extend1) != null)
            {
               lth = pkg.readInt();
               for(i = 0; i < lth; )
               {
                  type = pkg.readInt();
                  isExist = pkg.readBoolean();
                  beginData = pkg.readDate();
                  validDate = pkg.readInt();
                  value = pkg.readInt();
                  buff = new BuffInfo(type,isExist,beginData,validDate,value);
                  Current.findPlayer(pkg.extend1).playerInfo.buffInfo.add(buff.Type,buff);
                  i++;
               }
               evt.stopImmediatePropagation();
            }
         }
      }
      
      private function __buffUpdate(evt:CrazyTankSocketEvent) : void
      {
         var pkg:* = null;
         var len:int = 0;
         var _type:int = 0;
         var _isExist:Boolean = false;
         var _beginData:* = null;
         var _validDate:int = 0;
         var _value:int = 0;
         var _buff:* = null;
         if(Current)
         {
            pkg = evt.pkg;
            if(pkg.extend1 == Current.selfGamePlayer.LivingID)
            {
               return;
            }
            if(Current.findPlayer(pkg.extend1) != null)
            {
               len = pkg.readInt();
               _type = pkg.readInt();
               _isExist = pkg.readBoolean();
               _beginData = pkg.readDate();
               _validDate = pkg.readInt();
               _value = pkg.readInt();
               _buff = new BuffInfo(_type,_isExist,_beginData,_validDate,_value);
               if(_isExist)
               {
                  Current.findPlayer(pkg.extend1).playerInfo.buffInfo.add(_buff.Type,_buff);
               }
               else
               {
                  Current.findPlayer(pkg.extend1).playerInfo.buffInfo.remove(_buff.Type);
               }
               evt.stopImmediatePropagation();
            }
         }
      }
      
      private function __beginLoad(event:CrazyTankSocketEvent) : void
      {
         var count:int = 0;
         var i:int = 0;
         var needMovie:* = null;
         var petSkillCount:int = 0;
         var j:int = 0;
         var needPetSkill:* = null;
         StateManager.getInGame_Step_3 = true;
         _recevieLoadSocket = true;
         if(Current)
         {
            StateManager.getInGame_Step_4 = true;
            Current.maxTime = event.pkg.readInt();
            Current.mapIndex = event.pkg.readInt();
            count = event.pkg.readInt();
            for(i = 1; i <= count; )
            {
               needMovie = new GameNeedMovieInfo();
               needMovie.type = event.pkg.readInt();
               needMovie.path = event.pkg.readUTF();
               needMovie.classPath = event.pkg.readUTF();
               Current.neededMovies.push(needMovie);
               i++;
            }
            petSkillCount = event.pkg.readInt();
            for(j = 0; j < petSkillCount; )
            {
               needPetSkill = new GameNeedPetSkillInfo();
               needPetSkill.pic = event.pkg.readUTF();
               needPetSkill.effect = event.pkg.readUTF();
               Current.neededPetSkillResource.push(needPetSkill);
               j++;
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
      
      private function getRoomTypeNeedMissionInfo(roomType:int) : Boolean
      {
         return roomType == 2 || roomType == 3 || roomType == 4 || roomType == 5 || roomType == 8 || roomType == 10 || roomType == 11 || roomType == 14 || roomType == 17 || roomType == 20 || roomType == 21;
      }
      
      private function __gameMissionStart(evt:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var obj:Object = {};
         obj.id = pkg.clientId;
         var $isReady:Boolean = pkg.readBoolean();
      }
      
      public function dispatchAllGameReadyState(array:Array) : void
      {
         var pkg:* = null;
         var obj:* = null;
         var id:int = 0;
         var player:* = null;
         var roomPlayer:* = null;
         var _loc9_:int = 0;
         var _loc8_:* = array;
         for each(var e in array)
         {
            pkg = e.pkg;
            obj = {};
            id = pkg.clientId;
            if(Current)
            {
               player = Current.findPlayerByPlayerID(id);
               player.isReady = pkg.readBoolean();
               if(!player.isSelf && player.isReady)
               {
                  roomPlayer = RoomManager.Instance.current.findPlayerByID(id);
                  roomPlayer.isReady = true;
               }
            }
            pkg.position = 20;
         }
      }
      
      private function __gameMissionPrepare(e:CrazyTankSocketEvent) : void
      {
         if(RoomManager.Instance.current)
         {
            RoomManager.Instance.current.setPlayerReadyState(e.pkg.clientId,e.pkg.readBoolean());
         }
      }
      
      private function __gameMissionInfo(evt:CrazyTankSocketEvent) : void
      {
         var temp:* = null;
         var missionInfo:* = null;
         if(Current == null)
         {
            return;
         }
         if(!Current.missionInfo)
         {
            var _loc4_:* = new MissionInfo();
            Current.missionInfo = _loc4_;
            missionInfo = _loc4_;
         }
         else
         {
            missionInfo = Current.missionInfo;
         }
         missionInfo.id = evt.pkg.readInt();
         missionInfo.name = evt.pkg.readUTF();
         missionInfo.success = evt.pkg.readUTF();
         missionInfo.failure = evt.pkg.readUTF();
         missionInfo.description = evt.pkg.readUTF();
         temp = evt.pkg.readUTF();
         missionInfo.totalMissiton = evt.pkg.readInt();
         missionInfo.missionIndex = evt.pkg.readInt();
         missionInfo.totalValue1 = evt.pkg.readInt();
         missionInfo.totalValue2 = evt.pkg.readInt();
         missionInfo.totalValue3 = evt.pkg.readInt();
         missionInfo.totalValue4 = evt.pkg.readInt();
         missionInfo.nextMissionIndex = missionInfo.missionIndex + 1;
         missionInfo.parseString(temp);
         missionInfo.tryagain = evt.pkg.readInt();
         missionInfo.pic = evt.pkg.readUTF();
         checkCanToLoader();
      }
      
      private function __loadprogress(evt:CrazyTankSocketEvent) : void
      {
         var progress:int = 0;
         var zoneID:int = 0;
         var id:int = 0;
         var info:* = null;
         if(Current)
         {
            progress = evt.pkg.readInt();
            zoneID = evt.pkg.readInt();
            id = evt.pkg.readInt();
            info = Current.findRoomPlayer(id,zoneID);
            if(info && !info.isSelf)
            {
               info.progress = progress;
            }
         }
      }
      
      private function __gameStart(event:CrazyTankSocketEvent) : void
      {
         var pkg:* = null;
         var len:int = 0;
         var i:int = 0;
         var livingID:int = 0;
         var info:* = null;
         var blood:int = 0;
         var maxBlood:int = 0;
         var refineryLevel:int = 0;
         var deputyWeaponCount:int = 0;
         var count:int = 0;
         var buff:* = null;
         var j:int = 0;
         var data:int = 0;
         var buffCount:int = 0;
         var buffs:* = undefined;
         var l:int = 0;
         var isFrost:Boolean = false;
         var isHide:Boolean = false;
         var isNoHole:Boolean = false;
         var isBubble:Boolean = false;
         var sealSatesCount:int = 0;
         var sealSates:* = null;
         var I:int = 0;
         var K:* = null;
         var Value:* = null;
         var markMeHideSrcId:int = 0;
         var srcPlayer:* = null;
         var exitTimes:int = 0;
         var exitTimeLimit:int = 0;
         var bombLength:int = 0;
         var k:int = 0;
         var bomb:* = null;
         var boxCount:int = 0;
         var b:* = 0;
         var boxInfo:* = null;
         var type:int = 0;
         setGameSmallData();
         TryAgain = -1;
         ExpTweenManager.Instance.deleteTweens();
         if(Current)
         {
            event.executed = false;
            pkg = event.pkg;
            len = pkg.readInt();
            for(i = 1; i <= len; )
            {
               livingID = pkg.readInt();
               info = Current.findPlayer(livingID);
               if(info != null)
               {
                  info.reset();
                  info.pos = new Point(pkg.readInt(),pkg.readInt());
                  info.energy = 1;
                  info.direction = pkg.readInt();
                  blood = pkg.readInt();
                  maxBlood = pkg.readInt();
                  info.team = pkg.readInt();
                  refineryLevel = pkg.readInt();
                  if(info is LocalPlayer)
                  {
                     (info as LocalPlayer).deputyWeaponCount = pkg.readInt();
                  }
                  else
                  {
                     deputyWeaponCount = pkg.readInt();
                  }
                  info.powerRatio = pkg.readInt();
                  info.dander = pkg.readInt();
                  info.maxBlood = maxBlood;
                  info.updateBlood(blood,0,0);
                  info.wishKingCount = pkg.readInt();
                  info.wishKingEnergy = pkg.readInt();
                  info.currentWeapInfo.refineryLevel = refineryLevel;
                  count = pkg.readInt();
                  for(j = 0; j < count; )
                  {
                     buff = BuffManager.creatBuff(pkg.readInt());
                     data = pkg.readInt();
                     if(buff)
                     {
                        buff.data = data;
                        info.addBuff(buff);
                     }
                     j++;
                  }
                  buffCount = pkg.readInt();
                  buffs = new Vector.<FightBuffInfo>();
                  for(l = 0; l < buffCount; )
                  {
                     buff = BuffManager.creatBuff(pkg.readInt());
                     info.addBuff(buff);
                     l++;
                  }
                  isFrost = pkg.readBoolean();
                  isHide = pkg.readBoolean();
                  isNoHole = pkg.readBoolean();
                  isBubble = pkg.readBoolean();
                  sealSatesCount = pkg.readInt();
                  sealSates = new Dictionary();
                  for(I = 0; I < sealSatesCount; )
                  {
                     K = pkg.readUTF();
                     Value = pkg.readUTF();
                     sealSates[K] = Value;
                     I++;
                  }
                  info.isFrozen = isFrost;
                  info.isHidden = isHide;
                  info.isNoNole = isNoHole;
                  info.outProperty = sealSates;
                  if(RoomManager.Instance.current.type != 5 && info.playerInfo.currentPet)
                  {
                     info.currentPet = new Pet(info.playerInfo.currentPet);
                  }
                  markMeHideSrcId = pkg.readInt();
                  srcPlayer = Current.findPlayerByPlayerID(markMeHideSrcId);
                  if(srcPlayer)
                  {
                     info.markMeHide = true;
                     if(Current.selfGamePlayer == srcPlayer)
                     {
                        info.markMeHideDest = true;
                     }
                  }
                  exitTimes = pkg.readInt();
                  exitTimeLimit = pkg.readInt();
                  if(info.isSelf)
                  {
                     Current.exitTimes = exitTimes;
                     Current.exitTimeLimit = exitTimeLimit * 60000;
                  }
               }
               i++;
            }
            bombLength = pkg.readInt();
            for(k = 0; k < bombLength; )
            {
               bomb = new Bomb();
               bomb.Id = pkg.readInt();
               bomb.X = pkg.readInt();
               bomb.Y = pkg.readInt();
               Current.outBombs.add(k,bomb);
               k++;
            }
            boxCount = pkg.readInt();
            for(b = uint(0); b < boxCount; )
            {
               boxInfo = new SimpleBoxInfo();
               boxInfo.bid = pkg.readInt();
               boxInfo.bx = pkg.readInt();
               boxInfo.by = pkg.readInt();
               boxInfo.subType = pkg.readInt();
               boxInfo.model = pkg.readUTF();
               Current.outBoxs.add(boxInfo.bid,boxInfo);
               b++;
            }
            Current.startTime = pkg.readDate();
            MapManager.Instance.curMapCardLabelType = pkg.readInt();
            type = RoomManager.Instance.current.type;
            if(type == 5)
            {
               StateManager.setState("fightLabGameView",Current);
               if(PathManager.isStatistics)
               {
                  WeakGuildManager.Instance.statistics(4,TimeManager.Instance.enterFightTime);
               }
            }
            else if(type == 10)
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
            else if(len == 0)
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
               Current.IsOneOnOne = len == 2;
               if(PathManager.isStatistics)
               {
                  WeakGuildManager.Instance.statistics(4,TimeManager.Instance.enterFightTime);
               }
            }
            RoomManager.Instance.resetAllPlayerState();
         }
         CampBattleManager.instance.isFighting = true;
      }
      
      private function __missionAllOver(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var obj:* = null;
         var id:int = 0;
         var player:* = null;
         var self:* = null;
         var j:int = 0;
         var pkg:PackageIn = event.pkg;
         var playerCount:int = pkg.readInt();
         if(Current == null)
         {
            return;
         }
         while(i < playerCount)
         {
            id = pkg.readInt();
            player = Current.findPlayerByPlayerID(id);
            if(player)
            {
               if(player.expObj)
               {
                  obj = player.expObj;
               }
               else
               {
                  obj = {};
               }
               obj.killGP = pkg.readInt();
               obj.hertGP = pkg.readInt();
               obj.fightGP = pkg.readInt();
               obj.ghostGP = pkg.readInt();
               obj.gpForVIP = pkg.readInt();
               obj.gpForConsortia = pkg.readInt();
               obj.gpForSpouse = pkg.readInt();
               obj.gpForServer = pkg.readInt();
               obj.gpForApprenticeOnline = pkg.readInt();
               obj.gpForApprenticeTeam = pkg.readInt();
               obj.gpForDoubleCard = pkg.readInt();
               obj.gpForPower = pkg.readInt();
               obj.consortiaSkill = pkg.readInt();
               obj.luckyExp = pkg.readInt();
               obj.gainGP = pkg.readInt();
               obj.gpCSMUser = pkg.readInt();
               obj.gpAddWell = pkg.readInt();
               trace("gpCSMUser:" + obj.gpCSMUser);
               player.isWin = pkg.readBoolean();
               player.expObj = obj;
            }
            i++;
         }
         if(PathManager.solveExternalInterfaceEnabel() && Current.selfGamePlayer.isWin)
         {
            self = PlayerManager.Instance.Self;
         }
         Current.missionInfo.missionOverNPCMovies = [];
         var npcMovieCount:int = pkg.readInt();
         for(j = 0; j < npcMovieCount; )
         {
            Current.missionInfo.missionOverNPCMovies.push(pkg.readUTF());
            j++;
         }
      }
      
      private function __takeOut(event:CrazyTankSocketEvent) : void
      {
         if(Current)
         {
            Current.resultCard.push(event);
         }
      }
      
      private function __showAllCard(event:CrazyTankSocketEvent) : void
      {
         if(Current)
         {
            Current.showAllCard.push(event);
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
      
      public function selfGetItemShowAndSound(list:Dictionary) : Boolean
      {
         var data:* = null;
         var msg:* = null;
         var channelTag:* = null;
         var goodTag:* = null;
         var playSound:Boolean = false;
         var _loc9_:int = 0;
         var _loc8_:* = list;
         for each(var info in list)
         {
            data = new ChatData();
            data.channel = 6;
            msg = LanguageMgr.GetTranslation("tank.data.player.FightingPlayerInfo.your");
            channelTag = ChatFormats.getTagsByChannel(data);
            goodTag = ChatFormats.creatGoodTag(info.Property1 != "31"?"[" + info.Name + "]":"[" + info.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(info.TemplateID).Name + "Lv" + BeadTemplateManager.Instance.GetBeadInfobyID(info.TemplateID).BaseLevel + "]",2,info.TemplateID,info.Quality,info.IsBinds,data);
            data.htmlMessage = channelTag[0] + msg + goodTag + channelTag[1] + "<BR>";
            ChatManager.Instance.chat(data,false);
            if(info.Quality >= 3)
            {
               playSound = true;
            }
         }
         return playSound;
      }
      
      public function isIdenticalGame(id:int = 0) : Boolean
      {
         var gamePlayers:DictionaryData = RoomManager.Instance.current.players;
         var selfInfo:SelfInfo = PlayerManager.Instance.Self;
         if(id == selfInfo.ID)
         {
            return false;
         }
         var _loc6_:int = 0;
         var _loc5_:* = gamePlayers;
         for each(var i in gamePlayers)
         {
            if(i.playerInfo.ID == id && i.playerInfo.ZoneID == selfInfo.ZoneID)
            {
               return true;
            }
         }
         return false;
      }
      
      private function __loadResource(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var needMovie:* = null;
         setLoaderStop();
         var count:int = event.pkg.readInt();
         for(i = 0; i < count; )
         {
            needMovie = new GameNeedMovieInfo();
            needMovie.type = event.pkg.readInt();
            needMovie.path = event.pkg.readUTF();
            needMovie.classPath = event.pkg.readUTF();
            needMovie.startLoad();
            i++;
         }
      }
      
      public function setLoaderStop() : void
      {
         var length:int = 0;
         var i:int = 0;
         if(_loaderArray != null)
         {
            length = _loaderArray.length;
            for(i = 0; i < length; )
            {
               if(!(_loaderArray[i] as BaseLoader).isComplete)
               {
                  (_loaderArray[i] as BaseLoader).unload();
               }
               i++;
            }
            _loaderArray.length = 0;
         }
      }
      
      public function get gameView() : IGameView
      {
         return _gameView;
      }
      
      public function set gameView(value:IGameView) : void
      {
         _gameView = value;
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
      
      public function get boxPhysicalEvtVec() : Vector.<CrazyTankSocketEvent>
      {
         return _boxPhysicalEvtVec;
      }
      
      private function __skillInfoInit(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var skillId:int = 0;
         var cd:int = 0;
         var j:int = 0;
         var skillId2:int = 0;
         var cd2:int = 0;
         var count2:int = 0;
         var pkg:PackageIn = event.pkg;
         petSkillList = [];
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            skillId = pkg.readInt();
            cd = pkg.readInt();
            petSkillList.push({
               "id":skillId,
               "cd":cd
            });
            pkg.readInt();
            i++;
         }
         horseSkillList = [];
         count = pkg.readInt();
         for(j = 0; j < count; )
         {
            skillId2 = pkg.readInt();
            cd2 = pkg.readInt();
            count2 = pkg.readInt();
            horseSkillList.push({
               "id":skillId2,
               "cd":cd2,
               "count":count2
            });
            j++;
         }
         dispatchEvent(new Event("skillInfoInitGame"));
      }
      
      private function setGameSmallData() : void
      {
         var color:Number = NaN;
         randomSmallLivingShape = int(Math.random() * 3);
         if(teamColorData)
         {
            teamColorData.clear();
         }
         teamColorData = new DictionaryData();
         var list:Array = [];
         var index:int = 1;
         do
         {
            teamColorData.add(index,[16777215 * Math.random(),16777215 * Math.random()]);
            color = teamColorData[index][0];
            if(list.indexOf(color) == -1)
            {
               list[index] = teamColorData[index][0];
               index++;
            }
         }
         while(index <= 8);
         
      }
      
      private function setSmallMapEnable(value:String, random:int) : void
      {
         var i:int = 0;
         var enable:Boolean = false;
         var key:Array = ["0","SMALLMAP_BORDER_ENABLE","SMALLMAP_ALPHA","SMALLMAP_POINT_ENABLE","SMALLMAP_GRID_ENABLE","SMALLMAP_SHAPE_ENABLE"];
         var enableIndex:int = int(Math.random() * (key.length - 1)) + 1;
         var bombKingMap:Object = {};
         bombKingMap["SMALLMAP_ENABLE"] = false;
         for(i = 1; i < key.length; )
         {
            if(_pathInfo.BOMBKing_KILL_CHEAT)
            {
               if(i == enableIndex)
               {
                  bombKingMap[key[i]] = true;
               }
               else
               {
                  bombKingMap[key[i]] = Math.random() < 0.5?false:true;
               }
            }
            else
            {
               bombKingMap[key[i]] = false;
            }
            i++;
         }
         _pathInfo.BOMBKing_KILL_CHEAT_MAP = bombKingMap;
         var enableCount:int = 0;
         var maxCount:* = random;
         var enableList:Array = value.split(",");
         var openKey:Array = [];
         _pathInfo.SMALLMAP_ENABLE = Boolean(int(enableList[0]));
         if(_pathInfo.SMALLMAP_ENABLE)
         {
            return;
         }
         i = 1;
         while(i < enableList.length)
         {
            enable = int(enableList[i]);
            _pathInfo[key[i]] = enable;
            if(enable)
            {
               openKey.push(key[i]);
               enableCount++;
            }
            i++;
         }
         if(maxCount > 0 && enableCount >= maxCount)
         {
            setRandomSmallMapEnalbe(openKey,enableCount,maxCount);
         }
      }
      
      private function setRandomSmallMapEnalbe(openKey:Array, enableCount:int, maxCount:int) : void
      {
         var i:int = 0;
         var minCount:int = Math.floor(enableCount / 2);
         var randomCount:int = (maxCount - minCount) * Math.random() + minCount;
         var index:int = openKey.length;
         while(index)
         {
            index--;
            openKey.push(openKey.splice(int(Math.random() * index),1)[0]);
         }
         for(i = 0; i < openKey.length; )
         {
            if(i >= randomCount)
            {
               _pathInfo[openKey[i]] = false;
            }
            i++;
         }
      }
      
      private function isInBOMBKingGame() : Boolean
      {
         var gameMode:int = GameControl.Instance.Current.gameMode;
         return gameMode == 28 || gameMode == 29;
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
         var is3D:Boolean = false;
         if(_current && _current.roomType == 120 || _current.roomType == 123 || RoomManager.Instance.current.type == 1 && RoomManager.Instance.current.dungeonMode == 120)
         {
            is3D = true;
         }
         return is3D;
      }
      
      public function get specialSkillType() : String
      {
         if(_specialSkillType == null)
         {
            _specialSkillType = Math.random() * 10 > 5?"A":"B";
         }
         return _specialSkillType;
      }
      
      public function setDropData(itemId:int, count:int) : void
      {
         var isItem:Boolean = false;
         var i:int = 0;
         var obj:* = null;
         for(i = 0; i < dropData.length; )
         {
            if(dropData[i].itemId == itemId)
            {
               dropData[i].count = dropData[i].count + count;
               isItem = true;
               break;
            }
            i++;
         }
         if(!isItem)
         {
            obj = {};
            obj.count = count;
            obj.itemId = itemId;
            dropData.push(obj);
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
