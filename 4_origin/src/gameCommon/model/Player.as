package gameCommon.model
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.LivingEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PetSkillManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.view.characterStarling.IGameCharacter;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import game.view.map.MapView;
   import gameStarling.view.map.MapView3D;
   import pet.data.PetSkillTemplateInfo;
   import room.RoomManager;
   import room.model.DeputyWeaponInfo;
   import room.model.WeaponInfo;
   import room.model.WebSpeedInfo;
   import starling.display.cell.CellContent3D;
   
   [Event(name="beginShoot",type="ddt.events.LivingEvent")]
   [Event(name="addState",type="ddt.events.LivingEvent")]
   [Event(name="usingItem",type="ddt.events.LivingEvent")]
   [Event(name="usingSpecialSkill",type="ddt.events.LivingEvent")]
   [Event(name="danderChanged",type="ddt.events.LivingEvent")]
   [Event(name="bombChanged",type="ddt.events.LivingEvent")]
   public class Player extends TurnedLiving
   {
      
      public static const MaxPsychic:int = 999;
      
      public static const MaxSoulPropUsedCount:int = 2;
      
      public static var MOVE_SPEED:Number = 2;
      
      public static var GHOST_MOVE_SPEED:Number = 8;
      
      public static var FALL_SPEED:Number = 12;
      
      public static const FORCE_MAX:int = 2000;
      
      public static const FORCE_STEP:int = 24;
      
      public static const TOTAL_DANDER:int = 200;
      
      public static const SHOOT_INTERVAL:uint = 24;
      
      public static const SHOOT_TIMER:uint = 1000;
      
      public static const TOTAL_BLOOD:int = 1000;
      
      public static const TOTAL_LEADER_BLOOD:int = 2000;
      
      public static const LACK_HP:int = 2;
       
      
      protected var _currentMap:MapView;
      
      protected var _currentMap3D:MapView3D;
      
      public var isPlayAnimation:int;
      
      protected var _maxForce:int = 2000;
      
      private var _info:PlayerInfo;
      
      private var _movie:IGameCharacter;
      
      public var _expObj:Object;
      
      public var isUpGrade:Boolean;
      
      private var _isWin:Boolean;
      
      public var tieStatus:int;
      
      public var CurrentLevel:int;
      
      public var CurrentGP:int;
      
      public var TotalKill:int;
      
      public var TotalHurt:int;
      
      public var TotalHitTargetCount:int;
      
      public var TotalShootCount:int;
      
      public var GetCardCount:int;
      
      private var _bossCardCount:int;
      
      public var GainOffer:int;
      
      public var GainGP:int;
      
      public var VipGP:int;
      
      public var MarryGP:int;
      
      public var AcademyGP:int;
      
      public var zoneName:String;
      
      public var ringFlag:Boolean;
      
      public var loveBuffLevel:int;
      
      private var _powerRatio:int = 100;
      
      private var _skill:int = -1;
      
      private var _isSpecialSkill:Boolean;
      
      protected var _dander:int;
      
      private var _currentWeapInfo:WeaponInfo;
      
      private var _currentBomb:int;
      
      public var webSpeedInfo:WebSpeedInfo;
      
      private var _currentDeputyWeaponInfo:DeputyWeaponInfo;
      
      private var _isReady:Boolean;
      
      private var _turnTime:int = 0;
      
      private var _reverse:int = 1;
      
      private var _isAutoGuide:Boolean = false;
      
      private var _pet:Pet;
      
      public var hasLevelAgain:Boolean = false;
      
      public var hasGardGet:Boolean = false;
      
      public var wishKingCount:int;
      
      public var wishKingEnergy:int;
      
      public var IsRobot:Boolean;
      
      public var killNum:int;
      
      public var flagNum:int;
      
      public var isFeignDeath:Boolean;
      
      public function Player(info:PlayerInfo, id:int, team:int, maxBlood:int, templeId:int = 0)
      {
         _info = info;
         super(id,team,maxBlood,templeId);
         setWeaponInfo();
         setDeputyWeaponInfo();
         webSpeedInfo = new WebSpeedInfo(_info.webSpeed);
         initEvent();
      }
      
      public function get currentMap() : MapView
      {
         return _currentMap;
      }
      
      public function set currentMap(value:MapView) : void
      {
         _currentMap = value;
      }
      
      public function get currentMap3D() : MapView3D
      {
         return _currentMap3D;
      }
      
      public function set currentMap3D(value:MapView3D) : void
      {
         _currentMap3D = value;
      }
      
      public function get BossCardCount() : int
      {
         return _bossCardCount;
      }
      
      public function set BossCardCount(value:int) : void
      {
         _bossCardCount = value;
      }
      
      private function initEvent() : void
      {
         _info.addEventListener("propertychange",__playerPropChanged);
      }
      
      private function removeEvent() : void
      {
         _info.removeEventListener("propertychange",__playerPropChanged);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         movie = null;
         character = null;
         if(_currentWeapInfo)
         {
            _currentWeapInfo.dispose();
         }
         _currentWeapInfo = null;
         if(_currentDeputyWeaponInfo)
         {
            _currentDeputyWeaponInfo.dispose();
         }
         _currentDeputyWeaponInfo = null;
         webSpeedInfo = null;
         _info = null;
         _currentMap = null;
         _currentMap3D = null;
         super.dispose();
      }
      
      override public function reset() : void
      {
         super.reset();
         _isAttacking = false;
         _dander = 0;
         if(_movie)
         {
            _movie.State = 1;
         }
      }
      
      override public function get playerInfo() : PlayerInfo
      {
         return _info;
      }
      
      override public function get isSelf() : Boolean
      {
         return _info is SelfInfo;
      }
      
      public function get movie() : IGameCharacter
      {
         return _movie;
      }
      
      public function set movie(value:IGameCharacter) : void
      {
         _movie = value;
      }
      
      public function get isWin() : Boolean
      {
         return _isWin;
      }
      
      public function set isWin(value:Boolean) : void
      {
         _isWin = value;
      }
      
      public function set MP(value:int) : void
      {
         if(currentPet)
         {
            currentPet.MP = value;
         }
      }
      
      public function set expObj(value:Object) : void
      {
         _expObj = value;
      }
      
      public function get expObj() : Object
      {
         return _expObj;
      }
      
      public function playerMoveTo(type:Number, target:Point, dir:Number, isLiving:Boolean, acts:Array = null, finishedFun:Function = null) : void
      {
         dispatchEvent(new LivingEvent("playerMoveto",0,0,type,target,dir,isLiving,acts,finishedFun));
      }
      
      public function beginShoot() : void
      {
         dispatchEvent(new LivingEvent("beginShoot"));
      }
      
      public function useItem(info:ItemTemplateInfo) : void
      {
         dispatchEvent(new LivingEvent("usingItem",0,0,info));
      }
      
      public function useItemByIcon(dis:DisplayObject) : void
      {
         dispatchEvent(new LivingEvent("usingItem",0,0,dis));
      }
      
      public function useItemByIcon3D(dis:CellContent3D) : void
      {
         dispatchEvent(new LivingEvent("usingItem",0,0,dis));
      }
      
      public function get maxForce() : int
      {
         return _maxForce;
      }
      
      public function set maxForce(val:int) : void
      {
         if(_maxForce != val)
         {
            _maxForce = val;
            dispatchEvent(new LivingEvent("maxforceChanged",_maxForce));
         }
      }
      
      public function get powerRatio() : Number
      {
         return _powerRatio / 100;
      }
      
      public function set powerRatio(value:Number) : void
      {
         _powerRatio = value;
      }
      
      public function get skill() : int
      {
         return _skill;
      }
      
      public function set skill(val:int) : void
      {
         _skill = val;
         if(_skill >= 0)
         {
            dispatchEvent(new LivingEvent("usingSpecialSkill"));
         }
      }
      
      public function get isSpecialSkill() : Boolean
      {
         return _isSpecialSkill;
      }
      
      public function set isSpecialSkill(value:Boolean) : void
      {
         if(_isSpecialSkill != value)
         {
            _isSpecialSkill = value;
            if(value)
            {
               dispatchEvent(new LivingEvent("usingSpecialSkill"));
            }
         }
      }
      
      public function get dander() : int
      {
         return _dander;
      }
      
      public function set dander(value:int) : void
      {
         if(RoomManager.Instance.current && RoomManager.Instance.current.gameMode == 8)
         {
            return;
         }
         if(_dander == value || !_isLiving)
         {
            return;
         }
         if(_dander < 0)
         {
            _dander = 0;
         }
         else
         {
            _dander = value > 200?200:int(value);
         }
         dispatchEvent(new LivingEvent("danderChanged",_dander));
      }
      
      public function reduceDander(value:int) : void
      {
         if(_dander == value)
         {
            return;
         }
         if(_dander < 0)
         {
            _dander = 0;
         }
         else
         {
            _dander = value > 200?200:int(value);
         }
         dispatchEvent(new LivingEvent("danderChanged",_dander));
      }
      
      public function get currentWeapInfo() : WeaponInfo
      {
         return _currentWeapInfo;
      }
      
      public function set currentWeapInfo(value:WeaponInfo) : void
      {
         _currentWeapInfo = value;
      }
      
      public function get currentBomb() : int
      {
         return _currentBomb;
      }
      
      public function set currentBomb(value:int) : void
      {
         if(value == _currentBomb)
         {
            return;
         }
         _currentBomb = value;
         dispatchEvent(new LivingEvent("bombChanged",_currentBomb,0));
      }
      
      override public function beginNewTurn() : void
      {
         super.beginNewTurn();
         _currentBomb = _currentWeapInfo.commonBall;
         _isSpecialSkill = false;
         gemDefense = false;
      }
      
      override public function die(widthAction:Boolean = true) : void
      {
         if(isLiving)
         {
            if(_movie)
            {
               _movie.State = 2;
            }
            super.die();
            isSpecialSkill = false;
            dander = 0;
            SoundManager.instance.play("Sound042");
         }
      }
      
      public function doAction(type:*) : void
      {
         dispatchEvent(new LivingEvent("playerDoAction",0,0,type));
      }
      
      override public function isPlayer() : Boolean
      {
         return true;
      }
      
      protected function setWeaponInfo() : void
      {
         if(_currentWeapInfo && _currentWeapInfo.TemplateID == 70016 && playerInfo.WeaponID <= 0)
         {
            return;
         }
         if(playerInfo.WeaponID == -1)
         {
            playerInfo.WeaponID = 70016;
         }
         var iteminfo:InventoryItemInfo = new InventoryItemInfo();
         iteminfo.TemplateID = playerInfo.WeaponID;
         ItemManager.fill(iteminfo);
         if(_currentWeapInfo)
         {
            _currentWeapInfo.dispose();
         }
         _currentWeapInfo = new WeaponInfo(iteminfo);
         currentBomb = _currentWeapInfo.commonBall;
      }
      
      public function setDeputyWeaponInfo() : void
      {
         var iteminfo:InventoryItemInfo = new InventoryItemInfo();
         iteminfo.TemplateID = _info.DeputyWeaponID;
         ItemManager.fill(iteminfo);
         _currentDeputyWeaponInfo = new DeputyWeaponInfo(iteminfo);
      }
      
      public function get currentDeputyWeaponInfo() : DeputyWeaponInfo
      {
         return _currentDeputyWeaponInfo;
      }
      
      public function hasDeputyWeapon() : Boolean
      {
         return _info != null && _info.DeputyWeaponID > 0;
      }
      
      private function __playerPropChanged(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["WeaponID"])
         {
            setWeaponInfo();
         }
         else if(event.changedProperties["DeputyWeaponID"])
         {
            setDeputyWeaponInfo();
         }
         if(event.changedProperties["Grade"] && StateManager.currentStateType != "missionResult")
         {
            isUpGrade = _info.IsUpGrade;
            if(isSelf)
            {
               PlayerManager.Instance.Self.isUpGradeInGame = true;
            }
         }
      }
      
      public function get isReady() : Boolean
      {
         return _isReady;
      }
      
      public function set isReady(value:Boolean) : void
      {
         _isReady = value;
      }
      
      override public function updateBlood(value:Number, type:int, addVlaue:int = 0) : void
      {
         super.updateBlood(value,type,addVlaue);
         if(_movie == null)
         {
            return;
         }
         if(blood <= maxBlood * 0.3)
         {
            _movie.State = 2;
         }
         else
         {
            _movie.State = 1;
         }
         if(blood != maxBlood)
         {
            _movie.isLackHp = type != 0 && addVlaue >= maxBlood * 0.1;
         }
      }
      
      public function get turnTime() : int
      {
         return _turnTime;
      }
      
      public function set turnTime(val:int) : void
      {
         _turnTime = val;
      }
      
      public function get reverse() : int
      {
         if(isRedSkull)
         {
            return -1;
         }
         return _reverse;
      }
      
      public function set reverse(val:int) : void
      {
         _reverse = val;
         dispatchEvent(new LivingEvent("reverseChanged",0,0,reverse));
      }
      
      public function get isAutoGuide() : Boolean
      {
         if(_isAutoGuide == true)
         {
            _isAutoGuide = false;
            return true;
         }
         return _isAutoGuide;
      }
      
      public function set isAutoGuide(value:Boolean) : void
      {
         if(_isAutoGuide == value)
         {
            return;
         }
         _isAutoGuide = value;
      }
      
      public function get currentPet() : Pet
      {
         return _pet;
      }
      
      public function set currentPet(val:Pet) : void
      {
         _pet = val;
      }
      
      private function onUsePetSkill(event:LivingEvent) : void
      {
         dispatchEvent(new LivingEvent(event.type,event.value,0,event.paras[0]));
      }
      
      public function usePetSkill(skillID:int, isUsed:Boolean) : void
      {
         var skill:PetSkillTemplateInfo = PetSkillManager.getSkillByID(skillID);
         if(skill && isUsed)
         {
            currentPet.useSkill(skillID,isUsed);
         }
         dispatchEvent(new LivingEvent("usePetSkill",skillID,0,isUsed));
      }
      
      public function useHorseSkill(skillID:int, isUsed:Boolean, restCount:int) : void
      {
         dispatchEvent(new LivingEvent("horseSkillUse",0,0,skillID,isUsed,restCount));
      }
      
      public function petBeat(act:String, pt:Point, targets:Array) : void
      {
         dispatchEvent(new LivingEvent("petBeat",0,0,act,pt,targets));
      }
      
      public function clone(livingId:int = 0) : Player
      {
         var temInfo:* = null;
         var tempPlayerInfo:PlayerInfo = _info.clone();
         var temPlayer:Player = new Player(tempPlayerInfo,livingId,this.team,this.maxBlood);
         ObjectUtils.copyProperties(temPlayer,this);
         var temBuff:Vector.<FightBuffInfo> = new Vector.<FightBuffInfo>();
         var _loc8_:* = 0;
         var _loc7_:* = turnBuffs;
         for each(var info in turnBuffs)
         {
            temBuff.push(info.clone());
         }
         _loc8_ = temBuff;
         temPlayer.outTurnBuffs = _loc8_;
         temPlayer.turnBuffs = _loc8_;
         return temPlayer;
      }
   }
}
