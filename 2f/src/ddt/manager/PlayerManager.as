package ddt.manager{   import GodSyah.SyahManager;   import bagAndInfo.BagAndInfoManager;   import bagAndInfo.cell.BagCell;   import bagAndInfo.energyData.EnergyDataAnalyzer;   import baglocked.BaglockedManager;   import beadSystem.data.BeadEvent;   import beadSystem.model.BeadModel;   import calendar.CalendarManager;   import cardSystem.data.CardInfo;   import cityWide.CityWideEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.yy.game.GameMsgCollector;   import com.yy.game.GameProfileParams;   import consortion.ConsortionModelManager;   import ddt.bagStore.BagStore;   import ddt.data.AccountInfo;   import ddt.data.AreaInfo;   import ddt.data.BagInfo;   import ddt.data.BuffInfo;   import ddt.data.CMFriendInfo;   import ddt.data.CheckCodeData;   import ddt.data.EquipType;   import ddt.data.PathInfo;   import ddt.data.analyze.FriendListAnalyzer;   import ddt.data.analyze.MyAcademyPlayersAnalyze;   import ddt.data.analyze.RecentContactsAnalyze;   import ddt.data.club.ClubInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.player.FriendListPlayer;   import ddt.data.player.PlayerInfo;   import ddt.data.player.PlayerState;   import ddt.data.player.SelfInfo;   import ddt.events.BagEvent;   import ddt.events.CEvent;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.PkgEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.view.CheckCodeFrame;   import ddt.view.caddyII.CaddyModel;   import ddt.view.caddyII.reader.AwardsInfo;   import ddt.view.chat.ChatData;   import ddt.view.im.AddCommunityFriend;   import ddtBuried.BuriedManager;   import ddtBuried.event.BuriedEvent;   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.utils.ByteArray;   import flashP2P.FlashP2PManager;   import game.GameManager;   import gemstone.info.GemstListInfo;   import gemstone.info.GemstonInitInfo;   import giftSystem.GiftManager;   import giftSystem.MyGiftCellInfo;   import im.CustomInfo;   import im.IMEvent;   import kingBless.KingBlessManager;   import magicStone.data.MagicStoneInfo;   import mainbutton.MainButtnController;   import mark.data.MarkBagData;   import mark.data.MarkChipData;   import mark.data.MarkProData;   import pet.data.PetEquipData;   import pet.data.PetInfo;   import pet.data.PetSkill;   import powerUp.PowerUpMovieManager;   import quest.TaskManager;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;   import road7th.utils.BitmapReader;   import roomList.PassInputFrame;   import starling.display.player.FightPlayerVo;   import store.equipGhost.data.EquipGhostData;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;   import totem.TotemManager;   import trainer.controller.SystemOpenPromptManager;      public class PlayerManager extends EventDispatcher   {            public static const FULL_HP:int = 1;            public static const BAG_UPDATED:String = "bag_update";            public static const PROPBAG_UPDATED:String = "propbag_update";            public static const FRIEND_STATE_CHANGED:String = "friendStateChanged";            public static const FRIENDLIST_COMPLETE:String = "friendListComplete";            public static const RECENT_CONTAST_COMPLETE:String = "recentContactsComplete";            public static const CIVIL_SELFINFO_CHANGE:String = "civilselfinfochange";            public static const VIP_STATE_CHANGE:String = "VIPStateChange";            public static const GIFT_INFO_CHANGE:String = "giftInfoChange";            public static const SELF_GIFT_INFO_CHANGE:String = "selfGiftInfoChange";            public static const NEW_GIFT_UPDATE:String = "newGiftUPDATE";            public static const NEW_GIFT_ADD:String = "newGiftAdd";            public static const FARM_BAG_UPDATE:String = "farmDataUpdate";            public static const UPDATE_PLAYER_PROPERTY:String = "updatePlayerState";            public static const UPDATE_PET:String = "updatePet";            public static const GIRL_HEAD_PHOTO_CHANGE:String = "girl_head_photo_change";            public static const GirlHeadPhotoRoot:String = "http://ddthead.7road.com";            public static var isShowPHP:Boolean = false;            public static const CUSTOM_MAX:int = 10;            public static const VIP_GRADE_MAX:int = 15;            private static var _instance:PlayerManager;            public static const HORSERACING_BUY:int = 1;            public static const WORSHIP_THE_MOON:int = 2;            public static var SelfStudyEnergy:Boolean = true;                   private var _recentContacts:DictionaryData;            public var customList:Vector.<CustomInfo>;            private var _friendList:DictionaryData;            private var _cmFriendList:DictionaryData;            private var _blackList:DictionaryData;            private var _clubPlays:DictionaryData;            private var _tempList:DictionaryData;            private var _mailTempList:DictionaryData;            private var _myAcademyPlayers:DictionaryData;            private var _sameCityList:Array;            public var energyData:Object;            private var _timer1:TimerJuggler;            private var _timer2:TimerJuggler;            private var _fightPower:int;            private var _bagLockStateList:Array;            private var _isReportGameProfile:Boolean;            private var _playerEquipCategaryIdArr:Array;            private var _self:SelfInfo;            private var _curcentId:int;            public var SelfConsortia:ClubInfo;            private var _fightVo:FightPlayerVo;            private var _account:AccountInfo;            public var vipDiscountArr:Array;            public var vipPriceArr:Array;            public var merryDiscountArr:Array;            public var merryActivity:Boolean = false;            public var vipActivity:Boolean = false;            public var vipDiscountTime:String = "";            public var merryDiscountTime:String = "";            public var kingBuffDiscountArr:Array;            public var kingBuffPriceArr:Array;            public var kingBuffDiscountTime:String = "";            public var kingBuffActivity:Boolean = false;            private var _areaList:DictionaryData;            private var _propertyAdditions:DictionaryData;            private var _whoGetCards:Boolean = false;            private var tempStyle:Array;            private var changedStyle:DictionaryData;            public var gemstoneInfoList:Vector.<GemstonInitInfo>;            public function PlayerManager() { super(); }
            public static function get Instance() : PlayerManager { return null; }
            public static function readLuckyPropertyName(id:int) : String { return null; }
            public function get curcentId() : int { return 0; }
            public function set curcentId(value:int) : void { }
            public function get Self() : SelfInfo { return null; }
            public function get fightVo() : FightPlayerVo { return null; }
            public function setup(acc:AccountInfo) : void { }
            public function get Account() : AccountInfo { return null; }
            public function getDressEquipPlace(info:InventoryItemInfo) : int { return 0; }
            private function __updateInventorySlot(evt:PkgEvent) : void { }
            public function getPlaceOfEquip(item:InventoryItemInfo) : int { return 0; }
            private function showTipWithEquip(item:InventoryItemInfo) : void { }
            private function __itemEquip(evt:PkgEvent) : void { }
            private function rezArr(str:String) : Array { return null; }
            private function __onsItemEquip(evt:PkgEvent) : void { }
            protected function __onGetBagLockedList(e:PkgEvent) : void { }
            public function isBagLockedPSWNeeded(type:int) : Boolean { return false; }
            public function get bagLockStateList() : Array { return null; }
            public function requireBagLockPSWDNeededList() : void { }
            public function submitBagLockPSWNeededList(list:Array) : void { }
            private function __bagLockedHandler(evt:PkgEvent) : void { }
            private function __friendAdd(evt:PkgEvent) : void { }
            public function isNeedPSW(type:int) : Boolean { return false; }
            public function addFriend(player:PlayerInfo) : void { }
            public function addBlackList(player:FriendListPlayer) : void { }
            public function removeFriend(id:int) : void { }
            private function __friendRemove(evt:PkgEvent) : void { }
            private function __playerState(evt:PkgEvent) : void { }
            private function spouseStateChange(state:int) : void { }
            private function masterStateChange(state:int, clientId:int) : void { }
            private function playerStateChange(obj:Object) : void { }
            private function initEvents() : void { }
            private function __useRoomBordenBoxHanlder(e:PkgEvent) : void { }
            private function __updateRoomBordenBag(e:PkgEvent) : void { }
            private function __gameRate(event:PkgEvent) : void { }
            private function __vipMerryDiscountInfo(event:CrazyTankSocketEvent) : void { }
            private function __onGetPlayerRspecial(e:PkgEvent) : void { }
            protected function __totalCharge(event:PkgEvent) : void { }
            protected function __onUpdateDungeonExp(event:PkgEvent) : void { }
            protected function __updatePeerID(event:PkgEvent) : void { }
            protected function __updateEnergyHandler(event:PkgEvent) : void { }
            protected function __necklaceStrengthInfoUpadte(event:PkgEvent) : void { }
            protected function __updateAreaInfo(event:PkgEvent) : void { }
            public function get areaList() : DictionaryData { return null; }
            public function getSelfAreaNameByAreaID() : String { return null; }
            public function getAreaNameByAreaID(areaID:int) : String { return null; }
            private function __onOpenHole(pEvent:PkgEvent) : void { }
            protected function __updatePlayerProperty(event:PkgEvent) : void { }
            public function get propertyAdditions() : DictionaryData { return null; }
            private function __roomListPass(evt:CrazyTankSocketEvent) : void { }
            private function __sameCity(event:PkgEvent) : void { }
            private function initSameCity() : void { }
            private function __chatFilteringFriendsShare(event:PkgEvent) : void { }
            private function __updateUerGuild(event:PkgEvent) : void { }
            private function __getCards(event:PkgEvent) : void { }
            public function get whoGetCards() : Boolean { return false; }
            public function set whoGetCards(value:Boolean) : void { }
            private function __sysNotice(event:CrazyTankSocketEvent) : void { }
            private function __canReLoadGift(event:PkgEvent) : void { }
            private function __addGiftItem(event:PkgEvent) : void { }
            private function addItem(templateId:int, amount:int) : void { }
            private function __getGifts(event:PkgEvent) : void { }
            private function __upVipInfo(evt:PkgEvent) : void { }
            public function setupFriendList(analyzer:FriendListAnalyzer) : void { }
            public function setupEnergyData(analyzer:EnergyDataAnalyzer) : void { }
            public function checkHasGroupName(name:String) : Boolean { return false; }
            public function setupMyacademyPlayers(analyzer:MyAcademyPlayersAnalyze) : void { }
            private function romoveAcademyPlayers() : void { }
            public function setupRecentContacts(analyzer:RecentContactsAnalyze) : void { }
            public function set friendList(value:DictionaryData) : void { }
            public function get friendList() : DictionaryData { return null; }
            public function get friendListOnline() : DictionaryData { return null; }
            public function getFriendForCustom(relation:int) : DictionaryData { return null; }
            public function deleteCustomGroup(relation:int) : void { }
            public function get myAcademyPlayers() : DictionaryData { return null; }
            public function get recentContacts() : DictionaryData { return null; }
            public function set recentContacts(value:DictionaryData) : void { }
            public function get onlineRecentContactList() : Array { return null; }
            public function get offlineRecentContactList() : Array { return null; }
            public function getByNameFriend(name:String) : FriendListPlayer { return null; }
            public function deleteRecentContact(id:int) : void { }
            public function get friendAndCustomTitle() : Array { return null; }
            public function get onlineFriendList() : Array { return null; }
            public function getOnlineFriendForCustom(relation:int) : Array { return null; }
            public function get offlineFriendList() : Array { return null; }
            public function getOfflineFriendForCustom(relation:int) : Array { return null; }
            public function get onlineMyAcademyPlayers() : Array { return null; }
            public function get offlineMyAcademyPlayers() : Array { return null; }
            public function set blackList(value:DictionaryData) : void { }
            public function get blackList() : DictionaryData { return null; }
            public function get CMFriendList() : DictionaryData { return null; }
            public function set CMFriendList(value:DictionaryData) : void { }
            public function get PlayCMFriendList() : Array { return null; }
            public function get UnPlayCMFriendList() : Array { return null; }
            private function __updatePrivateInfo(e:PkgEvent) : void { }
            public function get hasTempStyle() : Boolean { return false; }
            public function isChangeStyleTemp(id:int) : Boolean { return false; }
            public function setStyleTemply(tempPlayerStyle:Object) : void { }
            private function storeTempStyle(player:PlayerInfo) : void { }
            public function readAllTempStyleEvent() : void { }
            private function __readTempStyle(evt:CrazyTankSocketEvent) : void { }
            private function __updatePlayerInfo(evt:PkgEvent) : void { }
            protected function __onTimer1Handler(event:Event) : void { }
            protected function __onTimer2Handler(event:Event) : void { }
            public function getDeputyWeaponIcon(deputyWeapon:InventoryItemInfo, type:int = 0) : DisplayObject { return null; }
            private function __dailyAwardHandler(evt:PkgEvent) : void { }
            public function get checkEnterDungeon() : Boolean { return false; }
            public function __checkCodePopup(e:PkgEvent) : void { }
            private function __buffObtain(evt:CrazyTankSocketEvent) : void { }
            private function __buffUpdate(evt:CrazyTankSocketEvent) : void { }
            public function findPlayerByNickName(info:PlayerInfo, nickName:String) : PlayerInfo { return null; }
            public function findPlayer(id:int, zoneID:int = -1, nickName:String = "") : PlayerInfo { return null; }
            public function hasInMailTempList(id:int) : Boolean { return false; }
            public function set mailTempList(value:DictionaryData) : void { }
            public function hasInFriendList(id:int) : Boolean { return false; }
            public function hasInClubPlays(id:int) : Boolean { return false; }
            private function __selfPopChange(e:PlayerPropertyEvent) : void { }
            private function reportGameProfile() : void { }
            private function __updatePet(event:PkgEvent) : void { }
            private function __updateOneKeyFinish(event:PkgEvent) : void { }
            public function get isReportGameProfile() : Boolean { return false; }
            public function set isReportGameProfile(value:Boolean) : void { }
   }}