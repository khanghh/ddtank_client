package gameCommon.model
{
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffType;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   import ddt.manager.LogManager;
   import ddt.view.character.ICharacter;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import game.actions.ActionManager;
   import gameCommon.BuffManager;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.event.LivingCommandEvent;
   import gameCommon.interfaces.ICommandedAble;
   import gameCommon.view.buff.FightContainerBuff;
   import gameCommon.view.effects.BaseMirariEffectIcon;
   import road7th.data.DictionaryData;
   import road7th.data.StringObject;
   
   [Event(name="posChanged",type="ddt.events.LivingEvent")]
   [Event(name="dirChanged",type="ddt.events.LivingEvent")]
   [Event(name="forzenChanged",type="ddt.events.LivingEvent")]
   [Event(name="hiddenChanged",type="ddt.events.LivingEvent")]
   [Event(name="noholeChanged",type="ddt.events.LivingEvent")]
   [Event(name="die",type="ddt.events.LivingEvent")]
   [Event(name="angleChanged",type="ddt.events.LivingEvent")]
   [Event(name="bloodChanged",type="ddt.events.LivingEvent")]
   [Event(name="beginNewTurn",type="ddt.events.LivingEvent")]
   [Event(name="shoot",type="ddt.events.LivingEvent")]
   [Event(name="beat",type="ddt.events.LivingEvent")]
   [Event(name="transmit",type="ddt.events.LivingEvent")]
   [Event(name="moveTo",type="ddt.events.LivingEvent")]
   [Event(name="fall",type="ddt.events.LivingEvent")]
   [Event(name="jump",type="ddt.events.LivingEvent")]
   [Event(name="say",type="ddt.events.LivingEvent")]
   public class Living extends EventDispatcher implements ICommandedAble
   {
      
      public static const CRY_ACTION:String = "cry";
      
      public static const STAND_ACTION:String = "stand";
      
      public static const DIE_ACTION:String = "die";
      
      public static const SHOOT_ACTION:String = "beat2";
      
      public static const BORN_ACTION:String = "born";
      
      public static const RENEW:String = "renew";
      
      public static const ANGRY_ACTION:String = "angry";
      
      public static const WALK_ACTION:String = "walk";
      
      public static const DEFENCE_ACTION:String = "shield";
      
      public static const ADD_BLOOD:int = 0;
      
      public static const SUICIDE:int = 6;
      
      public static const WOUND:int = 3;
      
      public static const FLASH_BACK:int = 7;
      
      public static const BEING_KILLED_ADD_BLOOD:int = 12;
       
      
      public var character:ICharacter;
      
      public var typeLiving:int;
      
      private var _state:int = 0;
      
      private var _onChange:Boolean;
      
      private var _mirariEffects:DictionaryData;
      
      private var _localBuffs:Vector.<FightBuffInfo>;
      
      private var _turnBuffs:Vector.<FightBuffInfo>;
      
      private var _petBuffs:Vector.<FightBuffInfo>;
      
      private var _barBuffs:Vector.<FightBuffInfo>;
      
      public var outTurnBuffs:Vector.<FightBuffInfo>;
      
      private var _headTopAddIcon:DictionaryData;
      
      private var _noPicPetBuff:DictionaryData;
      
      public var maxEnergy:int = 240;
      
      public var isExist:Boolean = true;
      
      public var isBottom:Boolean;
      
      public var isLocked:Boolean;
      
      private var _fightPower:Number;
      
      private var _currentSelectId:int;
      
      public var state:Boolean;
      
      private var _damageNum:int;
      
      private var _templeId:int;
      
      public var wishFreeTime:int = 3;
      
      private var _isLockFly:Boolean = false;
      
      private var _isLockAngle:Boolean;
      
      private var _payBuff:FightContainerBuff;
      
      private var _consortiaBuff:FightContainerBuff;
      
      private var _cardBuff:FightContainerBuff;
      
      private var _name:String = "";
      
      private var _livingID:int;
      
      private var _team:int;
      
      private var _fallingType:int = 0;
      
      protected var _pos:Point;
      
      protected var _isShowBlood:Boolean = true;
      
      protected var _isShowSmallMapPoint:Boolean = true;
      
      private var _direction:int = 1;
      
      private var _maxBlood:int;
      
      private var _blood:Number;
      
      private var _isFrozen:Boolean;
      
      private var _isGemGlow:Boolean;
      
      private var _gemDefense:Boolean;
      
      private var _isHidden:Boolean;
      
      private var _removeStealth:Boolean;
      
      private var _isFog:Boolean;
      
      private var _backEffFog:Boolean;
      
      private var _backEffRadius:Number = -1;
      
      private var _isRedSkull:Boolean;
      
      private var _isNoNole:Boolean;
      
      protected var _lockState:Boolean;
      
      protected var _lockType:int = 1;
      
      protected var _isLiving:Boolean;
      
      private var _playerAngle:Number = 0;
      
      private var _actionMovieName:String = "";
      
      private var _actionBonesMovieName:String = "";
      
      private var _isMoving:Boolean;
      
      public var isFalling:Boolean;
      
      private var _actionManager:ActionManager;
      
      private var _actionMovie:Bitmap;
      
      private var _thumbnail:BitmapData;
      
      private var _currentShootList:Array;
      
      private var _defaultAction:String = "";
      
      private var _cmdList:Dictionary;
      
      public var outProperty:Dictionary;
      
      private var _markMeHide:Boolean;
      
      private var _markMeHideDest:Boolean;
      
      private var _shootInterval:int = 24;
      
      protected var _psychic:int = 0;
      
      protected var _energy:Number = 1;
      
      private var _forbidMoving:Boolean = false;
      
      private var _currentAction:String;
      
      private var _turnCount:int;
      
      private var _skillBuffIcon:int;
      
      private var _iconState:Boolean;
      
      private var _showSolidIce:Boolean = false;
      
      private var _isDamageAverageState:Boolean = false;
      
      private var _damageId:int = 20070;
      
      private var _isNotSkillHeathState:Boolean = false;
      
      private var _despairId:int = 20060;
      
      private var _isRemoveStealth:Boolean = false;
      
      private var _eyeId:int = 20050;
      
      private var _showDisturb:Boolean = false;
      
      private var _notHasFairBattleSkill:Boolean = false;
      
      private var _noUseCritical:Boolean = false;
      
      public var route:Vector.<Point>;
      
      public var autoOnHook:Boolean = false;
      
      public function Living(param1:int, param2:int, param3:int, param4:int = 0){super();}
      
      public function get MirariEffects() : DictionaryData{return null;}
      
      public function get fightPower() : Number{return 0;}
      
      public function set fightPower(param1:Number) : void{}
      
      public function get currentSelectId() : int{return 0;}
      
      public function set currentSelectId(param1:int) : void{}
      
      public function get isBoss() : Boolean{return false;}
      
      public function resetWithinTheMap() : void{}
      
      public function reset() : void{}
      
      public function clearEffectIcon() : void{}
      
      public function set isLockFly(param1:Boolean) : void{}
      
      public function get isLockFly() : Boolean{return false;}
      
      public function get isLockAngle() : Boolean{return false;}
      
      public function set isLockAngle(param1:Boolean) : void{}
      
      public function hasEffect(param1:BaseMirariEffectIcon) : Boolean{return false;}
      
      public function get localBuffs() : Vector.<FightBuffInfo>{return null;}
      
      public function get turnBuffs() : Vector.<FightBuffInfo>{return null;}
      
      public function set turnBuffs(param1:Vector.<FightBuffInfo>) : void{}
      
      public function get petBuffs() : Vector.<FightBuffInfo>{return null;}
      
      public function get barBuffs() : Vector.<FightBuffInfo>{return null;}
      
      private function addPayBuff(param1:FightBuffInfo) : void{}
      
      private function addConsortiaBuff(param1:FightBuffInfo) : void{}
      
      private function addCardBuff(param1:FightBuffInfo) : void{}
      
      public function updateBuff(param1:FightBuffInfo, param2:Vector.<FightBuffInfo>) : void{}
      
      public function addBuff(param1:FightBuffInfo) : void{}
      
      public function addPetBuff(param1:FightBuffInfo) : void{}
      
      public function removePetBuff(param1:FightBuffInfo) : void{}
      
      private function hasBuff(param1:FightBuffInfo, param2:Vector.<FightBuffInfo>) : Boolean{return false;}
      
      public function getBuffByID(param1:int) : FightBuffInfo{return null;}
      
      public function removeBuff(param1:int) : void{}
      
      protected function buffCompare(param1:FightBuffInfo, param2:FightBuffInfo) : Number{return 0;}
      
      public function handleMirariEffect(param1:BaseMirariEffectIcon) : void{}
      
      public function removeMirariEffect(param1:BaseMirariEffectIcon) : void{}
      
      public function dispose() : void{}
      
      public function set name(param1:String) : void{}
      
      public function get name() : String{return null;}
      
      public function get LivingID() : int{return 0;}
      
      public function get team() : int{return 0;}
      
      public function set team(param1:int) : void{}
      
      public function set fallingType(param1:int) : void{}
      
      public function get fallingType() : int{return 0;}
      
      public function get onChange() : Boolean{return false;}
      
      public function set onChange(param1:Boolean) : void{}
      
      public function get pos() : Point{return null;}
      
      public function set pos(param1:Point) : void{}
      
      public function get isShowBlood() : Boolean{return false;}
      
      public function set isShowBlood(param1:Boolean) : void{}
      
      public function get isShowSmallMapPoint() : Boolean{return false;}
      
      public function set isShowSmallMapPoint(param1:Boolean) : void{}
      
      public function get direction() : int{return 0;}
      
      public function set direction(param1:int) : void{}
      
      public function get maxBlood() : int{return 0;}
      
      public function set maxBlood(param1:int) : void{}
      
      public function get blood() : Number{return 0;}
      
      public function set blood(param1:Number) : void{}
      
      public function initBlood(param1:int) : void{}
      
      public function get isFrozen() : Boolean{return false;}
      
      public function set isFrozen(param1:Boolean) : void{}
      
      public function get isGemGlow() : Boolean{return false;}
      
      public function set isGemGlow(param1:Boolean) : void{}
      
      public function get gemDefense() : Boolean{return false;}
      
      public function set gemDefense(param1:Boolean) : void{}
      
      public function get isHidden() : Boolean{return false;}
      
      public function set isHidden(param1:Boolean) : void{}
      
      public function get removeStealth() : Boolean{return false;}
      
      public function set removeStealth(param1:Boolean) : void{}
      
      public function get isFog() : Boolean{return false;}
      
      public function set isFog(param1:Boolean) : void{}
      
      public function get backEffFog() : Boolean{return false;}
      
      public function set updateBackFog(param1:Number) : void{}
      
      public function get backEffRadius() : Number{return 0;}
      
      public function get isRedSkull() : Boolean{return false;}
      
      public function set isRedSkull(param1:Boolean) : void{}
      
      public function get isNoNole() : Boolean{return false;}
      
      public function set isNoNole(param1:Boolean) : void{}
      
      public function set LockState(param1:Boolean) : void{}
      
      public function get LockState() : Boolean{return false;}
      
      public function set LockType(param1:int) : void{}
      
      public function get LockType() : int{return 0;}
      
      public function get isLiving() : Boolean{return false;}
      
      public function die(param1:Boolean = true) : void{}
      
      public function revive() : void{}
      
      public function get playerAngle() : Number{return 0;}
      
      public function set playerAngle(param1:Number) : void{}
      
      public function get actionMovieName() : String{return null;}
      
      public function set actionMovieName(param1:String) : void{}
      
      public function get actionBonesMovieName() : String{return null;}
      
      public function get isMoving() : Boolean{return false;}
      
      public function set isMoving(param1:Boolean) : void{}
      
      public function updateBlood(param1:Number, param2:int, param3:int = 0) : void{}
      
      public function get actionCount() : int{return 0;}
      
      public function traceCurrentAction() : void{}
      
      public function act(param1:BaseAction) : void{}
      
      public function update() : void{}
      
      public function actionManagerClear() : void{}
      
      public function excuteAtOnce() : void{}
      
      public function set actionMovieBitmap(param1:Bitmap) : void{}
      
      public function get actionMovieBitmap() : Bitmap{return null;}
      
      public function isPlayer() : Boolean{return false;}
      
      public function get isSelf() : Boolean{return false;}
      
      public function get playerInfo() : PlayerInfo{return null;}
      
      public function startMoving() : void{}
      
      public function beginNewTurn() : void{}
      
      public function get currentShootList() : Array{return null;}
      
      public function shoot(param1:Array, param2:CrazyTankSocketEvent) : void{}
      
      public function beat(param1:Array) : void{}
      
      public function beatenBy(param1:Living) : void{}
      
      private function __beatenBy(param1:LivingEvent) : void{}
      
      public function transmit(param1:Point) : void{}
      
      public function showAttackEffect(param1:int) : void{}
      
      public function showDeadEffect(param1:String, param2:Function, param3:Object) : void{}
      
      public function moveTo(param1:Number, param2:Point, param3:Number, param4:Boolean, param5:String = "", param6:int = 3, param7:String = "") : void{}
      
      public function changePos(param1:Point, param2:String = "") : void{}
      
      public function fallTo(param1:Point, param2:int, param3:String = "", param4:int = 0) : void{}
      
      public function jumpTo(param1:Point, param2:int, param3:String = "", param4:int = 0) : void{}
      
      public function set State(param1:int) : void{}
      
      public function get State() : int{return 0;}
      
      public function say(param1:String, param2:int = 0) : void{}
      
      public function playMovie(param1:String, param2:Function = null, param3:Array = null) : void{}
      
      public function turnRotation(param1:int, param2:int, param3:String) : void{}
      
      public function set defaultAction(param1:String) : void{}
      
      public function get defaultAction() : String{return null;}
      
      public function doDefaultAction() : void{}
      
      public function pick(param1:Object) : void{}
      
      private function cmdX(param1:int) : void{}
      
      public function get commandList() : Dictionary{return null;}
      
      public function initCommand() : void{}
      
      public function command(param1:String, param2:*) : Boolean{return false;}
      
      public function sendCommand(param1:String, param2:Object = null) : void{}
      
      public function setProperty(param1:String, param2:String) : void{}
      
      public function set markMeHide(param1:Boolean) : void{}
      
      public function get markMeHide() : Boolean{return false;}
      
      public function set markMeHideDest(param1:Boolean) : void{}
      
      public function get markMeHideDest() : Boolean{return false;}
      
      public function bomd() : void{}
      
      public function showEffect(param1:String) : void{}
      
      public function showBuffEffect(param1:String, param2:int) : void{}
      
      public function removeBuffEffect(param1:int) : void{}
      
      public function removeSkillMovie(param1:int) : void{}
      
      public function applySkill(param1:int, ... rest) : void{}
      
      public function get shootInterval() : int{return 0;}
      
      public function set shootInterval(param1:int) : void{}
      
      public function get maxPsychic() : int{return 0;}
      
      public function get psychic() : int{return 0;}
      
      public function set psychic(param1:int) : void{}
      
      public function get energy() : Number{return 0;}
      
      public function set energy(param1:Number) : void{}
      
      public function get forbidMoving() : Boolean{return false;}
      
      public function set forbidMoving(param1:Boolean) : void{}
      
      public function get thumbnail() : BitmapData{return null;}
      
      public function set thumbnail(param1:BitmapData) : void{}
      
      public function set currentAction(param1:String) : void{}
      
      public function get currentAction() : String{return null;}
      
      public function get damageNum() : int{return 0;}
      
      public function set damageNum(param1:int) : void{}
      
      public function get templeId() : int{return 0;}
      
      public function get turnCount() : int{return 0;}
      
      public function set turnCount(param1:int) : void{}
      
      public function set skillEffectPic(param1:StringObject) : void{}
      
      public function set showSolidIce(param1:Boolean) : void{}
      
      public function get showSolidIce() : Boolean{return false;}
      
      public function set isDamageAverageState(param1:Boolean) : void{}
      
      public function get isDamageAverageState() : Boolean{return false;}
      
      public function set isNotSkillHeathState(param1:Boolean) : void{}
      
      public function get isNotSkillHeathState() : Boolean{return false;}
      
      public function set isRemoveStealth(param1:Boolean) : void{}
      
      public function get isRemoveStealth() : Boolean{return false;}
      
      public function set showDisturb(param1:Boolean) : void{}
      
      public function get showDisturb() : Boolean{return false;}
      
      public function set notHasFairBattleSkill(param1:Boolean) : void{}
      
      public function get notHasFairBattleSkill() : Boolean{return false;}
      
      public function set noUseCritical(param1:Boolean) : void{}
      
      public function get noUseCritical() : Boolean{return false;}
   }
}
