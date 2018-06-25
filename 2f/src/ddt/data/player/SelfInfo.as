package ddt.data.player{   import cardSystem.data.CardInfo;   import com.hurlant.util.Base64;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.BuffInfo;   import ddt.data.ConsortiaInfo;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.manager.ChatManager;   import ddt.manager.ExternalInterfaceManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PVEMapPermissionManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.ServerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.TimeManager;   import ddt.utils.GoodUtils;   import ddt.view.buff.BuffControl;   import ddt.view.chat.ChatData;   import ddt.view.goods.AddPricePanel;   import flash.events.Event;   import flash.utils.ByteArray;   import flash.utils.Dictionary;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;   import trainer.controller.WeakGuildManager;      public class SelfInfo extends PlayerInfo   {            public static const PET:String = "Pets";            private static const buffScanTime:int = 60;                   public var CivilPlayerList:Array;            private var _timer:TimerJuggler;            private var _questionOne:String;            private var _questionTwo:String;            private var _leftTimes:int = 5;            public var IsNovice:Boolean;            public var rid:String;            public var _hasPopupLeagueNotice:Boolean;            private var _ticketNum:int;            public var uploadNum:int;            private var _ringUseNum:DictionaryData;            public var SubID:int;            public var SubName:String = "";            public var baiduEnterCode:String;            public var isViewOther:Boolean = false;            private var _marryInfoID:int;            private var _civilIntroduction:String;            private var _isPublishEquit:Boolean;            private var _bagPwdState:Boolean;            private var _bagLocked:Boolean;            private var _shouldPassword:Boolean;            public var IsBanChat:Boolean;            public var _props:DictionaryData;            private var _isFirst:int;            private var FirstLoaded:Boolean = false;            private var _questList:Array;            public var PropBag:BagInfo;            public var FightBag:BagInfo;            public var TempBag:BagInfo;            public var ConsortiaBag:BagInfo;            public var CaddyBag:BagInfo;            public var farmBag:BagInfo;            public var vegetableBag:BagInfo;            public var magicStoneBag:BagInfo;            public var MagicHouseBag:BagInfo;            public var horseAmuletBag:BagInfo;            public var minesBag:BagInfo;            public var roomBordenBag:BagInfo;            private var _overtimeList:Array;            private var sendedGrade:Array;            public var StoreBag:BagInfo;            private var _weaklessGuildProgress:ByteArray;            public var _canTakeVipReward:Boolean;            private var _VIPExpireDay:Object;            public var LastDate:Object;            public var isOldPlayerHasValidEquitAtLogin:Boolean;            private var _vipNextLevelDaysNeeded:int;            public var systemDate:Object;            private var _vipDiscount:int = 0;            private var _vipDiscountValidity:Date;            private var _consortiaInfo:ConsortiaInfo;            private var _energy:int;            private var _buyEnergyCount:int;            private var _gold:Number;            private var _money:Number;            private var _bandMoney:Number = 0;            private var _ddtMoney:Number = 0;            private var _uesedFinishTime:int;            private var _cardInfo:CardInfo;            private var _isFarmHelper:Boolean;            private var _coin:int;            private var _LastServerId:int = -1;            private var _totalCharge:int;            private var _fishScore:int;            private var _myHonor:int;            private var _essence:Number;            private var _petScore:Number = 0;            private var _dungeonCount:DictionaryData;            private var _stive:int;            public var freeInvitedUsedCnt:int = 0;            public function SelfInfo() { super(); }
            override public function set NickName(value:String) : void { }
            public function set MarryInfoID(value:int) : void { }
            public function get MarryInfoID() : int { return 0; }
            public function set Introduction(value:String) : void { }
            public function get Introduction() : String { return null; }
            public function set IsPublishEquit(value:Boolean) : void { }
            public function get IsPublishEquit() : Boolean { return false; }
            public function set bagPwdState($bagpwdstate:Boolean) : void { }
            public function get bagPwdState() : Boolean { return false; }
            public function set bagLocked(b:Boolean) : void { }
            public function get bagLocked() : Boolean { return false; }
            public function get shouldPassword() : Boolean { return false; }
            public function set shouldPassword(value:Boolean) : void { }
            public function onReceiveTypes(value:String) : void { }
            public function resetProps() : void { }
            public function findOvertimeItems(lefttime:Number = 0) : Array { return null; }
            public function getOverdueItems() : Array { return null; }
            public function set IsFirst(b:int) : void { }
            public function get IsFirst() : int { return 0; }
            private function initIsFirst() : void { }
            public function findItemCount(tempId:int, LimitValue:int = -1) : int { return 0; }
            public function loadPlayerItem() : void { }
            public function loadRelatedPlayersInfo() : void { }
            private function loadBodyThingComplete(itemData:DictionaryData, buffData:DictionaryData) : void { }
            public function getPveMapPermission(mapid:int, level:int) : Boolean { return false; }
            public function canEquip(info:InventoryItemInfo) : Boolean { return false; }
            override public function addBuff(buff:BuffInfo) : void { }
            private function __refreshSelfInfo(evt:Event) : void { }
            private function refreshBuff() : void { }
            public function achievedQuest(id:int) : Boolean { return false; }
            public function unlockAllBag() : void { }
            public function getBag(bagType:int) : BagInfo { return null; }
            public function get questionOne() : String { return null; }
            public function set questionOne(value:String) : void { }
            public function get questionTwo() : String { return null; }
            public function set questionTwo(value:String) : void { }
            public function get leftTimes() : int { return 0; }
            public function set leftTimes(value:int) : void { }
            public function getMedalNum() : int { return 0; }
            public function get OvertimeListByBody() : Array { return null; }
            public function sendOverTimeListByBody() : void { }
            override public function set Grade(value:int) : void { }
            public function get weaklessGuildProgress() : ByteArray { return null; }
            public function set weaklessGuildProgress(value:ByteArray) : void { }
            public function set weaklessGuildProgressStr(value:String) : void { }
            public function IsWeakGuildFinish(step:int) : Boolean { return false; }
            public function isToffListGuideFinish(step:int) : Boolean { return false; }
            public function isDungeonGuideFinish(step:int) : Boolean { return false; }
            public function isMagicStoneGuideFinish(step:int) : Boolean { return false; }
            public function isCatchInsectGuideFinish(step:int) : Boolean { return false; }
            public function isNewOnceFinish(step:int) : Boolean { return false; }
            private function bit(step:int) : Boolean { return false; }
            public function get canTakeVipReward() : Boolean { return false; }
            public function set canTakeVipReward(value:Boolean) : void { }
            public function get VIPExpireDay() : Object { return null; }
            public function set VIPExpireDay(value:Object) : void { }
            public function set VIPNextLevelDaysNeeded(value:int) : void { }
            public function get VIPNextLevelDaysNeeded() : int { return 0; }
            public function get VIPLeftDays() : int { return 0; }
            public function get VipLeftHours() : int { return 0; }
            public function get isSameDay() : Boolean { return false; }
            public function set vipDiscount(value:int) : void { }
            public function get vipDiscount() : int { return 0; }
            public function set vipDiscountValidity(value:Date) : void { }
            public function get vipDiscountValidity() : Date { return null; }
            public function set consortiaInfo(info:ConsortiaInfo) : void { }
            public function get consortiaInfo() : ConsortiaInfo { return null; }
            public function get energy() : int { return 0; }
            public function set energy(value:int) : void { }
            public function get buyEnergyCount() : int { return 0; }
            public function set buyEnergyCount(value:int) : void { }
            public function get Gold() : Number { return 0; }
            public function set Gold(value:Number) : void { }
            public function get Money() : Number { return 0; }
            public function set Money(value:Number) : void { }
            public function get BandMoney() : int { return 0; }
            public function set BandMoney(num:int) : void { }
            public function get DDTMoney() : Number { return 0; }
            public function set DDTMoney(value:Number) : void { }
            public function set uesedFinishTime(value:int) : void { }
            public function get uesedFinishTime() : int { return 0; }
            public function get cardInfo() : CardInfo { return null; }
            public function set cardInfo(value:CardInfo) : void { }
            public function get isFarmHelper() : Boolean { return false; }
            public function set isFarmHelper(value:Boolean) : void { }
            override public function get pets() : DictionaryData { return null; }
            protected function __petsDataChanged(event:DictionaryEvent) : void { }
            public function set coin(value:int) : void { }
            public function get coin() : int { return 0; }
            public function get LastServerId() : int { return 0; }
            public function set LastServerId(value:int) : void { }
            public function get totalCharge() : int { return 0; }
            public function set totalCharge(value:int) : void { }
            public function get fishScore() : int { return 0; }
            public function set fishScore(value:int) : void { }
            public function set myHonor(value:int) : void { }
            public function get myHonor() : int { return 0; }
            public function get essence() : Number { return 0; }
            public function set essence(value:Number) : void { }
            public function get petScore() : Number { return 0; }
            public function set petScore(value:Number) : void { }
            public function getDungeonCount(mapID:int) : int { return 0; }
            public function setDungeonCount(mapID:int, count:int) : void { }
            public function get ticketNum() : int { return 0; }
            public function set ticketNum(value:int) : void { }
            public function get ringUseNum() : DictionaryData { return null; }
            public function set ringUseNum(value:DictionaryData) : void { }
            public function get stive() : int { return 0; }
            public function set stive(value:int) : void { }
            public function checkFreeInvite() : Boolean { return false; }
            public function get freeInviteCnt() : int { return 0; }
   }}class DateGeter{      public static var date:Date;          function DateGeter() { super(); }
}