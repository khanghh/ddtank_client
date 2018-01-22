package ddt.data.goods
{
   import bagAndInfo.amulet.EquipAmuletManager;
   import bagAndInfo.amulet.vo.EquipAmuletPhaseVo;
   import ddt.data.EquipType;
   import ddt.events.GoodsEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import flash.events.Event;
   import flash.utils.ByteArray;
   import gemstone.info.GemstListInfo;
   import magicStone.data.MagicStoneInfo;
   import road7th.utils.DateUtils;
   import store.forge.wishBead.WishBeadManager;
   import store.forge.wishBead.WishChangeInfo;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class InventoryItemInfo extends ItemTemplateInfo
   {
      
      private static var _isTimerStarted:Boolean = false;
      
      private static var _temp_Instances:Array = [];
       
      
      private var _checkTimeOutTimer:TimerJuggler;
      
      private var _checkColorValidTimer:TimerJuggler;
      
      private var _checkTimePackTimer:TimerJuggler;
      
      public var ItemID:Number;
      
      public var UserID:Number;
      
      public var IsBinds:Boolean;
      
      public var isDeleted:Boolean;
      
      public var BagType:int;
      
      public var type:int;
      
      public var isInvalid:Boolean;
      
      public var lock:Boolean = false;
      
      public var goodsLock:Boolean = false;
      
      public var Color:String;
      
      public var Skin:String;
      
      public var isMoveSpace:Boolean = true;
      
      private var _isUsed:Boolean;
      
      public var BeginDate:String;
      
      protected var _ValidDate:Number;
      
      public var isConversion:Boolean = false;
      
      private var _DiscolorValidDate:String;
      
      private var atLeastOnHour:Boolean;
      
      private var _count:int = 1;
      
      private var _exaltLevel:int;
      
      private var _StrengthenLevel:int;
      
      private var _StrengthenExp:int;
      
      private var _isGold:Boolean;
      
      public var Damage:int;
      
      public var Guard:int;
      
      public var Boold:int;
      
      public var Bless:int;
      
      private var _goldValidDate:int;
      
      private var _goldBeginTime:String;
      
      public var IsJudge:Boolean;
      
      public var Place:int;
      
      public var AttackCompose:int;
      
      public var DefendCompose:int;
      
      public var LuckCompose:int;
      
      public var AgilityCompose:int;
      
      public var lockType:int;
      
      public var Hole1:int = -1;
      
      public var Hole2:int = -1;
      
      public var Hole3:int = -1;
      
      public var Hole4:int = -1;
      
      public var Hole5:int = -1;
      
      public var Hole6:int = -1;
      
      public var Hole5Level:int;
      
      public var Hole5Exp:int = 0;
      
      public var Hole6Level:int;
      
      public var Hole6Exp:int = 0;
      
      public var beadExp:int;
      
      public var beadLevel:int = 1;
      
      public var beadIsLock:int;
      
      private var _curExp:int;
      
      public var isShowBind:Boolean = true;
      
      public var gemstoneList:Vector.<GemstListInfo>;
      
      public var latentEnergyCurStr:String = "0,0,0,0";
      
      public var latentEnergyNewStr:String = "0,0,0,0";
      
      public var latentEnergyEndTime:Date;
      
      public var MagicExp:int;
      
      public var MagicLevel:int;
      
      public var magicStoneAttr:MagicStoneInfo;
      
      public var cellLocked:Boolean;
      
      public var RingExp:int;
      
      private var _awakenEquipPro:AwakenEquipInfo = null;
      
      public var wearStatus:Boolean = false;
      
      public var fromBag:Boolean = false;
      
      public function InventoryItemInfo()
      {
         super();
         if(!_isTimerStarted)
         {
            _temp_Instances.push(this);
         }
      }
      
      public static function startTimer() : void
      {
         if(!_isTimerStarted)
         {
            _isTimerStarted = true;
            var _loc3_:int = 0;
            var _loc2_:* = _temp_Instances;
            for each(var _loc1_ in _temp_Instances)
            {
               _loc1_.updateRemainDate();
            }
            _temp_Instances = null;
         }
      }
      
      public function get IsUsed() : Boolean
      {
         return _isUsed;
      }
      
      public function setIsUsed(param1:Boolean) : void
      {
         _isUsed = param1;
      }
      
      public function set IsUsed(param1:Boolean) : void
      {
         isBeadLocked = param1;
         if(_isUsed == param1)
         {
            return;
         }
         _isUsed = param1;
         if(_isUsed && _isTimerStarted)
         {
            updateRemainDate();
         }
      }
      
      override public function set Property5(param1:String) : void
      {
         _property5 = param1;
         transformValidDate();
      }
      
      public function set ValidDate(param1:Number) : void
      {
         isConversion = false;
         _ValidDate = param1;
         transformValidDate();
      }
      
      private function transformValidDate() : void
      {
         if(!EquipType.isPropertyWater(this))
         {
            return;
         }
         if(!isConversion)
         {
            switch(int(Property5) - 1)
            {
               case 0:
                  break;
               case 1:
                  _ValidDate = _ValidDate / 24;
                  isConversion = true;
                  break;
               case 2:
                  _ValidDate = _ValidDate / 1440;
                  isConversion = true;
            }
         }
      }
      
      public function get ValidDate() : Number
      {
         return _ValidDate;
      }
      
      public function getRemainDate() : Number
      {
         var _loc2_:* = null;
         var _loc1_:Number = NaN;
         if(ValidDate == 0)
         {
            return 2147483647;
         }
         if(!_isUsed)
         {
            return ValidDate;
         }
         _loc2_ = DateUtils.getDateByStr(BeginDate);
         _loc1_ = TimeManager.Instance.TotalDaysToNow(_loc2_);
         _loc1_ = _loc1_ < 0?0:Number(_loc1_);
         return ValidDate - _loc1_;
      }
      
      public function getColorValidDate() : Number
      {
         var _loc2_:* = null;
         var _loc1_:Number = NaN;
         if(!_isUsed)
         {
            return 2147483647;
         }
         _loc2_ = DateUtils.getDateByStr(DiscolorValidDate);
         _loc1_ = TimeManager.Instance.TotalDaysToNow(_loc2_) * -1;
         return _loc1_;
      }
      
      public function set DiscolorValidDate(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc2_:Number = NaN;
         _DiscolorValidDate = param1;
         if(RefineryLevel >= 3 && _isUsed)
         {
            _loc3_ = DateUtils.getDateByStr(DiscolorValidDate);
            _loc2_ = _loc3_.time - TimeManager.Instance.Now().time;
            if(_loc2_ <= 0)
            {
               SocketManager.Instance.out.sendChangeColorShellTimeOver(BagType,Place);
            }
            else
            {
               updateDiscolorValidDate();
            }
         }
      }
      
      public function get DiscolorValidDate() : String
      {
         return _DiscolorValidDate;
      }
      
      private function updateDiscolorValidDate() : void
      {
         var _loc2_:Date = DateUtils.getDateByStr(DiscolorValidDate);
         var _loc1_:Number = _loc2_.time - TimeManager.Instance.Now().time;
         if(_checkColorValidTimer != null)
         {
            _checkColorValidTimer.stop();
            _checkColorValidTimer.removeEventListener("timerComplete",_timerColorComplete);
            TimerManager.getInstance().removeJugglerByTimer(_checkColorValidTimer);
            _checkColorValidTimer = null;
         }
         _checkColorValidTimer = TimerManager.getInstance().addTimerJuggler(_loc1_,1);
         _checkColorValidTimer.addEventListener("timerComplete",_timerColorComplete);
         _checkColorValidTimer.start();
      }
      
      private function updateRemainDate() : void
      {
         var _loc4_:* = null;
         var _loc2_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc1_:* = 0;
         if(ValidDate != 0 && _isUsed)
         {
            _loc4_ = DateUtils.getDateByStr(BeginDate);
            _loc2_ = TimeManager.Instance.TotalDaysToNow(_loc4_);
            _loc5_ = ValidDate - _loc2_;
            if(_loc5_ > 0)
            {
               if(_checkTimeOutTimer != null)
               {
                  _checkTimeOutTimer.stop();
                  _checkTimeOutTimer.removeEventListener("timerComplete",__timerComplete);
                  TimerManager.getInstance().removeJugglerByTimer(_checkTimeOutTimer);
                  _checkTimeOutTimer = null;
               }
               checkTimePcak(_loc5_);
               atLeastOnHour = _loc5_ * 24 > 1;
               _loc1_ = uint(!!atLeastOnHour?_loc5_ * 86400000 - 3600000:Number(_loc5_ * 86400000));
               _checkTimeOutTimer = TimerManager.getInstance().addTimerJuggler(_loc1_,1);
               _checkTimeOutTimer.addEventListener("timerComplete",__timerComplete);
               _checkTimeOutTimer.start();
            }
            else
            {
               if(CategoryID == 50 || CategoryID == 51 || CategoryID == 52)
               {
                  if(PlayerManager.Instance.Self.pets.length > 0)
                  {
                     var _loc7_:int = 0;
                     var _loc6_:* = PlayerManager.Instance.Self.pets;
                     for(var _loc3_ in PlayerManager.Instance.Self.pets)
                     {
                        SocketManager.Instance.out.delPetEquip(PlayerManager.Instance.Self.pets[_loc3_].Place,Place);
                     }
                  }
                  return;
               }
               SocketManager.Instance.out.sendItemOverDue(BagType,Place);
            }
         }
      }
      
      private function checkTimePcak(param1:Number) : void
      {
         var _loc2_:* = 0;
         if(_checkTimePackTimer != null)
         {
            _checkTimePackTimer.stop();
            _checkTimePackTimer.removeEventListener("timerComplete",__timerComplete);
            TimerManager.getInstance().removeJugglerByTimer(_checkTimePackTimer);
            _checkTimePackTimer = null;
         }
         if(TemplateID >= 1120098 && TemplateID <= 1120101)
         {
            if(param1 * 86400000 <= 1800000)
            {
               ChatManager.Instance.addTimePackTip(Name);
               return;
            }
            _loc2_ = uint(param1 * 86400000 - 1800000);
            _checkTimePackTimer = TimerManager.getInstance().addTimerJuggler(_loc2_,1);
            _checkTimePackTimer.addEventListener("timerComplete",__timerPackComplete);
            _checkTimePackTimer.start();
         }
      }
      
      protected function __timerPackComplete(param1:Event) : void
      {
         _checkTimePackTimer.removeEventListener("timerComplete",__timerPackComplete);
         _checkTimePackTimer.stop();
         ChatManager.Instance.addTimePackTip(Name);
      }
      
      private function __timerComplete(param1:Event) : void
      {
         _checkTimeOutTimer.removeEventListener("timerComplete",__timerComplete);
         _checkTimeOutTimer.stop();
         if(!IsBinds)
         {
            return;
         }
         if(TemplateID >= 1120098 && TemplateID <= 1120101)
         {
            ChatManager.Instance.addTimePackTip(Name);
         }
         if(atLeastOnHour)
         {
            _checkTimeOutTimer.delay = 3610000;
         }
         else
         {
            _checkTimeOutTimer.delay = 10000;
         }
         _checkTimeOutTimer.reset();
         _checkTimeOutTimer.addEventListener("timer",__sendGoodsTimeOut);
         _checkTimeOutTimer.start();
      }
      
      private function _timerColorComplete(param1:Event) : void
      {
         _checkColorValidTimer.removeEventListener("timerComplete",_timerColorComplete);
         _checkColorValidTimer.stop();
         SocketManager.Instance.out.sendChangeColorShellTimeOver(BagType,Place);
      }
      
      private function __sendGoodsTimeOut(param1:Event) : void
      {
         if(StateManager.currentStateType != "fighting" && StateManager.currentStateType != "fightLabGameView")
         {
            if(CategoryID == 50 || CategoryID == 51 || CategoryID == 52)
            {
               if(PlayerManager.Instance.Self.pets.length > 0)
               {
                  var _loc4_:int = 0;
                  var _loc3_:* = PlayerManager.Instance.Self.pets;
                  for(var _loc2_ in PlayerManager.Instance.Self.pets)
                  {
                     SocketManager.Instance.out.delPetEquip(PlayerManager.Instance.Self.pets[_loc2_].Place,Place);
                  }
               }
               return;
            }
            SocketManager.Instance.out.sendItemOverDue(BagType,Place);
            _checkTimeOutTimer.removeEventListener("timer",__sendGoodsTimeOut);
            _checkTimeOutTimer.stop();
         }
      }
      
      public function get Count() : int
      {
         return _count;
      }
      
      public function set Count(param1:int) : void
      {
         if(_count == param1)
         {
            return;
         }
         _count = param1;
         dispatchEvent(new GoodsEvent("propertyChange","Count",_count));
      }
      
      public function clone() : InventoryItemInfo
      {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeObject(this);
         return _loc1_.readObject();
      }
      
      public function set exaltLevel(param1:int) : void
      {
         _exaltLevel = param1;
      }
      
      public function get exaltLevel() : int
      {
         return _exaltLevel;
      }
      
      public function set StrengthenLevel(param1:int) : void
      {
         _StrengthenLevel = param1;
      }
      
      public function get StrengthenLevel() : int
      {
         return _StrengthenLevel;
      }
      
      public function set StrengthenExp(param1:int) : void
      {
         _StrengthenExp = param1;
      }
      
      public function get StrengthenExp() : int
      {
         return _StrengthenExp;
      }
      
      public function get isGold() : Boolean
      {
         return _isGold;
      }
      
      public function set isGold(param1:Boolean) : void
      {
         var _loc2_:* = null;
         _isGold = param1;
         if(_isGold)
         {
            _loc2_ = WishBeadManager.instance.getWishInfoByTemplateID(TemplateID,CategoryID);
            if(!_loc2_)
            {
               return;
            }
            Attack = _loc2_.Attack > 0?_loc2_.Attack:int(Attack);
            Defence = _loc2_.Defence > 0?_loc2_.Defence:int(Defence);
            Agility = _loc2_.Agility > 0?_loc2_.Agility:int(Agility);
            Luck = _loc2_.Luck > 0?_loc2_.Luck:int(Luck);
            Damage = _loc2_.Damage >= 0?_loc2_.Damage:int(Damage);
            Guard = _loc2_.Guard >= 0?_loc2_.Guard:int(Guard);
            Boold = _loc2_.Boold >= 0?_loc2_.Boold:int(Boold);
            Bless = _loc2_.BlessID;
            Pic = _loc2_.Pic != ""?_loc2_.Pic:Pic;
         }
      }
      
      public function get goldValidDate() : int
      {
         return _goldValidDate;
      }
      
      public function set goldValidDate(param1:int) : void
      {
         _goldValidDate = param1;
      }
      
      public function get goldBeginTime() : String
      {
         return _goldBeginTime;
      }
      
      public function set goldBeginTime(param1:String) : void
      {
         _goldBeginTime = param1;
      }
      
      public function getGoldRemainDate() : Number
      {
         var _loc2_:Date = DateUtils.getDateByStr(_goldBeginTime);
         var _loc1_:Number = TimeManager.Instance.TotalDaysToNow(_loc2_);
         _loc1_ = _loc1_ < 0?0:Number(_loc1_);
         return goldValidDate - _loc1_;
      }
      
      public function get equipAmuletProperty1() : int
      {
         if(Hole1 <= 0)
         {
            return 0;
         }
         var _loc2_:EquipAmuletPhaseVo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(this.StrengthenLevel);
         var _loc1_:int = Math.round(Hole5 / 10000 * _loc2_["property" + Hole1]);
         return _loc1_ || 1;
      }
      
      public function get equipAmuletProperty2() : int
      {
         if(Hole2 <= 0)
         {
            return 0;
         }
         var _loc2_:EquipAmuletPhaseVo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(this.StrengthenLevel);
         var _loc1_:int = Math.round(Hole6 / 10000 * _loc2_["property" + Hole2]);
         return _loc1_ || 1;
      }
      
      public function get equipAmuletProperty3() : int
      {
         if(Hole3 <= 0)
         {
            return 0;
         }
         var _loc2_:EquipAmuletPhaseVo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(this.StrengthenLevel);
         var _loc1_:int = Math.round(Hole5Exp / 10000 * _loc2_["property" + Hole3]);
         return _loc1_ || 1;
      }
      
      public function get equipAmuletProperty4() : int
      {
         if(Hole4 <= 0)
         {
            return 0;
         }
         var _loc2_:EquipAmuletPhaseVo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(this.StrengthenLevel);
         var _loc1_:int = Math.round(Hole6Exp / 10000 * _loc2_["property" + Hole4]);
         return _loc1_ || 1;
      }
      
      public function get curExp() : int
      {
         return _curExp;
      }
      
      public function set curExp(param1:int) : void
      {
         _curExp = param1;
      }
      
      public function get isHasLatentEnergy() : Boolean
      {
         if(!latentEnergyEndTime || latentEnergyEndTime.getTime() <= TimeManager.Instance.Now().getTime())
         {
            return false;
         }
         var _loc1_:Array = latentEnergyCurList;
         if(_loc1_[0] == "0" || _loc1_[1] == "0" || _loc1_[2] == "0" || _loc1_[3] == "0")
         {
            return false;
         }
         return true;
      }
      
      public function get latentEnergyCurList() : Array
      {
         if(!isCanLatentEnergy)
         {
            latentEnergyCurStr = "0,0,0,0";
         }
         if(latentEnergyCurStr == "")
         {
            latentEnergyCurStr = "0,0,0,0";
         }
         return latentEnergyCurStr.split(",");
      }
      
      public function get latentEnergyNewList() : Array
      {
         if(latentEnergyNewStr == "")
         {
            latentEnergyNewStr = "0,0,0,0";
         }
         if(!isHasLatentEnergy)
         {
            latentEnergyNewStr = "0,0,0,0";
         }
         return latentEnergyNewStr.split(",");
      }
      
      public function get isHasLatenetEnergyNew() : Boolean
      {
         var _loc1_:Array = latentEnergyNewList;
         if(_loc1_[0] == "0" || _loc1_[1] == "0" || _loc1_[2] == "0" || _loc1_[3] == "0")
         {
            return false;
         }
         return true;
      }
      
      public function get isCanLatentEnergy() : Boolean
      {
         if(CategoryID == 3 || CategoryID == 13 || CategoryID == 2 || CategoryID == 4 || CategoryID == 6 || CategoryID == 15)
         {
            return true;
         }
         return false;
      }
      
      public function isCanEnchant() : Boolean
      {
         if(CategoryID == 8 || CategoryID == 9 || EquipType.isWeddingRing(this))
         {
            return true;
         }
         return false;
      }
      
      public function isCanGodRefining() : Boolean
      {
         if(CategoryID == 7)
         {
            return true;
         }
         return false;
      }
      
      public function get hasComposeAttribte() : Boolean
      {
         return AttackCompose > 0 || DefendCompose > 0 || LuckCompose > 0 || AgilityCompose > 0;
      }
      
      public function set awakenEquipPro(param1:AwakenEquipInfo) : void
      {
         _awakenEquipPro = param1;
         dispatchEvent(new GoodsEvent("awakenInfoChange"));
      }
      
      public function get awakenEquipPro() : AwakenEquipInfo
      {
         return _awakenEquipPro;
      }
   }
}
