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
      
      public function Living(param1:int, param2:int, param3:int, param4:int = 0)
      {
         _localBuffs = new Vector.<FightBuffInfo>();
         _turnBuffs = new Vector.<FightBuffInfo>();
         _petBuffs = new Vector.<FightBuffInfo>();
         _barBuffs = new Vector.<FightBuffInfo>();
         outTurnBuffs = new Vector.<FightBuffInfo>();
         _noPicPetBuff = new DictionaryData();
         _pos = new Point(0,0);
         super();
         _livingID = param1;
         _team = param2;
         _maxBlood = param3;
         _actionManager = new ActionManager();
         _mirariEffects = new DictionaryData();
         _templeId = param4;
         reset();
      }
      
      public function get MirariEffects() : DictionaryData
      {
         return _mirariEffects;
      }
      
      public function get fightPower() : Number
      {
         return _fightPower;
      }
      
      public function set fightPower(param1:Number) : void
      {
         _fightPower = param1;
         dispatchEvent(new LivingEvent("fightPowerChange"));
      }
      
      public function get currentSelectId() : int
      {
         return _currentSelectId;
      }
      
      public function set currentSelectId(param1:int) : void
      {
         _currentSelectId = param1;
         dispatchEvent(new LivingEvent("wishSelectChange"));
      }
      
      public function get isBoss() : Boolean
      {
         return typeLiving == 4 || typeLiving == 5;
      }
      
      public function resetWithinTheMap() : void
      {
         _isFrozen = false;
         _gemDefense = false;
         _isHidden = false;
         _isNoNole = false;
         isLockAngle = false;
      }
      
      public function reset() : void
      {
         _blood = _maxBlood;
         _isLiving = true;
         _isFrozen = false;
         _gemDefense = false;
         _isHidden = false;
         _isNoNole = false;
         isLockAngle = false;
         _headTopAddIcon = new DictionaryData();
         _headTopAddIcon["showProvoke1"] = 20530;
         _headTopAddIcon["showProvoke2"] = 20531;
         _headTopAddIcon["showImprisonment"] = 20510;
         _headTopAddIcon["showBlind"] = 20520;
         _localBuffs = new Vector.<FightBuffInfo>();
         _turnBuffs = new Vector.<FightBuffInfo>();
         _petBuffs = new Vector.<FightBuffInfo>();
         _barBuffs = new Vector.<FightBuffInfo>();
         outTurnBuffs = new Vector.<FightBuffInfo>();
         ObjectUtils.disposeObject(_payBuff);
         _payBuff = null;
         ObjectUtils.disposeObject(_consortiaBuff);
         _consortiaBuff = null;
         ObjectUtils.disposeObject(_cardBuff);
         _cardBuff = null;
         _currentShootList = null;
      }
      
      public function clearEffectIcon() : void
      {
         _mirariEffects.clear();
      }
      
      public function set isLockFly(param1:Boolean) : void
      {
         _isLockFly = param1;
         dispatchEvent(new LivingEvent("lockFlyChanged",0,0,_isLockFly));
      }
      
      public function get isLockFly() : Boolean
      {
         return _isLockFly;
      }
      
      public function get isLockAngle() : Boolean
      {
         return _isLockAngle;
      }
      
      public function set isLockAngle(param1:Boolean) : void
      {
         if(_isLockAngle == param1)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(_isLockAngle)
         {
            _loc3_ = 1;
         }
         if(param1)
         {
            _loc2_ = 1;
         }
         _isLockAngle = param1;
         dispatchEvent(new LivingEvent("lockAngleChange",_loc2_,_loc3_));
      }
      
      public function hasEffect(param1:BaseMirariEffectIcon) : Boolean
      {
         return _mirariEffects[param1.mirariType] != null;
      }
      
      public function get localBuffs() : Vector.<FightBuffInfo>
      {
         return _localBuffs;
      }
      
      public function get turnBuffs() : Vector.<FightBuffInfo>
      {
         return _turnBuffs;
      }
      
      public function set turnBuffs(param1:Vector.<FightBuffInfo>) : void
      {
         _turnBuffs = param1;
      }
      
      public function get petBuffs() : Vector.<FightBuffInfo>
      {
         return _petBuffs;
      }
      
      public function get barBuffs() : Vector.<FightBuffInfo>
      {
         return _barBuffs;
      }
      
      private function addPayBuff(param1:FightBuffInfo) : void
      {
         if(_payBuff == null)
         {
            _payBuff = new FightContainerBuff(-1);
            _localBuffs.unshift(_payBuff);
         }
         _payBuff.addFightBuff(param1);
      }
      
      private function addConsortiaBuff(param1:FightBuffInfo) : void
      {
         if(_consortiaBuff == null)
         {
            _consortiaBuff = new FightContainerBuff(-1,3);
            _localBuffs.unshift(_consortiaBuff);
         }
         _consortiaBuff.addFightBuff(param1);
      }
      
      private function addCardBuff(param1:FightBuffInfo) : void
      {
         if(_cardBuff == null)
         {
            _cardBuff = new FightContainerBuff(-1,4);
            _localBuffs.unshift(_cardBuff);
         }
         _cardBuff.addFightBuff(param1);
      }
      
      public function updateBuff(param1:FightBuffInfo, param2:Vector.<FightBuffInfo>) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = param2;
         for each(var _loc3_ in param2)
         {
            if(_loc3_.id == param1.id)
            {
               _loc3_.Count = param1.Count;
               return;
            }
         }
      }
      
      public function addBuff(param1:FightBuffInfo) : void
      {
         param1.isSelf = isSelf;
         if(BuffType.isPayBuff(param1.id))
         {
            addPayBuff(param1);
            return;
         }
         if(BuffManager.isConsortiaBuff(param1))
         {
            addConsortiaBuff(param1);
            return;
         }
         if(BuffManager.isCardBuff(param1))
         {
            addCardBuff(param1);
            return;
         }
         if(param1.type == 1)
         {
            _localBuffs.push(param1);
         }
         else if(param1.type == 6)
         {
            if(BuffManager.buffTemplateData.hasKey(param1.id))
            {
               if(param1.showType == 1)
               {
                  if(hasBuff(param1,_barBuffs))
                  {
                     updateBuff(param1,_barBuffs);
                  }
                  else
                  {
                     _barBuffs.push(param1);
                  }
               }
               else
               {
                  if(hasBuff(param1,_turnBuffs))
                  {
                     return;
                  }
                  _turnBuffs.push(param1);
               }
            }
         }
         else
         {
            if(hasBuff(param1,_turnBuffs))
            {
               return;
            }
            _turnBuffs.push(param1);
         }
         param1.execute(this);
         dispatchEvent(new LivingEvent("buffChanged",0,0,param1.type,param1));
      }
      
      public function addPetBuff(param1:FightBuffInfo) : void
      {
         var _loc3_:Boolean = false;
         if(param1.buffPic != "-1")
         {
            _loc3_ = false;
            var _loc5_:int = 0;
            var _loc4_:* = _petBuffs;
            for each(var _loc2_ in _petBuffs)
            {
               if(_loc2_.id == param1.id)
               {
                  _loc2_.Count = Number(_loc2_.Count) + 1;
                  _loc3_ = true;
                  break;
               }
            }
            if(!_loc3_)
            {
               _petBuffs.push(param1);
            }
         }
         else
         {
            _noPicPetBuff.add(param1.id,true);
         }
         param1.execute(this);
         dispatchEvent(new LivingEvent("buffChanged",0,0,param1.type,param1));
      }
      
      public function removePetBuff(param1:FightBuffInfo) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = _petBuffs.length;
         var _loc2_:int = param1.id;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_petBuffs[_loc4_].id == _loc2_)
            {
               _petBuffs[_loc4_].unExecute(this);
               _petBuffs.splice(_loc4_,1);
               dispatchEvent(new LivingEvent("buffChanged",0,0,param1.type,param1));
               break;
            }
            _loc4_++;
         }
         if(param1.buffPic == "-1" && _noPicPetBuff[param1.id])
         {
            _noPicPetBuff.remove(param1.id);
            param1.unExecute(this);
         }
      }
      
      private function hasBuff(param1:FightBuffInfo, param2:Vector.<FightBuffInfo>) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:* = param2;
         for each(var _loc3_ in param2)
         {
            if(_loc3_.id == param1.id)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getBuffByID(param1:int) : FightBuffInfo
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _petBuffs;
         for each(_loc2_ in _petBuffs)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         var _loc6_:int = 0;
         var _loc5_:* = _localBuffs;
         for each(_loc2_ in _localBuffs)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         var _loc8_:int = 0;
         var _loc7_:* = _turnBuffs;
         for each(_loc2_ in _turnBuffs)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function removeBuff(param1:int) : void
      {
         var _loc2_:* = undefined;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         if(BuffManager.buffTemplateData.hasKey(param1))
         {
            _loc5_ = BuffManager.buffTemplateData[param1] as GameBuffInfo;
            if(_loc5_.ShowType == 0)
            {
               _loc2_ = _turnBuffs;
            }
            else
            {
               _loc2_ = _barBuffs;
            }
            _loc6_ = _loc5_.Type;
         }
         else if(BuffType.isLocalBuffByID(param1))
         {
            _loc2_ = _localBuffs;
            _loc6_ = 1;
         }
         else
         {
            _loc2_ = _turnBuffs;
            _loc6_ = 0;
         }
         var _loc4_:int = _loc2_.length;
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            if(_loc2_[_loc7_].id == param1)
            {
               _loc3_ = _loc2_[_loc7_];
               _loc3_.Count = 0;
               _loc2_[_loc7_].unExecute(this);
               _loc2_.splice(_loc7_,1);
               if(_loc6_ == 1)
               {
                  _localBuffs = _localBuffs.sort(buffCompare);
               }
               else if(_loc6_ == 6)
               {
                  _barBuffs = _barBuffs.sort(buffCompare);
               }
               else
               {
                  _turnBuffs = _turnBuffs.sort(buffCompare);
               }
               dispatchEvent(new LivingEvent("buffChanged",0,0,_loc6_,_loc3_));
               break;
            }
            _loc7_++;
         }
      }
      
      protected function buffCompare(param1:FightBuffInfo, param2:FightBuffInfo) : Number
      {
         if(param1.priority == param2.priority)
         {
            return 0;
         }
         if(param1.priority < param2.priority)
         {
            return 1;
         }
         return -1;
      }
      
      public function handleMirariEffect(param1:BaseMirariEffectIcon) : void
      {
         if(param1.single)
         {
            if(!hasEffect(param1))
            {
               _mirariEffects.add(param1.mirariType,param1);
            }
         }
         else
         {
            _mirariEffects.add(param1.mirariType,param1);
         }
         param1.excuteEffect(this);
      }
      
      public function removeMirariEffect(param1:BaseMirariEffectIcon) : void
      {
         param1.dispose();
         _mirariEffects.remove(param1.mirariType);
         param1.unExcuteEffect(this);
      }
      
      public function dispose() : void
      {
         isExist = false;
         if(_actionMovie)
         {
            if(_actionMovie.parent)
            {
               _actionMovie.parent.removeChild(_actionMovie);
            }
            _actionMovie.bitmapData.dispose();
         }
         _actionMovie = null;
         if(_thumbnail)
         {
            _thumbnail.dispose();
         }
         _thumbnail = null;
         character = null;
         if(_mirariEffects)
         {
            _mirariEffects.clear();
         }
         _mirariEffects = null;
         if(_actionManager)
         {
            _actionManager.clear();
         }
         _actionManager = null;
         _currentShootList = null;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get LivingID() : int
      {
         return _livingID;
      }
      
      public function get team() : int
      {
         return _team;
      }
      
      public function set team(param1:int) : void
      {
         _team = param1;
      }
      
      public function set fallingType(param1:int) : void
      {
         _fallingType = 0;
      }
      
      public function get fallingType() : int
      {
         return _fallingType;
      }
      
      public function get onChange() : Boolean
      {
         return _onChange;
      }
      
      public function set onChange(param1:Boolean) : void
      {
         _onChange = param1;
      }
      
      public function get pos() : Point
      {
         return _pos;
      }
      
      public function set pos(param1:Point) : void
      {
         if(!param1)
         {
            return;
         }
         if(_pos.equals(param1) == false)
         {
            _pos = param1;
            dispatchEvent(new LivingEvent("posChanged"));
         }
      }
      
      public function get isShowBlood() : Boolean
      {
         return _isShowBlood;
      }
      
      public function set isShowBlood(param1:Boolean) : void
      {
         _isShowBlood = param1;
      }
      
      public function get isShowSmallMapPoint() : Boolean
      {
         return _isShowSmallMapPoint;
      }
      
      public function set isShowSmallMapPoint(param1:Boolean) : void
      {
         _isShowSmallMapPoint = param1;
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function set direction(param1:int) : void
      {
         if(_direction == param1)
         {
            return;
         }
         _direction = param1;
         sendCommand("changeDir");
         dispatchEvent(new LivingEvent("dirChanged"));
      }
      
      public function get maxBlood() : int
      {
         return _maxBlood;
      }
      
      public function set maxBlood(param1:int) : void
      {
         _maxBlood = param1;
         dispatchEvent(new LivingEvent("maxHpChanged"));
      }
      
      public function get blood() : Number
      {
         return _blood;
      }
      
      public function set blood(param1:Number) : void
      {
         _blood = param1 > maxBlood?maxBlood:param1;
      }
      
      public function initBlood(param1:int) : void
      {
         blood = param1;
         dispatchEvent(new LivingEvent("bloodChanged",param1,0,5));
      }
      
      public function get isFrozen() : Boolean
      {
         return _isFrozen;
      }
      
      public function set isFrozen(param1:Boolean) : void
      {
         if(_isFrozen == param1)
         {
            return;
         }
         _isFrozen = param1;
         dispatchEvent(new LivingEvent("forzenChanged"));
      }
      
      public function get isGemGlow() : Boolean
      {
         return _isGemGlow;
      }
      
      public function set isGemGlow(param1:Boolean) : void
      {
         if(_isGemGlow != param1)
         {
            _isGemGlow = param1;
            dispatchEvent(new LivingEvent("gemGlowChanged"));
         }
      }
      
      public function get gemDefense() : Boolean
      {
         return _gemDefense;
      }
      
      public function set gemDefense(param1:Boolean) : void
      {
         if(_gemDefense == param1)
         {
            return;
         }
         _gemDefense = param1;
         dispatchEvent(new LivingEvent("gemDefenseChanged"));
      }
      
      public function get isHidden() : Boolean
      {
         if(isFog)
         {
            return isFog;
         }
         if(removeStealth)
         {
            return !removeStealth;
         }
         return _isHidden;
      }
      
      public function set isHidden(param1:Boolean) : void
      {
         if(param1 == _isHidden)
         {
            return;
         }
         _isHidden = param1;
         dispatchEvent(new LivingEvent("hiddenChanged"));
      }
      
      public function get removeStealth() : Boolean
      {
         return _removeStealth;
      }
      
      public function set removeStealth(param1:Boolean) : void
      {
         if(_removeStealth == param1)
         {
            return;
         }
         _removeStealth = param1;
         dispatchEvent(new LivingEvent("hiddenChanged"));
      }
      
      public function get isFog() : Boolean
      {
         return _isFog;
      }
      
      public function set isFog(param1:Boolean) : void
      {
         if(param1 == _isFog)
         {
            return;
         }
         _isFog = param1;
         dispatchEvent(new LivingEvent("hiddenChanged"));
      }
      
      public function get isRedSkull() : Boolean
      {
         return _isRedSkull;
      }
      
      public function set isRedSkull(param1:Boolean) : void
      {
         if(param1 == _isRedSkull)
         {
            return;
         }
         _isRedSkull = param1;
         dispatchEvent(new LivingEvent("isRedSkullChange"));
      }
      
      public function get isNoNole() : Boolean
      {
         return _isNoNole;
      }
      
      public function set isNoNole(param1:Boolean) : void
      {
         if(_isNoNole != param1)
         {
            _isNoNole = param1;
            if(_isNoNole)
            {
               addBuff(BuffManager.creatBuff(5));
            }
            else
            {
               removeBuff(5);
            }
         }
      }
      
      public function set LockState(param1:Boolean) : void
      {
         if(_lockState != param1)
         {
            _lockState = param1;
            if(_lockState)
            {
               if(LockType == 1 || LockType == 2 || LockType == 3)
               {
                  addBuff(BuffManager.creatBuff(1000));
               }
            }
            else
            {
               removeBuff(1000);
            }
         }
      }
      
      public function get LockState() : Boolean
      {
         return _lockState;
      }
      
      public function set LockType(param1:int) : void
      {
         _lockType = param1;
      }
      
      public function get LockType() : int
      {
         return _lockType;
      }
      
      public function get isLiving() : Boolean
      {
         return _isLiving;
      }
      
      public function die(param1:Boolean = true) : void
      {
         if(_isLiving)
         {
            _isLiving = false;
            dispatchEvent(new LivingEvent("die",0,0,param1));
            _turnBuffs = new Vector.<FightBuffInfo>();
            dispatchEvent(new LivingEvent("buffChanged",0,0,0,null));
         }
      }
      
      public function revive() : void
      {
         _isLiving = true;
         _isFrozen = false;
         _gemDefense = false;
         _isHidden = false;
         _isNoNole = false;
         isLockAngle = false;
      }
      
      public function get playerAngle() : Number
      {
         return _playerAngle;
      }
      
      public function set playerAngle(param1:Number) : void
      {
         _playerAngle = param1;
         dispatchEvent(new LivingEvent("angleChanged"));
      }
      
      public function get actionMovieName() : String
      {
         return _actionMovieName;
      }
      
      public function set actionMovieName(param1:String) : void
      {
         _actionMovieName = param1;
         _actionBonesMovieName = _actionMovieName.replace(/\./g,"_");
      }
      
      public function get actionBonesMovieName() : String
      {
         return _actionBonesMovieName;
      }
      
      public function get isMoving() : Boolean
      {
         return _isMoving;
      }
      
      public function set isMoving(param1:Boolean) : void
      {
         _isMoving = param1;
      }
      
      public function updateBlood(param1:Number, param2:int, param3:int = 0) : void
      {
         var _loc6_:Number = NaN;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         trace("actionMovieName:" + actionMovieName + ",ID:" + LivingID + ",type:" + param2 + ",value:" + param1 + ",addVlaue:" + param3);
         LogManager.getInstance().sendLog(this.actionMovieName);
         if(!isLiving)
         {
            return;
         }
         if(param2 == 3)
         {
            _blood = param1;
            dispatchEvent(new LivingEvent("bloodChanged",param1,_blood,param2,param3));
         }
         else if(param2 == 7)
         {
            _loc6_ = _blood;
            _blood = _blood - param3;
            dispatchEvent(new LivingEvent("bloodChanged",_blood,_loc6_,param2,param3));
         }
         else
         {
            if(param2 == 12)
            {
               param2 = 0;
               if(ModuleLoader.hasDefinition("asset.game.skill.effect.effect082"))
               {
                  showBuffEffect("asset.game.skill.effect.effect082",408);
               }
               _loc5_ = getBuffByID(1435);
               if(_loc5_ == null)
               {
                  _loc5_ = getBuffByID(1514);
               }
               if(_loc5_ && param3 > 0)
               {
                  var _loc7_:* = _loc5_.Count - 1;
                  _loc5_.Count = _loc7_;
                  _loc5_.Count = Math.max(0,_loc7_);
                  dispatchEvent(new LivingEvent("buffChanged",0,0,_loc5_.type,_loc5_));
               }
            }
            if(_blood != param1 || GameControl.Instance.Current.gameMode == 17)
            {
               _loc4_ = _blood;
               blood = param1;
               if(param2 != 6 && _isLiving)
               {
                  dispatchEvent(new LivingEvent("bloodChanged",param1,_loc4_,param2,param3));
               }
            }
            else if(param2 == 0 && param1 >= _blood)
            {
               dispatchEvent(new LivingEvent("bloodChanged",param1,_blood,param2,param3));
            }
         }
         if(_blood <= 0)
         {
            _blood = 0;
            die(param2 != 6);
         }
      }
      
      public function get actionCount() : int
      {
         if(_actionManager)
         {
            return _actionManager.actionCount;
         }
         return 0;
      }
      
      public function traceCurrentAction() : void
      {
         _actionManager.traceAllRemainAction();
      }
      
      public function act(param1:BaseAction) : void
      {
         _actionManager.act(param1);
      }
      
      public function update() : void
      {
         if(_actionManager != null)
         {
            _actionManager.execute();
         }
      }
      
      public function actionManagerClear() : void
      {
         _actionManager.clear();
      }
      
      public function excuteAtOnce() : void
      {
         _actionManager.executeAtOnce();
         _actionManager.clear();
      }
      
      public function set actionMovieBitmap(param1:Bitmap) : void
      {
         _actionMovie = param1;
      }
      
      public function get actionMovieBitmap() : Bitmap
      {
         return _actionMovie;
      }
      
      public function isPlayer() : Boolean
      {
         return false;
      }
      
      public function get isSelf() : Boolean
      {
         return false;
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return null;
      }
      
      public function startMoving() : void
      {
         dispatchEvent(new LivingEvent("startMoving"));
      }
      
      public function beginNewTurn() : void
      {
         dispatchEvent(new LivingEvent("beginNewTurn"));
      }
      
      public function get currentShootList() : Array
      {
         return _currentShootList;
      }
      
      public function shoot(param1:Array, param2:CrazyTankSocketEvent) : void
      {
         _currentShootList = param1;
         dispatchEvent(new LivingEvent("shoot",0,0,param1,param2));
      }
      
      public function beat(param1:Array) : void
      {
         dispatchEvent(new LivingEvent("beat",0,0,param1));
      }
      
      public function beatenBy(param1:Living) : void
      {
         param1.addEventListener("beat",__beatenBy);
      }
      
      private function __beatenBy(param1:LivingEvent) : void
      {
         var _loc5_:Living = param1.paras[1];
         var _loc4_:int = param1.paras[2];
         var _loc3_:int = param1.value;
         var _loc2_:int = param1.paras[3];
         if(isLiving)
         {
            isHidden = false;
            showAttackEffect(_loc2_);
            updateBlood(_loc3_,3,_loc4_);
         }
      }
      
      public function transmit(param1:Point) : void
      {
         if(_pos.equals(param1) == false)
         {
            _pos = param1;
            dispatchEvent(new LivingEvent("posChanged"));
         }
      }
      
      public function showAttackEffect(param1:int) : void
      {
         if(param1 > 0)
         {
            dispatchEvent(new LivingEvent("showAttackEffect",0,0,param1));
         }
      }
      
      public function showDeadEffect(param1:String, param2:Function, param3:Object) : void
      {
         dispatchEvent(new LivingEvent("playDeadEffect",0,0,0,param1,param2,param3));
      }
      
      public function moveTo(param1:Number, param2:Point, param3:Number, param4:Boolean, param5:String = "", param6:int = 3, param7:String = "") : void
      {
         if(isPlayer() || _isLiving)
         {
            if(param2.x > _pos.x)
            {
               direction = 1;
            }
            else
            {
               direction = -1;
            }
            dispatchEvent(new LivingEvent("moveTo",0,0,param1,param2,param3,param4,param5,param6,param7));
         }
      }
      
      public function changePos(param1:Point, param2:String = "") : void
      {
         dispatchEvent(new LivingEvent("changePosition",0,0,param1));
      }
      
      public function fallTo(param1:Point, param2:int, param3:String = "", param4:int = 0) : void
      {
         dispatchEvent(new LivingEvent("fall",0,0,param1,param2,param3,param4));
      }
      
      public function jumpTo(param1:Point, param2:int, param3:String = "", param4:int = 0) : void
      {
         dispatchEvent(new LivingEvent("jump",0,0,param1,param2,param3,param4));
      }
      
      public function set State(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         dispatchEvent(new LivingEvent("changeState"));
      }
      
      public function get State() : int
      {
         return _state;
      }
      
      public function say(param1:String, param2:int = 0) : void
      {
         dispatchEvent(new LivingEvent("say",0,0,param1,param2));
      }
      
      public function playMovie(param1:String, param2:Function = null, param3:Array = null) : void
      {
         dispatchEvent(new LivingEvent("playmovie",0,0,param1,param2,param3));
      }
      
      public function turnRotation(param1:int, param2:int, param3:String) : void
      {
         dispatchEvent(new LivingEvent("turnrotation",0,0,param1,param2,param3));
      }
      
      public function set defaultAction(param1:String) : void
      {
         _defaultAction = param1;
         dispatchEvent(new LivingEvent("defaultActionChanged"));
      }
      
      public function get defaultAction() : String
      {
         return _defaultAction;
      }
      
      public function doDefaultAction() : void
      {
         playMovie(_defaultAction);
      }
      
      public function pick(param1:Object) : void
      {
         dispatchEvent(new LivingEvent("boxPick",0,0,param1));
      }
      
      private function cmdX(param1:int) : void
      {
      }
      
      public function get commandList() : Dictionary
      {
         if(!_cmdList)
         {
            initCommand();
         }
         return _cmdList;
      }
      
      public function initCommand() : void
      {
         _cmdList = new Dictionary();
         _cmdList["x"] = cmdX;
      }
      
      public function command(param1:String, param2:*) : Boolean
      {
         if(commandList[param1])
         {
            commandList[param1](param2);
         }
         return true;
      }
      
      public function sendCommand(param1:String, param2:Object = null) : void
      {
         dispatchEvent(new LivingCommandEvent("someCommand"));
      }
      
      public function setProperty(param1:String, param2:String) : void
      {
         var _loc3_:StringObject = new StringObject(param2);
         var _loc6_:* = param1;
         try
         {
            if(_headTopAddIcon != null && _headTopAddIcon.hasKey(param1))
            {
               this["skillEffectPic"] = new StringObject(_headTopAddIcon[param1] + "|" + _loc3_.getBoolean());
               return;
            }
            if(_loc3_.isBoolean)
            {
               this[param1] = _loc3_.getBoolean();
               return;
            }
            if(_loc3_.isInt)
            {
               this[param1] = _loc3_.getInt();
               return;
            }
            this[param1] = _loc3_;
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      public function set markMeHide(param1:Boolean) : void
      {
         this._markMeHide = param1;
         dispatchEvent(new LivingEvent("addSkillBuffBar",0,0,21590,param1));
      }
      
      public function get markMeHide() : Boolean
      {
         return this._markMeHide;
      }
      
      public function set markMeHideDest(param1:Boolean) : void
      {
         this._markMeHideDest = param1;
         dispatchEvent(new LivingEvent("mark_me_hide_dest"));
      }
      
      public function get markMeHideDest() : Boolean
      {
         return this._markMeHideDest;
      }
      
      public function bomd() : void
      {
         dispatchEvent(new LivingEvent("bombed"));
      }
      
      public function showEffect(param1:String) : void
      {
         dispatchEvent(new LivingEvent("playskillMovie",0,0,param1));
      }
      
      public function showBuffEffect(param1:String, param2:int) : void
      {
         dispatchEvent(new LivingEvent("playContinuousEffect",0,0,param1,param2));
      }
      
      public function removeBuffEffect(param1:int) : void
      {
         dispatchEvent(new LivingEvent("removeContinuousEffect",0,0,param1));
      }
      
      public function removeSkillMovie(param1:int) : void
      {
         dispatchEvent(new LivingEvent("removeSkillMovie",0,0,param1));
      }
      
      public function applySkill(param1:int, ... rest) : void
      {
         var _loc3_:* = null;
         if(rest == null || rest.length == 0)
         {
            _loc3_ = new LivingEvent("applySkill",0,0,param1);
         }
         else if(rest.length == 1)
         {
            _loc3_ = new LivingEvent("applySkill",0,0,param1,rest[0]);
         }
         else if(rest.length == 2)
         {
            _loc3_ = new LivingEvent("applySkill",0,0,param1,rest[0],rest[1]);
         }
         else if(rest.length == 3)
         {
            _loc3_ = new LivingEvent("applySkill",0,0,param1,rest[0],rest[1],rest[2]);
         }
         else if(rest.length == 4)
         {
            _loc3_ = new LivingEvent("applySkill",0,0,param1,rest[0],rest[1],rest[2],rest[3]);
         }
         dispatchEvent(_loc3_);
      }
      
      public function get shootInterval() : int
      {
         return _shootInterval;
      }
      
      public function set shootInterval(param1:int) : void
      {
         _shootInterval = param1;
      }
      
      public function get maxPsychic() : int
      {
         return 999;
      }
      
      public function get psychic() : int
      {
         return _psychic >= 0?_psychic:0;
      }
      
      public function set psychic(param1:int) : void
      {
         if(_psychic != param1 && param1 <= maxPsychic)
         {
            _psychic = param1;
            dispatchEvent(new LivingEvent("psychicChanged"));
         }
      }
      
      public function get energy() : Number
      {
         return _energy;
      }
      
      public function set energy(param1:Number) : void
      {
         if(param1 != _energy && param1 <= maxEnergy)
         {
            _energy = param1 >= 0?param1:0;
            dispatchEvent(new LivingEvent("energyChanged"));
         }
      }
      
      public function get forbidMoving() : Boolean
      {
         return _forbidMoving;
      }
      
      public function set forbidMoving(param1:Boolean) : void
      {
         _forbidMoving = param1;
      }
      
      public function get thumbnail() : BitmapData
      {
         return _thumbnail;
      }
      
      public function set thumbnail(param1:BitmapData) : void
      {
         if(_thumbnail != null)
         {
            _thumbnail.dispose();
         }
         _thumbnail = param1;
      }
      
      public function set currentAction(param1:String) : void
      {
         _currentAction = param1;
      }
      
      public function get currentAction() : String
      {
         return _currentAction;
      }
      
      public function get damageNum() : int
      {
         return _damageNum;
      }
      
      public function set damageNum(param1:int) : void
      {
         _damageNum = param1;
      }
      
      public function get templeId() : int
      {
         return _templeId;
      }
      
      public function get turnCount() : int
      {
         return _turnCount;
      }
      
      public function set turnCount(param1:int) : void
      {
         if(_turnCount == param1)
         {
            return;
         }
         _turnCount = param1;
      }
      
      public function set skillEffectPic(param1:StringObject) : void
      {
         var _loc2_:Array = param1.getData.split("|");
         _skillBuffIcon = _loc2_[0];
         _iconState = _loc2_[1] == "true";
         dispatchEvent(new LivingEvent("addSkillBuffBar",0,0,_skillBuffIcon,_iconState));
      }
      
      public function set showSolidIce(param1:Boolean) : void
      {
         if(_showSolidIce == param1)
         {
            return;
         }
         _showSolidIce = param1;
         dispatchEvent(new LivingEvent("solidiceStateChanged"));
      }
      
      public function get showSolidIce() : Boolean
      {
         return _showSolidIce;
      }
      
      public function set isDamageAverageState(param1:Boolean) : void
      {
         if(_isDamageAverageState == param1)
         {
            return;
         }
         _isDamageAverageState = param1;
         dispatchEvent(new LivingEvent("addSkillBuffBar",0,0,_damageId,param1));
      }
      
      public function get isDamageAverageState() : Boolean
      {
         return _isDamageAverageState;
      }
      
      public function set isNotSkillHeathState(param1:Boolean) : void
      {
         if(_isNotSkillHeathState == param1)
         {
            return;
         }
         _isNotSkillHeathState = param1;
         dispatchEvent(new LivingEvent("addSkillBuffBar",0,0,_despairId,param1));
      }
      
      public function get isNotSkillHeathState() : Boolean
      {
         return _isNotSkillHeathState;
      }
      
      public function set isRemoveStealth(param1:Boolean) : void
      {
         dispatchEvent(new LivingEvent("addSkillBuffBar",0,0,_eyeId,param1));
         if(this.isSelf)
         {
            if(_isRemoveStealth == param1)
            {
               return;
            }
            _isRemoveStealth = param1;
            dispatchEvent(new LivingEvent("targetStealthStateChanged"));
         }
      }
      
      public function get isRemoveStealth() : Boolean
      {
         return _isRemoveStealth;
      }
      
      public function set showDisturb(param1:Boolean) : void
      {
         dispatchEvent(new LivingEvent("addSkillBuffBar",0,0,20500,param1));
         if(isSelf)
         {
            _showDisturb = param1;
            dispatchEvent(new LivingEvent("DisturbStateChanged"));
         }
      }
      
      public function get showDisturb() : Boolean
      {
         return _showDisturb;
      }
      
      public function set notHasFairBattleSkill(param1:Boolean) : void
      {
         if(isLiving)
         {
            dispatchEvent(new LivingEvent("addSkillBuffBar",0,0,5,param1));
            if(isSelf)
            {
               _notHasFairBattleSkill = param1;
               dispatchEvent(new LivingEvent("notUseBattleSkill"));
            }
         }
      }
      
      public function get notHasFairBattleSkill() : Boolean
      {
         return _notHasFairBattleSkill;
      }
      
      public function set noUseCritical(param1:Boolean) : void
      {
         if(isLiving)
         {
            dispatchEvent(new LivingEvent("addSkillBuffBar",0,0,21580,param1));
            if(isSelf)
            {
               _noUseCritical = param1;
               dispatchEvent(new LivingEvent("enableSpellKill"));
            }
         }
      }
      
      public function get noUseCritical() : Boolean
      {
         return _noUseCritical;
      }
   }
}
