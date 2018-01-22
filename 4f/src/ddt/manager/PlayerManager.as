package ddt.manager
{
   import GodSyah.SyahManager;
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.energyData.EnergyDataAnalyzer;
   import baglocked.BaglockedManager;
   import beadSystem.data.BeadEvent;
   import beadSystem.model.BeadModel;
   import calendar.CalendarManager;
   import cardSystem.data.CardInfo;
   import cityWide.CityWideEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.yy.game.GameMsgCollector;
   import com.yy.game.GameProfileParams;
   import consortion.ConsortionModelManager;
   import ddt.bagStore.BagStore;
   import ddt.data.AccountInfo;
   import ddt.data.AreaInfo;
   import ddt.data.BagInfo;
   import ddt.data.BuffInfo;
   import ddt.data.CMFriendInfo;
   import ddt.data.CheckCodeData;
   import ddt.data.EquipType;
   import ddt.data.PathInfo;
   import ddt.data.analyze.FriendListAnalyzer;
   import ddt.data.analyze.MyAcademyPlayersAnalyze;
   import ddt.data.analyze.RecentContactsAnalyze;
   import ddt.data.club.ClubInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.PlayerState;
   import ddt.data.player.SelfInfo;
   import ddt.events.BagEvent;
   import ddt.events.CEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.view.CheckCodeFrame;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.caddyII.reader.AwardsInfo;
   import ddt.view.chat.ChatData;
   import ddt.view.im.AddCommunityFriend;
   import ddtBuried.BuriedManager;
   import ddtBuried.event.BuriedEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flashP2P.FlashP2PManager;
   import game.GameManager;
   import gemstone.info.GemstListInfo;
   import gemstone.info.GemstonInitInfo;
   import giftSystem.GiftManager;
   import giftSystem.MyGiftCellInfo;
   import im.CustomInfo;
   import im.IMEvent;
   import kingBless.KingBlessManager;
   import magicStone.data.MagicStoneInfo;
   import mainbutton.MainButtnController;
   import mark.data.MarkBagData;
   import mark.data.MarkChipData;
   import mark.data.MarkProData;
   import pet.data.PetEquipData;
   import pet.data.PetInfo;
   import pet.data.PetSkill;
   import powerUp.PowerUpMovieManager;
   import quest.TaskManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import road7th.utils.BitmapReader;
   import roomList.PassInputFrame;
   import starling.display.player.FightPlayerVo;
   import store.equipGhost.data.EquipGhostData;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   import totem.TotemManager;
   import trainer.controller.SystemOpenPromptManager;
   
   public class PlayerManager extends EventDispatcher
   {
      
      public static const FULL_HP:int = 1;
      
      public static const BAG_UPDATED:String = "bag_update";
      
      public static const PROPBAG_UPDATED:String = "propbag_update";
      
      public static const FRIEND_STATE_CHANGED:String = "friendStateChanged";
      
      public static const FRIENDLIST_COMPLETE:String = "friendListComplete";
      
      public static const RECENT_CONTAST_COMPLETE:String = "recentContactsComplete";
      
      public static const CIVIL_SELFINFO_CHANGE:String = "civilselfinfochange";
      
      public static const VIP_STATE_CHANGE:String = "VIPStateChange";
      
      public static const GIFT_INFO_CHANGE:String = "giftInfoChange";
      
      public static const SELF_GIFT_INFO_CHANGE:String = "selfGiftInfoChange";
      
      public static const NEW_GIFT_UPDATE:String = "newGiftUPDATE";
      
      public static const NEW_GIFT_ADD:String = "newGiftAdd";
      
      public static const FARM_BAG_UPDATE:String = "farmDataUpdate";
      
      public static const UPDATE_PLAYER_PROPERTY:String = "updatePlayerState";
      
      public static const UPDATE_PET:String = "updatePet";
      
      public static const GIRL_HEAD_PHOTO_CHANGE:String = "girl_head_photo_change";
      
      public static const GirlHeadPhotoRoot:String = "http://ddthead.7road.com";
      
      public static var isShowPHP:Boolean = false;
      
      public static const CUSTOM_MAX:int = 10;
      
      public static const VIP_GRADE_MAX:int = 15;
      
      private static var _instance:PlayerManager;
      
      public static const HORSERACING_BUY:int = 1;
      
      public static const WORSHIP_THE_MOON:int = 2;
      
      public static var SelfStudyEnergy:Boolean = true;
       
      
      private var _recentContacts:DictionaryData;
      
      public var customList:Vector.<CustomInfo>;
      
      private var _friendList:DictionaryData;
      
      private var _cmFriendList:DictionaryData;
      
      private var _blackList:DictionaryData;
      
      private var _clubPlays:DictionaryData;
      
      private var _tempList:DictionaryData;
      
      private var _mailTempList:DictionaryData;
      
      private var _myAcademyPlayers:DictionaryData;
      
      private var _sameCityList:Array;
      
      public var energyData:Object;
      
      private var _timer1:TimerJuggler;
      
      private var _timer2:TimerJuggler;
      
      private var _fightPower:int;
      
      private var _bagLockStateList:Array;
      
      private var _isReportGameProfile:Boolean;
      
      private var _playerEquipCategaryIdArr:Array;
      
      private var _self:SelfInfo;
      
      private var _curcentId:int;
      
      public var SelfConsortia:ClubInfo;
      
      private var _fightVo:FightPlayerVo;
      
      private var _account:AccountInfo;
      
      public var vipDiscountArr:Array;
      
      public var vipPriceArr:Array;
      
      public var merryDiscountArr:Array;
      
      public var merryActivity:Boolean = false;
      
      public var vipActivity:Boolean = false;
      
      public var vipDiscountTime:String = "";
      
      public var merryDiscountTime:String = "";
      
      public var kingBuffDiscountArr:Array;
      
      public var kingBuffPriceArr:Array;
      
      public var kingBuffDiscountTime:String = "";
      
      public var kingBuffActivity:Boolean = false;
      
      private var _areaList:DictionaryData;
      
      private var _propertyAdditions:DictionaryData;
      
      private var _whoGetCards:Boolean = false;
      
      private var tempStyle:Array;
      
      private var changedStyle:DictionaryData;
      
      public var gemstoneInfoList:Vector.<GemstonInitInfo>;
      
      public function PlayerManager(){super();}
      
      public static function get Instance() : PlayerManager{return null;}
      
      public static function readLuckyPropertyName(param1:int) : String{return null;}
      
      public function get curcentId() : int{return 0;}
      
      public function set curcentId(param1:int) : void{}
      
      public function get Self() : SelfInfo{return null;}
      
      public function get fightVo() : FightPlayerVo{return null;}
      
      public function setup(param1:AccountInfo) : void{}
      
      public function get Account() : AccountInfo{return null;}
      
      public function getDressEquipPlace(param1:InventoryItemInfo) : int{return 0;}
      
      private function __updateInventorySlot(param1:PkgEvent) : void{}
      
      public function getPlaceOfEquip(param1:InventoryItemInfo) : int{return 0;}
      
      private function showTipWithEquip(param1:InventoryItemInfo) : void{}
      
      private function __itemEquip(param1:PkgEvent) : void{}
      
      private function rezArr(param1:String) : Array{return null;}
      
      private function __onsItemEquip(param1:PkgEvent) : void{}
      
      protected function __onGetBagLockedList(param1:PkgEvent) : void{}
      
      public function isBagLockedPSWNeeded(param1:int) : Boolean{return false;}
      
      public function get bagLockStateList() : Array{return null;}
      
      public function requireBagLockPSWDNeededList() : void{}
      
      public function submitBagLockPSWNeededList(param1:Array) : void{}
      
      private function __bagLockedHandler(param1:PkgEvent) : void{}
      
      private function __friendAdd(param1:PkgEvent) : void{}
      
      public function isNeedPSW(param1:int) : Boolean{return false;}
      
      public function addFriend(param1:PlayerInfo) : void{}
      
      public function addBlackList(param1:FriendListPlayer) : void{}
      
      public function removeFriend(param1:int) : void{}
      
      private function __friendRemove(param1:PkgEvent) : void{}
      
      private function __playerState(param1:PkgEvent) : void{}
      
      private function spouseStateChange(param1:int) : void{}
      
      private function masterStateChange(param1:int, param2:int) : void{}
      
      private function playerStateChange(param1:Object) : void{}
      
      private function initEvents() : void{}
      
      private function __useRoomBordenBoxHanlder(param1:PkgEvent) : void{}
      
      private function __updateRoomBordenBag(param1:PkgEvent) : void{}
      
      private function __gameRate(param1:PkgEvent) : void{}
      
      private function __vipMerryDiscountInfo(param1:CrazyTankSocketEvent) : void{}
      
      private function __onGetPlayerRspecial(param1:PkgEvent) : void{}
      
      protected function __totalCharge(param1:PkgEvent) : void{}
      
      protected function __onUpdateDungeonExp(param1:PkgEvent) : void{}
      
      protected function __updatePeerID(param1:PkgEvent) : void{}
      
      protected function __updateEnergyHandler(param1:PkgEvent) : void{}
      
      protected function __necklaceStrengthInfoUpadte(param1:PkgEvent) : void{}
      
      protected function __updateAreaInfo(param1:PkgEvent) : void{}
      
      public function get areaList() : DictionaryData{return null;}
      
      public function getSelfAreaNameByAreaID() : String{return null;}
      
      public function getAreaNameByAreaID(param1:int) : String{return null;}
      
      private function __onOpenHole(param1:PkgEvent) : void{}
      
      protected function __updatePlayerProperty(param1:PkgEvent) : void{}
      
      public function get propertyAdditions() : DictionaryData{return null;}
      
      private function __roomListPass(param1:CrazyTankSocketEvent) : void{}
      
      private function __sameCity(param1:PkgEvent) : void{}
      
      private function initSameCity() : void{}
      
      private function __chatFilteringFriendsShare(param1:PkgEvent) : void{}
      
      private function __updateUerGuild(param1:PkgEvent) : void{}
      
      private function __getCards(param1:PkgEvent) : void{}
      
      public function get whoGetCards() : Boolean{return false;}
      
      public function set whoGetCards(param1:Boolean) : void{}
      
      private function __sysNotice(param1:CrazyTankSocketEvent) : void{}
      
      private function __canReLoadGift(param1:PkgEvent) : void{}
      
      private function __addGiftItem(param1:PkgEvent) : void{}
      
      private function addItem(param1:int, param2:int) : void{}
      
      private function __getGifts(param1:PkgEvent) : void{}
      
      private function __upVipInfo(param1:PkgEvent) : void{}
      
      public function setupFriendList(param1:FriendListAnalyzer) : void{}
      
      public function setupEnergyData(param1:EnergyDataAnalyzer) : void{}
      
      public function checkHasGroupName(param1:String) : Boolean{return false;}
      
      public function setupMyacademyPlayers(param1:MyAcademyPlayersAnalyze) : void{}
      
      private function romoveAcademyPlayers() : void{}
      
      public function setupRecentContacts(param1:RecentContactsAnalyze) : void{}
      
      public function set friendList(param1:DictionaryData) : void{}
      
      public function get friendList() : DictionaryData{return null;}
      
      public function get friendListOnline() : DictionaryData{return null;}
      
      public function getFriendForCustom(param1:int) : DictionaryData{return null;}
      
      public function deleteCustomGroup(param1:int) : void{}
      
      public function get myAcademyPlayers() : DictionaryData{return null;}
      
      public function get recentContacts() : DictionaryData{return null;}
      
      public function set recentContacts(param1:DictionaryData) : void{}
      
      public function get onlineRecentContactList() : Array{return null;}
      
      public function get offlineRecentContactList() : Array{return null;}
      
      public function getByNameFriend(param1:String) : FriendListPlayer{return null;}
      
      public function deleteRecentContact(param1:int) : void{}
      
      public function get friendAndCustomTitle() : Array{return null;}
      
      public function get onlineFriendList() : Array{return null;}
      
      public function getOnlineFriendForCustom(param1:int) : Array{return null;}
      
      public function get offlineFriendList() : Array{return null;}
      
      public function getOfflineFriendForCustom(param1:int) : Array{return null;}
      
      public function get onlineMyAcademyPlayers() : Array{return null;}
      
      public function get offlineMyAcademyPlayers() : Array{return null;}
      
      public function set blackList(param1:DictionaryData) : void{}
      
      public function get blackList() : DictionaryData{return null;}
      
      public function get CMFriendList() : DictionaryData{return null;}
      
      public function set CMFriendList(param1:DictionaryData) : void{}
      
      public function get PlayCMFriendList() : Array{return null;}
      
      public function get UnPlayCMFriendList() : Array{return null;}
      
      private function __updatePrivateInfo(param1:PkgEvent) : void{}
      
      public function get hasTempStyle() : Boolean{return false;}
      
      public function isChangeStyleTemp(param1:int) : Boolean{return false;}
      
      public function setStyleTemply(param1:Object) : void{}
      
      private function storeTempStyle(param1:PlayerInfo) : void{}
      
      public function readAllTempStyleEvent() : void{}
      
      private function __readTempStyle(param1:CrazyTankSocketEvent) : void{}
      
      private function __updatePlayerInfo(param1:PkgEvent) : void{}
      
      protected function __onTimer1Handler(param1:Event) : void{}
      
      protected function __onTimer2Handler(param1:Event) : void{}
      
      public function getDeputyWeaponIcon(param1:InventoryItemInfo, param2:int = 0) : DisplayObject{return null;}
      
      private function __dailyAwardHandler(param1:PkgEvent) : void{}
      
      public function get checkEnterDungeon() : Boolean{return false;}
      
      public function __checkCodePopup(param1:PkgEvent) : void{}
      
      private function __buffObtain(param1:CrazyTankSocketEvent) : void{}
      
      private function __buffUpdate(param1:CrazyTankSocketEvent) : void{}
      
      public function findPlayerByNickName(param1:PlayerInfo, param2:String) : PlayerInfo{return null;}
      
      public function findPlayer(param1:int, param2:int = -1, param3:String = "") : PlayerInfo{return null;}
      
      public function hasInMailTempList(param1:int) : Boolean{return false;}
      
      public function set mailTempList(param1:DictionaryData) : void{}
      
      public function hasInFriendList(param1:int) : Boolean{return false;}
      
      public function hasInClubPlays(param1:int) : Boolean{return false;}
      
      private function __selfPopChange(param1:PlayerPropertyEvent) : void{}
      
      private function reportGameProfile() : void{}
      
      private function __updatePet(param1:PkgEvent) : void{}
      
      private function __updateOneKeyFinish(param1:PkgEvent) : void{}
      
      public function get isReportGameProfile() : Boolean{return false;}
      
      public function set isReportGameProfile(param1:Boolean) : void{}
   }
}
