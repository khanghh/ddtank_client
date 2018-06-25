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
      
      override public function set NickName(value:String) : void
      {
         .super.NickName = value;
      }
      
      public function set MarryInfoID(value:int) : void
      {
         _marryInfoID = value;
         onPropertiesChanged("MarryInfoID");
      }
      
      public function get MarryInfoID() : int
      {
         return _marryInfoID;
      }
      
      public function set Introduction(value:String) : void
      {
         _civilIntroduction = value;
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
      
      public function set IsPublishEquit(value:Boolean) : void
      {
         _isPublishEquit = value;
         onPropertiesChanged("IsPublishEquit");
      }
      
      public function get IsPublishEquit() : Boolean
      {
         return _isPublishEquit;
      }
      
      public function set bagPwdState($bagpwdstate:Boolean) : void
      {
         _bagPwdState = $bagpwdstate;
      }
      
      public function get bagPwdState() : Boolean
      {
         return _bagPwdState;
      }
      
      public function set bagLocked(b:Boolean) : void
      {
         _bagLocked = b;
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
      
      public function set shouldPassword(value:Boolean) : void
      {
         _shouldPassword = value;
      }
      
      public function onReceiveTypes(value:String) : void
      {
         dispatchEvent(new BagEvent(value,new Dictionary()));
      }
      
      public function resetProps() : void
      {
         _props = new DictionaryData();
      }
      
      public function findOvertimeItems(lefttime:Number = 0) : Array
      {
         return getOverdueItems();
      }
      
      public function getOverdueItems() : Array
      {
         var betoArr:Array = [];
         var hasArr:Array = [];
         var bagA:Array = GoodUtils.getOverdueItemsFrom(PropBag.items);
         var bagB:Array = GoodUtils.getOverdueItemsFrom(FightBag.items);
         var bagC:Array = GoodUtils.getOverdueItemsFrom(Bag.items);
         var body:Array = GoodUtils.getOverdueItemsFrom(ConsortiaBag.items);
         betoArr = betoArr.concat(bagA[0],bagB[0],[],bagC[0]);
         hasArr = hasArr.concat(bagA[1],bagB[1],[],bagC[1]);
         return [betoArr,hasArr];
      }
      
      public function set IsFirst(b:int) : void
      {
         _isFirst = b;
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
      
      public function findItemCount(tempId:int, LimitValue:int = -1) : int
      {
         return Bag.getLimitSLItemCountByTemplateId(tempId,LimitValue);
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
      
      private function loadBodyThingComplete(itemData:DictionaryData, buffData:DictionaryData) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = itemData;
         for each(var i in itemData)
         {
            Bag.addItem(i);
         }
         var _loc8_:int = 0;
         var _loc7_:* = buffData;
         for each(var j in buffData)
         {
            super.addBuff(j);
         }
      }
      
      public function getPveMapPermission(mapid:int, level:int) : Boolean
      {
         return PVEMapPermissionManager.Instance.getPermission(mapid,level,PvePermission);
      }
      
      public function canEquip(info:InventoryItemInfo) : Boolean
      {
         if(!EquipType.canEquip(info))
         {
            if(!isNaN(info.CategoryID))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.data.player.SelfInfo.this"));
            }
         }
         else if(info.getRemainDate() <= 0)
         {
            AddPricePanel.Instance.setInfo(info,true);
            AddPricePanel.Instance.show();
         }
         else if(info.NeedSex != 0 && info.NeedSex != (!!Sex?1:2))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.data.player.SelfInfo.object"));
         }
         else if(info.NeedLevel > Grade)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.data.player.SelfInfo.need"));
         }
         else
         {
            return true;
         }
         return false;
      }
      
      override public function addBuff(buff:BuffInfo) : void
      {
         super.addBuff(buff);
         if(!_timer)
         {
            _timer = TimerManager.getInstance().addTimerJuggler(60000);
            _timer.addEventListener("timer",__refreshSelfInfo);
            _timer.start();
         }
      }
      
      private function __refreshSelfInfo(evt:Event) : void
      {
         refreshBuff();
      }
      
      private function refreshBuff() : void
      {
         var msg:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _buffInfo;
         for each(var buff in _buffInfo)
         {
            if(!BuffControl.isPayBuff(buff))
            {
               if(buff.ValidDate - Math.floor((TimeManager.Instance.Now().time - buff.BeginData.time) / 60000) - 1 == 60)
               {
                  msg = new ChatData();
                  msg.channel = 7;
                  msg.msg = LanguageMgr.GetTranslation("tank.view.buffInfo.outDate",buff.buffName,60);
                  ChatManager.Instance.chat(msg);
               }
            }
         }
      }
      
      public function achievedQuest(id:int) : Boolean
      {
         if(_questList && _questList[id])
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
      
      public function getBag(bagType:int) : BagInfo
      {
         var _loc2_:* = bagType;
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
      
      public function set questionOne(value:String) : void
      {
         _questionOne = value;
      }
      
      public function get questionTwo() : String
      {
         return _questionTwo;
      }
      
      public function set questionTwo(value:String) : void
      {
         _questionTwo = value;
      }
      
      public function get leftTimes() : int
      {
         return _leftTimes;
      }
      
      public function set leftTimes(value:int) : void
      {
         _leftTimes = value;
      }
      
      public function getMedalNum() : int
      {
         var value1:int = PropBag.getItemCountByTemplateId(-300);
         var value2:int = ConsortiaBag.getItemCountByTemplateId(-300);
         return value1 + value2;
      }
      
      public function get OvertimeListByBody() : Array
      {
         return PlayerManager.Instance.Self.Bag.findOvertimeItemsByBody();
      }
      
      public function sendOverTimeListByBody() : void
      {
         var temp:Array = PlayerManager.Instance.Self.Bag.findOvertimeItemsByBodyII();
         var _loc7_:int = 0;
         var _loc6_:* = temp;
         for each(var info in temp)
         {
            if(info.CategoryID == 50 || info.CategoryID == 51 || info.CategoryID == 52)
            {
               if(PlayerManager.Instance.Self.pets.length > 0)
               {
                  var _loc5_:int = 0;
                  var _loc4_:* = PlayerManager.Instance.Self.pets;
                  for(var p in PlayerManager.Instance.Self.pets)
                  {
                     SocketManager.Instance.out.delPetEquip(PlayerManager.Instance.Self.pets[p].Place,info.Place);
                  }
               }
               return;
            }
            SocketManager.Instance.out.sendItemOverDue(info.BagType,info.Place);
         }
      }
      
      override public function set Grade(value:int) : void
      {
         .super.Grade = value;
         if(IsUpGrade && PathManager.solveExternalInterfaceEnabel() && sendedGrade.indexOf(value) == -1)
         {
            ExternalInterfaceManager.sendToAgent(2,ID,NickName,ServerManager.Instance.zoneName,Grade);
            sendedGrade.push(Grade);
         }
      }
      
      public function get weaklessGuildProgress() : ByteArray
      {
         return _weaklessGuildProgress;
      }
      
      public function set weaklessGuildProgress(value:ByteArray) : void
      {
         _weaklessGuildProgress = value;
      }
      
      public function set weaklessGuildProgressStr(value:String) : void
      {
         weaklessGuildProgress = Base64.decodeToByteArray(value);
      }
      
      public function IsWeakGuildFinish(step:int) : Boolean
      {
         if(!WeakGuildManager.Instance.switchUserGuide && step != 300 && step != 301 && step != 107 && step != 91 && step != 90 && step != 70 && step != 65 && step != 15)
         {
            return true;
         }
         if(!_weaklessGuildProgress || step > _weaklessGuildProgress.length * 8 || step < 1)
         {
            return false;
         }
         if(bit(950) && step != 300 && step != 301)
         {
            return true;
         }
         return bit(step);
      }
      
      public function isToffListGuideFinish(step:int) : Boolean
      {
         if(Grade > 20)
         {
            return true;
         }
         return bit(step);
      }
      
      public function isDungeonGuideFinish(step:int) : Boolean
      {
         if(PlayerManager.Instance.Self.Grade > 12)
         {
            return true;
         }
         return bit(step);
      }
      
      public function isMagicStoneGuideFinish(step:int) : Boolean
      {
         if(PlayerManager.Instance.Self.Grade > 45)
         {
            return true;
         }
         return bit(step);
      }
      
      public function isCatchInsectGuideFinish(step:int) : Boolean
      {
         return bit(step);
      }
      
      public function isNewOnceFinish(step:int) : Boolean
      {
         return bit(step);
      }
      
      private function bit(step:int) : Boolean
      {
         step--;
         var index:int = step / 8;
         var offset:int = step % 8;
         if(!_weaklessGuildProgress)
         {
            return false;
         }
         var result:* = _weaklessGuildProgress[index] & 1 << offset;
         return result != 0;
      }
      
      public function get canTakeVipReward() : Boolean
      {
         return _canTakeVipReward;
      }
      
      public function set canTakeVipReward(value:Boolean) : void
      {
         _canTakeVipReward = value;
         onPropertiesChanged("canTakeVipReward");
      }
      
      public function get VIPExpireDay() : Object
      {
         return _VIPExpireDay;
      }
      
      public function set VIPExpireDay(value:Object) : void
      {
         _VIPExpireDay = value;
         onPropertiesChanged("VipExpireDay");
      }
      
      public function set VIPNextLevelDaysNeeded(value:int) : void
      {
         _vipNextLevelDaysNeeded = value;
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
         var hours:int = (VIPExpireDay.valueOf() - systemDate.valueOf()) / 3600000;
         return hours;
      }
      
      public function get isSameDay() : Boolean
      {
         if(LastDate.fullYear == systemDate.fullYear && LastDate.month == systemDate.month && LastDate.date == systemDate.date)
         {
            return true;
         }
         return false;
      }
      
      public function set vipDiscount(value:int) : void
      {
         _vipDiscount = value;
      }
      
      public function get vipDiscount() : int
      {
         return _vipDiscount;
      }
      
      public function set vipDiscountValidity(value:Date) : void
      {
         _vipDiscountValidity = value;
      }
      
      public function get vipDiscountValidity() : Date
      {
         return _vipDiscountValidity;
      }
      
      public function set consortiaInfo(info:ConsortiaInfo) : void
      {
         if(_consortiaInfo == info)
         {
            return;
         }
         consortiaInfo.beginChanges();
         ObjectUtils.copyProperties(consortiaInfo,info);
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
      
      public function set energy(value:int) : void
      {
         if(_energy == value)
         {
            return;
         }
         _energy = value;
         onPropertiesChanged("Energy");
      }
      
      public function get buyEnergyCount() : int
      {
         return _buyEnergyCount;
      }
      
      public function set buyEnergyCount(value:int) : void
      {
         if(_buyEnergyCount == value)
         {
            return;
         }
         _buyEnergyCount = value;
         onPropertiesChanged("BuyEnergyCount");
      }
      
      public function get Gold() : Number
      {
         return _gold;
      }
      
      public function set Gold(value:Number) : void
      {
         if(_gold == value)
         {
            return;
         }
         _gold = value;
         onPropertiesChanged("Gold");
      }
      
      public function get Money() : Number
      {
         return _money;
      }
      
      public function set Money(value:Number) : void
      {
         if(_money == value)
         {
            return;
         }
         _money = value;
         onPropertiesChanged("Money");
      }
      
      public function get BandMoney() : int
      {
         return _bandMoney;
      }
      
      public function set BandMoney(num:int) : void
      {
         _bandMoney = num;
         onPropertiesChanged("BandMoney");
      }
      
      public function get DDTMoney() : Number
      {
         return _ddtMoney;
      }
      
      public function set DDTMoney(value:Number) : void
      {
         if(_ddtMoney == value)
         {
            return;
         }
         _ddtMoney = value;
         onPropertiesChanged("Money");
      }
      
      public function set uesedFinishTime(value:int) : void
      {
         _uesedFinishTime = value;
      }
      
      public function get uesedFinishTime() : int
      {
         return _uesedFinishTime;
      }
      
      public function get cardInfo() : CardInfo
      {
         return _cardInfo;
      }
      
      public function set cardInfo(value:CardInfo) : void
      {
         _cardInfo = value;
      }
      
      public function get isFarmHelper() : Boolean
      {
         return _isFarmHelper;
      }
      
      public function set isFarmHelper(value:Boolean) : void
      {
         _isFarmHelper = value;
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
      
      protected function __petsDataChanged(event:DictionaryEvent) : void
      {
         onPropertiesChanged("Pets");
      }
      
      public function set coin(value:int) : void
      {
         _coin = value;
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
      
      public function set LastServerId(value:int) : void
      {
         _LastServerId = value;
      }
      
      public function get totalCharge() : int
      {
         return _totalCharge;
      }
      
      public function set totalCharge(value:int) : void
      {
         _totalCharge = value;
      }
      
      public function get fishScore() : int
      {
         return _fishScore;
      }
      
      public function set fishScore(value:int) : void
      {
         _fishScore = value;
      }
      
      public function set myHonor(value:int) : void
      {
         _myHonor = value;
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
      
      public function set essence(value:Number) : void
      {
         if(_essence != value)
         {
            _essence = value;
         }
         onPropertiesChanged("Essence");
      }
      
      public function get petScore() : Number
      {
         return _petScore;
      }
      
      public function set petScore(value:Number) : void
      {
         if(_petScore == value)
         {
            return;
         }
         _petScore = value;
         onPropertiesChanged("PetScore");
      }
      
      public function getDungeonCount(mapID:int) : int
      {
         var count:int = _dungeonCount[mapID] || 0;
         return count;
      }
      
      public function setDungeonCount(mapID:int, count:int) : void
      {
         _dungeonCount.add(mapID,count);
      }
      
      public function get ticketNum() : int
      {
         return _ticketNum;
      }
      
      public function set ticketNum(value:int) : void
      {
         _ticketNum = value;
         onPropertiesChanged("ticketNum");
      }
      
      public function get ringUseNum() : DictionaryData
      {
         return _ringUseNum;
      }
      
      public function set ringUseNum(value:DictionaryData) : void
      {
         if(_ringUseNum)
         {
            _ringUseNum.clear();
         }
         _ringUseNum = value;
         onPropertiesChanged("ringUseNum");
      }
      
      public function get stive() : int
      {
         return _stive;
      }
      
      public function set stive(value:int) : void
      {
         if(_stive == value)
         {
            return;
         }
         _stive = value;
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
