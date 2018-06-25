package gameCommon.model{   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.player.PlayerInfo;   import ddt.data.player.SelfInfo;   import ddt.events.LivingEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.ItemManager;   import ddt.manager.PetSkillManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.view.characterStarling.IGameCharacter;   import flash.display.DisplayObject;   import flash.geom.Point;   import game.view.map.MapView;   import gameStarling.view.map.MapView3D;   import pet.data.PetSkillTemplateInfo;   import room.RoomManager;   import room.model.DeputyWeaponInfo;   import room.model.WeaponInfo;   import room.model.WebSpeedInfo;   import starling.display.cell.CellContent3D;      [Event(name="beginShoot",type="ddt.events.LivingEvent")]   [Event(name="addState",type="ddt.events.LivingEvent")]   [Event(name="usingItem",type="ddt.events.LivingEvent")]   [Event(name="usingSpecialSkill",type="ddt.events.LivingEvent")]   [Event(name="danderChanged",type="ddt.events.LivingEvent")]   [Event(name="bombChanged",type="ddt.events.LivingEvent")]   public class Player extends TurnedLiving   {            public static const MaxPsychic:int = 999;            public static const MaxSoulPropUsedCount:int = 2;            public static var MOVE_SPEED:Number = 2;            public static var GHOST_MOVE_SPEED:Number = 8;            public static var FALL_SPEED:Number = 12;            public static const FORCE_MAX:int = 2000;            public static const FORCE_STEP:int = 24;            public static const TOTAL_DANDER:int = 200;            public static const SHOOT_INTERVAL:uint = 24;            public static const SHOOT_TIMER:uint = 1000;            public static const TOTAL_BLOOD:int = 1000;            public static const TOTAL_LEADER_BLOOD:int = 2000;            public static const LACK_HP:int = 2;                   protected var _currentMap:MapView;            protected var _currentMap3D:MapView3D;            public var isPlayAnimation:int;            protected var _maxForce:int = 2000;            private var _info:PlayerInfo;            private var _movie:IGameCharacter;            public var _expObj:Object;            public var isUpGrade:Boolean;            private var _isWin:Boolean;            public var tieStatus:int;            public var CurrentLevel:int;            public var CurrentGP:int;            public var TotalKill:int;            public var TotalHurt:int;            public var TotalHitTargetCount:int;            public var TotalShootCount:int;            public var GetCardCount:int;            private var _bossCardCount:int;            public var GainOffer:int;            public var GainGP:int;            public var VipGP:int;            public var MarryGP:int;            public var AcademyGP:int;            public var zoneName:String;            public var ringFlag:Boolean;            public var loveBuffLevel:int;            private var _powerRatio:int = 100;            private var _skill:int = -1;            private var _isSpecialSkill:Boolean;            protected var _dander:int;            private var _currentWeapInfo:WeaponInfo;            private var _currentBomb:int;            public var webSpeedInfo:WebSpeedInfo;            private var _currentDeputyWeaponInfo:DeputyWeaponInfo;            private var _isReady:Boolean;            private var _turnTime:int = 0;            private var _reverse:int = 1;            private var _isAutoGuide:Boolean = false;            private var _pet:Pet;            public var hasLevelAgain:Boolean = false;            public var hasGardGet:Boolean = false;            public var wishKingCount:int;            public var wishKingEnergy:int;            public var IsRobot:Boolean;            public var killNum:int;            public var flagNum:int;            public var isFeignDeath:Boolean;            public function Player(info:PlayerInfo, id:int, team:int, maxBlood:int, templeId:int = 0) { super(null,null,null,null); }
            public function get currentMap() : MapView { return null; }
            public function set currentMap(value:MapView) : void { }
            public function get currentMap3D() : MapView3D { return null; }
            public function set currentMap3D(value:MapView3D) : void { }
            public function get BossCardCount() : int { return 0; }
            public function set BossCardCount(value:int) : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
            override public function reset() : void { }
            override public function get playerInfo() : PlayerInfo { return null; }
            override public function get isSelf() : Boolean { return false; }
            public function get movie() : IGameCharacter { return null; }
            public function set movie(value:IGameCharacter) : void { }
            public function get isWin() : Boolean { return false; }
            public function set isWin(value:Boolean) : void { }
            public function set MP(value:int) : void { }
            public function set expObj(value:Object) : void { }
            public function get expObj() : Object { return null; }
            public function playerMoveTo(type:Number, target:Point, dir:Number, isLiving:Boolean, acts:Array = null, finishedFun:Function = null) : void { }
            public function beginShoot() : void { }
            public function useItem(info:ItemTemplateInfo) : void { }
            public function useItemByIcon(dis:DisplayObject) : void { }
            public function useItemByIcon3D(dis:CellContent3D) : void { }
            public function get maxForce() : int { return 0; }
            public function set maxForce(val:int) : void { }
            public function get powerRatio() : Number { return 0; }
            public function set powerRatio(value:Number) : void { }
            public function get skill() : int { return 0; }
            public function set skill(val:int) : void { }
            public function get isSpecialSkill() : Boolean { return false; }
            public function set isSpecialSkill(value:Boolean) : void { }
            public function get dander() : int { return 0; }
            public function set dander(value:int) : void { }
            public function reduceDander(value:int) : void { }
            public function get currentWeapInfo() : WeaponInfo { return null; }
            public function set currentWeapInfo(value:WeaponInfo) : void { }
            public function get currentBomb() : int { return 0; }
            public function set currentBomb(value:int) : void { }
            override public function beginNewTurn() : void { }
            override public function die(widthAction:Boolean = true) : void { }
            public function doAction(type:*) : void { }
            override public function isPlayer() : Boolean { return false; }
            protected function setWeaponInfo() : void { }
            public function setDeputyWeaponInfo() : void { }
            public function get currentDeputyWeaponInfo() : DeputyWeaponInfo { return null; }
            public function hasDeputyWeapon() : Boolean { return false; }
            private function __playerPropChanged(event:PlayerPropertyEvent) : void { }
            public function get isReady() : Boolean { return false; }
            public function set isReady(value:Boolean) : void { }
            override public function updateBlood(value:Number, type:int, addVlaue:int = 0) : void { }
            public function get turnTime() : int { return 0; }
            public function set turnTime(val:int) : void { }
            public function get reverse() : int { return 0; }
            public function set reverse(val:int) : void { }
            public function get isAutoGuide() : Boolean { return false; }
            public function set isAutoGuide(value:Boolean) : void { }
            public function get currentPet() : Pet { return null; }
            public function set currentPet(val:Pet) : void { }
            private function onUsePetSkill(event:LivingEvent) : void { }
            public function usePetSkill(skillID:int, isUsed:Boolean) : void { }
            public function useHorseSkill(skillID:int, isUsed:Boolean, restCount:int) : void { }
            public function petBeat(act:String, pt:Point, targets:Array) : void { }
            public function clone(livingId:int = 0) : Player { return null; }
   }}