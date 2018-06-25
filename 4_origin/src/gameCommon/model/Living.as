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
      
      public function Living(id:int, team:int, maxBlood:int, templeId:int = 0)
      {
         _localBuffs = new Vector.<FightBuffInfo>();
         _turnBuffs = new Vector.<FightBuffInfo>();
         _petBuffs = new Vector.<FightBuffInfo>();
         _barBuffs = new Vector.<FightBuffInfo>();
         outTurnBuffs = new Vector.<FightBuffInfo>();
         _noPicPetBuff = new DictionaryData();
         _pos = new Point(0,0);
         super();
         _livingID = id;
         _team = team;
         _maxBlood = maxBlood;
         _actionManager = new ActionManager();
         _mirariEffects = new DictionaryData();
         _templeId = templeId;
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
      
      public function set fightPower(value:Number) : void
      {
         _fightPower = value;
         dispatchEvent(new LivingEvent("fightPowerChange"));
      }
      
      public function get currentSelectId() : int
      {
         return _currentSelectId;
      }
      
      public function set currentSelectId(value:int) : void
      {
         _currentSelectId = value;
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
      
      public function set isLockFly(val:Boolean) : void
      {
         _isLockFly = val;
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
      
      public function set isLockAngle(val:Boolean) : void
      {
         if(_isLockAngle == val)
         {
            return;
         }
         var oldValue:int = 0;
         var newValue:int = 0;
         if(_isLockAngle)
         {
            oldValue = 1;
         }
         if(val)
         {
            newValue = 1;
         }
         _isLockAngle = val;
         dispatchEvent(new LivingEvent("lockAngleChange",newValue,oldValue));
      }
      
      public function hasEffect(effecicon:BaseMirariEffectIcon) : Boolean
      {
         return _mirariEffects[effecicon.mirariType] != null;
      }
      
      public function get localBuffs() : Vector.<FightBuffInfo>
      {
         return _localBuffs;
      }
      
      public function get turnBuffs() : Vector.<FightBuffInfo>
      {
         return _turnBuffs;
      }
      
      public function set turnBuffs(buffs:Vector.<FightBuffInfo>) : void
      {
         _turnBuffs = buffs;
      }
      
      public function get petBuffs() : Vector.<FightBuffInfo>
      {
         return _petBuffs;
      }
      
      public function get barBuffs() : Vector.<FightBuffInfo>
      {
         return _barBuffs;
      }
      
      private function addPayBuff(buff:FightBuffInfo) : void
      {
         if(_payBuff == null)
         {
            _payBuff = new FightContainerBuff(-1);
            _localBuffs.unshift(_payBuff);
         }
         _payBuff.addFightBuff(buff);
      }
      
      private function addConsortiaBuff(buff:FightBuffInfo) : void
      {
         if(_consortiaBuff == null)
         {
            _consortiaBuff = new FightContainerBuff(-1,3);
            _localBuffs.unshift(_consortiaBuff);
         }
         _consortiaBuff.addFightBuff(buff);
      }
      
      private function addCardBuff(buff:FightBuffInfo) : void
      {
         if(_cardBuff == null)
         {
            _cardBuff = new FightContainerBuff(-1,4);
            _localBuffs.unshift(_cardBuff);
         }
         _cardBuff.addFightBuff(buff);
      }
      
      public function updateBuff(buffInfo:FightBuffInfo, list:Vector.<FightBuffInfo>) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var b in list)
         {
            if(b.id == buffInfo.id)
            {
               b.Count = buffInfo.Count;
               return;
            }
         }
      }
      
      public function addBuff(buff:FightBuffInfo) : void
      {
         buff.isSelf = isSelf;
         if(BuffType.isPayBuff(buff.id))
         {
            addPayBuff(buff);
            return;
         }
         if(BuffManager.isConsortiaBuff(buff))
         {
            addConsortiaBuff(buff);
            return;
         }
         if(BuffManager.isCardBuff(buff))
         {
            addCardBuff(buff);
            return;
         }
         if(buff.type == 1)
         {
            _localBuffs.push(buff);
         }
         else if(buff.type == 6)
         {
            if(BuffManager.buffTemplateData.hasKey(buff.id))
            {
               if(buff.showType == 1)
               {
                  if(hasBuff(buff,_barBuffs))
                  {
                     updateBuff(buff,_barBuffs);
                  }
                  else
                  {
                     _barBuffs.push(buff);
                  }
               }
               else
               {
                  if(hasBuff(buff,_turnBuffs))
                  {
                     return;
                  }
                  _turnBuffs.push(buff);
               }
            }
         }
         else
         {
            if(hasBuff(buff,_turnBuffs))
            {
               return;
            }
            _turnBuffs.push(buff);
         }
         buff.execute(this);
         dispatchEvent(new LivingEvent("buffChanged",0,0,buff.type,buff));
      }
      
      public function addPetBuff(buff:FightBuffInfo) : void
      {
         var hasBuff:Boolean = false;
         if(buff.buffPic != "-1")
         {
            hasBuff = false;
            var _loc5_:int = 0;
            var _loc4_:* = _petBuffs;
            for each(var b in _petBuffs)
            {
               if(b.id == buff.id)
               {
                  b.Count = Number(b.Count) + 1;
                  hasBuff = true;
                  break;
               }
            }
            if(!hasBuff)
            {
               _petBuffs.push(buff);
            }
         }
         else
         {
            _noPicPetBuff.add(buff.id,true);
         }
         buff.execute(this);
         dispatchEvent(new LivingEvent("buffChanged",0,0,buff.type,buff));
      }
      
      public function removePetBuff(buff:FightBuffInfo) : void
      {
         var i:int = 0;
         var len:int = _petBuffs.length;
         var buffid:int = buff.id;
         for(i = 0; i < len; )
         {
            if(_petBuffs[i].id == buffid)
            {
               _petBuffs[i].unExecute(this);
               _petBuffs.splice(i,1);
               dispatchEvent(new LivingEvent("buffChanged",0,0,buff.type,buff));
               break;
            }
            i++;
         }
         if(buff.buffPic == "-1" && _noPicPetBuff[buff.id])
         {
            _noPicPetBuff.remove(buff.id);
            buff.unExecute(this);
         }
      }
      
      private function hasBuff(buff:FightBuffInfo, list:Vector.<FightBuffInfo>) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var b in list)
         {
            if(b.id == buff.id)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getBuffByID(buffId:int) : FightBuffInfo
      {
         var buffInfo:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _petBuffs;
         for each(buffInfo in _petBuffs)
         {
            if(buffInfo.id == buffId)
            {
               return buffInfo;
            }
         }
         var _loc6_:int = 0;
         var _loc5_:* = _localBuffs;
         for each(buffInfo in _localBuffs)
         {
            if(buffInfo.id == buffId)
            {
               return buffInfo;
            }
         }
         var _loc8_:int = 0;
         var _loc7_:* = _turnBuffs;
         for each(buffInfo in _turnBuffs)
         {
            if(buffInfo.id == buffId)
            {
               return buffInfo;
            }
         }
         return null;
      }
      
      public function removeBuff(buffid:int) : void
      {
         var buffs:* = undefined;
         var buffType:int = 0;
         var gameBuffInfo:* = null;
         var i:int = 0;
         var buff:* = null;
         if(BuffManager.buffTemplateData.hasKey(buffid))
         {
            gameBuffInfo = BuffManager.buffTemplateData[buffid] as GameBuffInfo;
            if(gameBuffInfo.ShowType == 0)
            {
               buffs = _turnBuffs;
            }
            else
            {
               buffs = _barBuffs;
            }
            buffType = gameBuffInfo.Type;
         }
         else if(BuffType.isLocalBuffByID(buffid))
         {
            buffs = _localBuffs;
            buffType = 1;
         }
         else
         {
            buffs = _turnBuffs;
            buffType = 0;
         }
         var len:int = buffs.length;
         for(i = 0; i < len; )
         {
            if(buffs[i].id == buffid)
            {
               buff = buffs[i];
               buff.Count = 0;
               buffs[i].unExecute(this);
               buffs.splice(i,1);
               if(buffType == 1)
               {
                  _localBuffs = _localBuffs.sort(buffCompare);
               }
               else if(buffType == 6)
               {
                  _barBuffs = _barBuffs.sort(buffCompare);
               }
               else
               {
                  _turnBuffs = _turnBuffs.sort(buffCompare);
               }
               dispatchEvent(new LivingEvent("buffChanged",0,0,buffType,buff));
               break;
            }
            i++;
         }
      }
      
      protected function buffCompare(a:FightBuffInfo, b:FightBuffInfo) : Number
      {
         if(a.priority == b.priority)
         {
            return 0;
         }
         if(a.priority < b.priority)
         {
            return 1;
         }
         return -1;
      }
      
      public function handleMirariEffect(effecicon:BaseMirariEffectIcon) : void
      {
         if(effecicon.single)
         {
            if(!hasEffect(effecicon))
            {
               _mirariEffects.add(effecicon.mirariType,effecicon);
            }
         }
         else
         {
            _mirariEffects.add(effecicon.mirariType,effecicon);
         }
         effecicon.excuteEffect(this);
      }
      
      public function removeMirariEffect(effecicon:BaseMirariEffectIcon) : void
      {
         effecicon.dispose();
         _mirariEffects.remove(effecicon.mirariType);
         effecicon.unExcuteEffect(this);
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
      
      public function set name(value:String) : void
      {
         _name = value;
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
      
      public function set team(value:int) : void
      {
         _team = value;
      }
      
      public function set fallingType(i:int) : void
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
      
      public function set onChange(value:Boolean) : void
      {
         _onChange = value;
      }
      
      public function get pos() : Point
      {
         return _pos;
      }
      
      public function set pos(value:Point) : void
      {
         if(!value)
         {
            return;
         }
         if(_pos.equals(value) == false)
         {
            _pos = value;
            dispatchEvent(new LivingEvent("posChanged"));
         }
      }
      
      public function get isShowBlood() : Boolean
      {
         return _isShowBlood;
      }
      
      public function set isShowBlood(value:Boolean) : void
      {
         _isShowBlood = value;
      }
      
      public function get isShowSmallMapPoint() : Boolean
      {
         return _isShowSmallMapPoint;
      }
      
      public function set isShowSmallMapPoint(value:Boolean) : void
      {
         _isShowSmallMapPoint = value;
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function set direction(value:int) : void
      {
         if(_direction == value)
         {
            return;
         }
         _direction = value;
         sendCommand("changeDir");
         dispatchEvent(new LivingEvent("dirChanged"));
      }
      
      public function get maxBlood() : int
      {
         return _maxBlood;
      }
      
      public function set maxBlood(value:int) : void
      {
         _maxBlood = value;
         dispatchEvent(new LivingEvent("maxHpChanged"));
      }
      
      public function get blood() : Number
      {
         return _blood;
      }
      
      public function set blood(value:Number) : void
      {
         _blood = value > maxBlood?maxBlood:value;
      }
      
      public function initBlood(value:int) : void
      {
         blood = value;
         dispatchEvent(new LivingEvent("bloodChanged",value,0,5));
      }
      
      public function get isFrozen() : Boolean
      {
         return _isFrozen;
      }
      
      public function set isFrozen(value:Boolean) : void
      {
         if(_isFrozen == value)
         {
            return;
         }
         _isFrozen = value;
         dispatchEvent(new LivingEvent("forzenChanged"));
      }
      
      public function get isGemGlow() : Boolean
      {
         return _isGemGlow;
      }
      
      public function set isGemGlow(i:Boolean) : void
      {
         if(_isGemGlow != i)
         {
            _isGemGlow = i;
            dispatchEvent(new LivingEvent("gemGlowChanged"));
         }
      }
      
      public function get gemDefense() : Boolean
      {
         return _gemDefense;
      }
      
      public function set gemDefense(value:Boolean) : void
      {
         if(_gemDefense == value)
         {
            return;
         }
         _gemDefense = value;
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
      
      public function set isHidden(value:Boolean) : void
      {
         if(value == _isHidden)
         {
            return;
         }
         _isHidden = value;
         dispatchEvent(new LivingEvent("hiddenChanged"));
      }
      
      public function get removeStealth() : Boolean
      {
         return _removeStealth;
      }
      
      public function set removeStealth(value:Boolean) : void
      {
         if(_removeStealth == value)
         {
            return;
         }
         _removeStealth = value;
         dispatchEvent(new LivingEvent("hiddenChanged"));
      }
      
      public function get isFog() : Boolean
      {
         return _isFog;
      }
      
      public function set isFog(value:Boolean) : void
      {
         if(value == _isFog)
         {
            return;
         }
         _isFog = value;
         dispatchEvent(new LivingEvent("hiddenChanged"));
      }
      
      public function get backEffFog() : Boolean
      {
         return _backEffRadius > 0;
      }
      
      public function set updateBackFog(value:Number) : void
      {
         if(_backEffRadius == value)
         {
            return;
         }
         _backEffRadius = value;
         dispatchEvent(new LivingEvent("backEffectChange",_backEffRadius));
      }
      
      public function get backEffRadius() : Number
      {
         return _backEffRadius;
      }
      
      public function get isRedSkull() : Boolean
      {
         return _isRedSkull;
      }
      
      public function set isRedSkull(value:Boolean) : void
      {
         if(value == _isRedSkull)
         {
            return;
         }
         _isRedSkull = value;
         dispatchEvent(new LivingEvent("isRedSkullChange"));
      }
      
      public function get isNoNole() : Boolean
      {
         return _isNoNole;
      }
      
      public function set isNoNole(val:Boolean) : void
      {
         if(_isNoNole != val)
         {
            _isNoNole = val;
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
      
      public function set LockState(val:Boolean) : void
      {
         if(_lockState != val)
         {
            _lockState = val;
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
      
      public function set LockType(value:int) : void
      {
         _lockType = value;
      }
      
      public function get LockType() : int
      {
         return _lockType;
      }
      
      public function get isLiving() : Boolean
      {
         return _isLiving;
      }
      
      public function die(withAction:Boolean = true) : void
      {
         if(_isLiving)
         {
            _isLiving = false;
            dispatchEvent(new LivingEvent("die",0,0,withAction));
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
      
      public function set playerAngle(value:Number) : void
      {
         _playerAngle = value;
         dispatchEvent(new LivingEvent("angleChanged"));
      }
      
      public function get actionMovieName() : String
      {
         return _actionMovieName;
      }
      
      public function set actionMovieName(value:String) : void
      {
         _actionMovieName = value;
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
      
      public function set isMoving(value:Boolean) : void
      {
         _isMoving = value;
      }
      
      public function updateBlood(value:Number, type:int, addVlaue:int = 0) : void
      {
         var oldBlood:Number = NaN;
         var buff:* = null;
         var old:int = 0;
         trace("actionMovieName:" + actionMovieName + ",ID:" + LivingID + ",type:" + type + ",value:" + value + ",addVlaue:" + addVlaue);
         LogManager.getInstance().sendLog(this.actionMovieName);
         if(!isLiving)
         {
            return;
         }
         if(type == 3)
         {
            _blood = value;
            dispatchEvent(new LivingEvent("bloodChanged",value,_blood,type,addVlaue));
         }
         else if(type == 7)
         {
            oldBlood = _blood;
            _blood = _blood - addVlaue;
            dispatchEvent(new LivingEvent("bloodChanged",_blood,oldBlood,type,addVlaue));
         }
         else
         {
            if(type == 12)
            {
               type = 0;
               if(ModuleLoader.hasDefinition("asset.game.skill.effect.effect082"))
               {
                  showBuffEffect("asset.game.skill.effect.effect082",408);
               }
               buff = getBuffByID(1435);
               if(buff == null)
               {
                  buff = getBuffByID(1514);
               }
               if(buff && addVlaue > 0)
               {
                  var _loc7_:* = buff.Count - 1;
                  buff.Count = _loc7_;
                  buff.Count = Math.max(0,_loc7_);
                  dispatchEvent(new LivingEvent("buffChanged",0,0,buff.type,buff));
               }
            }
            if(_blood != value || GameControl.Instance.Current.gameMode == 17)
            {
               old = _blood;
               blood = value;
               if(type != 6 && _isLiving)
               {
                  dispatchEvent(new LivingEvent("bloodChanged",value,old,type,addVlaue));
               }
            }
            else if(type == 0 && value >= _blood)
            {
               dispatchEvent(new LivingEvent("bloodChanged",value,_blood,type,addVlaue));
            }
         }
         if(_blood <= 0)
         {
            _blood = 0;
            die(type != 6);
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
      
      public function act(action:BaseAction) : void
      {
         _actionManager.act(action);
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
      
      public function set actionMovieBitmap(value:Bitmap) : void
      {
         _actionMovie = value;
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
      
      public function shoot(list:Array, event:CrazyTankSocketEvent) : void
      {
         _currentShootList = list;
         dispatchEvent(new LivingEvent("shoot",0,0,list,event));
      }
      
      public function beat(arg:Array) : void
      {
         dispatchEvent(new LivingEvent("beat",0,0,arg));
      }
      
      public function beatenBy(attacker:Living) : void
      {
         attacker.addEventListener("beat",__beatenBy);
      }
      
      private function __beatenBy(evt:LivingEvent) : void
      {
         var target:Living = evt.paras[1];
         var damage:int = evt.paras[2];
         var targetBlood:int = evt.value;
         var targetAttackEffect:int = evt.paras[3];
         if(isLiving)
         {
            isHidden = false;
            showAttackEffect(targetAttackEffect);
            updateBlood(targetBlood,3,damage);
         }
      }
      
      public function transmit(pos:Point) : void
      {
         if(_pos.equals(pos) == false)
         {
            _pos = pos;
            dispatchEvent(new LivingEvent("posChanged"));
         }
      }
      
      public function showAttackEffect(effectID:int) : void
      {
         if(effectID > 0)
         {
            dispatchEvent(new LivingEvent("showAttackEffect",0,0,effectID));
         }
      }
      
      public function showDeadEffect(deadEffect:String, backFun:Function, argObj:Object) : void
      {
         dispatchEvent(new LivingEvent("playDeadEffect",0,0,0,deadEffect,backFun,argObj));
      }
      
      public function moveTo(type:Number, target:Point, dir:Number, isLiving:Boolean, action:String = "", speed:int = 3, endAction:String = "") : void
      {
         if(isPlayer() || _isLiving)
         {
            if(target.x > _pos.x)
            {
               direction = 1;
            }
            else
            {
               direction = -1;
            }
            dispatchEvent(new LivingEvent("moveTo",0,0,type,target,dir,isLiving,action,speed,endAction));
         }
      }
      
      public function changePos(target:Point, action:String = "") : void
      {
         dispatchEvent(new LivingEvent("changePosition",0,0,target));
      }
      
      public function fallTo(pos:Point, speed:int, action:String = "", fallType:int = 0) : void
      {
         dispatchEvent(new LivingEvent("fall",0,0,pos,speed,action,fallType));
      }
      
      public function jumpTo(pos:Point, speed:int, action:String = "", type:int = 0) : void
      {
         dispatchEvent(new LivingEvent("jump",0,0,pos,speed,action,type));
      }
      
      public function set State(state:int) : void
      {
         if(_state == state)
         {
            return;
         }
         _state = state;
         dispatchEvent(new LivingEvent("changeState"));
      }
      
      public function get State() : int
      {
         return _state;
      }
      
      public function say(msg:String, type:int = 0) : void
      {
         dispatchEvent(new LivingEvent("say",0,0,msg,type));
      }
      
      public function playMovie(type:String, fun:Function = null, args:Array = null) : void
      {
         dispatchEvent(new LivingEvent("playmovie",0,0,type,fun,args));
      }
      
      public function turnRotation(rota:int, speed:int, endPlay:String) : void
      {
         dispatchEvent(new LivingEvent("turnrotation",0,0,rota,speed,endPlay));
      }
      
      public function set defaultAction(action:String) : void
      {
         _defaultAction = action;
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
      
      public function pick(box:Object) : void
      {
         dispatchEvent(new LivingEvent("boxPick",0,0,box));
      }
      
      private function cmdX(value:int) : void
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
      
      public function command(command:String, value:*) : Boolean
      {
         if(commandList[command])
         {
            commandList[command](value);
         }
         return true;
      }
      
      public function sendCommand(type:String, data:Object = null) : void
      {
         dispatchEvent(new LivingCommandEvent("someCommand"));
      }
      
      public function setProperty(property:String, value:String) : void
      {
         var vo:StringObject = new StringObject(value);
         var _loc6_:* = property;
         try
         {
            if(_headTopAddIcon != null && _headTopAddIcon.hasKey(property))
            {
               this["skillEffectPic"] = new StringObject(_headTopAddIcon[property] + "|" + vo.getBoolean());
               return;
            }
            if(vo.isBoolean)
            {
               this[property] = vo.getBoolean();
               return;
            }
            if(vo.isInt)
            {
               this[property] = vo.getInt();
               return;
            }
            this[property] = vo;
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      public function set markMeHide(value:Boolean) : void
      {
         this._markMeHide = value;
         dispatchEvent(new LivingEvent("addSkillBuffBar",0,0,21590,value));
      }
      
      public function get markMeHide() : Boolean
      {
         return this._markMeHide;
      }
      
      public function set markMeHideDest(value:Boolean) : void
      {
         this._markMeHideDest = value;
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
      
      public function showEffect(name:String) : void
      {
         dispatchEvent(new LivingEvent("playskillMovie",0,0,name));
      }
      
      public function showBuffEffect(name:String, id:int) : void
      {
         dispatchEvent(new LivingEvent("playContinuousEffect",0,0,name,id));
      }
      
      public function removeBuffEffect(id:int) : void
      {
         dispatchEvent(new LivingEvent("removeContinuousEffect",0,0,id));
      }
      
      public function removeSkillMovie(id:int) : void
      {
         dispatchEvent(new LivingEvent("removeSkillMovie",0,0,id));
      }
      
      public function applySkill(skill:int, ... args) : void
      {
         var evt:* = null;
         if(args == null || args.length == 0)
         {
            evt = new LivingEvent("applySkill",0,0,skill);
         }
         else if(args.length == 1)
         {
            evt = new LivingEvent("applySkill",0,0,skill,args[0]);
         }
         else if(args.length == 2)
         {
            evt = new LivingEvent("applySkill",0,0,skill,args[0],args[1]);
         }
         else if(args.length == 3)
         {
            evt = new LivingEvent("applySkill",0,0,skill,args[0],args[1],args[2]);
         }
         else if(args.length == 4)
         {
            evt = new LivingEvent("applySkill",0,0,skill,args[0],args[1],args[2],args[3]);
         }
         dispatchEvent(evt);
      }
      
      public function get shootInterval() : int
      {
         return _shootInterval;
      }
      
      public function set shootInterval(value:int) : void
      {
         _shootInterval = value;
      }
      
      public function get maxPsychic() : int
      {
         return 999;
      }
      
      public function get psychic() : int
      {
         return _psychic >= 0?_psychic:0;
      }
      
      public function set psychic(val:int) : void
      {
         if(_psychic != val && val <= maxPsychic)
         {
            _psychic = val;
            dispatchEvent(new LivingEvent("psychicChanged"));
         }
      }
      
      public function get energy() : Number
      {
         return _energy;
      }
      
      public function set energy(value:Number) : void
      {
         if(value != _energy && value <= maxEnergy)
         {
            _energy = value >= 0?value:0;
            dispatchEvent(new LivingEvent("energyChanged"));
         }
      }
      
      public function get forbidMoving() : Boolean
      {
         return _forbidMoving;
      }
      
      public function set forbidMoving(value:Boolean) : void
      {
         _forbidMoving = value;
      }
      
      public function get thumbnail() : BitmapData
      {
         return _thumbnail;
      }
      
      public function set thumbnail(value:BitmapData) : void
      {
         if(_thumbnail != null)
         {
            _thumbnail.dispose();
         }
         _thumbnail = value;
      }
      
      public function set currentAction(value:String) : void
      {
         _currentAction = value;
      }
      
      public function get currentAction() : String
      {
         return _currentAction;
      }
      
      public function get damageNum() : int
      {
         return _damageNum;
      }
      
      public function set damageNum(value:int) : void
      {
         _damageNum = value;
      }
      
      public function get templeId() : int
      {
         return _templeId;
      }
      
      public function get turnCount() : int
      {
         return _turnCount;
      }
      
      public function set turnCount(value:int) : void
      {
         if(_turnCount == value)
         {
            return;
         }
         _turnCount = value;
      }
      
      public function set skillEffectPic(value:StringObject) : void
      {
         var data:Array = value.getData.split("|");
         _skillBuffIcon = data[0];
         _iconState = data[1] == "true";
         dispatchEvent(new LivingEvent("addSkillBuffBar",0,0,_skillBuffIcon,_iconState));
      }
      
      public function set showSolidIce(value:Boolean) : void
      {
         if(_showSolidIce == value)
         {
            return;
         }
         _showSolidIce = value;
         dispatchEvent(new LivingEvent("solidiceStateChanged"));
      }
      
      public function get showSolidIce() : Boolean
      {
         return _showSolidIce;
      }
      
      public function set isDamageAverageState(value:Boolean) : void
      {
         if(_isDamageAverageState == value)
         {
            return;
         }
         _isDamageAverageState = value;
         dispatchEvent(new LivingEvent("addSkillBuffBar",0,0,_damageId,value));
      }
      
      public function get isDamageAverageState() : Boolean
      {
         return _isDamageAverageState;
      }
      
      public function set isNotSkillHeathState(value:Boolean) : void
      {
         if(_isNotSkillHeathState == value)
         {
            return;
         }
         _isNotSkillHeathState = value;
         dispatchEvent(new LivingEvent("addSkillBuffBar",0,0,_despairId,value));
      }
      
      public function get isNotSkillHeathState() : Boolean
      {
         return _isNotSkillHeathState;
      }
      
      public function set isRemoveStealth(value:Boolean) : void
      {
         dispatchEvent(new LivingEvent("addSkillBuffBar",0,0,_eyeId,value));
         if(this.isSelf)
         {
            if(_isRemoveStealth == value)
            {
               return;
            }
            _isRemoveStealth = value;
            dispatchEvent(new LivingEvent("targetStealthStateChanged"));
         }
      }
      
      public function get isRemoveStealth() : Boolean
      {
         return _isRemoveStealth;
      }
      
      public function set showDisturb(value:Boolean) : void
      {
         dispatchEvent(new LivingEvent("addSkillBuffBar",0,0,20500,value));
         if(isSelf)
         {
            _showDisturb = value;
            dispatchEvent(new LivingEvent("DisturbStateChanged"));
         }
      }
      
      public function get showDisturb() : Boolean
      {
         return _showDisturb;
      }
      
      public function set notHasFairBattleSkill(value:Boolean) : void
      {
         if(isLiving)
         {
            dispatchEvent(new LivingEvent("addSkillBuffBar",0,0,5,value));
            if(isSelf)
            {
               _notHasFairBattleSkill = value;
               dispatchEvent(new LivingEvent("notUseBattleSkill"));
            }
         }
      }
      
      public function get notHasFairBattleSkill() : Boolean
      {
         return _notHasFairBattleSkill;
      }
      
      public function set noUseCritical(value:Boolean) : void
      {
         if(isLiving)
         {
            dispatchEvent(new LivingEvent("addSkillBuffBar",0,0,21580,value));
            if(isSelf)
            {
               _noUseCritical = value;
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
