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
   import ddt.utils.ConfirmAlertData;
   import ddt.utils.HelperBuyAlert;
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
      
      private static var _sortEquipBagData:ConfirmAlertData = new ConfirmAlertData();
      
      private static var _sortPetEquipBagData:ConfirmAlertData = new ConfirmAlertData();
      
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
      
      public function BagView()
      {
         _self = PlayerManager.Instance.Self;
         super();
         _buttonContainer = ComponentFactory.Instance.creatCustomObject("bagAndInfo.bagView.buttonContainer");
         init();
         initEvent();
      }
      
      public function get bagType() : int
      {
         return _bagType;
      }
      
      protected function init() : void
      {
         initBackGround();
         initBagList();
         initMoneyTexts();
         initButtons();
         initTabButtons();
         initGoodsNumInfo();
         set_breakBtn_enable();
         set_text_location();
         set_btn_location();
         setBagType(0);
      }
      
      protected function initBackGround() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("bagBGAsset4");
         addChild(_bg);
         _equipSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("bagView.equipTabBtn");
         _equipSelectedBtn.mouseEnabled = false;
         _equipSelectedBtn.mouseChildren = false;
         _equipSelectedBtn.selected = true;
         addChild(_equipSelectedBtn);
         _propSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("bagView.propTabBtn");
         _propSelectedBtn.mouseEnabled = false;
         _propSelectedBtn.mouseChildren = false;
         addChild(_propSelectedBtn);
         _beadSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("bagView.beadTabBtn");
         _beadSelectedBtn.mouseEnabled = false;
         _beadSelectedBtn.mouseChildren = false;
         _beadSelectedBtn.visible = false;
         addChild(_beadSelectedBtn);
         _dressSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("bagView.dressTabBtn");
         _dressSelectedBtn.mouseEnabled = false;
         _dressSelectedBtn.mouseChildren = false;
         addChild(_dressSelectedBtn);
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.view.bgIII");
         _buttonContainer.addChild(_bg1);
         _moneyBg = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.moneyViewBG");
         _buttonContainer.addChild(_moneyBg);
         _moneyBg1 = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.moneyViewBGI");
         _buttonContainer.addChild(_moneyBg1);
         _moneyBg2 = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.moneyViewBGII");
         _buttonContainer.addChild(_moneyBg2);
         _moneyBg3 = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.moneyViewBGIII");
         _buttonContainer.addChild(_moneyBg3);
         _bgShape = new Shape();
         _bgShape.graphics.beginFill(15262671,1);
         _bgShape.graphics.drawRoundRect(0,0,327,328,2,2);
         _bgShape.graphics.endFill();
         _bgShape.x = 11;
         _bgShape.y = 50;
         _bgShapeII = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcardCell.BG");
         addChild(_bgShapeII);
         _bgShapeII.visible = false;
         bagLockBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.lockBtn");
         addChild(bagLockBtn);
      }
      
      protected function initBagList() : void
      {
         _equiplist = new BagEquipListView(0);
         _proplist = new BagListView(1);
         _petlist = new PetBagListView(1);
         PositionUtils.setPos(_petlist,"bagAndInfo.bagView.petBag.pos18");
         _beadList = new BeadBagList(21,32,80);
         _beadList2 = new BeadBagList(21,81,129);
         _beadList3 = new BeadBagList(21,130,178);
         var _loc1_:* = 14;
         _beadList3.x = _loc1_;
         _loc1_ = _loc1_;
         _beadList2.x = _loc1_;
         _loc1_ = _loc1_;
         _beadList.x = _loc1_;
         _loc1_ = _loc1_;
         _proplist.x = _loc1_;
         _equiplist.x = _loc1_;
         _loc1_ = 48;
         _beadList3.y = _loc1_;
         _loc1_ = _loc1_;
         _beadList2.y = _loc1_;
         _loc1_ = _loc1_;
         _beadList.y = _loc1_;
         _loc1_ = _loc1_;
         _proplist.y = _loc1_;
         _equiplist.y = _loc1_;
         _loc1_ = 330;
         _petlist.width = _loc1_;
         _loc1_ = _loc1_;
         _beadList3.width = _loc1_;
         _loc1_ = _loc1_;
         _beadList2.width = _loc1_;
         _loc1_ = _loc1_;
         _beadList.width = _loc1_;
         _loc1_ = _loc1_;
         _proplist.width = _loc1_;
         _equiplist.width = _loc1_;
         _loc1_ = 320;
         _petlist.height = _loc1_;
         _loc1_ = _loc1_;
         _beadList3.height = _loc1_;
         _loc1_ = _loc1_;
         _beadList2.height = _loc1_;
         _loc1_ = _loc1_;
         _beadList.height = _loc1_;
         _loc1_ = _loc1_;
         _proplist.height = _loc1_;
         _equiplist.height = _loc1_;
         _proplist.visible = false;
         _petlist.visible = false;
         _beadList.visible = false;
         _beadList2.visible = false;
         _beadList3.visible = false;
         _lists = [_equiplist,_proplist,_petlist,_beadList,_beadList2,_beadList3];
         _currentList = _equiplist;
         addChild(_equiplist);
         addChild(_proplist);
         addChild(_petlist);
         addChild(_beadList);
         addChild(_beadList2);
         addChild(_beadList3);
      }
      
      protected function initMoneyTexts() : void
      {
         _moneyText = ComponentFactory.Instance.creatComponentByStylename("BagMoneyInfoText");
         _goldText = ComponentFactory.Instance.creatComponentByStylename("BagGoldInfoText");
         _giftText = ComponentFactory.Instance.creatComponentByStylename("BagGiftInfoText");
         _giftText.x = 147;
         _giftText.y = 385;
         _orderTxt = ComponentFactory.Instance.creatComponentByStylename("BagGiftInfoText");
         _orderTxt.x = 146;
         _orderTxt.y = 418;
         _buttonContainer.addChild(_goldText);
         _buttonContainer.addChild(_moneyText);
         _buttonContainer.addChild(_giftText);
         _buttonContainer.addChild(_orderTxt);
         _goldButton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.bag.GoldButton");
         _goldButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GoldDirections");
         _orderBtn = ComponentFactory.Instance.creatCustomObject("bagAndInfo.bag.OrderBtn");
         _buttonContainer.addChild(_goldButton);
         _buttonContainer.addChild(_orderBtn);
         var levelNum:int = ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel);
         var vipNum:int = ServerConfigManager.instance.VIPExtraBindMoneyUpper[PlayerManager.Instance.Self.VIPLevel - 1];
         _giftButton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.bag.GiftButton");
         _giftButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GiftDirections",levelNum.toString());
         if(PlayerManager.Instance.Self.IsVIP)
         {
            _orderBtn.tipData = LanguageMgr.GetTranslation("tank.view.bagII.MedalDirections",ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel));
         }
         else
         {
            _orderBtn.tipData = LanguageMgr.GetTranslation("tank.view.bagII.MedalDirections",ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade));
         }
         _buttonContainer.addChild(_giftButton);
         _moneyButton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.bag.MoneyButton");
         _moneyButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.MoneyDirections");
         _buttonContainer.addChild(_moneyButton);
      }
      
      protected function initButtons() : void
      {
         _sellBtn = ComponentFactory.Instance.creatComponentByStylename("bagSellButton1");
         _sellBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.bagSell");
         _buttonContainer.addChild(_sellBtn);
         _continueBtn = ComponentFactory.Instance.creatComponentByStylename("bagContinueButton1");
         _continueBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.bagContinue");
         _buttonContainer.addChild(_continueBtn);
         _breakBtn = ComponentFactory.Instance.creatComponentByStylename("bagBreakButton1");
         _breakBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.bagBreak");
         _buttonContainer.addChild(_breakBtn);
         _keySortBtn = ComponentFactory.Instance.creatComponentByStylename("bagKeySetButton1");
         _keySortBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.bagSortTxt");
         _buttonContainer.addChild(_keySortBtn);
         _keySortBtn.enable = _isSkillCanUse();
         _PointCouponBitmap = ComponentFactory.Instance.creatBitmap("bagAndInfo.info.PointCoupon");
         _buttonContainer.addChild(_PointCouponBitmap);
         _LiJinBitmap = ComponentFactory.Instance.creatBitmap("bagAndInfo.info.ddtMoney1");
         _buttonContainer.addChild(_LiJinBitmap);
         _MoneyBitmap = ComponentFactory.Instance.creatBitmap("bagAndInfo.info.money");
         _buttonContainer.addChild(_MoneyBitmap);
         _orderTxtBitmap = ComponentFactory.Instance.creat("bagAndInfo.order");
         _orderTxtBitmap.x = 120;
         _orderTxtBitmap.y = 415;
         _buttonContainer.addChild(_orderTxtBitmap);
      }
      
      public function set sortBagEnable(value:Boolean) : void
      {
         _keySortBtn.enable = value;
      }
      
      public function set breakBtnEnable(value:Boolean) : void
      {
         _breakBtn.enable = value;
      }
      
      public function set cardbtnVible(value:Boolean) : void
      {
         _cardEnbleFlase.visible = value;
      }
      
      public function set cardbtnFilter(filter:Array) : void
      {
         _cardEnbleFlase.filters = filter;
      }
      
      public function set sortBagFilter(filter:Array) : void
      {
         _keySortBtn.filters = filter;
      }
      
      public function set breakBtnFilter(filter:Array) : void
      {
         _breakBtn.filters = filter;
      }
      
      public function set tableEnable(value:Boolean) : void
      {
         _tabBtn3.mouseEnabled = value;
      }
      
      public function switchButtomVisible(value:Boolean) : void
      {
         _bg1.visible = value;
         _sellBtn.visible = value;
         _breakBtn.visible = value;
         _continueBtn.visible = value;
         _keySortBtn.visible = value;
         _goldText.visible = value;
         _giftButton.visible = value;
         _giftText.visible = value;
         _moneyButton.visible = value;
         _orderTxt.visible = value;
         _orderBtn.visible = value;
         _moneyBg3.visible = value;
         if(_pgup)
         {
            _pgup.visible = !value;
         }
         if(_pgdn)
         {
            _pgdn.visible = !value;
         }
         if(_pageTxt)
         {
            _pageTxt.visible = !value;
         }
         if(_pageTxtBg)
         {
            _pageTxtBg.visible = !value;
         }
         if(_beadFeedBtn)
         {
            _beadFeedBtn.visible = !value;
         }
         if(_beadLockBtn)
         {
            _beadLockBtn.visible = !value;
         }
         if(_beadOneKeyBtn)
         {
            _beadOneKeyBtn.visible = !value;
         }
         if(_beadSortBtn)
         {
            _beadSortBtn.visible = !value;
         }
         enableBeadFunctionBtns(!value);
         if(_moneyBg1)
         {
            _moneyBg1.visible = value;
         }
         if(_moneyBg2)
         {
            _moneyBg2.visible = value;
         }
         if(_LiJinBitmap)
         {
            _LiJinBitmap.visible = value;
         }
         if(_MoneyBitmap)
         {
            _MoneyBitmap.visible = value;
         }
         if(_orderTxtBitmap)
         {
            _orderTxtBitmap.visible = value;
         }
      }
      
      public function enableBeadFunctionBtns(value:Boolean) : void
      {
         if(_beadFeedBtn)
         {
            _beadFeedBtn.enable = value;
         }
         if(_beadLockBtn)
         {
            _beadLockBtn.enable = value;
         }
         if(_beadOneKeyBtn)
         {
            _beadOneKeyBtn.enable = value;
         }
         if(_beadSortBtn)
         {
            _beadSortBtn.enable = value;
         }
      }
      
      public function initBeadButton() : void
      {
         _pgup = ComponentFactory.Instance.creatComponentByStylename("beadSystem.prePageBtn");
         addChild(_pgup);
         _pgdn = ComponentFactory.Instance.creatComponentByStylename("beadSystem.nextPageBtn");
         addChild(_pgdn);
         _pageTxtBg = ComponentFactory.Instance.creatBitmap("beadSystem.pageTxt.bg");
         addChild(_pageTxtBg);
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("beadSystem.pageTxt");
         addChild(_pageTxt);
         _pageTxt.text = "1/3";
         _pgup.addEventListener("click",__pgupHandler);
         _pgdn.addEventListener("click",__pgdnHandler);
         _beadSortBtn = ComponentFactory.Instance.creatComponentByStylename("beadSystem.sortBtn");
         _beadSortBtn.text = LanguageMgr.GetTranslation("ddt.beadSystem.sortBtnTxt");
         _beadSortBtn.addEventListener("click",__sortBagClick,false,0,true);
         addChild(_beadSortBtn);
         _beadFeedBtn = ComponentFactory.Instance.creatComponentByStylename("beadSystem.feedbtn1");
         _beadFeedBtn.width = 106;
         _beadFeedBtn.tipStyle = "ddtstore.StoreEmbedBG.MultipleLineTip";
         _beadFeedBtn.tipData = LanguageMgr.GetTranslation("ddt.bagandinfo.beadTip");
         addChild(_beadFeedBtn);
         _beadLockBtn = ComponentFactory.Instance.creatComponentByStylename("beadSystem.lockbtn1");
         _beadLockBtn.tipStyle = "ddtstore.StoreEmbedBG.MultipleLineTip";
         _beadLockBtn.tipData = LanguageMgr.GetTranslation("ddt.bagandinfo.beadLockTip");
         addChild(_beadLockBtn);
         _beadOneKeyBtn = ComponentFactory.Instance.creatComponentByStylename("beadSystem.feedAllBtn");
         _beadOneKeyBtn.tipStyle = "ddtstore.StoreEmbedBG.MultipleLineTip";
         _beadOneKeyBtn.tipData = LanguageMgr.GetTranslation("ddt.bagandinfo.beadOneKeyTip");
         addChild(_beadOneKeyBtn);
         _beadOneKeyBtn.addEventListener("click",__oneKeyFeedClick);
      }
      
      public function adjustBeadBagPage(onlyNotBind:Boolean) : void
      {
         var leastPlace:int = 2147483647;
         var _loc6_:int = 0;
         var _loc5_:* = _info.BeadBag.items;
         for each(var bead in _info.BeadBag.items)
         {
            if(bead.Place < leastPlace && bead.Place > 31 && (!onlyNotBind || !bead.IsBinds))
            {
               leastPlace = bead.Place;
            }
         }
         var index:int = (leastPlace - 32) / 49 + 1;
         if(index <= 0 || index > 3)
         {
            index = 1;
         }
         if(_pageTxt)
         {
            _pageTxt.text = index + "/3";
         }
         _beadList.visible = index == 1;
         _beadList2.visible = index == 2;
         _beadList3.visible = index == 3;
         _currentBeadList = [_beadList,_beadList2,_beadList3][index - 1];
      }
      
      public function __oneKeyFeedClick(pEvent:MouseEvent) : void
      {
         var allExp:int = 0;
         var isBind:Boolean = false;
         var i:int = 0;
         var desFlag:Boolean = false;
         var j:int = 0;
         SoundManager.instance.play("008");
         if(BeadModel.beadCanUpgrade)
         {
            if(int(PlayerManager.Instance.Self.embedUpLevelCell.itemInfo.Hole1) == 21)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.mostHightLevel"));
               return;
            }
            allExp = 0;
            isBind = false;
            _feedID = 0;
            if(!_feedVec)
            {
               _feedVec = new Vector.<Vector.<BeadCell>>(8);
               _bindVec = new Vector.<Boolean>(8);
            }
            i = 0;
            while(i < 8)
            {
               if(!_feedVec[i])
               {
                  _feedVec[i] = new Vector.<BeadCell>();
                  _bindVec[i] = false;
               }
               else
               {
                  _feedVec[i].length = 0;
               }
               i++;
            }
            var _loc9_:int = 0;
            var _loc8_:* = _currentBeadList.BeadCells;
            for each(var cell in _currentBeadList.BeadCells)
            {
               if(cell.info && !cell.itemInfo.IsUsed)
               {
                  if(cell.itemInfo.Hole1 < 13 && BeadTemplateManager.Instance.GetBeadInfobyID(cell.itemInfo.TemplateID).Type3 <= 0)
                  {
                     _feedVec[0].push(cell);
                     allExp = allExp + cell.itemInfo.Hole2;
                     cell.locked = true;
                     if(!_bindVec[0] && cell.itemInfo.IsBinds)
                     {
                        _bindVec[0] = true;
                     }
                  }
                  else if(cell.itemInfo.Hole1 == 13)
                  {
                     _feedVec[1].push(cell);
                  }
                  else if(cell.itemInfo.Hole1 == 14)
                  {
                     _feedVec[2].push(cell);
                  }
                  else if(cell.itemInfo.Hole1 == 15)
                  {
                     _feedVec[3].push(cell);
                  }
                  else if(cell.itemInfo.Hole1 == 16 || BeadTemplateManager.Instance.GetBeadInfobyID(cell.itemInfo.TemplateID).Type3 > 0)
                  {
                     _feedVec[4].push(cell);
                  }
                  else if(cell.itemInfo.Hole1 == 17)
                  {
                     _feedVec[5].push(cell);
                  }
                  else if(cell.itemInfo.Hole1 == 18)
                  {
                     _feedVec[6].push(cell);
                  }
                  else if(cell.itemInfo.Hole1 == 19)
                  {
                     _feedVec[7].push(cell);
                  }
                  else if(cell.itemInfo.Hole1 == 20)
                  {
                     _feedVec[7].push(cell);
                  }
                  else if(cell.itemInfo.Hole1 == 21)
                  {
                     _feedVec[7].push(cell);
                  }
               }
            }
            if(allExp == 0)
            {
               desFlag = true;
               for(j = 1; j < 8; )
               {
                  if(_feedVec[j].length > 0)
                  {
                     desFlag = false;
                     break;
                  }
                  j++;
               }
               if(desFlag)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.noBeadToFeed"));
               }
               else
               {
                  _feedID = j;
                  checkBoxPrompts(_feedID);
               }
               return;
            }
            _allExp = allExp;
            boxPrompts(_bindVec[0]);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.tipNoFeedBead"));
         }
      }
      
      private function checkNextBox() : void
      {
         _feedID = Number(_feedID) + 1;
         if(_feedID < 5)
         {
            checkBoxPrompts(_feedID);
         }
      }
      
      private function checkBoxPrompts(id:int) : void
      {
         var i:int = 0;
         _allExp = 0;
         _id = id;
         var length:int = _feedVec[id].length;
         if(length > 0)
         {
            for(i = 0; i < length; )
            {
               _allExp = _allExp + _feedVec[id][i].itemInfo.Hole2;
               _feedVec[id][i].locked = true;
               if(!_bindVec[id] && _feedVec[id][i].itemInfo.IsBinds)
               {
                  _bindVec[id] = true;
               }
               i++;
            }
            beadSystemManager.Instance.addEventListener("createComplete",__onCreateComplete);
            beadSystemManager.Instance.showFrame("infoframe");
         }
         else
         {
            _feedID = Number(_feedID) + 1;
            if(_feedID < 5)
            {
               checkBoxPrompts(_feedID);
            }
            else
            {
               _feedID = 0;
            }
         }
      }
      
      private function __onCreateComplete(e:CEvent) : void
      {
         var promptAlert:* = null;
         beadSystemManager.Instance.removeEventListener("createComplete",__onCreateComplete);
         if(e.data.type == "infoframe")
         {
            promptAlert = e.data.spr;
            promptAlert["setBeadName"](_feedVec[_id][0].tipData["beadName"]);
            LayerManager.Instance.addToLayer(promptAlert,1,true,1);
            promptAlert["textInput"].setFocus();
            promptAlert["isBind"] = _bindVec[_id];
            promptAlert.addEventListener("response",__onConfigResponse);
         }
      }
      
      private function boxPrompts(isBind:Boolean) : void
      {
         var bindAlert:* = null;
         var alert:* = null;
         var showExp:* = null;
         if(isBind && !BeadModel.isBeadCellIsBind)
         {
            bindAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.useBindBead"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            bindAlert.addEventListener("response",__onBindRespones);
         }
         else
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.FeedBeadConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            showExp = ComponentFactory.Instance.creatComponentByStylename("beadSystem.feedBeadShowExpTextOneFeed");
            showExp.htmlText = LanguageMgr.GetTranslation("ddt.beadSystem.feedBeadGetExp",_allExp);
            alert.addChild(showExp);
            alert.addEventListener("response",__onFeedResponse);
         }
      }
      
      protected function __onConfigResponse(event:FrameEvent) : void
      {
         var length:int = 0;
         var i:int = 0;
         var alertInfo:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         SoundManager.instance.playButtonSound();
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               if(alertInfo["textInput"].text == "YES" || alertInfo["textInput"].text == "yes")
               {
                  boxPrompts(alertInfo["isBind"]);
                  alertInfo.removeEventListener("response",__onConfigResponse);
                  ObjectUtils.disposeObject(alertInfo);
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.feedBeadPromptInfo"));
               }
         }
      }
      
      protected function __onBindRespones(pEvent:FrameEvent) : void
      {
         var length:int = 0;
         var i:int = 0;
         var alert:* = null;
         var showExp:* = null;
         SoundManager.instance.playButtonSound();
         switch(int(pEvent.responseCode))
         {
            case 0:
            case 1:
               length = _feedVec[_feedID].length;
               for(i = 0; i < length; )
               {
                  _feedVec[_feedID][i].locked = false;
                  i++;
               }
               break;
            case 2:
            case 3:
            case 4:
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.FeedBeadConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
               showExp = ComponentFactory.Instance.creatComponentByStylename("beadSystem.feedBeadShowExpTextOneFeed");
               showExp.htmlText = LanguageMgr.GetTranslation("ddt.beadSystem.feedBeadGetExp",_allExp);
               alert.addChild(showExp);
               alert.addEventListener("response",__onFeedResponse);
         }
         pEvent.currentTarget.removeEventListener("response",__onBindRespones);
         ObjectUtils.disposeObject(pEvent.currentTarget);
      }
      
      protected function __onFeedResponse(event:FrameEvent) : void
      {
         var length:int = 0;
         var i:int = 0;
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               length = _feedVec[_feedID].length;
               for(i = 0; i < length; )
               {
                  _feedVec[_feedID][i].locked = false;
                  i++;
               }
               break;
            case 2:
            case 3:
            case 4:
               if(_feedVec[_feedID].length > 0)
               {
                  if(!_oneKeyFeedMC)
                  {
                     _oneKeyFeedMC = ClassUtils.CreatInstance("beadSystem.oneKeyFeed.MC");
                     _oneKeyFeedMC.gotoAndPlay(1);
                     var _loc4_:* = 0.9;
                     _oneKeyFeedMC.scaleY = _loc4_;
                     _oneKeyFeedMC.scaleX = _loc4_;
                     _oneKeyFeedMC.x = 707;
                     _oneKeyFeedMC.y = 295;
                     _oneKeyFeedMC.addEventListener("oneKeyComplete",__disposeOneKeyMC);
                     LayerManager.Instance.addToLayer(_oneKeyFeedMC,0,false,1,true);
                  }
                  break;
               }
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.tipNoBead"));
               break;
         }
         event.currentTarget.removeEventListener("response",__onFeedResponse);
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      private function __disposeOneKeyMC(pEvent:Event) : void
      {
         var i:int = 0;
         var arr:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = _feedVec[_feedID];
         for each(var c in _feedVec[_feedID])
         {
            if(c.info && !c.itemInfo.IsUsed)
            {
               arr.push(c.beadPlace);
            }
         }
         SocketManager.Instance.out.sendBeadUpgrade(arr);
         var length:int = _feedVec[_feedID].length;
         for(i = 0; i < length; )
         {
            _feedVec[_feedID][i].locked = false;
            i++;
         }
         _oneKeyFeedMC.removeEventListener("oneKeyComplete",__disposeOneKeyMC);
         _oneKeyFeedMC.stop();
         ObjectUtils.disposeObject(_oneKeyFeedMC);
         _oneKeyFeedMC = null;
         if(_allExp + BeadModel.upgradeCellInfo.Hole2 >= ServerConfigManager.instance.getBeadUpgradeExp()[BeadModel.upgradeCellInfo.Hole1 + 1])
         {
            beadSystemManager.Instance.dispatchEvent(new BeadEvent("playUpgradeMC"));
         }
         checkNextBox();
      }
      
      protected function initTabButtons() : void
      {
         _tabBtn1 = new Sprite();
         _tabBtn1.graphics.beginFill(255,1);
         _tabBtn1.graphics.drawRoundRect(348,39,51,131,15,15);
         _tabBtn1.graphics.endFill();
         _tabBtn1.alpha = 0;
         _tabBtn1.buttonMode = true;
         addChild(_tabBtn1);
         _tabBtn2 = new Sprite();
         _tabBtn2.graphics.beginFill(255,1);
         _tabBtn2.graphics.drawRoundRect(349,183,51,131,15,15);
         _tabBtn2.graphics.endFill();
         _tabBtn2.alpha = 0;
         _tabBtn2.buttonMode = true;
         addChild(_tabBtn2);
         _tabBtn3 = new Sprite();
         _tabBtn3.graphics.beginFill(255,1);
         _tabBtn3.graphics.drawRoundRect(349,327,51,131,15,15);
         _tabBtn3.graphics.endFill();
         _tabBtn3.alpha = 0;
         _tabBtn3.buttonMode = true;
         _tabBtn3.visible = false;
         addChild(_tabBtn3);
         _tabBtn4 = new Sprite();
         _tabBtn4.graphics.beginFill(255,1);
         _tabBtn4.graphics.drawRoundRect(349,327,51,131,15,15);
         _tabBtn4.graphics.endFill();
         _tabBtn4.alpha = 0;
         _tabBtn4.buttonMode = true;
         addChild(_tabBtn4);
         _cardEnbleFlase = ComponentFactory.Instance.creatBitmap("asset.cardbtn.enblefalse");
         _cardEnbleFlase.visible = false;
         addChild(_buttonContainer);
      }
      
      private function initGoodsNumInfo() : void
      {
         _goodsNumInfoText = ComponentFactory.Instance.creatComponentByStylename("bagGoodsInfoNumText");
         _goodsNumTotalText = ComponentFactory.Instance.creatComponentByStylename("bagGoodsInfoNumTotalText");
         _goodsNumTotalText.text = "/ 49";
      }
      
      private function updateView() : void
      {
         updateMoney();
         updateBagList();
      }
      
      protected function updateBagList() : void
      {
         if(_info)
         {
            _equiplist.currentBagType = _bagType;
            _equiplist.setData(_info.Bag);
            if(_isScreenFood)
            {
               _petlist.setData(_info.PropBag);
            }
            else
            {
               _proplist.setData(_info.PropBag);
            }
            if(_bagType != 5)
            {
               if(_beadList)
               {
                  _beadList.setData(_info.BeadBag);
               }
               if(_beadList2)
               {
                  _beadList2.setData(_info.BeadBag);
               }
               if(_beadList3)
               {
                  _beadList3.setData(_info.BeadBag);
               }
            }
         }
         else
         {
            _equiplist.setData(null);
            _proplist.setData(null);
            _petlist.setData(null);
         }
      }
      
      private function __showBead(event:BagEvent) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.beadToBeadBag"));
      }
      
      public function createCard() : void
      {
         CardManager.Instance.addEventListener("bagBagViewComplete",__cardBagViewComplete);
         CardManager.Instance.showView(1);
      }
      
      protected function __cardBagViewComplete(event:CardSystemEvent) : void
      {
         if(_bagList == null)
         {
            _bagList = event.info;
            addChild(_bagList);
            _bagList.vectorListModel.appendAll(CardManager.Instance.model.getBagListData());
            DragManager.ListenWheelEvent(_bagList.onMouseWheel);
            DragManager.changeCardState(CardManager.Instance.setSignLockedCardNone);
            PlayerManager.Instance.Self.cardBagDic.addEventListener("add",__upData);
            PlayerManager.Instance.Self.cardBagDic.addEventListener("update",__upData);
            PlayerManager.Instance.Self.cardBagDic.addEventListener("remove",__remove);
         }
         setBagType(2);
         dispatchEvent(new CardSocketEvent("setSelectCardComplete"));
      }
      
      private function __upData(event:DictionaryEvent) : void
      {
         var itemDate:* = null;
         var newArr:* = null;
         var info:CardInfo = event.data as CardInfo;
         var m:int = info.Place % 4 == 0?info.Place / 4 - 2:Number(info.Place / 4 - 1);
         var n:int = info.Place % 4 == 0?4:Number(info.Place % 4);
         if(_bagList.vectorListModel.elements[m] == null)
         {
            itemDate = [];
            itemDate[0] = m + 1;
            itemDate[n] = info;
            _bagList.vectorListModel.append(itemDate);
         }
         else
         {
            newArr = _bagList.vectorListModel.elements[m] as Array;
            newArr[n] = info;
            _bagList.vectorListModel.replaceAt(m,newArr);
         }
      }
      
      private function __remove(event:DictionaryEvent) : void
      {
         var info:CardInfo = event.data as CardInfo;
         var m:int = info.Place % 4 == 0?info.Place / 4 - 2:Number(info.Place / 4 - 1);
         var n:int = info.Place % 4 == 0?4:Number(info.Place % 4);
         var newArr:Array = _bagList.vectorListModel.elements[m] as Array;
         newArr[n] = null;
         _bagList.vectorListModel.replaceAt(m,newArr);
      }
      
      protected function initEvent() : void
      {
         if(_sellBtn)
         {
            _sellBtn.addEventListener("click",__sellClick);
         }
         if(_breakBtn)
         {
            _breakBtn.addEventListener("click",__breakClick);
         }
         if(_equiplist)
         {
            _equiplist.addEventListener("itemclick",__cellClick);
         }
         if(_equiplist)
         {
            _equiplist.addEventListener("doubleclick",__cellDoubleClick);
         }
         if(_equiplist)
         {
            _equiplist.addEventListener("change",__listChange);
         }
         if(_proplist)
         {
            _proplist.doubleClickEnabled = true;
         }
         if(_proplist)
         {
            _proplist.addEventListener("itemclick",__cellClick);
         }
         if(_proplist)
         {
            _proplist.addEventListener("doubleclick",__cellDoubleClick);
         }
         if(_petlist)
         {
            _petlist.addEventListener("itemclick",__cellClick);
            _petlist.addEventListener("doubleclick",__cellDoubleClick);
         }
         if(_beadList)
         {
            _beadList.addEventListener("itemclick",__cellClick);
            _beadList2.addEventListener("itemclick",__cellClick);
            _beadList3.addEventListener("itemclick",__cellClick);
         }
         if(_tabBtn1)
         {
            _tabBtn1.addEventListener("click",__itemtabBtnClick);
         }
         if(_tabBtn2)
         {
            _tabBtn2.addEventListener("click",__itemtabBtnClick);
         }
         if(_tabBtn3)
         {
            _tabBtn3.addEventListener("click",__itemtabBtnClick);
         }
         if(_tabBtn4)
         {
            _tabBtn4.addEventListener("click",__itemtabBtnClick);
         }
         CellMenu.instance.addEventListener("addprice",__cellAddPrice);
         CellMenu.instance.addEventListener("move",__cellMove);
         CellMenu.instance.addEventListener("open",__cellOpen);
         CellMenu.instance.addEventListener("use",__cellUse);
         CellMenu.instance.addEventListener("open_batch",__cellOpenBatch);
         CellMenu.instance.addEventListener("color_change",__cellColorChange);
         CellMenu.instance.addEventListener("delete",__cellSell);
         if(_keySortBtn)
         {
            _keySortBtn.addEventListener("click",__sortBagClick);
         }
         if(_keySortBtn)
         {
            _keySortBtn.addEventListener("rollOver",__bagArrangeOver);
         }
         if(_keySortBtn)
         {
            _keySortBtn.addEventListener("rollOut",__bagArrangeOut);
         }
         SocketManager.Instance.addEventListener(PkgEvent.format(205),__useColorShell);
         beadSystemManager.Instance.addEventListener("autoOpenBead",__onAutoOpenBeadChanged);
         if(bagLockBtn)
         {
            bagLockBtn.addEventListener("click",bagLockHandler,false,0,true);
         }
         adjustEvent();
      }
      
      protected function bagLockHandler(event:MouseEvent) : void
      {
         __openSettingLock(null);
      }
      
      protected function __bagArrangeOut(event:MouseEvent) : void
      {
         if(_bagType == 21)
         {
            return;
         }
         if(_bagArrangeSprite && _bagArrangeSprite.parent && !containPoint(event.localX,event.localY))
         {
            removeChild(_bagArrangeSprite);
         }
      }
      
      private function containPoint(x:int, y:int) : Boolean
      {
         if(x > 0 && x < _bagArrangeSprite.width && y <= 3 && y > -_bagArrangeSprite.height)
         {
            return true;
         }
         return false;
      }
      
      private function __onAutoOpenBeadChanged(pEvent:BeadEvent) : void
      {
         if(!_beadOneKeyBtn || !_beadLockBtn || !_beadFeedBtn)
         {
            return;
         }
         if(pEvent.CellId == 0)
         {
            _beadOneKeyBtn.enable = true;
            _beadLockBtn.enable = true;
            _beadFeedBtn.enable = true;
         }
         else if(pEvent.CellId == 1)
         {
            _beadOneKeyBtn.enable = false;
            _beadLockBtn.enable = false;
            _beadFeedBtn.enable = false;
         }
      }
      
      private function isInBag(item:InventoryItemInfo, bagList:BeadBagList) : Boolean
      {
         if(item.Place >= bagList._startIndex && item.Place <= bagList._stopIndex)
         {
            return true;
         }
         return false;
      }
      
      protected function __onBeadBagChanged(event:DictionaryEvent) : void
      {
         var tmp:int = 0;
         var i:int = 0;
         if(_bagType != 21)
         {
            return;
         }
         var arr:Array = [_beadList,_beadList2,_beadList3];
         var toPage:int = 1;
         var item:InventoryItemInfo = InventoryItemInfo(event.data);
         if(item.Place < 32)
         {
            return;
         }
         if(_info.BeadBag.getItemAt(item.Place))
         {
            tmp = 1;
            for(i = 0; i < arr.length; )
            {
               if(isInBag(item,arr[i]))
               {
                  tmp = i + 1;
                  break;
               }
               i++;
            }
            toPage = tmp > toPage?tmp:int(toPage);
         }
         if(toPage > 3 || toPage < 1)
         {
            toPage = 1;
         }
         if(_currIndex == toPage)
         {
            return;
         }
         _currIndex = toPage;
         _beadList.visible = toPage == 1;
         _beadList2.visible = toPage == 2;
         _beadList3.visible = toPage == 3;
         _pageTxt.text = toPage + "/3";
         _currentBeadList = arr[toPage - 1];
      }
      
      private function __pgupHandler(pEvent:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_currIndex == 1)
         {
            _currIndex = 3;
            _beadList.visible = false;
            _beadList2.visible = false;
            _beadList3.visible = true;
            _pageTxt.text = "3/3";
            _currentBeadList = _beadList3;
         }
         else if(_currIndex == 2)
         {
            _currIndex = 1;
            _beadList.visible = true;
            _beadList2.visible = false;
            _beadList3.visible = false;
            _pageTxt.text = "1/3";
            _currentBeadList = _beadList;
         }
         else if(_currIndex == 3)
         {
            _currIndex = 2;
            _beadList.visible = false;
            _beadList2.visible = true;
            _beadList3.visible = false;
            _pageTxt.text = "2/3";
            _currentBeadList = _beadList2;
         }
      }
      
      private function setCurrPage(pIndex:int) : void
      {
      }
      
      public function __pgdnHandler(pEvent:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_currIndex == 1)
         {
            _currIndex = 2;
            _beadList.visible = false;
            _beadList2.visible = true;
            _beadList3.visible = false;
            _pageTxt.text = "2/3";
            _currentBeadList = _beadList2;
         }
         else if(_currIndex == 2)
         {
            _currIndex = 3;
            _beadList.visible = false;
            _beadList2.visible = false;
            _beadList3.visible = true;
            _pageTxt.text = "3/3";
            _currentBeadList = _beadList3;
         }
         else if(_currIndex == 3)
         {
            _currIndex = 1;
            _beadList.visible = true;
            _beadList2.visible = false;
            _beadList3.visible = false;
            _pageTxt.text = "1/3";
            _currentBeadList = _beadList;
         }
      }
      
      protected function adjustEvent() : void
      {
      }
      
      protected function __useColorShell(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var result:Boolean = pkg.readBoolean();
         if(result)
         {
            SoundManager.instance.play("063");
         }
      }
      
      protected function removeEvents() : void
      {
         if(_sellBtn)
         {
            _sellBtn.removeEventListener("click",__sellClick);
         }
         if(_breakBtn)
         {
            _breakBtn.removeEventListener("click",__breakClick);
         }
         if(_equiplist)
         {
            _equiplist.removeEventListener("itemclick",__cellClick);
         }
         if(_equiplist)
         {
            _equiplist.removeEventListener("change",__listChange);
         }
         if(_equiplist)
         {
            _equiplist.removeEventListener("doubleclick",__cellDoubleClick);
         }
         if(_proplist)
         {
            _proplist.removeEventListener("itemclick",__cellClick);
         }
         if(_proplist)
         {
            _proplist.removeEventListener("doubleclick",__cellDoubleClick);
         }
         if(_proplist)
         {
            _proplist.removeEventListener("change",__listChange);
         }
         if(_petlist)
         {
            _petlist.removeEventListener("doubleclick",__cellDoubleClick);
         }
         if(_petlist)
         {
            _petlist.removeEventListener("itemclick",__cellClick);
         }
         if(_beadList)
         {
            _beadList.removeEventListener("itemclick",__cellClick);
         }
         if(_beadList2)
         {
            _beadList.removeEventListener("itemclick",__cellClick);
         }
         if(_beadList3)
         {
            _beadList.removeEventListener("itemclick",__cellClick);
         }
         if(_dressbagView)
         {
            _dressbagView.removeEventListener("itemclick",__cellClick);
         }
         if(_dressbagView)
         {
            _dressbagView.removeEventListener("doubleclick",__cellDoubleClick);
         }
         if(_beadList)
         {
            _beadList.removeEventListener("change",__listChange);
         }
         if(_tabBtn1)
         {
            _tabBtn1.removeEventListener("click",__itemtabBtnClick);
         }
         if(_tabBtn2)
         {
            _tabBtn2.removeEventListener("click",__itemtabBtnClick);
         }
         if(_tabBtn3)
         {
            _tabBtn3.removeEventListener("click",__itemtabBtnClick);
         }
         if(_tabBtn4)
         {
            _tabBtn4.removeEventListener("click",__itemtabBtnClick);
         }
         if(_pgup)
         {
            _pgup.removeEventListener("click",__pgupHandler);
         }
         if(_pgdn)
         {
            _pgdn.removeEventListener("click",__pgdnHandler);
         }
         if(_beadSortBtn)
         {
            _beadSortBtn.removeEventListener("click",__sortBagClick);
         }
         CellMenu.instance.removeEventListener("addprice",__cellAddPrice);
         CellMenu.instance.removeEventListener("move",__cellMove);
         CellMenu.instance.removeEventListener("open",__cellOpen);
         CellMenu.instance.removeEventListener("use",__cellUse);
         CellMenu.instance.removeEventListener("open_batch",__cellOpenBatch);
         CellMenu.instance.removeEventListener("color_change",__cellColorChange);
         CellMenu.instance.removeEventListener("delete",__cellSell);
         if(_keySortBtn)
         {
            _keySortBtn.removeEventListener("click",__sortBagClick);
            _keySortBtn.removeEventListener("rollOver",__bagArrangeOver);
            _keySortBtn.removeEventListener("rollOut",__bagArrangeOut);
         }
         PlayerManager.Instance.Self.removeEventListener("showBead",__showBead);
         PlayerManager.Instance.Self.cardBagDic.removeEventListener("add",__upData);
         PlayerManager.Instance.Self.cardBagDic.removeEventListener("update",__upData);
         PlayerManager.Instance.Self.cardBagDic.removeEventListener("remove",__remove);
         if(_info)
         {
            _info.removeEventListener("propertychange",__propertyChange);
            _info.getBag(0).removeEventListener("update",__onBagUpdateEQUIPBAG);
            _info.getBag(1).removeEventListener("update",__onBagUpdatePROPBAG);
            _info.BeadBag.items.removeEventListener("add",__onBeadBagChanged);
         }
         SocketManager.Instance.removeEventListener(PkgEvent.format(205),__useColorShell);
         beadSystemManager.Instance.removeEventListener("autoOpenBead",__onAutoOpenBeadChanged);
         if(bagLockBtn)
         {
            bagLockBtn.removeEventListener("click",bagLockHandler);
         }
         PlayerDressManager.instance.removeEventListener("bagViewComplete",showDressBagView);
         CardManager.Instance.removeEventListener("bagBagViewComplete",__cardBagViewComplete);
      }
      
      protected function __itemtabBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = event.currentTarget;
         if(_tabBtn1 !== _loc2_)
         {
            if(_tabBtn2 !== _loc2_)
            {
               if(_tabBtn3 !== _loc2_)
               {
                  if(_tabBtn4 === _loc2_)
                  {
                     setBagType(8);
                     refreshSelectedButton(4);
                  }
               }
               else
               {
                  if(PlayerManager.Instance.Self.Grade < 16)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.giftSystem.openBeadBtn.text",16));
                     return;
                  }
                  if(_bagType == 21)
                  {
                     return;
                  }
                  setBagType(21);
                  refreshSelectedButton(3);
               }
            }
            else
            {
               if(_bagType == 1 || _bagType == 5)
               {
                  return;
               }
               setBagType(!!_isScreenFood?5:1);
               refreshSelectedButton(2);
            }
         }
         else
         {
            if(_bagType == 0)
            {
               return;
            }
            setBagType(0);
            refreshSelectedButton(1);
         }
      }
      
      public function enableOrdisableSB(enable:Boolean) : void
      {
         if(_equipSelectedBtn)
         {
            _equipSelectedBtn.enable = enable;
         }
         if(_propSelectedBtn)
         {
            _propSelectedBtn.enable = enable;
         }
         if(_dressSelectedBtn)
         {
            _dressSelectedBtn.enable = enable;
         }
         if(_tabBtn1)
         {
            _tabBtn1.visible = enable;
         }
         if(_tabBtn2)
         {
            _tabBtn2.visible = enable;
         }
         if(_tabBtn4)
         {
            _tabBtn4.visible = enable;
         }
      }
      
      public function showDressSelectedBtnOnly(enable:Boolean) : void
      {
         if(_equipSelectedBtn)
         {
            _equipSelectedBtn.enable = !enable;
         }
         if(_propSelectedBtn)
         {
            _propSelectedBtn.enable = !enable;
         }
         if(_dressSelectedBtn)
         {
            _dressSelectedBtn.enable = enable;
         }
         if(_tabBtn1)
         {
            _tabBtn1.visible = !enable;
         }
         if(_tabBtn2)
         {
            _tabBtn2.visible = !enable;
         }
         if(_tabBtn4)
         {
            _tabBtn4.visible = enable;
         }
      }
      
      public function enableDressSelectedBtn(enable:Boolean) : void
      {
         if(_dressSelectedBtn)
         {
            _dressSelectedBtn.enable = enable;
         }
         if(_tabBtn4)
         {
            _tabBtn4.visible = enable;
         }
      }
      
      public function showOrHideSB(isShow:Boolean) : void
      {
         if(_equipSelectedBtn)
         {
            _equipSelectedBtn.visible = isShow;
         }
         if(_propSelectedBtn)
         {
            _propSelectedBtn.visible = isShow;
         }
         if(_dressSelectedBtn)
         {
            _dressSelectedBtn.visible = isShow;
         }
      }
      
      protected function refreshSelectedButton(tag:int) : void
      {
         if(_equipSelectedBtn)
         {
            _equipSelectedBtn.selected = tag == 1;
         }
         if(_propSelectedBtn)
         {
            _propSelectedBtn.selected = tag == 2;
         }
         if(_beadSelectedBtn)
         {
            _beadSelectedBtn.selected = tag == 3;
         }
         if(_dressSelectedBtn)
         {
            _dressSelectedBtn.selected = tag == 4;
         }
      }
      
      public function setBagType(type:int) : void
      {
         var thisClass:* = null;
         if(type != 21)
         {
            _currIndex = 1;
            if(_beadList)
            {
               _currentBeadList = _beadList;
            }
            if(_pageTxt)
            {
               _pageTxt.text = "1/3";
            }
         }
         if(_equipEnbleFlase)
         {
            btnReable();
         }
         _bagType = type;
         if(type == 5)
         {
            refreshSelectedButton(2);
         }
         if(type == 0)
         {
            refreshSelectedButton(1);
         }
         else if(type == 1)
         {
            refreshSelectedButton(2);
         }
         else if(type == 2)
         {
            type = 0;
            refreshSelectedButton(1);
         }
         else if(type == 21)
         {
            refreshSelectedButton(3);
            switchButtomVisible(false);
         }
         else if(type == 8)
         {
            PlayerDressManager.instance.addEventListener("bagViewComplete",showDressBagView);
            PlayerDressManager.instance.showView(1);
            refreshSelectedButton(4);
         }
         dispatchEvent(new Event("tabChange"));
         _buttonContainer.visible = _bagType != 8;
         _bgShape.visible = _bagType == 0 || _bagType == 1 || _bagType == 5;
         _equiplist.visible = _bagType == 0;
         _proplist.visible = _bagType == 1;
         if(_dressbagView)
         {
            _dressbagView.visible = _bagType == 8;
         }
         if(_petlist)
         {
            _petlist.visible = _bagType == 5;
         }
         if(_beadList)
         {
            _beadList.visible = _bagType == 21;
            if(_beadList.visible)
            {
               _beadList2.visible = _bagType == 21;
               _beadList3.visible = _bagType == 21;
               _currentBeadList = _beadList;
               _beadList2.visible = false;
               _beadList3.visible = false;
            }
            else
            {
               _beadList2.visible = _bagType == 21;
               _beadList3.visible = _bagType == 21;
               _currentBeadList = null;
            }
         }
         if(_bagList)
         {
            _bagList.visible = _bagType == 2;
         }
         if(_bgShapeII)
         {
            _bgShapeII.visible = _bagType == 2;
         }
         set_breakBtn_enable();
         var _loc3_:* = _bagType != 2 && _bagType != 100;
         _continueBtn.enable = _loc3_;
         _sellBtn.enable = _loc3_;
         if(_bagType == 0 || _bagType == 1 || _bagType == 5)
         {
            _sellBtn.filters = ComponentFactory.Instance.creatFilters("lightFilter");
            _continueBtn.filters = ComponentFactory.Instance.creatFilters("lightFilter");
         }
         if(_bagType == 2)
         {
            _sellBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            _continueBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            btnUnable();
            showOrHideSB(false);
            if(bagLockBtn)
            {
               bagLockBtn.x = 265;
               bagLockBtn.y = -59;
            }
         }
         else
         {
            showOrHideSB(true);
            thisClass = getQualifiedClassName(this);
            if(bagLockBtn && thisClass != "email.view::EmailBagView")
            {
               bagLockBtn.x = 298;
               bagLockBtn.y = -64;
            }
         }
         if(_bagType == 0)
         {
            _moneyText.x = 47;
            _moneyText.y = 384;
            _moneyBg.x = 18;
            _moneyBg.y = 381;
            _goldButton.x = 19;
            _goldButton.y = 385;
            _PointCouponBitmap.x = 19;
            _PointCouponBitmap.y = 382;
            _giftText.x = 147;
            _giftText.y = 385;
            _LiJinBitmap.x = 119;
            _LiJinBitmap.y = 382;
            _giftButton.x = 121;
            _giftButton.y = 386;
            _moneyBg1.x = 119;
            _moneyBg1.y = 381;
            _orderTxt.x = 146;
            _orderTxt.y = 418;
         }
         if(_bagType == 21)
         {
            _moneyText.x = 270;
            _moneyText.y = 397;
            _moneyBg.x = 241;
            _moneyBg.y = 394;
            _goldButton.x = 241;
            _goldButton.y = 399;
            _PointCouponBitmap.x = 240;
            _PointCouponBitmap.y = 395;
            _giftText.x = 269;
            _giftText.y = 426;
            _LiJinBitmap.x = 240;
            _LiJinBitmap.y = 423;
            _giftButton.x = 242;
            _giftButton.y = 426;
            _moneyBg1.x = 241;
            _moneyBg1.y = 422;
            _giftButton.visible = true;
            _giftText.visible = true;
            _LiJinBitmap.visible = true;
            _moneyBg1.visible = true;
            adjustBeadBagPage(false);
         }
         else
         {
            _moneyText.x = 47;
            _moneyText.y = 384;
            _moneyBg.x = 18;
            _moneyBg.y = 381;
            _goldButton.x = 19;
            _goldButton.y = 385;
            _PointCouponBitmap.x = 19;
            _PointCouponBitmap.y = 382;
            _giftText.x = 147;
            _giftText.y = 385;
            _LiJinBitmap.x = 119;
            _LiJinBitmap.y = 382;
            _giftButton.x = 121;
            _giftButton.y = 386;
            _moneyBg1.x = 119;
            _moneyBg1.y = 381;
         }
      }
      
      protected function showDressBagView(event:PlayerDressEvent) : void
      {
         if(!_dressbagView)
         {
            _dressbagView = event.info;
            addChild(_dressbagView);
            _dressbagView.addEventListener("itemclick",__cellClick);
            _dressbagView.addEventListener("doubleclick",__cellDoubleClick);
         }
         else
         {
            _dressbagView.visible = true;
            _dressbagView["updateBagList"]();
         }
      }
      
      private function btnUnable() : void
      {
         if(_tabBtn1)
         {
            _tabBtn1.buttonMode = false;
         }
         if(_tabBtn1)
         {
            _tabBtn1.removeEventListener("click",__itemtabBtnClick);
         }
         if(_tabBtn2)
         {
            _tabBtn2.buttonMode = false;
         }
         if(_tabBtn2)
         {
            _tabBtn2.removeEventListener("click",__itemtabBtnClick);
         }
         if(_tabBtn3)
         {
            _tabBtn3.buttonMode = false;
         }
         if(_tabBtn3)
         {
            _tabBtn3.removeEventListener("click",__itemtabBtnClick);
         }
         if(_tabBtn4)
         {
            _tabBtn4.buttonMode = false;
         }
         if(_tabBtn4)
         {
            _tabBtn4.removeEventListener("click",__itemtabBtnClick);
         }
         _disEnabledFilters = [ComponentFactory.Instance.model.getSet("bagAndInfo.reworkname.ButtonDisenable")];
         _equipEnbleFlase = ComponentFactory.Instance.creatBitmap("asset.equipbtn.enblefalse");
         _equipEnbleFlase.visible = false;
         addChild(_equipEnbleFlase);
         _equipEnbleFlase.filters = _disEnabledFilters;
         _propEnbleFlase = ComponentFactory.Instance.creatBitmap("asset.propbtn.enblefalse");
         _propEnbleFlase.visible = false;
         addChild(_propEnbleFlase);
         _propEnbleFlase.filters = _disEnabledFilters;
         _beadEnbleFlase = ComponentFactory.Instance.creatBitmap("asset.cardbtn.enblefalse");
         _beadEnbleFlase.visible = false;
         addChild(_beadEnbleFlase);
         _beadEnbleFlase.filters = _disEnabledFilters;
         PositionUtils.setPos(_equipEnbleFlase,"equipEnbleFlasePos");
         PositionUtils.setPos(_propEnbleFlase,"propEnbleFlasePos");
         PositionUtils.setPos(_beadEnbleFlase,"beadEnbleFlasePos");
      }
      
      private function btnReable() : void
      {
         if(_tabBtn1)
         {
            _tabBtn1.buttonMode = true;
         }
         if(_tabBtn1)
         {
            _tabBtn1.addEventListener("click",__itemtabBtnClick);
         }
         if(_tabBtn2)
         {
            _tabBtn2.buttonMode = true;
         }
         if(_tabBtn2)
         {
            _tabBtn2.addEventListener("click",__itemtabBtnClick);
         }
         if(_tabBtn3)
         {
            _tabBtn3.buttonMode = true;
         }
         if(_tabBtn3)
         {
            _tabBtn3.addEventListener("click",__itemtabBtnClick);
         }
         if(_tabBtn4)
         {
            _tabBtn4.buttonMode = true;
         }
         if(_tabBtn4)
         {
            _tabBtn4.addEventListener("click",__itemtabBtnClick);
         }
         _disEnabledFilters = null;
         ObjectUtils.disposeObject(_equipEnbleFlase);
         _equipEnbleFlase = null;
         ObjectUtils.disposeObject(_propEnbleFlase);
         _propEnbleFlase = null;
         ObjectUtils.disposeObject(_beadEnbleFlase);
         _beadEnbleFlase = null;
      }
      
      public function isNeedCard(value:Boolean) : void
      {
      }
      
      protected function set_breakBtn_enable() : void
      {
      }
      
      protected function set_text_location() : void
      {
      }
      
      protected function set_btn_location() : void
      {
      }
      
      private function __onBagUpdateEQUIPBAG(evt:BagEvent) : void
      {
         if(!(_dressbagView && _dressbagView.visible == true))
         {
            setBagCountShow(0);
         }
      }
      
      protected function __onBagUpdatePROPBAG(evt:BagEvent) : void
      {
         if(this.bagType != 21 && !_isScreenFood && this.bagType != 2)
         {
            setBagCountShow(1);
         }
      }
      
      private function __openSettingLock(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         BaglockedManager.Instance.onShow();
         SharedManager.Instance.setBagLocked = true;
         SharedManager.Instance.save();
      }
      
      protected function __bagArrangeOver(evt:MouseEvent) : void
      {
         if(_bagType == 21 || _bagType == 0 && _isScreenFood)
         {
            return;
         }
         if(!_bagArrangeSprite)
         {
            _bagArrangeSprite = ComponentFactory.Instance.creatCustomObject("bagArrangeTipSprite");
         }
         _bagArrangeSprite.y = _keySortBtn.y + _buttonContainer.y - 24;
         addChild(_bagArrangeSprite);
      }
      
      protected function __sortBagClick(evt:MouseEvent) : void
      {
         evt = evt;
         SoundManager.instance.play("008");
         if(_bagType != 21)
         {
            if(_isScreenFood && _bagType == 0)
            {
               onClickSortPetEquipBag = function():void
               {
                  PlayerManager.Instance.Self.getBag(_bagType).foldPetEquips(_bagType,PlayerManager.Instance.Self.getBag(_bagType),0,48);
               };
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  return;
               }
               if(_sortPetEquipBagData.notShowAlertAgain)
               {
                  PlayerManager.Instance.Self.getBag(_bagType).foldPetEquips(_bagType,PlayerManager.Instance.Self.getBag(_bagType),0,48);
                  return;
               }
               var msg:String = LanguageMgr.GetTranslation("petBag.sortTips");
               HelperBuyAlert.getInstance().alert(msg,_sortPetEquipBagData,"SimpleAlertWithNotShowAgain",null,onClickSortPetEquipBag,null,0);
               return;
            }
            if(_bagArrangeSprite && _bagType == 1)
            {
               PlayerManager.Instance.Self.PropBag.sortBag(_bagType,PlayerManager.Instance.Self.getBag(_bagType),0,95,_bagArrangeSprite.arrangeAdd);
               return;
            }
            if(_bagArrangeSprite && _bagArrangeSprite.arrangeAdd && bagType == 0 && !_sortEquipBagData.notShowAlertAgain)
            {
               onClickSortEquipBag = function():void
               {
                  PlayerManager.Instance.Self.PropBag.sortBag(_bagType,PlayerManager.Instance.Self.getBag(_bagType),0,48,_bagArrangeSprite.arrangeAdd);
               };
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  return;
               }
               msg = LanguageMgr.GetTranslation("bag.bagView.equipSortTips");
               HelperBuyAlert.getInstance().alert(msg,_sortEquipBagData,"SimpleAlertWithNotShowAgain",null,onClickSortEquipBag,null,0);
            }
            else if(_bagArrangeSprite)
            {
               PlayerManager.Instance.Self.PropBag.sortBag(_bagType,PlayerManager.Instance.Self.getBag(_bagType),0,48,_bagArrangeSprite.arrangeAdd);
            }
         }
         else
         {
            PlayerManager.Instance.Self.PropBag.sortBag(_bagType,PlayerManager.Instance.Self.getBag(_bagType),32,178,true);
         }
      }
      
      private function __frameEvent(event:FrameEvent) : void
      {
         var alert:BaseAlerFrame = event.target as BaseAlerFrame;
         alert.removeEventListener("response",__frameEvent);
         alert.dispose();
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               if(_bagType != 21)
               {
                  PlayerManager.Instance.Self.PropBag.sortBag(_bagType,PlayerManager.Instance.Self.getBag(_bagType),0,48,false);
                  break;
               }
               break;
            case 2:
            case 3:
            case 4:
               if(_bagType != 21)
               {
                  PlayerManager.Instance.Self.PropBag.sortBag(_bagType,PlayerManager.Instance.Self.getBag(_bagType),0,48,true);
               }
               else
               {
                  PlayerManager.Instance.Self.PropBag.sortBag(_bagType,PlayerManager.Instance.Self.getBag(_bagType),32,178,true);
               }
         }
      }
      
      private function __propertyChange(evt:PlayerPropertyEvent) : void
      {
         if(evt.changedProperties["BandMoney"] || evt.changedProperties["Money"] || evt.changedProperties["Gold"] || evt.changedProperties["Money"])
         {
            updateMoney();
         }
      }
      
      private function updateMoney() : void
      {
         if(_info)
         {
            _goldText.text = String(_info.Gold);
            _moneyText.text = String(_info.Money);
            _giftText.text = String(_info.BandMoney);
            _orderTxt.text = String(_info.DDTMoney);
         }
         else
         {
            var _loc1_:* = "";
            _giftText.text = _loc1_;
            _loc1_ = _loc1_;
            _moneyText.text = _loc1_;
            _goldText.text = _loc1_;
         }
      }
      
      protected function __listChange(evt:Event) : void
      {
         if(!(_dressbagView && _dressbagView.visible == true))
         {
            setBagType(0);
         }
      }
      
      private function __feedClick(pEvent:MouseEvent) : void
      {
         if(!(bead_state & 1))
         {
            bead_state = bead_state | 1;
            SoundManager.instance.play("008");
            _beadFeedBtn.dragStart(pEvent.stageX,pEvent.stageY);
            _beadFeedBtn.addEventListener("stopfeed",__stopFeed);
            dispatchEvent(new Event("sellstart"));
            stage.addEventListener("click",__onStageClick_FeedBtn);
            pEvent.stopImmediatePropagation();
         }
         else
         {
            bead_state = ~1 & bead_state;
            _beadFeedBtn.stopDrag();
         }
      }
      
      private function __stopFeed(pEvent:Event) : void
      {
         bead_state = ~1 & bead_state;
         _beadFeedBtn.removeEventListener("stopsell",__stopSell);
         dispatchEvent(new Event("stopfeed"));
         if(stage)
         {
            stage.removeEventListener("click",__onStageClick_FeedBtn);
         }
      }
      
      private function __onStageClick_FeedBtn(pEvent:Event) : void
      {
         bead_state = ~1 & bead_state;
         dispatchEvent(new Event("stopfeed"));
         if(stage)
         {
            stage.removeEventListener("click",__onStageClick_FeedBtn);
         }
      }
      
      private function __sellClick(evt:MouseEvent) : void
      {
         if(!(state & 1))
         {
            state = state | 1;
            SoundManager.instance.play("008");
            _sellBtn.dragStart(evt.stageX,evt.stageY);
            _sellBtn.addEventListener("stopsell",__stopSell);
            dispatchEvent(new Event("sellstart"));
            stage.addEventListener("click",__onStageClick_SellBtn);
            evt.stopImmediatePropagation();
         }
         else
         {
            state = ~1 & state;
            _sellBtn.stopDrag();
         }
      }
      
      private function __stopSell(evt:Event) : void
      {
         state = ~1 & state;
         _sellBtn.removeEventListener("stopsell",__stopSell);
         dispatchEvent(new Event("sellstop"));
         if(stage)
         {
            stage.removeEventListener("click",__onStageClick_SellBtn);
         }
      }
      
      private function __onStageClick_SellBtn(e:Event) : void
      {
         state = ~1 & state;
         dispatchEvent(new Event("sellstop"));
         if(stage)
         {
            stage.removeEventListener("click",__onStageClick_SellBtn);
         }
      }
      
      private function __breakClick(evt:MouseEvent) : void
      {
         if(_breakBtn.enable)
         {
            SoundManager.instance.play("008");
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
            }
            else
            {
               _breakBtn.dragStart(evt.stageX,evt.stageY);
            }
         }
      }
      
      public function resetMouse() : void
      {
         state = ~1 & state;
         LayerManager.Instance.clearnStageDynamic();
         Mouse.show();
         if(_breakBtn)
         {
            _breakBtn.stopDrag();
         }
      }
      
      private function isOnlyGivingGoods(info:InventoryItemInfo) : Boolean
      {
         return info.IsBinds == false && EquipType.isPackage(info) && info.Property2 == "10";
      }
      
      protected function __cellClick(evt:CellEvent) : void
      {
         var cell:* = undefined;
         var info:* = null;
         var pos:* = null;
         if(_sellBtn && !_sellBtn.isActive)
         {
            evt.stopImmediatePropagation();
            if(evt.data is BagCell)
            {
               cell = evt.data as BagCell;
            }
            else
            {
               cell = evt.data as BeadCell;
            }
            if(cell)
            {
               info = cell.itemInfo as InventoryItemInfo;
            }
            if(info == null)
            {
               return;
            }
            if(!cell.locked)
            {
               SoundManager.instance.play("008");
               if(!isOnlyGivingGoods(info) && (info.getRemainDate() <= 0 && !EquipType.isProp(info) || EquipType.isPackage(info) || info.getRemainDate() <= 0 && info.TemplateID == 10200 || info.TemplateID == 11955 || info.TemplateID == 11963 || EquipType.canBeUsed(info) || DressUtils.isDress(info) || EquipType.isGetPackage(info) || EquipType.isFireworks(info) || info.CategoryID == 68 || info.CategoryID == 43 || info.CategoryID == 73))
               {
                  pos = cell.parent.localToGlobal(new Point(cell.x,cell.y));
                  CellMenu.instance.show(cell,pos.x + 20,pos.y + 20);
               }
               else
               {
                  cell.dragStart();
               }
            }
         }
      }
      
      public function set cellDoubleClickEnable(b:Boolean) : void
      {
         if(b)
         {
            _equiplist.addEventListener("doubleclick",__cellDoubleClick);
            _proplist.addEventListener("doubleclick",__cellDoubleClick);
         }
         else
         {
            _equiplist.removeEventListener("doubleclick",__cellDoubleClick);
            _proplist.removeEventListener("doubleclick",__cellDoubleClick);
         }
      }
      
      protected function __cellDoubleClick(evt:CellEvent) : void
      {
         var alert:* = null;
         var toPlace:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         evt.stopImmediatePropagation();
         var cell:BagCell = evt.data as BagCell;
         var info:InventoryItemInfo = cell.info as InventoryItemInfo;
         if(BagAndInfoManager.Instance.getBagAndGiftFrame() && BagAndInfoManager.Instance.getBagAndGiftFrame().infoFrame.currentType == 3)
         {
            if(info.CategoryID == TexpManager.Instance.texpType)
            {
               SocketManager.Instance.out.sendClearStoreBag();
               SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,0,info.Count,true);
               return;
            }
            if(TexpManager.Instance.texpType == 53)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TextCell.texpTips"));
               return;
            }
            if(TexpManager.Instance.texpType == 20)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TextCell.magicTexpTips"));
               return;
            }
            if(TexpManager.Instance.texpType == 78)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TextCell.nsTexpTips"));
               return;
            }
         }
         var templeteInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(info.TemplateID);
         var playerSex:int = !!PlayerManager.Instance.Self.Sex?1:2;
         if(info.getRemainDate() <= 0)
         {
            return;
         }
         if(templeteInfo.NeedSex != playerSex && templeteInfo.NeedSex != 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.data.player.SelfInfo.object"));
            return;
         }
         if(!cell.locked)
         {
            if(int(cell.info.Property1) != 1100 && (cell.info.BindType == 1 || cell.info.BindType == 2 || cell.info.BindType == 3) && cell.itemInfo.IsBinds == false)
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.BindsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
               alert.addEventListener("response",__onResponse);
               temInfo = info;
            }
            else
            {
               SoundManager.instance.play("008");
               if(info.BagType == 1)
               {
                  if(evt.target is PetBagListView && info.CategoryID == 34)
                  {
                     PetsBagManager.instance().dispatchEvent(new UpdatePetInfoEvent("showPetFood",info));
                  }
                  else
                  {
                     CellMenu.instance.cell = cell;
                     __cellUse(evt);
                  }
               }
               else if(PlayerManager.Instance.Self.canEquip(info))
               {
                  if(info.CategoryID == 50 || info.CategoryID == 51 || info.CategoryID == 52)
                  {
                     if(PetsBagManager.instance().view && PetsBagManager.instance().view.parent)
                     {
                        if(!PetsBagManager.instance().petModel.currentPetInfo)
                        {
                           MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petEquipNo"));
                           return;
                        }
                        SocketManager.Instance.out.addPetEquip(cell.place,PetsBagManager.instance().petModel.currentPetInfo.Place,0);
                     }
                     return;
                  }
                  if(EquipType.isArmShell(info))
                  {
                     return;
                  }
                  toPlace = PlayerManager.Instance.getDressEquipPlace(info);
                  SocketManager.Instance.out.sendMoveGoods(0,info.Place,0,toPlace,info.Count);
               }
            }
         }
      }
      
      private function __onResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.target as BaseAlerFrame;
         alert.removeEventListener("response",__onResponse);
         alert.dispose();
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            sendDefy();
         }
      }
      
      private function sendDefy() : void
      {
         var toPlace:int = 0;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.canEquip(temInfo))
         {
            if(temInfo.CategoryID == 50 || temInfo.CategoryID == 51 || temInfo.CategoryID == 52)
            {
               if(PetsBagManager.instance().view && PetsBagManager.instance().view.parent)
               {
                  if(!PetsBagManager.instance().petModel.currentPetInfo)
                  {
                     return;
                  }
                  SocketManager.Instance.out.addPetEquip(temInfo.Place,PetsBagManager.instance().petModel.currentPetInfo.Place,0);
               }
               return;
            }
            toPlace = PlayerManager.Instance.getDressEquipPlace(temInfo);
            SocketManager.Instance.out.sendMoveGoods(0,temInfo.Place,0,toPlace,temInfo.Count);
         }
      }
      
      private function __cellAddPrice(evt:Event) : void
      {
         var cell:BagCell = CellMenu.instance.cell;
         if(cell)
         {
            if(ShopManager.Instance.canAddPrice(cell.itemInfo.TemplateID))
            {
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  return;
               }
               AddPricePanel.Instance.setInfo(cell.itemInfo,false);
               AddPricePanel.Instance.show();
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.cantAddPrice"));
            }
         }
      }
      
      protected function __cellMove(evt:Event) : void
      {
         var cell:BagCell = CellMenu.instance.cell;
         if(cell)
         {
            cell.dragStart();
         }
      }
      
      protected function __cellOpenBatch(evt:Event) : void
      {
         var openBatchView:* = null;
         var cell:BagCell = CellMenu.instance.cell as BagCell;
         if(cell != null && cell.itemInfo != null)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            openBatchView = ComponentFactory.Instance.creatComponentByStylename("bag.OpenBatchView");
            openBatchView.item = cell.itemInfo;
            LayerManager.Instance.addToLayer(openBatchView,3,true,1);
         }
      }
      
      protected function __cellOpen(evt:Event) : void
      {
         var sexN:Number = NaN;
         var bg:* = null;
         var leftTime:int = 0;
         var h:int = 0;
         var m:int = 0;
         var alertAskGiftBag:* = null;
         var frame:* = null;
         var frame2:* = null;
         var cell:BagCell = CellMenu.instance.cell as BagCell;
         _currentCell = cell;
         if(cell != null && cell.itemInfo != null)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            BagAndInfoManager.Instance.isUpgradePack = cell.itemInfo.Property1 == "6" && cell.itemInfo.Property2 == "9" && cell.itemInfo.Property3 == "0";
            sexN = !!PlayerManager.Instance.Self.Sex?1:2;
            if(cell.info.NeedSex != 0 && sexN != cell.info.NeedSex)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.sexErr"));
               return;
            }
            if(PlayerManager.Instance.Self.Grade >= cell.info.NeedLevel)
            {
               if(cell.info.TemplateID == 112109)
               {
                  if(PlayerManager.Instance.Self.IsVIP)
                  {
                     RouletteManager.instance.useVipBox(cell);
                  }
                  else
                  {
                     evt.stopImmediatePropagation();
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.vip.vipIcon.notVip"));
                  }
               }
               else if(cell.info.TemplateID == 112019)
               {
                  RouletteManager.instance.useRouletteBox(cell);
               }
               else if(EquipType.isCaddy(cell.info))
               {
                  evt.stopImmediatePropagation();
                  RouletteManager.instance.useCaddy(cell);
               }
               else if(cell.info.TemplateID == 112222 || cell.info.TemplateID == 112223 || cell.info.TemplateID == 112224)
               {
                  evt.stopImmediatePropagation();
                  RouletteManager.instance.useBless(cell);
               }
               else if(EquipType.isBeadNeedOpen(cell.info))
               {
                  evt.stopImmediatePropagation();
                  RouletteManager.instance.useBead(cell.info.TemplateID);
               }
               else if(cell.info.TemplateID == 112255)
               {
                  evt.stopImmediatePropagation();
                  RouletteManager.instance.useCelebrationBox();
               }
               else if(cell.info.TemplateID == 112262 && !cell.itemInfo.IsBinds)
               {
                  evt.stopImmediatePropagation();
                  WonderfulActivityManager.Instance.useBattleCompanion(cell.itemInfo);
               }
               else if(EquipType.isOfferPackage(cell.info))
               {
                  evt.stopImmediatePropagation();
                  RouletteManager.instance.useOfferPack(cell);
               }
               else if(EquipType.isTimeBox(cell.info))
               {
                  bg = DateUtils.getDateByStr(InventoryItemInfo(cell.info).BeginDate);
                  leftTime = int(cell.info.Property3) * 60 - (TimeManager.Instance.Now().getTime() - bg.getTime()) / 1000;
                  if(leftTime <= 0)
                  {
                     SocketManager.Instance.out.sendItemOpenUp(cell.itemInfo.BagType,cell["place"]);
                  }
                  else
                  {
                     h = leftTime / 3600;
                     m = leftTime % 3600 / 60;
                     m = m > 0?m:1;
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.userGuild.boxTip",h,m));
                  }
               }
               else if(cell.info.CategoryID == 18)
               {
                  evt.stopImmediatePropagation();
                  SocketManager.Instance.out.sendOpenCardBox(cell["place"],1,cell.bagType);
               }
               else if(cell.info.CategoryID == 66)
               {
                  evt.stopImmediatePropagation();
                  SocketManager.Instance.out.sendOpenSpecialCardBox(cell["place"],1,cell.bagType);
               }
               else if(cell.info.TemplateID == 112108 || cell.info.TemplateID == 112150 || cell.info.TemplateID == 1120538 || cell.info.TemplateID == 1120539)
               {
                  SocketManager.Instance.out.sendOpenRandomBox(cell["place"],1);
               }
               else if(cell.info.TemplateID == 11961 || cell.info.TemplateID == 11965 || cell.info.TemplateID == 11967)
               {
                  SocketManager.Instance.out.sendOpenNationWord(cell.bagType,cell.place,1);
               }
               else if(EquipType.isSpecilPackage(cell.info))
               {
                  if(PlayerManager.Instance.Self.DDTMoney >= Number(cell.info.Property3))
                  {
                     alertAskGiftBag = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.AskGiftBag",cell.info.Property3,cell.info.Name),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
                     alertAskGiftBag.addEventListener("response",__GiftBagframeClose);
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.AskGiftBagII",cell.info.Property3));
                  }
               }
               else if(35 == cell.info.CategoryID)
               {
                  SocketManager.Instance.out.sendAddPet(cell.itemInfo.Place,cell.itemInfo.BagType);
               }
               else if(cell.info.Property2 == "8")
               {
                  frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("bagView.consumePack.openTxt",cell.info.Property3),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false);
                  frame.addEventListener("response",onConsumePackResponse);
               }
               else if(cell.info.Property2 == "11")
               {
                  frame2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("bagView.consumePack.openTxt",cell.info.Property3),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false,0);
                  frame2.addEventListener("response",onConsumePackResponse);
               }
               else if(cell.itemInfo.CategoryID == 222222222)
               {
                  ItemActivityGiftManager.instance.showFrame(1,cell.itemInfo);
               }
               else if(cell.info.TemplateID == 1120412 || cell.info.TemplateID == 1120413 || cell.info.TemplateID == 1120414 || cell.info.TemplateID == 1120433 || cell.info.TemplateID == 1120434 || cell.info.TemplateID == 12545)
               {
                  SocketManager.Instance.out.sendChangeSex(cell.bagType,cell.place);
               }
               else if(cell.info.CategoryID == 72)
               {
                  SocketManager.Instance.out.sendItemOpenUp(cell.itemInfo.BagType,cell.itemInfo.Place);
               }
               else if(EquipType.isGetPackage(cell.info))
               {
                  showGetFriendPackFrame(cell.info,cell.itemInfo.BagType,cell.itemInfo.Place);
               }
               else if(EquipType.isFireworks(cell.info))
               {
                  SocketManager.Instance.out.sendUseCard(cell.itemInfo.BagType,cell.itemInfo.Place,[cell.info.TemplateID],cell.info.PayType);
               }
               else if(cell.info.CategoryID == 68)
               {
                  SocketManager.Instance.out.sendOpenAmuletBox(cell.itemInfo.BagType,cell.itemInfo.Place);
               }
               else if(cell.info.CategoryID == 43)
               {
                  SocketManager.Instance.out.sendRoomBordenItemUp(cell.place);
               }
               else
               {
                  SocketManager.Instance.out.sendItemOpenUp(cell.itemInfo.BagType,cell.itemInfo.Place);
               }
            }
            else if(cell.info.CategoryID == 18)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cardSystem.bagView.openCardBox.level"));
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.level"));
            }
         }
      }
      
      private function showGetFriendPackFrame(info:ItemTemplateInfo, bagType:int, place:int) : void
      {
         var packFrameInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(int(info.Property8));
         if(_getFriendPackFrame)
         {
            _getFriendPackFrame.dispose();
            _getFriendPackFrame = null;
         }
         _getFriendPackFrame = ComponentFactory.Instance.creatComponentByStylename("bag.getFriendPackFrame");
         _getFriendPackFrame.updateView(packFrameInfo,bagType,place);
         _getFriendPackFrame.show();
      }
      
      protected function onConsumePackResponse(e:FrameEvent) : void
      {
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",onConsumePackResponse);
         if(e.responseCode == 0 || e.responseCode == 4 || e.responseCode == 1)
         {
            frame.dispose();
            return;
         }
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            if(frame.isBand)
            {
               if(PlayerManager.Instance.Self.BandMoney < int(_currentCell.info.Property3))
               {
                  initAlertFarme();
               }
               else
               {
                  SocketManager.Instance.out.sendItemOpenUp(_currentCell.itemInfo.BagType,_currentCell.itemInfo.Place,1,frame.isBand);
               }
            }
            else if(PlayerManager.Instance.Self.Money < int(_currentCell.info.Property3))
            {
               LeavePageManager.showFillFrame();
            }
            else
            {
               SocketManager.Instance.out.sendItemOpenUp(_currentCell.itemInfo.BagType,_currentCell.itemInfo.Place,1,frame.isBand);
            }
         }
         frame.dispose();
      }
      
      private function initAlertFarme() : void
      {
         var frame:* = null;
         frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("buried.alertInfo.noBindMoney"),"",LanguageMgr.GetTranslation("cancel"),true,false,false,2);
         frame.addEventListener("response",onResponseHander);
      }
      
      protected function onResponseHander(e:FrameEvent) : void
      {
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            if(PlayerManager.Instance.Self.Money < int(_currentCell.info.Property3))
            {
               LeavePageManager.showFillFrame();
            }
            else
            {
               SocketManager.Instance.out.sendItemOpenUp(_currentCell.itemInfo.BagType,_currentCell.itemInfo.Place,1,false);
            }
         }
         e.currentTarget.dispose();
      }
      
      private function __GiftBagframeClose(event:FrameEvent) : void
      {
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               if(_currentCell && _currentCell.itemInfo)
               {
                  SocketManager.Instance.out.sendItemOpenUp(_currentCell.itemInfo.BagType,_currentCell["place"]);
                  break;
               }
         }
         event.currentTarget.removeEventListener("response",__GiftBagframeClose);
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      private function __cellUse(evt:Event) : void
      {
         var alert:* = null;
         var thisQualifiedClassName:* = null;
         evt.stopImmediatePropagation();
         var cell:BagCell = CellMenu.instance.cell as BagCell;
         if(cell.info.CategoryID == 73)
         {
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(!cell || cell.info == null)
         {
            return;
         }
         if(cell.info.TemplateID == 11560 || cell.info.TemplateID == 11561 || cell.info.TemplateID == 11562)
         {
            if(this is ConsortionBankBagView)
            {
               BagStore.instance.isFromConsortionBankFrame = true;
            }
            else if(isHomeBankBagView())
            {
               BagStore.instance.isFromHomeBankFrame = true;
            }
            else
            {
               BagStore.instance.isFromBagFrame = true;
            }
            BagStore.instance.openStore("forge_store",1);
            return;
         }
         if(cell.info.TemplateID == 11961 || cell.info.TemplateID == 11965 || cell.info.TemplateID == 11967)
         {
            SocketManager.Instance.out.sendOpenNationWord(cell.bagType,cell.place,1);
            return;
         }
         if(cell.info.TemplateID == 11994)
         {
            startReworkName(cell.bagType,cell.place);
            return;
         }
         if(cell.info.CategoryID == 11 && cell.info.Property1 == "5" && cell.info.Property2 != "0")
         {
            showChatBugleInputFrame(cell.info.TemplateID);
            return;
         }
         if(cell.info.CategoryID == 23)
         {
            if(PlayerManager.Instance.Self.Grade < 13)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpCell.noGrade",13));
               return;
            }
            if(TexpManager.Instance.getLv(TexpManager.Instance.getExp(int(cell.info.Property1))) >= PlayerManager.Instance.Self.Grade + 5)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpCell.lvToplimit"));
               return;
            }
            if(TaskManager.instance.texpQuests.length > 0)
            {
               _tmpCell = cell;
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("texpSystem.view.TexpView.refreshTaskTip"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
               alert.addEventListener("response",__texpResponse);
               return;
            }
            SocketManager.Instance.out.sendTexp(-1,cell.info.TemplateID,1,cell.place);
            return;
         }
         if(cell.info.TemplateID == 11993)
         {
            if(PlayerManager.Instance.Self.ConsortiaID == 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.ConsortiaReworkNameView.consortiaNameAlert1"));
               return;
            }
            if(PlayerManager.Instance.Self.NickName != PlayerManager.Instance.Self.consortiaInfo.ChairmanName)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.ConsortiaReworkNameView.consortiaNameAlert2"));
               return;
            }
            startupConsortiaReworkName(cell.bagType,cell.place);
            return;
         }
         if(cell.info.TemplateID == 12604)
         {
            if(PlayerManager.Instance.Self.teamID == 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.battleTeamRenameAlert"));
               return;
            }
            if(PlayerManager.Instance.Self.teamDuty != 1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.battleTeamRenameAlert1"));
               return;
            }
            startupBattleTeamReworkName(cell.bagType,cell.place);
            return;
         }
         if(cell.info.TemplateID == 11569)
         {
            startupChangeSex(cell.bagType,cell.place);
            return;
         }
         if(cell.info.CategoryID == 11 && int(cell.info.Property1) == 37)
         {
            if(PlayerManager.Instance.Self.Bag.getItemAt(6))
            {
               if(PlayerManager.Instance.Self.Bag.getItemAt(6).StrengthenLevel >= 10)
               {
                  SocketManager.Instance.out.sendUseChangeColorShell(cell.bagType,cell.place);
                  return;
               }
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bagAndInfo.bag.UnableUseColorShell"));
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.bagAndInfo.ColorShell.NoWeapon"));
               return;
            }
         }
         else if(cell.info.CategoryID == 18)
         {
            SocketManager.Instance.out.sendOpenCardBox(cell.place,1,cell.bagType);
         }
         else if(cell.info.CategoryID == 66)
         {
            SocketManager.Instance.out.sendOpenSpecialCardBox(cell.place,1,cell.bagType);
         }
         if(cell.info.TemplateID == 12511)
         {
            CalendarManager.getInstance().open(1);
         }
         else if(cell.info.TemplateID == 11999)
         {
            ChangeColorManager.instance.changeColorModel.place = cell.place;
            ChangeColorManager.instance.changeColorModel.getColorEditableThings();
            ChangeColorManager.instance.show();
         }
         else if(cell.info.TemplateID != 34101)
         {
            if(cell.info.CategoryID == 11 && int(cell.info.Property1) == 24)
            {
               if(TrusteeshipManager.instance.spiritValue >= TrusteeshipManager.instance.maxSpiritValue)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.trusteeship.maxSpiritCannotUseTxt"));
                  return;
               }
               SocketManager.Instance.out.sendTrusteeshipUseSpiritItem(cell.place,cell.bagType);
            }
            else if(cell.info.CategoryID == 11 && int(cell.info.Property1) == 39)
            {
               SocketManager.Instance.out.sendUseItemKingBless(cell.place,cell.bagType);
            }
            else if(cell.info.CategoryID == 11 && int(cell.info.Property1) == 39 && int(cell.info.Property2) == 10)
            {
               SocketManager.Instance.out.sendUseItemDeed(cell.place,cell.bagType);
            }
            else if(cell.info.CategoryID == 11 && int(cell.info.Property1) == 101)
            {
               if(this is ConsortionBankBagView)
               {
                  BagStore.instance.isFromConsortionBankFrame = true;
               }
               else if(isHomeBankBagView())
               {
                  BagStore.instance.isFromHomeBankFrame = true;
               }
               else
               {
                  BagStore.instance.isFromBagFrame = true;
               }
               if(PlayerManager.Instance.Self.Grade < 5)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",5));
                  return;
               }
               BagStore.instance.openStore("forge_store",0);
            }
            else if(EquipType.isStrengthStone(cell.info))
            {
               if(this is ConsortionBankBagView)
               {
                  BagStore.instance.isFromConsortionBankFrame = true;
               }
               else if(isHomeBankBagView())
               {
                  BagStore.instance.isFromHomeBankFrame = true;
               }
               else
               {
                  BagStore.instance.isFromBagFrame = true;
               }
               BagStore.instance.openStore("bag_store");
            }
            else if(cell.info.CategoryID == 11 && int(cell.info.Property1) == 45)
            {
               if(PlayerManager.Instance.Self.Grade < 25)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.godTemple.openGodTempleBtn.text",25.toString()));
                  return;
               }
               thisQualifiedClassName = getQualifiedClassName(this);
               if(this is ConsortionBankBagView)
               {
                  BagStore.instance.isFromConsortionBankFrame = true;
               }
               else if(isHomeBankBagView())
               {
                  BagStore.instance.isFromHomeBankFrame = true;
               }
               else
               {
                  BagStore.instance.isFromBagFrame = true;
               }
               BagStore.instance.openStore("bag_store",1);
            }
            else if(cell.info.CategoryID == 11 && int(cell.info.Property1) == 82)
            {
               if((cell.info as InventoryItemInfo).ValidDate == 0)
               {
                  if(_self.horsePicCherishDic.hasKey(cell.info.Property2) && _self.horsePicCherishDic[cell.info.Property2].isUsed)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.pic.alreadyActive"));
                     return;
                  }
                  HorseManager.instance.skipHorsePicCherishId = int(cell.info.Property2);
                  HorseManager.instance.isSkipFromBagView = true;
                  HorseManager.instance.show();
               }
               else
               {
                  SocketManager.Instance.out.sendActiveHorsePicCherish((cell.info as InventoryItemInfo).Place);
               }
            }
            else if(cell.info.CategoryID == 62 && cell.info.Property1 == "1")
            {
               if((cell.info as InventoryItemInfo).ValidDate == 0)
               {
                  PetsAdvancedManager.Instance.showFrame(2,true);
               }
               else
               {
                  SocketManager.Instance.out.sendUsePetTemporaryCard((cell.info as InventoryItemInfo).BagType,(cell.info as InventoryItemInfo).Place);
               }
            }
            else if(cell.info.CategoryID == 11 && cell.info.Property1 == "47")
            {
               if(PlayerManager.Instance.Self.Bag.items[12])
               {
                  _necklacePtetrochemicalView = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.necklacePtetrochemicalView");
                  _necklacePtetrochemicalView.show();
                  _necklacePtetrochemicalView.addEventListener("response",__onNecklacePtetrochemicalClose);
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("necklacePtetrochemicalView.messagetip"));
               }
            }
            else if(cell.info.CategoryID == 11 && (int(cell.info.Property1) == 27 || int(cell.info.Property1) == 29 || int(cell.info.Property1) == 107))
            {
               if(_self.Grade < 19)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.openTxt",19));
                  return;
               }
               PetsBagManager.instance().show();
            }
            else if(!(cell.info.CategoryID == 11 && int(cell.info.Property1) == 47))
            {
               if(cell.info.CategoryID == 62 && int(cell.info.Property1) == 0)
               {
                  if(_self.Grade < 25)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.openTxt",25));
                     return;
                  }
                  PetsBagManager.instance().show();
               }
               else if(24 == cell.info.CategoryID)
               {
                  SocketManager.Instance.out.sendNewTitleCard(cell.itemInfo.Place,cell.itemInfo.BagType);
               }
               else if(EquipType.isComposeStone(cell.info))
               {
                  if(this is ConsortionBankBagView)
                  {
                     BagStore.instance.isFromConsortionBankFrame = true;
                  }
                  else if(isHomeBankBagView())
                  {
                     BagStore.instance.isFromHomeBankFrame = true;
                  }
                  else
                  {
                     BagStore.instance.isFromBagFrame = true;
                  }
                  BagStore.instance.openStore("bag_store",2);
               }
               else if(cell.info.TemplateID == 100100)
               {
                  if(PlayerManager.Instance.Self.Grade < 30)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("gemstone.limitLevel.tipTxt",30));
                     return;
                  }
                  if(this is ConsortionBankBagView)
                  {
                     BagStore.instance.isFromConsortionBankFrame = true;
                  }
                  else if(isHomeBankBagView())
                  {
                     BagStore.instance.isFromHomeBankFrame = true;
                  }
                  else
                  {
                     BagStore.instance.isFromBagFrame = true;
                  }
                  BagStore.instance.openStore("forge_store",3);
               }
               else if(cell.info.TemplateID == 11164 || cell.info.TemplateID == 11165)
               {
                  HorseManager.instance.show();
               }
               else if(cell.info.TemplateID == 12568)
               {
                  VIPCouponsManager.instance.openShow(cell.bagType,cell.place);
               }
               else if(cell.info.TemplateID == 12569)
               {
                  VIPCouponsManager.instance.useVipCoupons(cell.bagType,cell.place);
               }
               else if(cell.info.CategoryID == 11 && int(cell.info.Property1) == 104)
               {
                  if(PlayerManager.Instance.Self.Grade < 40)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.godTemple.openGodTempleBtn.text",40));
                     return;
                  }
                  BagStore.instance.openStore("forge_store",4);
               }
               else if(cell.info.TemplateID == 11179)
               {
                  SocketManager.Instance.out.sendItemOpenUp(cell.itemInfo.BagType,cell["place"]);
               }
               else if(cell.info.TemplateID == 12536 || cell.info.TemplateID == 12537)
               {
                  if(PlayerManager.Instance.Self.IsMarried)
                  {
                     SocketManager.Instance.out.sendUseLoveFeelingly(cell.itemInfo.BagType,cell["place"]);
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtBagAndInfo.hasNoMerry.info"));
                  }
               }
               else if(cell.info.TemplateID == 11966)
               {
                  RandomSuitCardManager.getInstance().useCard(cell.itemInfo.Place);
               }
               else if(cell.info.TemplateID == 12545)
               {
                  SocketManager.Instance.out.sendChangeSex(cell.bagType,cell.place);
               }
               else if(cell.info.CategoryID == 68)
               {
                  SocketManager.Instance.out.sendOpenAmuletBox(cell.itemInfo.BagType,cell.itemInfo.Place);
               }
               else if((cell.info.CategoryID == 20 || cell.info.CategoryID == 53) && int(cell.info.Property1) == 0)
               {
                  BagAndInfoManager.Instance.showBagAndInfo(2);
               }
               else if(cell.info.CategoryID == 11 && int(cell.info.Property1) == 108)
               {
                  BagAndInfoManager.Instance.showBagAndInfo(5);
               }
               else if(cell.info.CategoryID == 11 && int(cell.info.Property1) == 106)
               {
                  BagAndInfoManager.Instance.showBagAndInfo(9);
               }
               else if(cell.info.CategoryID == 11 && (int(cell.info.Property1) == 120 || int(cell.info.Property1) == 21))
               {
                  SocketManager.Instance.out.sendUseCard(cell.itemInfo.BagType,cell.itemInfo.Place,[cell.info.TemplateID],cell.info.PayType);
               }
               else if(cell.info.CategoryID == 11 && (int(cell.info.Property1) == 100 || int(cell.info.Property1) == 1100 || int(cell.info.Property1) == 115 || int(cell.info.Property1) == 1200))
               {
                  useProp(cell.itemInfo);
               }
               else if((cell.info.CategoryID == 11 || cell.info.CategoryID == 72) && int(cell.info.Property1) == 6)
               {
                  __cellOpen(evt);
               }
               else
               {
                  useCard(cell.itemInfo);
               }
            }
         }
      }
      
      protected function __onNecklacePtetrochemicalClose(event:FrameEvent) : void
      {
         if(event.responseCode == 0 || event.responseCode == 1 || event.responseCode == 4)
         {
            SoundManager.instance.playButtonSound();
            _necklacePtetrochemicalView.removeEventListener("response",__onNecklacePtetrochemicalClose);
            ObjectUtils.disposeObject(_necklacePtetrochemicalView);
            _necklacePtetrochemicalView = null;
         }
      }
      
      private function isHomeBankBagView() : Boolean
      {
         var thisQualifiedClassName:String = getQualifiedClassName(this);
         if(thisQualifiedClassName == "homeBank.view::HomeBankBagView")
         {
            return true;
         }
         return false;
      }
      
      protected function __cellColorChange(evt:Event) : void
      {
         var cell:BagCell = CellMenu.instance.cell;
         if(cell)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(cell.itemInfo.CategoryID == 13 || cell.itemInfo.CategoryID == 15)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.changeColor.suitAndWingCannotChange"));
               return;
            }
            if(checkDress(cell))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("playerDress.canNotChangeColor"));
               return;
            }
            ChangeColorManager.instance.changeColorModel.place = -1;
            ChangeColorManager.instance.addOneThing(cell);
            ChangeColorManager.instance.show();
         }
      }
      
      private function __alertChangeColor(event:FrameEvent) : void
      {
         event.currentTarget.removeEventListener("response",__alertChangeColor);
         SoundManager.instance.play("008");
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.Money < ShopManager.Instance.getGiftShopItemByTemplateID(11999).getItemPrice(1).bothMoneyValue)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.giftLack"));
               return;
            }
         }
      }
      
      protected function __cellSell(evt:Event) : void
      {
         var cell:BagCell = CellMenu.instance.cell;
         if(cell.info.CategoryID == 73)
         {
            return;
         }
         if(checkDress(cell))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("playerDress.canNotSell"));
            return;
         }
         if(cell)
         {
            cell.sellItem(cell.itemInfo);
         }
      }
      
      private function checkDress(cell:BagCell) : Boolean
      {
         var i:int = 0;
         var vo:* = null;
         if(!DressUtils.isDress(cell.itemInfo))
         {
            return false;
         }
         var modelArr:Array = PlayerDressManager.instance.modelArr;
         var _loc9_:int = 0;
         var _loc8_:* = modelArr;
         for each(var arr in modelArr)
         {
            for(i = 0; i <= arr.length - 1; )
            {
               vo = arr[i];
               if(vo.itemId == cell.itemInfo.ItemID)
               {
                  return true;
               }
               i++;
            }
         }
         var currentModel:DressModel = PlayerDressManager.instance.currentModel;
         if(currentModel)
         {
            var _loc11_:int = 0;
            var _loc10_:* = currentModel.model.Bag.items;
            for each(var item in currentModel.model.Bag.items)
            {
               if(item && item.ItemID == cell.itemInfo.ItemID)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function __texpResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var alert:BaseAlerFrame = evt.target as BaseAlerFrame;
         alert.removeEventListener("response",__texpResponse);
         alert.dispose();
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            if(PlayerManager.Instance.Self.Money < 10)
            {
               LeavePageManager.showFillFrame();
               _tmpCell = null;
               return;
            }
            SocketManager.Instance.out.sendTexp(-1,_tmpCell.info.TemplateID,1,_tmpCell.place);
            _tmpCell = null;
         }
      }
      
      private function useCard(info:InventoryItemInfo) : void
      {
         if(info.TemplateID == 11995 || info.TemplateID == 11998 || info.TemplateID == 11997 || info.TemplateID == 11996 || info.TemplateID.toString().substring(0,3) == "119" || info.TemplateID == 11992 || info.TemplateID == 20150 || info.TemplateID == 201145 || (info.TemplateID == 12535 || info.TemplateID == 1120435))
         {
            if(_self.Grade < 3 && (info.TemplateID == 11992 || info.CategoryID == 11 && info.Property1 == "25"))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",3));
               return;
            }
            if(info.TemplateID != 11916 && info.TemplateID != 11957 && info.TemplateID != 11968)
            {
               SocketManager.Instance.out.sendUseCard(info.BagType,info.Place,[info.TemplateID],info.PayType);
            }
         }
      }
      
      private function useProp(info:InventoryItemInfo) : void
      {
         if(!info)
         {
            return;
         }
         SocketManager.Instance.out.sendUseProp(info.BagType,info.Place,[info.TemplateID],info.PayType);
      }
      
      private function createBreakWin(cell:BagCell) : void
      {
         SoundManager.instance.play("008");
         var win:BreakGoodsView = ComponentFactory.Instance.creatComponentByStylename("breakGoodsView");
      }
      
      public function setCellInfo(index:int, info:InventoryItemInfo) : void
      {
         _currentList.setCellInfo(index,info);
      }
      
      public function dispose() : void
      {
         if(_oneKeyFeedMC)
         {
            _oneKeyFeedMC.removeEventListener("oneKeyComplete",__disposeOneKeyMC);
            _oneKeyFeedMC.stop();
            ObjectUtils.disposeObject(_oneKeyFeedMC);
         }
         removeEvents();
         resetMouse();
         _info = null;
         _lists = null;
         _tmpCell = null;
         _self.getBag(0).removeEventListener("update",__onBagUpdateEQUIPBAG);
         _self.getBag(1).removeEventListener("update",__onBagUpdatePROPBAG);
         if(_pgup)
         {
            ObjectUtils.disposeObject(_pgup);
         }
         _pgup = null;
         if(_pgdn)
         {
            ObjectUtils.disposeObject(_pgdn);
         }
         _pgdn = null;
         if(_pageTxt)
         {
            ObjectUtils.disposeObject(_pageTxt);
         }
         _pageTxt = null;
         if(_pageTxtBg)
         {
            ObjectUtils.disposeObject(_pageTxtBg);
         }
         _pageTxtBg = null;
         if(_beadSortBtn)
         {
            ObjectUtils.disposeObject(_beadSortBtn);
         }
         _beadSortBtn = null;
         if(_sellBtn)
         {
            _sellBtn.removeEventListener("click",__sellClick);
         }
         if(_sellBtn)
         {
            _sellBtn.removeEventListener("stopsell",__stopSell);
         }
         if(_breakBtn)
         {
            _breakBtn.removeEventListener("click",__breakClick);
         }
         if(_goodsNumInfoBg)
         {
            ObjectUtils.disposeObject(_goodsNumInfoBg);
         }
         _goodsNumInfoBg = null;
         if(_goodsNumInfoText)
         {
            ObjectUtils.disposeObject(_goodsNumInfoText);
         }
         _goodsNumInfoText = null;
         if(_goodsNumTotalText)
         {
            ObjectUtils.disposeObject(_goodsNumTotalText);
         }
         _goodsNumTotalText = null;
         if(_tabBtn1)
         {
            ObjectUtils.disposeObject(_tabBtn1);
         }
         _tabBtn1 = null;
         if(_tabBtn2)
         {
            ObjectUtils.disposeObject(_tabBtn2);
         }
         _tabBtn2 = null;
         if(_tabBtn3)
         {
            ObjectUtils.disposeObject(_tabBtn3);
         }
         _tabBtn3 = null;
         if(_tabBtn4)
         {
            ObjectUtils.disposeObject(_tabBtn4);
         }
         _tabBtn4 = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_bg1)
         {
            ObjectUtils.disposeObject(_bg1);
         }
         _bg1 = null;
         if(_goldText)
         {
            ObjectUtils.disposeObject(_goldText);
         }
         _goldText = null;
         if(_moneyText)
         {
            ObjectUtils.disposeObject(_moneyText);
         }
         _moneyText = null;
         ObjectUtils.disposeObject(_giftText);
         _giftText = null;
         ObjectUtils.disposeObject(_orderTxt);
         _orderTxt = null;
         ObjectUtils.disposeObject(_keySortBtn);
         _keySortBtn = null;
         ObjectUtils.disposeObject(_breakBtn);
         _breakBtn = null;
         _currentList = null;
         ObjectUtils.disposeObject(_sellBtn);
         _sellBtn = null;
         ObjectUtils.disposeObject(_proplist);
         _proplist = null;
         ObjectUtils.disposeObject(_petlist);
         _petlist = null;
         ObjectUtils.disposeObject(_equiplist);
         _equiplist = null;
         ObjectUtils.disposeObject(_beadList);
         _beadList = null;
         ObjectUtils.disposeObject(_beadList2);
         _beadList2 = null;
         ObjectUtils.disposeObject(_beadList3);
         _beadList3 = null;
         ObjectUtils.disposeObject(_bgShape);
         _bgShape = null;
         ObjectUtils.disposeObject(_goldButton);
         _goldButton = null;
         ObjectUtils.disposeObject(_giftButton);
         _giftButton = null;
         ObjectUtils.disposeObject(_moneyButton);
         _moneyButton = null;
         ObjectUtils.disposeObject(_orderBtn);
         _orderBtn = null;
         ObjectUtils.disposeObject(_continueBtn);
         _continueBtn = null;
         ObjectUtils.disposeObject(_chatBugleInputFrame);
         _chatBugleInputFrame = null;
         ObjectUtils.disposeObject(_bgShapeII);
         _bgShapeII = null;
         ObjectUtils.disposeObject(_bagList);
         _bagList = null;
         CardManager.Instance.disposeView(1);
         ObjectUtils.disposeObject(_PointCouponBitmap);
         _PointCouponBitmap = null;
         ObjectUtils.disposeObject(_LiJinBitmap);
         _LiJinBitmap = null;
         ObjectUtils.disposeObject(_MoneyBitmap);
         _MoneyBitmap = null;
         ObjectUtils.disposeObject(_orderTxtBitmap);
         _orderTxtBitmap = null;
         ObjectUtils.disposeObject(_currentBeadList);
         _currentBeadList = null;
         ObjectUtils.disposeObject(bagLockBtn);
         bagLockBtn = null;
         ObjectUtils.disposeObject(_equipSelectedBtn);
         _equipSelectedBtn = null;
         ObjectUtils.disposeObject(_propSelectedBtn);
         _propSelectedBtn = null;
         ObjectUtils.disposeObject(_beadSelectedBtn);
         _beadSelectedBtn = null;
         ObjectUtils.disposeObject(_dressSelectedBtn);
         _dressSelectedBtn = null;
         ObjectUtils.disposeObject(_cardEnbleFlase);
         _cardEnbleFlase = null;
         ObjectUtils.disposeObject(_moneyBg);
         _moneyBg = null;
         ObjectUtils.disposeObject(_moneyBg1);
         _moneyBg1 = null;
         ObjectUtils.disposeObject(_moneyBg2);
         _moneyBg2 = null;
         ObjectUtils.disposeObject(_moneyBg3);
         _moneyBg3 = null;
         ObjectUtils.disposeObject(_buttonContainer);
         _buttonContainer = null;
         ObjectUtils.disposeObject(_bagArrangeSprite);
         _bagArrangeSprite = null;
         ObjectUtils.disposeObject(_dressbagView);
         _dressbagView = null;
         PlayerDressManager.instance.disposeView(1);
         if(_oneKeyFeedMC)
         {
            ObjectUtils.disposeObject(_oneKeyFeedMC);
         }
         _oneKeyFeedMC = null;
         if(_reworknameView)
         {
            shutdownReworkName();
         }
         if(_consortaiReworkName)
         {
            shutdownConsortiaReworkName();
         }
         if(_battleTeamReworkName)
         {
            shutdownBattleTeamReworkName();
         }
         if(CellMenu.instance.showed)
         {
            CellMenu.instance.hide();
         }
         AddPricePanel.Instance.close();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function setBagCountShow(bagType:int) : void
      {
         var goodsNum:int = 0;
         var glowFilter:* = null;
         var textColor:* = 0;
         switch(int(bagType))
         {
            case 0:
               goodsNum = PlayerManager.Instance.Self.getBag(bagType).itemBgNumber(_equiplist._startIndex,_equiplist._stopIndex);
               if(goodsNum >= 49)
               {
                  textColor = uint(16711680);
                  glowFilter = new GlowFilter(16777215,0.5,3,3,10);
               }
               else
               {
                  textColor = uint(1310468);
                  glowFilter = new GlowFilter(876032,0.5,3,3,10);
               }
               break;
            case 1:
               goodsNum = PlayerManager.Instance.Self.getBag(bagType).itemBgNumber(0,48);
               if(goodsNum >= 48 + 1)
               {
                  textColor = uint(16711680);
                  glowFilter = new GlowFilter(16777215,0.5,3,3,10);
                  break;
               }
               textColor = uint(1310468);
               glowFilter = new GlowFilter(876032,0.5,3,3,10);
               break;
         }
         _goodsNumInfoText.textColor = textColor;
         _goodsNumInfoText.text = goodsNum.toString();
         setBagType(bagType);
      }
      
      public function get info() : SelfInfo
      {
         return _info;
      }
      
      public function set info(value:SelfInfo) : void
      {
         if(_info)
         {
            _info.removeEventListener("propertychange",__propertyChange);
            _info.getBag(0).removeEventListener("update",__onBagUpdateEQUIPBAG);
            _info.getBag(1).removeEventListener("update",__onBagUpdatePROPBAG);
            _info.BeadBag.items.removeEventListener("add",__onBeadBagChanged);
            PlayerManager.Instance.Self.removeEventListener("showBead",__showBead);
         }
         _info = value;
         if(_info)
         {
            _info.addEventListener("propertychange",__propertyChange);
            _info.getBag(0).addEventListener("update",__onBagUpdateEQUIPBAG);
            _info.getBag(1).addEventListener("update",__onBagUpdatePROPBAG);
            _info.BeadBag.items.addEventListener("add",__onBeadBagChanged);
            PlayerManager.Instance.Self.addEventListener("showBead",__showBead);
         }
         updateView();
      }
      
      private function startReworkName(bagType:int, place:int) : void
      {
         _reworknameView = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.ReworkName.ReworkNameFrame");
         LayerManager.Instance.addToLayer(_reworknameView,3,true,1);
         _reworknameView.initialize(bagType,place);
         _reworknameView.addEventListener("complete",__onRenameComplete);
      }
      
      private function shutdownReworkName() : void
      {
         _reworknameView.removeEventListener("complete",__onRenameComplete);
         ObjectUtils.disposeObject(_reworknameView);
         _reworknameView = null;
      }
      
      private function __onRenameComplete(evt:Event) : void
      {
         shutdownReworkName();
      }
      
      private function startupConsortiaReworkName(bagType:int, place:int) : void
      {
         _consortaiReworkName = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.ReworkName.ReworkNameConsortia");
         LayerManager.Instance.addToLayer(_consortaiReworkName,3,true,1);
         _consortaiReworkName.initialize(bagType,place);
         _consortaiReworkName.addEventListener("complete",__onConsortiaRenameComplete);
      }
      
      private function startupBattleTeamReworkName(bagType:int, place:int) : void
      {
         _battleTeamReworkName = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.ReworkName.ReworkNameBattleTeam");
         LayerManager.Instance.addToLayer(_battleTeamReworkName,3,true,1);
         _battleTeamReworkName.initialize(bagType,place);
      }
      
      private function shutdownConsortiaReworkName() : void
      {
         _consortaiReworkName.removeEventListener("complete",__onConsortiaRenameComplete);
         ObjectUtils.disposeObject(_consortaiReworkName);
         _consortaiReworkName = null;
      }
      
      private function showChatBugleInputFrame(templateID:int) : void
      {
         if(_chatBugleInputFrame == null)
         {
            _chatBugleInputFrame = ComponentFactory.Instance.creat("chat.BugleInputFrame");
         }
         _chatBugleInputFrame.templateID = templateID;
         LayerManager.Instance.addToLayer(_chatBugleInputFrame,3,true,2);
      }
      
      private function shutdownBattleTeamReworkName() : void
      {
         _battleTeamReworkName.removeEventListener("complete",__onBattleTeamRenameComplete);
         ObjectUtils.disposeObject(_battleTeamReworkName);
         _battleTeamReworkName = null;
      }
      
      private function __onBattleTeamRenameComplete(evt:Event) : void
      {
         shutdownBattleTeamReworkName();
      }
      
      private function __onConsortiaRenameComplete(evt:Event) : void
      {
         shutdownConsortiaReworkName();
      }
      
      public function hide() : void
      {
         if(_reworknameView)
         {
            shutdownReworkName();
         }
         if(_consortaiReworkName)
         {
            shutdownConsortiaReworkName();
         }
         if(_battleTeamReworkName)
         {
            shutdownBattleTeamReworkName();
         }
      }
      
      private function judgeAndPlayCardMovie() : void
      {
         var templateInfo:ItemTemplateInfo = _currentCell.info;
         var bagCardDic:DictionaryData = PlayerManager.Instance.Self.cardBagDic;
         var _loc9_:int = 0;
         var _loc8_:* = bagCardDic;
         for each(var cardInfo in bagCardDic)
         {
            if(cardInfo.TemplateID == int(templateInfo.Property5))
            {
               return;
            }
         }
         SocketManager.Instance.out.sendFirstGetCards();
         dispatchEvent(new Event("firstGetCard",true));
         getNewCardMovie = ClassUtils.CreatInstance("asset.getNecCard.movie") as MovieClip;
         PositionUtils.setPos(getNewCardMovie,"BagView.NewCardMovie.Pos");
         var s:Sprite = new Sprite();
         s.graphics.beginFill(16777215,0);
         s.graphics.drawRect(0,0,113,156);
         s.graphics.endFill();
         var cardTempInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(int(templateInfo.Property5));
         var cell:BaseCell = new BaseCell(s,cardTempInfo);
         getNewCardMovie["card"].addChild(cell);
         var text:GradientText = ComponentFactory.Instance.creatComponentByStylename("getNewCardMovie.text");
         text.text = LanguageMgr.GetTranslation("ddt.cardSystem.getNewCard.name",cardTempInfo.Name);
         text.x = text.x - (text.textWidth - cell.width) / 6;
         getNewCardMovie["word"].addChild(text);
         LayerManager.Instance.addToLayer(getNewCardMovie,0,false,2);
         getNewCardMovie.gotoAndPlay(1);
         getNewCardMovie.addEventListener("complete",__showOver);
         _soundControl = new SoundTransform();
         if(SoundManager.instance.allowSound)
         {
            _soundControl.volume = 1;
         }
         else
         {
            _soundControl.volume = 0;
         }
         getNewCardMovie.soundTransform = _soundControl;
      }
      
      private function __showOver(event:Event) : void
      {
         getNewCardMovie.removeEventListener("complete",__showOver);
         _soundControl.volume = 0;
         getNewCardMovie.soundTransform = _soundControl;
         _soundControl = null;
         ObjectUtils.disposeObject(getNewCardMovie);
         getNewCardMovie = null;
      }
      
      protected function _isSkillCanUse() : Boolean
      {
         var boo:Boolean = false;
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(5) && PlayerManager.Instance.Self.IsWeakGuildFinish(2) && PlayerManager.Instance.Self.IsWeakGuildFinish(12) && PlayerManager.Instance.Self.IsWeakGuildFinish(51) && PlayerManager.Instance.Self.IsWeakGuildFinish(55))
         {
            boo = true;
         }
         return boo;
      }
      
      private function startupChangeSex(bagType:int, place:int) : void
      {
         var alert:ChangeSexAlertFrame = ComponentFactory.Instance.creat("bagAndInfo.bag.changeSexAlert");
         alert.bagType = bagType;
         alert.place = place;
         alert.info = getAlertInfo("tank.view.bagII.changeSexAlert",true);
         alert.addEventListener("propertiesChanged",__onAlertSizeChanged);
         alert.addEventListener("response",__onAlertResponse);
         LayerManager.Instance.addToLayer(alert,3,alert.info.frameCenter,1);
         StageReferance.stage.focus = alert;
      }
      
      private function getAlertInfo(tip:String, showCancel:Boolean = false) : AlertInfo
      {
         var result:AlertInfo = new AlertInfo();
         result.autoDispose = true;
         result.showSubmit = true;
         result.showCancel = showCancel;
         result.enterEnable = true;
         result.escEnable = true;
         result.moveEnable = false;
         result.title = LanguageMgr.GetTranslation("AlertDialog.Info");
         result.data = LanguageMgr.GetTranslation(tip);
         return result;
      }
      
      private function __onAlertSizeChanged(event:ComponentEvent) : void
      {
         var alert:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         if(alert.info.frameCenter)
         {
            alert.x = (StageReferance.stageWidth - alert.width) / 2;
            alert.y = (StageReferance.stageHeight - alert.height) / 2;
         }
      }
      
      private function __onAlertResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:ChangeSexAlertFrame = ChangeSexAlertFrame(evt.currentTarget);
         alert.removeEventListener("propertiesChanged",__onAlertSizeChanged);
         alert.removeEventListener("response",__onAlertResponse);
         switch(int(evt.responseCode) - 2)
         {
            case 0:
            case 1:
               SocketManager.Instance.out.sendChangeSex(alert.bagType,alert.place);
         }
         alert.dispose();
         alert = null;
      }
      
      private function __changeSexHandler(evt:CrazyTankSocketEvent) : void
      {
         var alert:* = null;
         SocketManager.Instance.socket.close();
         var state:Boolean = evt.pkg.readBoolean();
         if(state)
         {
            alert = ComponentFactory.Instance.creat("sellGoodsAlert");
            alert.info = getAlertInfo("tank.view.bagII.changeSexAlert.success",false);
            alert.addEventListener("propertiesChanged",__onAlertSizeChanged);
            alert.addEventListener("response",__onSuccessAlertResponse);
            LayerManager.Instance.addToLayer(alert,3,alert.info.frameCenter,1);
            StageReferance.stage.focus = alert;
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.changeSexAlert.failed"));
         }
      }
      
      private function __onSuccessAlertResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         ExternalInterface.call("WindowReturn");
      }
      
      public function set isScreenFood(value:Boolean) : void
      {
         this._isScreenFood = value;
      }
      
      public function get beadFeedBtn() : BeadFeedButton
      {
         return _beadFeedBtn;
      }
      
      public function deleteButtonForPet() : void
      {
         if(bagLockBtn)
         {
            bagLockBtn.dispose();
            bagLockBtn = null;
         }
         if(_dressSelectedBtn)
         {
            _dressSelectedBtn.dispose();
            _dressSelectedBtn = null;
         }
      }
   }
}
