package bagAndInfo.bag{   import bagAndInfo.BagAndInfoManager;   import bagAndInfo.ReworkName.ReworkNameBattleTeam;   import bagAndInfo.ReworkName.ReworkNameConsortia;   import bagAndInfo.ReworkName.ReworkNameFrame;   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.BaseCell;   import bagAndInfo.changeSex.ChangeSexAlertFrame;   import baglocked.BaglockedManager;   import beadSystem.beadSystemManager;   import beadSystem.controls.BeadBagList;   import beadSystem.controls.BeadCell;   import beadSystem.controls.BeadFeedButton;   import beadSystem.controls.BeadLockButton;   import beadSystem.data.BeadEvent;   import beadSystem.model.BeadModel;   import calendar.CalendarManager;   import cardSystem.CardManager;   import cardSystem.CardSocketEvent;   import cardSystem.CardSystemEvent;   import cardSystem.data.CardInfo;   import com.pickgliss.events.ComponentEvent;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.OutMainListPanel;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.alert.SimpleAlert;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import consortion.view.selfConsortia.ConsortionBankBagView;   import ddt.bagStore.BagStore;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.player.SelfInfo;   import ddt.events.BagEvent;   import ddt.events.CEvent;   import ddt.events.CellEvent;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.PkgEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.BeadTemplateManager;   import ddt.manager.ChangeColorManager;   import ddt.manager.DragManager;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.RandomSuitCardManager;   import ddt.manager.RouletteManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SharedManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.ConfirmAlertData;   import ddt.utils.HelperBuyAlert;   import ddt.utils.PositionUtils;   import ddt.view.chat.ChatBugleInputFrame;   import ddt.view.goods.AddPricePanel;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.external.ExternalInterface;   import flash.filters.GlowFilter;   import flash.geom.Point;   import flash.media.SoundTransform;   import flash.ui.Mouse;   import flash.utils.getQualifiedClassName;   import horse.HorseManager;   import itemActivityGift.ItemActivityGiftManager;   import petsBag.PetsBagManager;   import petsBag.event.UpdatePetInfoEvent;   import petsBag.petsAdvanced.PetsAdvancedManager;   import playerDress.PlayerDressManager;   import playerDress.components.DressModel;   import playerDress.components.DressUtils;   import playerDress.data.DressVo;   import playerDress.event.PlayerDressEvent;   import quest.TaskManager;   import quest.TrusteeshipManager;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;   import road7th.utils.DateUtils;   import texpSystem.controller.TexpManager;   import vipCoupons.VIPCouponsManager;   import wonderfulActivity.WonderfulActivityManager;      [Event(name="sellstart")]   [Event(name="sellstop")]   public class BagView extends Sprite implements Disposeable   {            public static const FIRST_GET_CARD:String = "firstGetCard";            public static const TABCHANGE:String = "tabChange";            public static const SHOWBEAD:String = "showBeadFrame";            public static const EQUIP:int = 0;            public static const PROP:int = 1;            public static const CARD:int = 2;            public static const CONSORTION:int = 3;            public static const PET:int = 5;            public static const BEAD:int = 21;            public static const DRESS:int = 8;            public static const MAGICHOUSE:int = 51;            public static const MARK:int = 100;            public static var isShowCardBag:Boolean = false;            private static var _sortEquipBagData:ConfirmAlertData = new ConfirmAlertData();            private static var _sortPetEquipBagData:ConfirmAlertData = new ConfirmAlertData();            private static const UseColorShellLevel:int = 10;                   private var _index:int = 0;            private const STATE_SELL:uint = 1;            private const STATE_BEADFEED:uint = 1;            private var bead_state:uint = 0;            protected var _bgShape:Shape;            protected var _bgShapeII:MovieImage;            private var state:uint = 0;            private var _info:SelfInfo;            protected var _equiplist:BagEquipListView;            protected var _proplist:BagListView;            protected var _petlist:PetBagListView;            protected var _beadList:BeadBagList;            protected var _beadList2:BeadBagList;            protected var _beadList3:BeadBagList;            protected var _dressbagView:Sprite;            protected var _currIndex:int = 1;            protected var _sellBtn:SellGoodsBtn;            protected var _continueBtn:ContinueGoodsBtn;            protected var _lists:Array;            protected var _currentList:BagListView;            protected var _currentBeadList:BeadBagList;            protected var _breakBtn:BreakGoodsBtn;            protected var _keySortBtn:TextButton;            private var _chatBugleInputFrame:ChatBugleInputFrame;            protected var _bagType:int;            private var _self:SelfInfo;            private var _beadFeedBtn:BeadFeedButton;            private var _beadLockBtn:BeadLockButton;            private var _beadOneKeyBtn:SimpleBitmapButton;            protected var _goldText:FilterFrameText;            protected var _moneyText:FilterFrameText;            protected var _giftText:FilterFrameText;            protected var _orderTxt:FilterFrameText;            protected var _goldButton:RichesButton;            protected var _giftButton:RichesButton;            protected var _moneyButton:RichesButton;            protected var _bg:MutipleImage;            protected var _bg1:MovieImage;            protected var _tabBtn1:Sprite;            protected var _tabBtn2:Sprite;            protected var _tabBtn3:Sprite;            protected var _tabBtn4:Sprite;            protected var _cardEnbleFlase:Bitmap;            protected var _goodsNumInfoBg:Bitmap;            protected var _goodsNumInfoText:FilterFrameText;            protected var _goodsNumTotalText:FilterFrameText;            protected var _moneyBg:ScaleBitmapImage;            protected var _moneyBg1:ScaleBitmapImage;            protected var _moneyBg2:ScaleBitmapImage;            protected var _moneyBg3:ScaleBitmapImage;            protected var _PointCouponBitmap:Bitmap;            protected var _LiJinBitmap:Bitmap;            protected var _MoneyBitmap:Bitmap;            protected var _orderTxtBitmap:Bitmap;            private var _reworknameView:ReworkNameFrame;            private var _consortaiReworkName:ReworkNameConsortia;            private var _battleTeamReworkName:ReworkNameBattleTeam;            private var _baseAlerFrame:BaseAlerFrame;            protected var _isScreenFood:Boolean = false;            private var _bagList:OutMainListPanel;            private var _pageTxt:FilterFrameText;            private var _pgdn:BaseButton;            private var _pgup:BaseButton;            private var _pageTxtBg:Bitmap;            private var _beadSortBtn:TextButton;            protected var _equipEnbleFlase:Bitmap;            protected var _propEnbleFlase:Bitmap;            protected var _beadEnbleFlase:Bitmap;            private var _disEnabledFilters:Array;            private var _oneKeyFeedMC:MovieClip;            protected var _buttonContainer:Sprite;            protected var _bagArrangeSprite:BagArrangeTipSprite;            protected var _equipSelectedBtn:SelectedButton;            protected var _propSelectedBtn:SelectedButton;            protected var _beadSelectedBtn:SelectedButton;            protected var _dressSelectedBtn:SelectedButton;            public var bagLockBtn:SimpleBitmapButton;            private var _necklacePtetrochemicalView:NecklacePtetrochemicalView;            private var _allExp:int;            private var _feedVec:Vector.<Vector.<BeadCell>>;            private var _bindVec:Vector.<Boolean>;            private var _feedID:int = 0;            private var _id:int;            private var clickSign:int = 0;            private var temInfo:InventoryItemInfo;            private var _currentCell:BagCell;            private var _getFriendPackFrame:GetFriendPackFrame;            private var _tmpCell:BagCell;            private var getNewCardMovie:MovieClip;            private var _soundControl:SoundTransform;            public var _orderBtn:RichesButton;            public function BagView() { super(); }
            public function get bagType() : int { return 0; }
            protected function init() : void { }
            protected function initBackGround() : void { }
            protected function initBagList() : void { }
            protected function initMoneyTexts() : void { }
            protected function initButtons() : void { }
            public function set sortBagEnable(value:Boolean) : void { }
            public function set breakBtnEnable(value:Boolean) : void { }
            public function set cardbtnVible(value:Boolean) : void { }
            public function set cardbtnFilter(filter:Array) : void { }
            public function set sortBagFilter(filter:Array) : void { }
            public function set breakBtnFilter(filter:Array) : void { }
            public function set tableEnable(value:Boolean) : void { }
            public function switchButtomVisible(value:Boolean) : void { }
            public function enableBeadFunctionBtns(value:Boolean) : void { }
            public function initBeadButton() : void { }
            public function adjustBeadBagPage(onlyNotBind:Boolean) : void { }
            public function __oneKeyFeedClick(pEvent:MouseEvent) : void { }
            private function checkNextBox() : void { }
            private function checkBoxPrompts(id:int) : void { }
            private function __onCreateComplete(e:CEvent) : void { }
            private function boxPrompts(isBind:Boolean) : void { }
            protected function __onConfigResponse(event:FrameEvent) : void { }
            protected function __onBindRespones(pEvent:FrameEvent) : void { }
            protected function __onFeedResponse(event:FrameEvent) : void { }
            private function __disposeOneKeyMC(pEvent:Event) : void { }
            protected function initTabButtons() : void { }
            private function initGoodsNumInfo() : void { }
            private function updateView() : void { }
            protected function updateBagList() : void { }
            private function __showBead(event:BagEvent) : void { }
            public function createCard() : void { }
            protected function __cardBagViewComplete(event:CardSystemEvent) : void { }
            private function __upData(event:DictionaryEvent) : void { }
            private function __remove(event:DictionaryEvent) : void { }
            protected function initEvent() : void { }
            protected function bagLockHandler(event:MouseEvent) : void { }
            protected function __bagArrangeOut(event:MouseEvent) : void { }
            private function containPoint(x:int, y:int) : Boolean { return false; }
            private function __onAutoOpenBeadChanged(pEvent:BeadEvent) : void { }
            private function isInBag(item:InventoryItemInfo, bagList:BeadBagList) : Boolean { return false; }
            protected function __onBeadBagChanged(event:DictionaryEvent) : void { }
            private function __pgupHandler(pEvent:MouseEvent) : void { }
            private function setCurrPage(pIndex:int) : void { }
            public function __pgdnHandler(pEvent:MouseEvent) : void { }
            protected function adjustEvent() : void { }
            protected function __useColorShell(evt:PkgEvent) : void { }
            protected function removeEvents() : void { }
            protected function __itemtabBtnClick(event:MouseEvent) : void { }
            public function enableOrdisableSB(enable:Boolean) : void { }
            public function showDressSelectedBtnOnly(enable:Boolean) : void { }
            public function enableDressSelectedBtn(enable:Boolean) : void { }
            public function showOrHideSB(isShow:Boolean) : void { }
            protected function refreshSelectedButton(tag:int) : void { }
            public function setBagType(type:int) : void { }
            protected function showDressBagView(event:PlayerDressEvent) : void { }
            private function btnUnable() : void { }
            private function btnReable() : void { }
            public function isNeedCard(value:Boolean) : void { }
            protected function set_breakBtn_enable() : void { }
            protected function set_text_location() : void { }
            protected function set_btn_location() : void { }
            private function __onBagUpdateEQUIPBAG(evt:BagEvent) : void { }
            protected function __onBagUpdatePROPBAG(evt:BagEvent) : void { }
            private function __openSettingLock(evt:MouseEvent) : void { }
            protected function __bagArrangeOver(evt:MouseEvent) : void { }
            protected function __sortBagClick(evt:MouseEvent) : void { }
            private function __frameEvent(event:FrameEvent) : void { }
            private function __propertyChange(evt:PlayerPropertyEvent) : void { }
            private function updateMoney() : void { }
            protected function __listChange(evt:Event) : void { }
            private function __feedClick(pEvent:MouseEvent) : void { }
            private function __stopFeed(pEvent:Event) : void { }
            private function __onStageClick_FeedBtn(pEvent:Event) : void { }
            private function __sellClick(evt:MouseEvent) : void { }
            private function __stopSell(evt:Event) : void { }
            private function __onStageClick_SellBtn(e:Event) : void { }
            private function __breakClick(evt:MouseEvent) : void { }
            public function resetMouse() : void { }
            private function isOnlyGivingGoods(info:InventoryItemInfo) : Boolean { return false; }
            protected function __cellClick(evt:CellEvent) : void { }
            public function set cellDoubleClickEnable(b:Boolean) : void { }
            protected function __cellDoubleClick(evt:CellEvent) : void { }
            private function __onResponse(evt:FrameEvent) : void { }
            private function sendDefy() : void { }
            private function __cellAddPrice(evt:Event) : void { }
            protected function __cellMove(evt:Event) : void { }
            protected function __cellOpenBatch(evt:Event) : void { }
            protected function __cellOpen(evt:Event) : void { }
            private function showGetFriendPackFrame(info:ItemTemplateInfo, bagType:int, place:int) : void { }
            protected function onConsumePackResponse(e:FrameEvent) : void { }
            private function initAlertFarme() : void { }
            protected function onResponseHander(e:FrameEvent) : void { }
            private function __GiftBagframeClose(event:FrameEvent) : void { }
            private function __cellUse(evt:Event) : void { }
            protected function __onNecklacePtetrochemicalClose(event:FrameEvent) : void { }
            private function isHomeBankBagView() : Boolean { return false; }
            protected function __cellColorChange(evt:Event) : void { }
            private function __alertChangeColor(event:FrameEvent) : void { }
            protected function __cellSell(evt:Event) : void { }
            private function checkDress(cell:BagCell) : Boolean { return false; }
            private function __texpResponse(evt:FrameEvent) : void { }
            private function useCard(info:InventoryItemInfo) : void { }
            private function useProp(info:InventoryItemInfo) : void { }
            private function createBreakWin(cell:BagCell) : void { }
            public function setCellInfo(index:int, info:InventoryItemInfo) : void { }
            public function dispose() : void { }
            public function setBagCountShow(bagType:int) : void { }
            public function get info() : SelfInfo { return null; }
            public function set info(value:SelfInfo) : void { }
            private function startReworkName(bagType:int, place:int) : void { }
            private function shutdownReworkName() : void { }
            private function __onRenameComplete(evt:Event) : void { }
            private function startupConsortiaReworkName(bagType:int, place:int) : void { }
            private function startupBattleTeamReworkName(bagType:int, place:int) : void { }
            private function shutdownConsortiaReworkName() : void { }
            private function showChatBugleInputFrame(templateID:int) : void { }
            private function shutdownBattleTeamReworkName() : void { }
            private function __onBattleTeamRenameComplete(evt:Event) : void { }
            private function __onConsortiaRenameComplete(evt:Event) : void { }
            public function hide() : void { }
            private function judgeAndPlayCardMovie() : void { }
            private function __showOver(event:Event) : void { }
            protected function _isSkillCanUse() : Boolean { return false; }
            private function startupChangeSex(bagType:int, place:int) : void { }
            private function getAlertInfo(tip:String, showCancel:Boolean = false) : AlertInfo { return null; }
            private function __onAlertSizeChanged(event:ComponentEvent) : void { }
            private function __onAlertResponse(evt:FrameEvent) : void { }
            private function __changeSexHandler(evt:CrazyTankSocketEvent) : void { }
            private function __onSuccessAlertResponse(evt:FrameEvent) : void { }
            public function set isScreenFood(value:Boolean) : void { }
            public function get beadFeedBtn() : BeadFeedButton { return null; }
            public function deleteButtonForPet() : void { }
   }}