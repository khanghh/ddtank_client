package ddt.data.player
{
   import cardSystem.data.CardInfo;
   import com.hurlant.util.Base64;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.BuffInfo;
   import ddt.data.ConsortiaInfo;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.ExternalInterfaceManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PVEMapPermissionManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.ServerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.GoodUtils;
   import ddt.view.buff.BuffControl;
   import ddt.view.chat.ChatData;
   import ddt.view.goods.AddPricePanel;
   import flash.events.Event;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   import trainer.controller.WeakGuildManager;
   
   public class SelfInfo extends PlayerInfo
   {
      
      public static const PET:String = "Pets";
      
      private static const buffScanTime:int = 60;
       
      
      public var CivilPlayerList:Array;
      
      private var _timer:TimerJuggler;
      
      private var _questionOne:String;
      
      private var _questionTwo:String;
      
      private var _leftTimes:int = 5;
      
      public var IsNovice:Boolean;
      
      public var rid:String;
      
      public var _hasPopupLeagueNotice:Boolean;
      
      private var _ticketNum:int;
      
      public var uploadNum:int;
      
      private var _ringUseNum:DictionaryData;
      
      public var SubID:int;
      
      public var SubName:String = "";
      
      public var baiduEnterCode:String;
      
      public var isViewOther:Boolean = false;
      
      private var _marryInfoID:int;
      
      private var _civilIntroduction:String;
      
      private var _isPublishEquit:Boolean;
      
      private var _bagPwdState:Boolean;
      
      private var _bagLocked:Boolean;
      
      private var _shouldPassword:Boolean;
      
      public var IsBanChat:Boolean;
      
      public var _props:DictionaryData;
      
      private var _isFirst:int;
      
      private var FirstLoaded:Boolean = false;
      
      private var _questList:Array;
      
      public var PropBag:BagInfo;
      
      public var FightBag:BagInfo;
      
      public var TempBag:BagInfo;
      
      public var ConsortiaBag:BagInfo;
      
      public var CaddyBag:BagInfo;
      
      public var farmBag:BagInfo;
      
      public var vegetableBag:BagInfo;
      
      public var magicStoneBag:BagInfo;
      
      public var MagicHouseBag:BagInfo;
      
      public var horseAmuletBag:BagInfo;
      
      public var minesBag:BagInfo;
      
      public var roomBordenBag:BagInfo;
      
      private var _overtimeList:Array;
      
      private var sendedGrade:Array;
      
      public var StoreBag:BagInfo;
      
      private var _weaklessGuildProgress:ByteArray;
      
      public var _canTakeVipReward:Boolean;
      
      private var _VIPExpireDay:Object;
      
      public var LastDate:Object;
      
      public var isOldPlayerHasValidEquitAtLogin:Boolean;
      
      private var _vipNextLevelDaysNeeded:int;
      
      public var systemDate:Object;
      
      private var _vipDiscount:int = 0;
      
      private var _vipDiscountValidity:Date;
      
      private var _consortiaInfo:ConsortiaInfo;
      
      private var _energy:int;
      
      private var _buyEnergyCount:int;
      
      private var _gold:Number;
      
      private var _money:Number;
      
      private var _bandMoney:Number = 0;
      
      private var _ddtMoney:Number = 0;
      
      private var _uesedFinishTime:int;
      
      private var _cardInfo:CardInfo;
      
      private var _isFarmHelper:Boolean;
      
      private var _coin:int;
      
      private var _LastServerId:int = -1;
      
      private var _totalCharge:int;
      
      private var _fishScore:int;
      
      private var _myHonor:int;
      
      private var _essence:Number;
      
      private var _petScore:Number = 0;
      
      private var _dungeonCount:DictionaryData;
      
      private var _stive:int;
      
      public var freeInvitedUsedCnt:int = 0;
      
      public function SelfInfo()
      {
         CivilPlayerList = [];
         sendedGrade = [];
         super();
         PropBag = new BagInfo(1,48);
         FightBag = new BagInfo(3,48);
         TempBag = new BagInfo(4,48);
         ConsortiaBag = new BagInfo(11,100);
         StoreBag = new BagInfo(12,11);
         CaddyBag = new BagInfo(5,99);
         farmBag = new BagInfo(13,100);
         vegetableBag = new BagInfo(14,100);
         magicStoneBag = new BagInfo(41,142);
         MagicHouseBag = new BagInfo(51,100);
         horseAmuletBag = new BagInfo(42,144);
         minesBag = new BagInfo(52,64);
         roomBordenBag = new BagInfo(43,54);
         _isSelf = true;
         _dungeonCount = new DictionaryData();
      }
      
      override public function set NickName(param1:String) : void
      {
         .super.NickName = param1;
      }
      
      public function set MarryInfoID(param1:int) : void
      {
         _marryInfoID = param1;
         onPropertiesChanged("MarryInfoID");
      }
      
      public function get MarryInfoID() : int
      {
         return _marryInfoID;
      }
      
      public function set Introduction(param1:String) : void
      {
         _civilIntroduction = param1;
         onPropertiesChanged("Introduction");
      }
      
      public function get Introduction() : String
      {
         if(_civilIntroduction == null)
         {
            _civilIntroduction = "";
         }
         return _civilIntroduction;
      }
      
      public function set IsPublishEquit(param1:Boolean) : void
      {
         _isPublishEquit = param1;
         onPropertiesChanged("IsPublishEquit");
      }
      
      public function get IsPublishEquit() : Boolean
      {
         return _isPublishEquit;
      }
      
      public function set bagPwdState(param1:Boolean) : void
      {
         _bagPwdState = param1;
      }
      
      public function get bagPwdState() : Boolean
      {
         return _bagPwdState;
      }
      
      public function set bagLocked(param1:Boolean) : void
      {
         _bagLocked = param1;
         onPropertiesChanged("bagLocked");
      }
      
      public function get bagLocked() : Boolean
      {
         if(!_bagPwdState)
         {
            return false;
         }
         return _bagLocked;
      }
      
      public function get shouldPassword() : Boolean
      {
         return _shouldPassword;
      }
      
      public function set shouldPassword(param1:Boolean) : void
      {
         _shouldPassword = param1;
      }
      
      public function onReceiveTypes(param1:String) : void
      {
         dispatchEvent(new BagEvent(param1,new Dictionary()));
      }
      
      public function resetProps() : void
      {
         _props = new DictionaryData();
      }
      
      public function findOvertimeItems(param1:Number = 0) : Array
      {
         return getOverdueItems();
      }
      
      public function getOverdueItems() : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = GoodUtils.getOverdueItemsFrom(PropBag.items);
         var _loc5_:Array = GoodUtils.getOverdueItemsFrom(FightBag.items);
         var _loc6_:Array = GoodUtils.getOverdueItemsFrom(Bag.items);
         var _loc1_:Array = GoodUtils.getOverdueItemsFrom(ConsortiaBag.items);
         _loc2_ = _loc2_.concat(_loc4_[0],_loc5_[0],[],_loc6_[0]);
         _loc3_ = _loc3_.concat(_loc4_[1],_loc5_[1],[],_loc6_[1]);
         return [_loc2_,_loc3_];
      }
      
      public function set IsFirst(param1:int) : void
      {
         _isFirst = param1;
         if(_isFirst == 1)
         {
            initIsFirst();
         }
      }
      
      public function get IsFirst() : int
      {
         return _isFirst;
      }
      
      private function initIsFirst() : void
      {
         SharedManager.Instance.isWorldBossBuyBuff = false;
         SharedManager.Instance.isWorldBossBindBuyBuff = false;
         SharedManager.Instance.isWorldBossBuyBuffFull = false;
         SharedManager.Instance.isWorldBossBindBuyBuffFull = false;
         SharedManager.Instance.isRefreshPet = false;
         SharedManager.Instance.isResurrect = false;
         SharedManager.Instance.isReFight = false;
         SharedManager.Instance.save();
      }
      
      public function findItemCount(param1:int, param2:int = -1) : int
      {
         return Bag.getLimitSLItemCountByTemplateId(param1,param2);
      }
      
      public function loadPlayerItem() : void
      {
      }
      
      public function loadRelatedPlayersInfo() : void
      {
         if(FirstLoaded)
         {
            return;
         }
         FirstLoaded = true;
      }
      
      private function loadBodyThingComplete(param1:DictionaryData, param2:DictionaryData) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc4_ in param1)
         {
            Bag.addItem(_loc4_);
         }
         var _loc8_:int = 0;
         var _loc7_:* = param2;
         for each(var _loc3_ in param2)
         {
            super.addBuff(_loc3_);
         }
      }
      
      public function getPveMapPermission(param1:int, param2:int) : Boolean
      {
         return PVEMapPermissionManager.Instance.getPermission(param1,param2,PvePermission);
      }
      
      public function canEquip(param1:InventoryItemInfo) : Boolean
      {
         if(!EquipType.canEquip(param1))
         {
            if(!isNaN(param1.CategoryID))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.data.player.SelfInfo.this"));
            }
         }
         else if(param1.getRemainDate() <= 0)
         {
            AddPricePanel.Instance.setInfo(param1,true);
            AddPricePanel.Instance.show();
         }
         else if(param1.NeedSex != 0 && param1.NeedSex != (!!Sex?1:2))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.data.player.SelfInfo.object"));
         }
         else if(param1.NeedLevel > Grade)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.data.player.SelfInfo.need"));
         }
         else
         {
            return true;
         }
         return false;
      }
      
      override public function addBuff(param1:BuffInfo) : void
      {
         super.addBuff(param1);
         if(!_timer)
         {
            _timer = TimerManager.getInstance().addTimerJuggler(60000);
            _timer.addEventListener("timer",__refreshSelfInfo);
            _timer.start();
         }
      }
      
      private function __refreshSelfInfo(param1:Event) : void
      {
         refreshBuff();
      }
      
      private function refreshBuff() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _buffInfo;
         for each(var _loc1_ in _buffInfo)
         {
            if(!BuffControl.isPayBuff(_loc1_))
            {
               if(_loc1_.ValidDate - Math.floor((TimeManager.Instance.Now().time - _loc1_.BeginData.time) / 60000) - 1 == 60)
               {
                  _loc2_ = new ChatData();
                  _loc2_.channel = 7;
                  _loc2_.msg = LanguageMgr.GetTranslation("tank.view.buffInfo.outDate",_loc1_.buffName,60);
                  ChatManager.Instance.chat(_loc2_);
               }
            }
         }
      }
      
      public function achievedQuest(param1:int) : Boolean
      {
         if(_questList && _questList[param1])
         {
            return true;
         }
         return false;
      }
      
      public function unlockAllBag() : void
      {
         Bag.unLockAll();
         PropBag.unLockAll();
      }
      
      public function getBag(param1:int) : BagInfo
      {
         var _loc2_:* = param1;
         if(0 !== _loc2_)
         {
            if(1 !== _loc2_)
            {
               if(3 !== _loc2_)
               {
                  if(4 !== _loc2_)
                  {
                     if(11 !== _loc2_)
                     {
                        if(12 !== _loc2_)
                        {
                           if(5 !== _loc2_)
                           {
                              if(13 !== _loc2_)
                              {
                                 if(14 !== _loc2_)
                                 {
                                    if(21 !== _loc2_)
                                    {
                                       if(41 !== _loc2_)
                                       {
                                          if(51 !== _loc2_)
                                          {
                                             if(42 !== _loc2_)
                                             {
                                                if(52 !== _loc2_)
                                                {
                                                   if(43 !== _loc2_)
                                                   {
                                                      return null;
                                                   }
                                                   return roomBordenBag;
                                                }
                                                return minesBag;
                                             }
                                             return horseAmuletBag;
                                          }
                                          return MagicHouseBag;
                                       }
                                       return magicStoneBag;
                                    }
                                    return BeadBag;
                                 }
                                 return vegetableBag;
                              }
                              return farmBag;
                           }
                           return CaddyBag;
                        }
                        return StoreBag;
                     }
                     return ConsortiaBag;
                  }
                  return TempBag;
               }
               return FightBag;
            }
            return PropBag;
         }
         return Bag;
      }
      
      public function get questionOne() : String
      {
         return _questionOne;
      }
      
      public function set questionOne(param1:String) : void
      {
         _questionOne = param1;
      }
      
      public function get questionTwo() : String
      {
         return _questionTwo;
      }
      
      public function set questionTwo(param1:String) : void
      {
         _questionTwo = param1;
      }
      
      public function get leftTimes() : int
      {
         return _leftTimes;
      }
      
      public function set leftTimes(param1:int) : void
      {
         _leftTimes = param1;
      }
      
      public function getMedalNum() : int
      {
         var _loc1_:int = PropBag.getItemCountByTemplateId(-300);
         var _loc2_:int = ConsortiaBag.getItemCountByTemplateId(-300);
         return _loc1_ + _loc2_;
      }
      
      public function get OvertimeListByBody() : Array
      {
         return PlayerManager.Instance.Self.Bag.findOvertimeItemsByBody();
      }
      
      public function sendOverTimeListByBody() : void
      {
         var _loc2_:Array = PlayerManager.Instance.Self.Bag.findOvertimeItemsByBodyII();
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.CategoryID == 50 || _loc3_.CategoryID == 51 || _loc3_.CategoryID == 52)
            {
               if(PlayerManager.Instance.Self.pets.length > 0)
               {
                  var _loc5_:int = 0;
                  var _loc4_:* = PlayerManager.Instance.Self.pets;
                  for(var _loc1_ in PlayerManager.Instance.Self.pets)
                  {
                     SocketManager.Instance.out.delPetEquip(PlayerManager.Instance.Self.pets[_loc1_].Place,_loc3_.Place);
                  }
               }
               return;
            }
            SocketManager.Instance.out.sendItemOverDue(_loc3_.BagType,_loc3_.Place);
         }
      }
      
      override public function set Grade(param1:int) : void
      {
         .super.Grade = param1;
         if(IsUpGrade && PathManager.solveExternalInterfaceEnabel() && sendedGrade.indexOf(param1) == -1)
         {
            ExternalInterfaceManager.sendToAgent(2,ID,NickName,ServerManager.Instance.zoneName,Grade);
            sendedGrade.push(Grade);
         }
      }
      
      public function get weaklessGuildProgress() : ByteArray
      {
         return _weaklessGuildProgress;
      }
      
      public function set weaklessGuildProgress(param1:ByteArray) : void
      {
         _weaklessGuildProgress = param1;
      }
      
      public function set weaklessGuildProgressStr(param1:String) : void
      {
         weaklessGuildProgress = Base64.decodeToByteArray(param1);
      }
      
      public function IsWeakGuildFinish(param1:int) : Boolean
      {
         if(!WeakGuildManager.Instance.switchUserGuide && param1 != 300 && param1 != 301 && param1 != 107 && param1 != 91 && param1 != 90 && param1 != 70 && param1 != 65 && param1 != 15 && param1 != 141)
         {
            return true;
         }
         if(!_weaklessGuildProgress || param1 > _weaklessGuildProgress.length * 8 || param1 < 1)
         {
            return false;
         }
         if(bit(950) && param1 != 300 && param1 != 301)
         {
            return true;
         }
         return bit(param1);
      }
      
      public function isToffListGuideFinish(param1:int) : Boolean
      {
         if(Grade > 20)
         {
            return true;
         }
         return bit(param1);
      }
      
      public function isDungeonGuideFinish(param1:int) : Boolean
      {
         if(PlayerManager.Instance.Self.Grade > 12)
         {
            return true;
         }
         return bit(param1);
      }
      
      public function isMagicStoneGuideFinish(param1:int) : Boolean
      {
         if(PlayerManager.Instance.Self.Grade > 45)
         {
            return true;
         }
         return bit(param1);
      }
      
      public function isCatchInsectGuideFinish(param1:int) : Boolean
      {
         return bit(param1);
      }
      
      public function isNewOnceFinish(param1:int) : Boolean
      {
         return bit(param1);
      }
      
      private function bit(param1:int) : Boolean
      {
         param1--;
         var _loc3_:int = param1 / 8;
         var _loc4_:int = param1 % 8;
         if(!_weaklessGuildProgress)
         {
            return false;
         }
         var _loc2_:* = _weaklessGuildProgress[_loc3_] & 1 << _loc4_;
         return _loc2_ != 0;
      }
      
      public function get canTakeVipReward() : Boolean
      {
         return _canTakeVipReward;
      }
      
      public function set canTakeVipReward(param1:Boolean) : void
      {
         _canTakeVipReward = param1;
         onPropertiesChanged("canTakeVipReward");
      }
      
      public function get VIPExpireDay() : Object
      {
         return _VIPExpireDay;
      }
      
      public function set VIPExpireDay(param1:Object) : void
      {
         _VIPExpireDay = param1;
         onPropertiesChanged("VipExpireDay");
      }
      
      public function set VIPNextLevelDaysNeeded(param1:int) : void
      {
         _vipNextLevelDaysNeeded = param1;
         onPropertiesChanged("VIPNextLevelDaysNeeded");
      }
      
      public function get VIPNextLevelDaysNeeded() : int
      {
         return _vipNextLevelDaysNeeded;
      }
      
      public function get VIPLeftDays() : int
      {
         return int(VipLeftHours / 24);
      }
      
      public function get VipLeftHours() : int
      {
         var _loc1_:int = (VIPExpireDay.valueOf() - systemDate.valueOf()) / 3600000;
         return _loc1_;
      }
      
      public function get isSameDay() : Boolean
      {
         if(LastDate.fullYear == systemDate.fullYear && LastDate.month == systemDate.month && LastDate.date == systemDate.date)
         {
            return true;
         }
         return false;
      }
      
      public function set vipDiscount(param1:int) : void
      {
         _vipDiscount = param1;
      }
      
      public function get vipDiscount() : int
      {
         return _vipDiscount;
      }
      
      public function set vipDiscountValidity(param1:Date) : void
      {
         _vipDiscountValidity = param1;
      }
      
      public function get vipDiscountValidity() : Date
      {
         return _vipDiscountValidity;
      }
      
      public function set consortiaInfo(param1:ConsortiaInfo) : void
      {
         if(_consortiaInfo == param1)
         {
            return;
         }
         consortiaInfo.beginChanges();
         ObjectUtils.copyProperties(consortiaInfo,param1);
         consortiaInfo.commitChanges();
         onPropertiesChanged("consortiaInfo");
      }
      
      public function get consortiaInfo() : ConsortiaInfo
      {
         if(_consortiaInfo == null)
         {
            _consortiaInfo = new ConsortiaInfo();
         }
         return _consortiaInfo;
      }
      
      public function get energy() : int
      {
         return _energy;
      }
      
      public function set energy(param1:int) : void
      {
         if(_energy == param1)
         {
            return;
         }
         _energy = param1;
         onPropertiesChanged("Energy");
      }
      
      public function get buyEnergyCount() : int
      {
         return _buyEnergyCount;
      }
      
      public function set buyEnergyCount(param1:int) : void
      {
         if(_buyEnergyCount == param1)
         {
            return;
         }
         _buyEnergyCount = param1;
         onPropertiesChanged("BuyEnergyCount");
      }
      
      public function get Gold() : Number
      {
         return _gold;
      }
      
      public function set Gold(param1:Number) : void
      {
         if(_gold == param1)
         {
            return;
         }
         _gold = param1;
         onPropertiesChanged("Gold");
      }
      
      public function get Money() : Number
      {
         return _money;
      }
      
      public function set Money(param1:Number) : void
      {
         if(_money == param1)
         {
            return;
         }
         _money = param1;
         onPropertiesChanged("Money");
      }
      
      public function get BandMoney() : int
      {
         return _bandMoney;
      }
      
      public function set BandMoney(param1:int) : void
      {
         _bandMoney = param1;
         onPropertiesChanged("BandMoney");
      }
      
      public function get DDTMoney() : Number
      {
         return _ddtMoney;
      }
      
      public function set DDTMoney(param1:Number) : void
      {
         if(_ddtMoney == param1)
         {
            return;
         }
         _ddtMoney = param1;
         onPropertiesChanged("Money");
      }
      
      public function set uesedFinishTime(param1:int) : void
      {
         _uesedFinishTime = param1;
      }
      
      public function get uesedFinishTime() : int
      {
         return _uesedFinishTime;
      }
      
      public function get cardInfo() : CardInfo
      {
         return _cardInfo;
      }
      
      public function set cardInfo(param1:CardInfo) : void
      {
         _cardInfo = param1;
      }
      
      public function get isFarmHelper() : Boolean
      {
         return _isFarmHelper;
      }
      
      public function set isFarmHelper(param1:Boolean) : void
      {
         _isFarmHelper = param1;
      }
      
      override public function get pets() : DictionaryData
      {
         if(_pets == null)
         {
            _pets = new DictionaryData();
            _pets.addEventListener("add",__petsDataChanged);
            _pets.addEventListener("remove",__petsDataChanged);
         }
         return _pets;
      }
      
      protected function __petsDataChanged(param1:DictionaryEvent) : void
      {
         onPropertiesChanged("Pets");
      }
      
      public function set coin(param1:int) : void
      {
         _coin = param1;
         onPropertiesChanged("coin");
      }
      
      public function get coin() : int
      {
         return _coin;
      }
      
      public function get LastServerId() : int
      {
         return _LastServerId;
      }
      
      public function set LastServerId(param1:int) : void
      {
         _LastServerId = param1;
      }
      
      public function get totalCharge() : int
      {
         return _totalCharge;
      }
      
      public function set totalCharge(param1:int) : void
      {
         _totalCharge = param1;
      }
      
      public function get fishScore() : int
      {
         return _fishScore;
      }
      
      public function set fishScore(param1:int) : void
      {
         _fishScore = param1;
      }
      
      public function set myHonor(param1:int) : void
      {
         _myHonor = param1;
         onPropertiesChanged("myHonor");
      }
      
      public function get myHonor() : int
      {
         return _myHonor;
      }
      
      public function get essence() : Number
      {
         return _essence;
      }
      
      public function set essence(param1:Number) : void
      {
         if(_essence != param1)
         {
            _essence = param1;
         }
         onPropertiesChanged("Essence");
      }
      
      public function get petScore() : Number
      {
         return _petScore;
      }
      
      public function set petScore(param1:Number) : void
      {
         if(_petScore == param1)
         {
            return;
         }
         _petScore = param1;
         onPropertiesChanged("PetScore");
      }
      
      public function getDungeonCount(param1:int) : int
      {
         var _loc2_:int = _dungeonCount[param1] || 0;
         return _loc2_;
      }
      
      public function setDungeonCount(param1:int, param2:int) : void
      {
         _dungeonCount.add(param1,param2);
      }
      
      public function get ticketNum() : int
      {
         return _ticketNum;
      }
      
      public function set ticketNum(param1:int) : void
      {
         _ticketNum = param1;
         onPropertiesChanged("ticketNum");
      }
      
      public function get ringUseNum() : DictionaryData
      {
         return _ringUseNum;
      }
      
      public function set ringUseNum(param1:DictionaryData) : void
      {
         if(_ringUseNum)
         {
            _ringUseNum.clear();
         }
         _ringUseNum = param1;
         onPropertiesChanged("ringUseNum");
      }
      
      public function get stive() : int
      {
         return _stive;
      }
      
      public function set stive(param1:int) : void
      {
         if(_stive == param1)
         {
            return;
         }
         _stive = param1;
         onPropertiesChanged("stive");
      }
      
      public function checkFreeInvite() : Boolean
      {
         if(Grade >= ServerConfigManager.instance.FreeInviteLevelMin && Grade <= ServerConfigManager.instance.FreeInviteLevelMax)
         {
            return freeInviteCnt > 0;
         }
         return false;
      }
      
      public function get freeInviteCnt() : int
      {
         return Math.max(0,ServerConfigManager.instance.FreeInviteCount - freeInvitedUsedCnt);
      }
   }
}

class DateGeter
{
   
   public static var date:Date;
    
   
   function DateGeter()
   {
      super();
   }
}
