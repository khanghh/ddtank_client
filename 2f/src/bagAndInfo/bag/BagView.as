package bagAndInfo.bag
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.ReworkName.ReworkNameBattleTeam;
   import bagAndInfo.ReworkName.ReworkNameConsortia;
   import bagAndInfo.ReworkName.ReworkNameFrame;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.changeSex.ChangeSexAlertFrame;
   import baglocked.BaglockedManager;
   import beadSystem.beadSystemManager;
   import beadSystem.controls.BeadBagList;
   import beadSystem.controls.BeadCell;
   import beadSystem.controls.BeadFeedButton;
   import beadSystem.controls.BeadLockButton;
   import beadSystem.data.BeadEvent;
   import beadSystem.model.BeadModel;
   import calendar.CalendarManager;
   import cardSystem.CardManager;
   import cardSystem.CardSocketEvent;
   import cardSystem.CardSystemEvent;
   import cardSystem.data.CardInfo;
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.OutMainListPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.alert.SimpleAlert;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.selfConsortia.ConsortionBankBagView;
   import ddt.bagStore.BagStore;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.BagEvent;
   import ddt.events.CEvent;
   import ddt.events.CellEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.ChangeColorManager;
   import ddt.manager.DragManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.RandomSuitCardManager;
   import ddt.manager.RouletteManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SharedManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.ChatBugleInputFrame;
   import ddt.view.goods.AddPricePanel;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.media.SoundTransform;
   import flash.ui.Mouse;
   import flash.utils.getQualifiedClassName;
   import horse.HorseManager;
   import itemActivityGift.ItemActivityGiftManager;
   import petsBag.PetsBagManager;
   import petsBag.event.UpdatePetInfoEvent;
   import petsBag.petsAdvanced.PetsAdvancedManager;
   import playerDress.PlayerDressManager;
   import playerDress.components.DressModel;
   import playerDress.components.DressUtils;
   import playerDress.data.DressVo;
   import playerDress.event.PlayerDressEvent;
   import quest.TaskManager;
   import quest.TrusteeshipManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import road7th.utils.DateUtils;
   import texpSystem.controller.TexpManager;
   import vipCoupons.VIPCouponsManager;
   import wonderfulActivity.WonderfulActivityManager;
   
   [Event(name="sellstart")]
   [Event(name="sellstop")]
   public class BagView extends Sprite implements Disposeable
   {
      
      public static const FIRST_GET_CARD:String = "firstGetCard";
      
      public static const TABCHANGE:String = "tabChange";
      
      public static const SHOWBEAD:String = "showBeadFrame";
      
      public static const EQUIP:int = 0;
      
      public static const PROP:int = 1;
      
      public static const CARD:int = 2;
      
      public static const CONSORTION:int = 3;
      
      public static const PET:int = 5;
      
      public static const BEAD:int = 21;
      
      public static const DRESS:int = 8;
      
      public static const MAGICHOUSE:int = 51;
      
      public static const MARK:int = 100;
      
      public static var isShowCardBag:Boolean = false;
      
      private static const UseColorShellLevel:int = 10;
       
      
      private var _index:int = 0;
      
      private const STATE_SELL:uint = 1;
      
      private const STATE_BEADFEED:uint = 1;
      
      private var bead_state:uint = 0;
      
      protected var _bgShape:Shape;
      
      protected var _bgShapeII:MovieImage;
      
      private var state:uint = 0;
      
      private var _info:SelfInfo;
      
      protected var _equiplist:BagEquipListView;
      
      protected var _proplist:BagListView;
      
      protected var _petlist:PetBagListView;
      
      protected var _beadList:BeadBagList;
      
      protected var _beadList2:BeadBagList;
      
      protected var _beadList3:BeadBagList;
      
      protected var _dressbagView:Sprite;
      
      protected var _currIndex:int = 1;
      
      protected var _sellBtn:SellGoodsBtn;
      
      protected var _continueBtn:ContinueGoodsBtn;
      
      protected var _lists:Array;
      
      protected var _currentList:BagListView;
      
      protected var _currentBeadList:BeadBagList;
      
      protected var _breakBtn:BreakGoodsBtn;
      
      protected var _keySortBtn:TextButton;
      
      private var _chatBugleInputFrame:ChatBugleInputFrame;
      
      protected var _bagType:int;
      
      private var _self:SelfInfo;
      
      private var _beadFeedBtn:BeadFeedButton;
      
      private var _beadLockBtn:BeadLockButton;
      
      private var _beadOneKeyBtn:SimpleBitmapButton;
      
      protected var _goldText:FilterFrameText;
      
      protected var _moneyText:FilterFrameText;
      
      protected var _giftText:FilterFrameText;
      
      protected var _orderTxt:FilterFrameText;
      
      protected var _goldButton:RichesButton;
      
      protected var _giftButton:RichesButton;
      
      protected var _moneyButton:RichesButton;
      
      protected var _bg:MutipleImage;
      
      protected var _bg1:MovieImage;
      
      protected var _tabBtn1:Sprite;
      
      protected var _tabBtn2:Sprite;
      
      protected var _tabBtn3:Sprite;
      
      protected var _tabBtn4:Sprite;
      
      protected var _cardEnbleFlase:Bitmap;
      
      protected var _goodsNumInfoBg:Bitmap;
      
      protected var _goodsNumInfoText:FilterFrameText;
      
      protected var _goodsNumTotalText:FilterFrameText;
      
      protected var _moneyBg:ScaleBitmapImage;
      
      protected var _moneyBg1:ScaleBitmapImage;
      
      protected var _moneyBg2:ScaleBitmapImage;
      
      protected var _moneyBg3:ScaleBitmapImage;
      
      protected var _PointCouponBitmap:Bitmap;
      
      protected var _LiJinBitmap:Bitmap;
      
      protected var _MoneyBitmap:Bitmap;
      
      protected var _orderTxtBitmap:Bitmap;
      
      private var _reworknameView:ReworkNameFrame;
      
      private var _consortaiReworkName:ReworkNameConsortia;
      
      private var _battleTeamReworkName:ReworkNameBattleTeam;
      
      private var _baseAlerFrame:BaseAlerFrame;
      
      protected var _isScreenFood:Boolean = false;
      
      private var _bagList:OutMainListPanel;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pgdn:BaseButton;
      
      private var _pgup:BaseButton;
      
      private var _pageTxtBg:Bitmap;
      
      private var _beadSortBtn:TextButton;
      
      protected var _equipEnbleFlase:Bitmap;
      
      protected var _propEnbleFlase:Bitmap;
      
      protected var _beadEnbleFlase:Bitmap;
      
      private var _disEnabledFilters:Array;
      
      private var _oneKeyFeedMC:MovieClip;
      
      protected var _buttonContainer:Sprite;
      
      protected var _bagArrangeSprite:BagArrangeTipSprite;
      
      protected var _equipSelectedBtn:SelectedButton;
      
      protected var _propSelectedBtn:SelectedButton;
      
      protected var _beadSelectedBtn:SelectedButton;
      
      protected var _dressSelectedBtn:SelectedButton;
      
      public var bagLockBtn:SimpleBitmapButton;
      
      private var _necklacePtetrochemicalView:NecklacePtetrochemicalView;
      
      private var _allExp:int;
      
      private var _feedVec:Vector.<Vector.<BeadCell>>;
      
      private var _bindVec:Vector.<Boolean>;
      
      private var _feedID:int = 0;
      
      private var _id:int;
      
      private var clickSign:int = 0;
      
      private var temInfo:InventoryItemInfo;
      
      private var _currentCell:BagCell;
      
      private var _getFriendPackFrame:GetFriendPackFrame;
      
      private var _tmpCell:BagCell;
      
      private var getNewCardMovie:MovieClip;
      
      private var _soundControl:SoundTransform;
      
      public var _orderBtn:RichesButton;
      
      public function BagView(){super();}
      
      public function get bagType() : int{return 0;}
      
      protected function init() : void{}
      
      protected function initBackGround() : void{}
      
      protected function initBagList() : void{}
      
      protected function initMoneyTexts() : void{}
      
      protected function initButtons() : void{}
      
      public function set sortBagEnable(param1:Boolean) : void{}
      
      public function set breakBtnEnable(param1:Boolean) : void{}
      
      public function set cardbtnVible(param1:Boolean) : void{}
      
      public function set cardbtnFilter(param1:Array) : void{}
      
      public function set sortBagFilter(param1:Array) : void{}
      
      public function set breakBtnFilter(param1:Array) : void{}
      
      public function set tableEnable(param1:Boolean) : void{}
      
      public function switchButtomVisible(param1:Boolean) : void{}
      
      public function enableBeadFunctionBtns(param1:Boolean) : void{}
      
      public function initBeadButton() : void{}
      
      public function adjustBeadBagPage(param1:Boolean) : void{}
      
      public function __oneKeyFeedClick(param1:MouseEvent) : void{}
      
      private function checkNextBox() : void{}
      
      private function checkBoxPrompts(param1:int) : void{}
      
      private function __onCreateComplete(param1:CEvent) : void{}
      
      private function boxPrompts(param1:Boolean) : void{}
      
      protected function __onConfigResponse(param1:FrameEvent) : void{}
      
      protected function __onBindRespones(param1:FrameEvent) : void{}
      
      protected function __onFeedResponse(param1:FrameEvent) : void{}
      
      private function __disposeOneKeyMC(param1:Event) : void{}
      
      protected function initTabButtons() : void{}
      
      private function initGoodsNumInfo() : void{}
      
      private function updateView() : void{}
      
      protected function updateBagList() : void{}
      
      private function __showBead(param1:BagEvent) : void{}
      
      public function createCard() : void{}
      
      protected function __cardBagViewComplete(param1:CardSystemEvent) : void{}
      
      private function __upData(param1:DictionaryEvent) : void{}
      
      private function __remove(param1:DictionaryEvent) : void{}
      
      protected function initEvent() : void{}
      
      protected function bagLockHandler(param1:MouseEvent) : void{}
      
      protected function __bagArrangeOut(param1:MouseEvent) : void{}
      
      private function containPoint(param1:int, param2:int) : Boolean{return false;}
      
      private function __onAutoOpenBeadChanged(param1:BeadEvent) : void{}
      
      private function isInBag(param1:InventoryItemInfo, param2:BeadBagList) : Boolean{return false;}
      
      protected function __onBeadBagChanged(param1:DictionaryEvent) : void{}
      
      private function __pgupHandler(param1:MouseEvent) : void{}
      
      private function setCurrPage(param1:int) : void{}
      
      public function __pgdnHandler(param1:MouseEvent) : void{}
      
      protected function adjustEvent() : void{}
      
      protected function __useColorShell(param1:PkgEvent) : void{}
      
      protected function removeEvents() : void{}
      
      protected function __itemtabBtnClick(param1:MouseEvent) : void{}
      
      public function enableOrdisableSB(param1:Boolean) : void{}
      
      public function showDressSelectedBtnOnly(param1:Boolean) : void{}
      
      public function enableDressSelectedBtn(param1:Boolean) : void{}
      
      public function showOrHideSB(param1:Boolean) : void{}
      
      protected function refreshSelectedButton(param1:int) : void{}
      
      public function setBagType(param1:int) : void{}
      
      protected function showDressBagView(param1:PlayerDressEvent) : void{}
      
      private function btnUnable() : void{}
      
      private function btnReable() : void{}
      
      public function isNeedCard(param1:Boolean) : void{}
      
      protected function set_breakBtn_enable() : void{}
      
      protected function set_text_location() : void{}
      
      protected function set_btn_location() : void{}
      
      private function __onBagUpdateEQUIPBAG(param1:BagEvent) : void{}
      
      protected function __onBagUpdatePROPBAG(param1:BagEvent) : void{}
      
      private function __openSettingLock(param1:MouseEvent) : void{}
      
      protected function __bagArrangeOver(param1:MouseEvent) : void{}
      
      protected function __sortBagClick(param1:MouseEvent) : void{}
      
      protected function __onSortBagResponse(param1:FrameEvent) : void{}
      
      private function __frameEvent(param1:FrameEvent) : void{}
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      private function updateMoney() : void{}
      
      protected function __listChange(param1:Event) : void{}
      
      private function __feedClick(param1:MouseEvent) : void{}
      
      private function __stopFeed(param1:Event) : void{}
      
      private function __onStageClick_FeedBtn(param1:Event) : void{}
      
      private function __sellClick(param1:MouseEvent) : void{}
      
      private function __stopSell(param1:Event) : void{}
      
      private function __onStageClick_SellBtn(param1:Event) : void{}
      
      private function __breakClick(param1:MouseEvent) : void{}
      
      public function resetMouse() : void{}
      
      private function isOnlyGivingGoods(param1:InventoryItemInfo) : Boolean{return false;}
      
      protected function __cellClick(param1:CellEvent) : void{}
      
      public function set cellDoubleClickEnable(param1:Boolean) : void{}
      
      protected function __cellDoubleClick(param1:CellEvent) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function sendDefy() : void{}
      
      private function __cellAddPrice(param1:Event) : void{}
      
      protected function __cellMove(param1:Event) : void{}
      
      protected function __cellOpenBatch(param1:Event) : void{}
      
      protected function __cellOpen(param1:Event) : void{}
      
      private function showGetFriendPackFrame(param1:ItemTemplateInfo, param2:int, param3:int) : void{}
      
      protected function onConsumePackResponse(param1:FrameEvent) : void{}
      
      private function initAlertFarme() : void{}
      
      protected function onResponseHander(param1:FrameEvent) : void{}
      
      private function __GiftBagframeClose(param1:FrameEvent) : void{}
      
      private function __cellUse(param1:Event) : void{}
      
      protected function __onNecklacePtetrochemicalClose(param1:FrameEvent) : void{}
      
      private function isHomeBankBagView() : Boolean{return false;}
      
      protected function __cellColorChange(param1:Event) : void{}
      
      private function __alertChangeColor(param1:FrameEvent) : void{}
      
      protected function __cellSell(param1:Event) : void{}
      
      private function checkDress(param1:BagCell) : Boolean{return false;}
      
      private function __texpResponse(param1:FrameEvent) : void{}
      
      private function useCard(param1:InventoryItemInfo) : void{}
      
      private function useProp(param1:InventoryItemInfo) : void{}
      
      private function createBreakWin(param1:BagCell) : void{}
      
      public function setCellInfo(param1:int, param2:InventoryItemInfo) : void{}
      
      public function dispose() : void{}
      
      public function setBagCountShow(param1:int) : void{}
      
      public function get info() : SelfInfo{return null;}
      
      public function set info(param1:SelfInfo) : void{}
      
      private function startReworkName(param1:int, param2:int) : void{}
      
      private function shutdownReworkName() : void{}
      
      private function __onRenameComplete(param1:Event) : void{}
      
      private function startupConsortiaReworkName(param1:int, param2:int) : void{}
      
      private function startupBattleTeamReworkName(param1:int, param2:int) : void{}
      
      private function shutdownConsortiaReworkName() : void{}
      
      private function showChatBugleInputFrame(param1:int) : void{}
      
      private function shutdownBattleTeamReworkName() : void{}
      
      private function __onBattleTeamRenameComplete(param1:Event) : void{}
      
      private function __onConsortiaRenameComplete(param1:Event) : void{}
      
      public function hide() : void{}
      
      private function judgeAndPlayCardMovie() : void{}
      
      private function __showOver(param1:Event) : void{}
      
      protected function _isSkillCanUse() : Boolean{return false;}
      
      private function startupChangeSex(param1:int, param2:int) : void{}
      
      private function getAlertInfo(param1:String, param2:Boolean = false) : AlertInfo{return null;}
      
      private function __onAlertSizeChanged(param1:ComponentEvent) : void{}
      
      private function __onAlertResponse(param1:FrameEvent) : void{}
      
      private function __changeSexHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function __onSuccessAlertResponse(param1:FrameEvent) : void{}
      
      public function set isScreenFood(param1:Boolean) : void{}
      
      public function get beadFeedBtn() : BeadFeedButton{return null;}
      
      public function deleteButtonForPet() : void{}
   }
}
