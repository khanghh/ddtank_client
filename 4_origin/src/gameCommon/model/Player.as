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
      
      public function Player(param1:PlayerInfo, param2:int, param3:int, param4:int, param5:int = 0)
      {
         _info = param1;
         super(param2,param3,param4,param5);
         setWeaponInfo();
         setDeputyWeaponInfo();
         webSpeedInfo = new WebSpeedInfo(_info.webSpeed);
         initEvent();
      }
      
      public function get currentMap() : MapView
      {
         return _currentMap;
      }
      
      public function set currentMap(param1:MapView) : void
      {
         _currentMap = param1;
      }
      
      public function get currentMap3D() : MapView3D
      {
         return _currentMap3D;
      }
      
      public function set currentMap3D(param1:MapView3D) : void
      {
         _currentMap3D = param1;
      }
      
      public function get BossCardCount() : int
      {
         return _bossCardCount;
      }
      
      public function set BossCardCount(param1:int) : void
      {
         _bossCardCount = param1;
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
      
      public function set movie(param1:IGameCharacter) : void
      {
         _movie = param1;
      }
      
      public function get isWin() : Boolean
      {
         return _isWin;
      }
      
      public function set isWin(param1:Boolean) : void
      {
         _isWin = param1;
      }
      
      public function set MP(param1:int) : void
      {
         if(currentPet)
         {
            currentPet.MP = param1;
         }
      }
      
      public function set expObj(param1:Object) : void
      {
         _expObj = param1;
      }
      
      public function get expObj() : Object
      {
         return _expObj;
      }
      
      public function playerMoveTo(param1:Number, param2:Point, param3:Number, param4:Boolean, param5:Array = null, param6:Function = null) : void
      {
         dispatchEvent(new LivingEvent("playerMoveto",0,0,param1,param2,param3,param4,param5,param6));
      }
      
      public function beginShoot() : void
      {
         dispatchEvent(new LivingEvent("beginShoot"));
      }
      
      public function useItem(param1:ItemTemplateInfo) : void
      {
         dispatchEvent(new LivingEvent("usingItem",0,0,param1));
      }
      
      public function useItemByIcon(param1:DisplayObject) : void
      {
         dispatchEvent(new LivingEvent("usingItem",0,0,param1));
      }
      
      public function useItemByIcon3D(param1:CellContent3D) : void
      {
         dispatchEvent(new LivingEvent("usingItem",0,0,param1));
      }
      
      public function get maxForce() : int
      {
         return _maxForce;
      }
      
      public function set maxForce(param1:int) : void
      {
         if(_maxForce != param1)
         {
            _maxForce = param1;
            dispatchEvent(new LivingEvent("maxforceChanged",_maxForce));
         }
      }
      
      public function get powerRatio() : Number
      {
         return _powerRatio / 100;
      }
      
      public function set powerRatio(param1:Number) : void
      {
         _powerRatio = param1;
      }
      
      public function get skill() : int
      {
         return _skill;
      }
      
      public function set skill(param1:int) : void
      {
         _skill = param1;
         if(_skill >= 0)
         {
            dispatchEvent(new LivingEvent("usingSpecialSkill"));
         }
      }
      
      public function get isSpecialSkill() : Boolean
      {
         return _isSpecialSkill;
      }
      
      public function set isSpecialSkill(param1:Boolean) : void
      {
         if(_isSpecialSkill != param1)
         {
            _isSpecialSkill = param1;
            if(param1)
            {
               dispatchEvent(new LivingEvent("usingSpecialSkill"));
            }
         }
      }
      
      public function get dander() : int
      {
         return _dander;
      }
      
      public function set dander(param1:int) : void
      {
         if(RoomManager.Instance.current && RoomManager.Instance.current.gameMode == 8)
         {
            return;
         }
         if(_dander == param1 || !_isLiving)
         {
            return;
         }
         if(_dander < 0)
         {
            _dander = 0;
         }
         else
         {
            _dander = param1 > 200?200:int(param1);
         }
         dispatchEvent(new LivingEvent("danderChanged",_dander));
      }
      
      public function reduceDander(param1:int) : void
      {
         if(_dander == param1)
         {
            return;
         }
         if(_dander < 0)
         {
            _dander = 0;
         }
         else
         {
            _dander = param1 > 200?200:int(param1);
         }
         dispatchEvent(new LivingEvent("danderChanged",_dander));
      }
      
      public function get currentWeapInfo() : WeaponInfo
      {
         return _currentWeapInfo;
      }
      
      public function set currentWeapInfo(param1:WeaponInfo) : void
      {
         _currentWeapInfo = param1;
      }
      
      public function get currentBomb() : int
      {
         return _currentBomb;
      }
      
      public function set currentBomb(param1:int) : void
      {
         if(param1 == _currentBomb)
         {
            return;
         }
         _currentBomb = param1;
         dispatchEvent(new LivingEvent("bombChanged",_currentBomb,0));
      }
      
      override public function beginNewTurn() : void
      {
         super.beginNewTurn();
         _currentBomb = _currentWeapInfo.commonBall;
         _isSpecialSkill = false;
         gemDefense = false;
      }
      
      override public function die(param1:Boolean = true) : void
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
      
      public function doAction(param1:*) : void
      {
         dispatchEvent(new LivingEvent("playerDoAction",0,0,param1));
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
         var _loc1_:InventoryItemInfo = new InventoryItemInfo();
         _loc1_.TemplateID = playerInfo.WeaponID;
         ItemManager.fill(_loc1_);
         if(_currentWeapInfo)
         {
            _currentWeapInfo.dispose();
         }
         _currentWeapInfo = new WeaponInfo(_loc1_);
         currentBomb = _currentWeapInfo.commonBall;
      }
      
      public function setDeputyWeaponInfo() : void
      {
         var _loc1_:InventoryItemInfo = new InventoryItemInfo();
         _loc1_.TemplateID = _info.DeputyWeaponID;
         ItemManager.fill(_loc1_);
         _currentDeputyWeaponInfo = new DeputyWeaponInfo(_loc1_);
      }
      
      public function get currentDeputyWeaponInfo() : DeputyWeaponInfo
      {
         return _currentDeputyWeaponInfo;
      }
      
      public function hasDeputyWeapon() : Boolean
      {
         return _info != null && _info.DeputyWeaponID > 0;
      }
      
      private function __playerPropChanged(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["WeaponID"])
         {
            setWeaponInfo();
         }
         else if(param1.changedProperties["DeputyWeaponID"])
         {
            setDeputyWeaponInfo();
         }
         if(param1.changedProperties["Grade"] && StateManager.currentStateType != "missionResult")
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
      
      public function set isReady(param1:Boolean) : void
      {
         _isReady = param1;
      }
      
      override public function updateBlood(param1:Number, param2:int, param3:int = 0) : void
      {
         super.updateBlood(param1,param2,param3);
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
            _movie.isLackHp = param2 != 0 && param3 >= maxBlood * 0.1;
         }
      }
      
      public function get turnTime() : int
      {
         return _turnTime;
      }
      
      public function set turnTime(param1:int) : void
      {
         _turnTime = param1;
      }
      
      public function get reverse() : int
      {
         if(isRedSkull)
         {
            return -1;
         }
         return _reverse;
      }
      
      public function set reverse(param1:int) : void
      {
         _reverse = param1;
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
      
      public function set isAutoGuide(param1:Boolean) : void
      {
         if(_isAutoGuide == param1)
         {
            return;
         }
         _isAutoGuide = param1;
      }
      
      public function get currentPet() : Pet
      {
         return _pet;
      }
      
      public function set currentPet(param1:Pet) : void
      {
         _pet = param1;
      }
      
      private function onUsePetSkill(param1:LivingEvent) : void
      {
         dispatchEvent(new LivingEvent(param1.type,param1.value,0,param1.paras[0]));
      }
      
      public function usePetSkill(param1:int, param2:Boolean) : void
      {
         var _loc3_:PetSkillTemplateInfo = PetSkillManager.getSkillByID(param1);
         if(_loc3_ && param2)
         {
            currentPet.useSkill(param1,param2);
         }
         dispatchEvent(new LivingEvent("usePetSkill",param1,0,param2));
      }
      
      public function useHorseSkill(param1:int, param2:Boolean, param3:int) : void
      {
         dispatchEvent(new LivingEvent("horseSkillUse",0,0,param1,param2,param3));
      }
      
      public function petBeat(param1:String, param2:Point, param3:Array) : void
      {
         dispatchEvent(new LivingEvent("petBeat",0,0,param1,param2,param3));
      }
      
      public function clone(param1:int = 0) : Player
      {
         var _loc2_:* = null;
         var _loc3_:PlayerInfo = _info.clone();
         var _loc4_:Player = new Player(_loc3_,param1,this.team,this.maxBlood);
         ObjectUtils.copyProperties(_loc4_,this);
         var _loc5_:Vector.<FightBuffInfo> = new Vector.<FightBuffInfo>();
         var _loc8_:* = 0;
         var _loc7_:* = turnBuffs;
         for each(var _loc6_ in turnBuffs)
         {
            _loc5_.push(_loc6_.clone());
         }
         _loc8_ = _loc5_;
         _loc4_.outTurnBuffs = _loc8_;
         _loc4_.turnBuffs = _loc8_;
         return _loc4_;
      }
   }
}
