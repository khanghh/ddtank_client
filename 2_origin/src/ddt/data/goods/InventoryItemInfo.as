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
            for each(var i in _temp_Instances)
            {
               i.updateRemainDate();
            }
            _temp_Instances = null;
         }
      }
      
      public function get IsUsed() : Boolean
      {
         return _isUsed;
      }
      
      public function setIsUsed(value:Boolean) : void
      {
         _isUsed = value;
      }
      
      public function set IsUsed(value:Boolean) : void
      {
         isBeadLocked = value;
         if(_isUsed == value)
         {
            return;
         }
         _isUsed = value;
         if(_isUsed && _isTimerStarted)
         {
            updateRemainDate();
         }
      }
      
      override public function set Property5(value:String) : void
      {
         _property5 = value;
         transformValidDate();
      }
      
      public function set ValidDate(value:Number) : void
      {
         isConversion = false;
         _ValidDate = value;
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
            switch(int(int(Property5)) - 1)
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
         var bg:* = null;
         var diff:Number = NaN;
         if(ValidDate == 0)
         {
            return 2147483647;
         }
         if(!_isUsed)
         {
            return ValidDate;
         }
         bg = DateUtils.getDateByStr(BeginDate);
         diff = TimeManager.Instance.TotalDaysToNow(bg);
         diff = diff < 0?0:Number(diff);
         return ValidDate - diff;
      }
      
      public function getColorValidDate() : Number
      {
         var endDate:* = null;
         var diff:Number = NaN;
         if(!_isUsed)
         {
            return 2147483647;
         }
         endDate = DateUtils.getDateByStr(DiscolorValidDate);
         diff = TimeManager.Instance.TotalDaysToNow(endDate) * -1;
         return diff;
      }
      
      public function set DiscolorValidDate(value:String) : void
      {
         var endDate:* = null;
         var diff:Number = NaN;
         _DiscolorValidDate = value;
         if(RefineryLevel >= 3 && _isUsed)
         {
            endDate = DateUtils.getDateByStr(DiscolorValidDate);
            diff = endDate.time - TimeManager.Instance.Now().time;
            if(diff <= 0)
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
         var endDate:Date = DateUtils.getDateByStr(DiscolorValidDate);
         var diff:Number = endDate.time - TimeManager.Instance.Now().time;
         if(_checkColorValidTimer != null)
         {
            _checkColorValidTimer.stop();
            _checkColorValidTimer.removeEventListener("timerComplete",_timerColorComplete);
            TimerManager.getInstance().removeJugglerByTimer(_checkColorValidTimer);
            _checkColorValidTimer = null;
         }
         _checkColorValidTimer = TimerManager.getInstance().addTimerJuggler(diff,1);
         _checkColorValidTimer.addEventListener("timerComplete",_timerColorComplete);
         _checkColorValidTimer.start();
      }
      
      private function updateRemainDate() : void
      {
         var bg:* = null;
         var diff:Number = NaN;
         var remainDate:Number = NaN;
         var tempDelay:* = 0;
         if(ValidDate != 0 && _isUsed)
         {
            bg = DateUtils.getDateByStr(BeginDate);
            diff = TimeManager.Instance.TotalDaysToNow(bg);
            remainDate = ValidDate - diff;
            if(remainDate > 0)
            {
               if(_checkTimeOutTimer != null)
               {
                  _checkTimeOutTimer.stop();
                  _checkTimeOutTimer.removeEventListener("timerComplete",__timerComplete);
                  TimerManager.getInstance().removeJugglerByTimer(_checkTimeOutTimer);
                  _checkTimeOutTimer = null;
               }
               checkTimePcak(remainDate);
               atLeastOnHour = remainDate * 24 > 1;
               tempDelay = uint(!!atLeastOnHour?remainDate * 86400000 - 3600000:Number(remainDate * 86400000));
               _checkTimeOutTimer = TimerManager.getInstance().addTimerJuggler(tempDelay,1);
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
                     for(var p in PlayerManager.Instance.Self.pets)
                     {
                        SocketManager.Instance.out.delPetEquip(PlayerManager.Instance.Self.pets[p].Place,Place);
                     }
                  }
                  return;
               }
               SocketManager.Instance.out.sendItemOverDue(BagType,Place);
            }
         }
      }
      
      private function checkTimePcak(remainDate:Number) : void
      {
         var delay:* = 0;
         if(_checkTimePackTimer != null)
         {
            _checkTimePackTimer.stop();
            _checkTimePackTimer.removeEventListener("timerComplete",__timerComplete);
            TimerManager.getInstance().removeJugglerByTimer(_checkTimePackTimer);
            _checkTimePackTimer = null;
         }
         if(TemplateID >= 1120098 && TemplateID <= 1120101)
         {
            if(remainDate * 86400000 <= 1800000)
            {
               ChatManager.Instance.addTimePackTip(Name);
               return;
            }
            delay = uint(remainDate * 86400000 - 1800000);
            _checkTimePackTimer = TimerManager.getInstance().addTimerJuggler(delay,1);
            _checkTimePackTimer.addEventListener("timerComplete",__timerPackComplete);
            _checkTimePackTimer.start();
         }
      }
      
      protected function __timerPackComplete(event:Event) : void
      {
         _checkTimePackTimer.removeEventListener("timerComplete",__timerPackComplete);
         _checkTimePackTimer.stop();
         ChatManager.Instance.addTimePackTip(Name);
      }
      
      private function __timerComplete(evt:Event) : void
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
      
      private function _timerColorComplete(evt:Event) : void
      {
         _checkColorValidTimer.removeEventListener("timerComplete",_timerColorComplete);
         _checkColorValidTimer.stop();
         SocketManager.Instance.out.sendChangeColorShellTimeOver(BagType,Place);
      }
      
      private function __sendGoodsTimeOut(evt:Event) : void
      {
         if(StateManager.currentStateType != "fighting" && StateManager.currentStateType != "fightLabGameView")
         {
            if(CategoryID == 50 || CategoryID == 51 || CategoryID == 52)
            {
               if(PlayerManager.Instance.Self.pets.length > 0)
               {
                  var _loc4_:int = 0;
                  var _loc3_:* = PlayerManager.Instance.Self.pets;
                  for(var p in PlayerManager.Instance.Self.pets)
                  {
                     SocketManager.Instance.out.delPetEquip(PlayerManager.Instance.Self.pets[p].Place,Place);
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
      
      public function set Count(value:int) : void
      {
         if(_count == value)
         {
            return;
         }
         _count = value;
         dispatchEvent(new GoodsEvent("propertyChange","Count",_count));
      }
      
      public function clone() : InventoryItemInfo
      {
         var bytes:ByteArray = new ByteArray();
         bytes.writeObject(this);
         return bytes.readObject();
      }
      
      public function set exaltLevel(value:int) : void
      {
         _exaltLevel = value;
      }
      
      public function get exaltLevel() : int
      {
         return _exaltLevel;
      }
      
      public function set StrengthenLevel(value:int) : void
      {
         _StrengthenLevel = value;
      }
      
      public function get StrengthenLevel() : int
      {
         return _StrengthenLevel;
      }
      
      public function set StrengthenExp(value:int) : void
      {
         _StrengthenExp = value;
      }
      
      public function get StrengthenExp() : int
      {
         return _StrengthenExp;
      }
      
      public function get isGold() : Boolean
      {
         return _isGold;
      }
      
      public function set isGold(value:Boolean) : void
      {
         var wishInfo:* = null;
         _isGold = value;
         if(_isGold)
         {
            wishInfo = WishBeadManager.instance.getWishInfoByTemplateID(TemplateID,CategoryID);
            if(!wishInfo)
            {
               return;
            }
            Attack = wishInfo.Attack > 0?wishInfo.Attack:int(Attack);
            Defence = wishInfo.Defence > 0?wishInfo.Defence:int(Defence);
            Agility = wishInfo.Agility > 0?wishInfo.Agility:int(Agility);
            Luck = wishInfo.Luck > 0?wishInfo.Luck:int(Luck);
            Damage = wishInfo.Damage >= 0?wishInfo.Damage:int(Damage);
            Guard = wishInfo.Guard >= 0?wishInfo.Guard:int(Guard);
            Boold = wishInfo.Boold >= 0?wishInfo.Boold:int(Boold);
            Bless = wishInfo.BlessID;
            Pic = wishInfo.Pic != ""?wishInfo.Pic:Pic;
         }
      }
      
      public function get goldValidDate() : int
      {
         return _goldValidDate;
      }
      
      public function set goldValidDate(value:int) : void
      {
         _goldValidDate = value;
      }
      
      public function get goldBeginTime() : String
      {
         return _goldBeginTime;
      }
      
      public function set goldBeginTime(value:String) : void
      {
         _goldBeginTime = value;
      }
      
      public function getGoldRemainDate() : Number
      {
         var bg:Date = DateUtils.getDateByStr(_goldBeginTime);
         var diff:Number = TimeManager.Instance.TotalDaysToNow(bg);
         diff = diff < 0?0:Number(diff);
         return goldValidDate - diff;
      }
      
      public function get equipAmuletProperty1() : int
      {
         if(Hole1 <= 0)
         {
            return 0;
         }
         var vo:EquipAmuletPhaseVo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(this.StrengthenLevel);
         var value:int = Math.round(Hole5 / 10000 * vo["property" + Hole1]);
         return value || 1;
      }
      
      public function get equipAmuletProperty2() : int
      {
         if(Hole2 <= 0)
         {
            return 0;
         }
         var vo:EquipAmuletPhaseVo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(this.StrengthenLevel);
         var value:int = Math.round(Hole6 / 10000 * vo["property" + Hole2]);
         return value || 1;
      }
      
      public function get equipAmuletProperty3() : int
      {
         if(Hole3 <= 0)
         {
            return 0;
         }
         var vo:EquipAmuletPhaseVo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(this.StrengthenLevel);
         var value:int = Math.round(Hole5Exp / 10000 * vo["property" + Hole3]);
         return value || 1;
      }
      
      public function get equipAmuletProperty4() : int
      {
         if(Hole4 <= 0)
         {
            return 0;
         }
         var vo:EquipAmuletPhaseVo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(this.StrengthenLevel);
         var value:int = Math.round(Hole6Exp / 10000 * vo["property" + Hole4]);
         return value || 1;
      }
      
      public function get curExp() : int
      {
         return _curExp;
      }
      
      public function set curExp(value:int) : void
      {
         _curExp = value;
      }
      
      public function get isHasLatentEnergy() : Boolean
      {
         if(!latentEnergyEndTime || latentEnergyEndTime.getTime() <= TimeManager.Instance.Now().getTime())
         {
            return false;
         }
         var tmpArray:Array = latentEnergyCurList;
         if(tmpArray[0] == "0" || tmpArray[1] == "0" || tmpArray[2] == "0" || tmpArray[3] == "0")
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
         var tmpArray:Array = latentEnergyNewList;
         if(tmpArray[0] == "0" || tmpArray[1] == "0" || tmpArray[2] == "0" || tmpArray[3] == "0")
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
      
      public function set awakenEquipPro(info:AwakenEquipInfo) : void
      {
         _awakenEquipPro = info;
         dispatchEvent(new GoodsEvent("awakenInfoChange"));
      }
      
      public function get awakenEquipPro() : AwakenEquipInfo
      {
         return _awakenEquipPro;
      }
   }
}
