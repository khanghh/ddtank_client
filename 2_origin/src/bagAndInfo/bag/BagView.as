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
         var _loc2_:int = ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel);
         var _loc1_:int = ServerConfigManager.instance.VIPExtraBindMoneyUpper[PlayerManager.Instance.Self.VIPLevel - 1];
         _giftButton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.bag.GiftButton");
         _giftButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GiftDirections",_loc2_.toString());
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
      
      public function set sortBagEnable(param1:Boolean) : void
      {
         _keySortBtn.enable = param1;
      }
      
      public function set breakBtnEnable(param1:Boolean) : void
      {
         _breakBtn.enable = param1;
      }
      
      public function set cardbtnVible(param1:Boolean) : void
      {
         _cardEnbleFlase.visible = param1;
      }
      
      public function set cardbtnFilter(param1:Array) : void
      {
         _cardEnbleFlase.filters = param1;
      }
      
      public function set sortBagFilter(param1:Array) : void
      {
         _keySortBtn.filters = param1;
      }
      
      public function set breakBtnFilter(param1:Array) : void
      {
         _breakBtn.filters = param1;
      }
      
      public function set tableEnable(param1:Boolean) : void
      {
         _tabBtn3.mouseEnabled = param1;
      }
      
      public function switchButtomVisible(param1:Boolean) : void
      {
         _bg1.visible = param1;
         _sellBtn.visible = param1;
         _breakBtn.visible = param1;
         _continueBtn.visible = param1;
         _keySortBtn.visible = param1;
         _goldText.visible = param1;
         _giftButton.visible = param1;
         _giftText.visible = param1;
         _moneyButton.visible = param1;
         _orderTxt.visible = param1;
         _orderBtn.visible = param1;
         _moneyBg3.visible = param1;
         if(_pgup)
         {
            _pgup.visible = !param1;
         }
         if(_pgdn)
         {
            _pgdn.visible = !param1;
         }
         if(_pageTxt)
         {
            _pageTxt.visible = !param1;
         }
         if(_pageTxtBg)
         {
            _pageTxtBg.visible = !param1;
         }
         if(_beadFeedBtn)
         {
            _beadFeedBtn.visible = !param1;
         }
         if(_beadLockBtn)
         {
            _beadLockBtn.visible = !param1;
         }
         if(_beadOneKeyBtn)
         {
            _beadOneKeyBtn.visible = !param1;
         }
         if(_beadSortBtn)
         {
            _beadSortBtn.visible = !param1;
         }
         enableBeadFunctionBtns(!param1);
         if(_moneyBg1)
         {
            _moneyBg1.visible = param1;
         }
         if(_moneyBg2)
         {
            _moneyBg2.visible = param1;
         }
         if(_LiJinBitmap)
         {
            _LiJinBitmap.visible = param1;
         }
         if(_MoneyBitmap)
         {
            _MoneyBitmap.visible = param1;
         }
         if(_orderTxtBitmap)
         {
            _orderTxtBitmap.visible = param1;
         }
      }
      
      public function enableBeadFunctionBtns(param1:Boolean) : void
      {
         if(_beadFeedBtn)
         {
            _beadFeedBtn.enable = param1;
         }
         if(_beadLockBtn)
         {
            _beadLockBtn.enable = param1;
         }
         if(_beadOneKeyBtn)
         {
            _beadOneKeyBtn.enable = param1;
         }
         if(_beadSortBtn)
         {
            _beadSortBtn.enable = param1;
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
      
      public function adjustBeadBagPage(param1:Boolean) : void
      {
         var _loc4_:int = 2147483647;
         var _loc6_:int = 0;
         var _loc5_:* = _info.BeadBag.items;
         for each(var _loc3_ in _info.BeadBag.items)
         {
            if(_loc3_.Place < _loc4_ && _loc3_.Place > 31 && (!param1 || !_loc3_.IsBinds))
            {
               _loc4_ = _loc3_.Place;
            }
         }
         var _loc2_:int = (_loc4_ - 32) / 49 + 1;
         if(_loc2_ <= 0 || _loc2_ > 3)
         {
            _loc2_ = 1;
         }
         if(_pageTxt)
         {
            _pageTxt.text = _loc2_ + "/3";
         }
         _beadList.visible = _loc2_ == 1;
         _beadList2.visible = _loc2_ == 2;
         _beadList3.visible = _loc2_ == 3;
         _currentBeadList = [_beadList,_beadList2,_beadList3][_loc2_ - 1];
      }
      
      public function __oneKeyFeedClick(param1:MouseEvent) : void
      {
         var _loc7_:int = 0;
         var _loc6_:Boolean = false;
         var _loc5_:int = 0;
         var _loc2_:Boolean = false;
         var _loc4_:int = 0;
         SoundManager.instance.play("008");
         if(BeadModel.beadCanUpgrade)
         {
            if(int(PlayerManager.Instance.Self.embedUpLevelCell.itemInfo.Hole1) == 21)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.mostHightLevel"));
               return;
            }
            _loc7_ = 0;
            _loc6_ = false;
            _feedID = 0;
            if(!_feedVec)
            {
               _feedVec = new Vector.<Vector.<BeadCell>>(8);
               _bindVec = new Vector.<Boolean>(8);
            }
            _loc5_ = 0;
            while(_loc5_ < 8)
            {
               if(!_feedVec[_loc5_])
               {
                  _feedVec[_loc5_] = new Vector.<BeadCell>();
                  _bindVec[_loc5_] = false;
               }
               else
               {
                  _feedVec[_loc5_].length = 0;
               }
               _loc5_++;
            }
            var _loc9_:int = 0;
            var _loc8_:* = _currentBeadList.BeadCells;
            for each(var _loc3_ in _currentBeadList.BeadCells)
            {
               if(_loc3_.info && !_loc3_.itemInfo.IsUsed)
               {
                  if(_loc3_.itemInfo.Hole1 < 13 && BeadTemplateManager.Instance.GetBeadInfobyID(_loc3_.itemInfo.TemplateID).Type3 <= 0)
                  {
                     _feedVec[0].push(_loc3_);
                     _loc7_ = _loc7_ + _loc3_.itemInfo.Hole2;
                     _loc3_.locked = true;
                     if(!_bindVec[0] && _loc3_.itemInfo.IsBinds)
                     {
                        _bindVec[0] = true;
                     }
                  }
                  else if(_loc3_.itemInfo.Hole1 == 13)
                  {
                     _feedVec[1].push(_loc3_);
                  }
                  else if(_loc3_.itemInfo.Hole1 == 14)
                  {
                     _feedVec[2].push(_loc3_);
                  }
                  else if(_loc3_.itemInfo.Hole1 == 15)
                  {
                     _feedVec[3].push(_loc3_);
                  }
                  else if(_loc3_.itemInfo.Hole1 == 16 || BeadTemplateManager.Instance.GetBeadInfobyID(_loc3_.itemInfo.TemplateID).Type3 > 0)
                  {
                     _feedVec[4].push(_loc3_);
                  }
                  else if(_loc3_.itemInfo.Hole1 == 17)
                  {
                     _feedVec[5].push(_loc3_);
                  }
                  else if(_loc3_.itemInfo.Hole1 == 18)
                  {
                     _feedVec[6].push(_loc3_);
                  }
                  else if(_loc3_.itemInfo.Hole1 == 19)
                  {
                     _feedVec[7].push(_loc3_);
                  }
                  else if(_loc3_.itemInfo.Hole1 == 20)
                  {
                     _feedVec[7].push(_loc3_);
                  }
                  else if(_loc3_.itemInfo.Hole1 == 21)
                  {
                     _feedVec[7].push(_loc3_);
                  }
               }
            }
            if(_loc7_ == 0)
            {
               _loc2_ = true;
               _loc4_ = 1;
               while(_loc4_ < 8)
               {
                  if(_feedVec[_loc4_].length > 0)
                  {
                     _loc2_ = false;
                     break;
                  }
                  _loc4_++;
               }
               if(_loc2_)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.noBeadToFeed"));
               }
               else
               {
                  _feedID = _loc4_;
                  checkBoxPrompts(_feedID);
               }
               return;
            }
            _allExp = _loc7_;
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
      
      private function checkBoxPrompts(param1:int) : void
      {
         var _loc3_:int = 0;
         _allExp = 0;
         _id = param1;
         var _loc2_:int = _feedVec[param1].length;
         if(_loc2_ > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _allExp = _allExp + _feedVec[param1][_loc3_].itemInfo.Hole2;
               _feedVec[param1][_loc3_].locked = true;
               if(!_bindVec[param1] && _feedVec[param1][_loc3_].itemInfo.IsBinds)
               {
                  _bindVec[param1] = true;
               }
               _loc3_++;
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
      
      private function __onCreateComplete(param1:CEvent) : void
      {
         var _loc2_:* = null;
         beadSystemManager.Instance.removeEventListener("createComplete",__onCreateComplete);
         if(param1.data.type == "infoframe")
         {
            _loc2_ = param1.data.spr;
            _loc2_["setBeadName"](_feedVec[_id][0].tipData["beadName"]);
            LayerManager.Instance.addToLayer(_loc2_,1,true,1);
            _loc2_["textInput"].setFocus();
            _loc2_["isBind"] = _bindVec[_id];
            _loc2_.addEventListener("response",__onConfigResponse);
         }
      }
      
      private function boxPrompts(param1:Boolean) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1 && !BeadModel.isBeadCellIsBind)
         {
            _loc4_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.useBindBead"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            _loc4_.addEventListener("response",__onBindRespones);
         }
         else
         {
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.FeedBeadConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("beadSystem.feedBeadShowExpTextOneFeed");
            _loc2_.htmlText = LanguageMgr.GetTranslation("ddt.beadSystem.feedBeadGetExp",_allExp);
            _loc3_.addChild(_loc2_);
            _loc3_.addEventListener("response",__onFeedResponse);
         }
      }
      
      protected function __onConfigResponse(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         SoundManager.instance.playButtonSound();
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(_loc4_["textInput"].text == "YES" || _loc4_["textInput"].text == "yes")
               {
                  boxPrompts(_loc4_["isBind"]);
                  _loc4_.removeEventListener("response",__onConfigResponse);
                  ObjectUtils.disposeObject(_loc4_);
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.feedBeadPromptInfo"));
               }
         }
      }
      
      protected function __onBindRespones(param1:FrameEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _loc4_ = _feedVec[_feedID].length;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  _feedVec[_feedID][_loc5_].locked = false;
                  _loc5_++;
               }
               break;
            case 2:
            case 3:
            case 4:
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.FeedBeadConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("beadSystem.feedBeadShowExpTextOneFeed");
               _loc2_.htmlText = LanguageMgr.GetTranslation("ddt.beadSystem.feedBeadGetExp",_allExp);
               _loc3_.addChild(_loc2_);
               _loc3_.addEventListener("response",__onFeedResponse);
         }
         param1.currentTarget.removeEventListener("response",__onBindRespones);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      protected function __onFeedResponse(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _loc2_ = _feedVec[_feedID].length;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _feedVec[_feedID][_loc3_].locked = false;
                  _loc3_++;
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
         param1.currentTarget.removeEventListener("response",__onFeedResponse);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function __disposeOneKeyMC(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc3_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = _feedVec[_feedID];
         for each(var _loc2_ in _feedVec[_feedID])
         {
            if(_loc2_.info && !_loc2_.itemInfo.IsUsed)
            {
               _loc3_.push(_loc2_.beadPlace);
            }
         }
         SocketManager.Instance.out.sendBeadUpgrade(_loc3_);
         var _loc4_:int = _feedVec[_feedID].length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _feedVec[_feedID][_loc5_].locked = false;
            _loc5_++;
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
      
      private function __showBead(param1:BagEvent) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.beadToBeadBag"));
      }
      
      public function createCard() : void
      {
         CardManager.Instance.addEventListener("bagBagViewComplete",__cardBagViewComplete);
         CardManager.Instance.showView(1);
      }
      
      protected function __cardBagViewComplete(param1:CardSystemEvent) : void
      {
         if(_bagList == null)
         {
            _bagList = param1.info;
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
      
      private function __upData(param1:DictionaryEvent) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:CardInfo = param1.data as CardInfo;
         var _loc3_:int = _loc6_.Place % 4 == 0?_loc6_.Place / 4 - 2:Number(_loc6_.Place / 4 - 1);
         var _loc2_:int = _loc6_.Place % 4 == 0?4:Number(_loc6_.Place % 4);
         if(_bagList.vectorListModel.elements[_loc3_] == null)
         {
            _loc4_ = [];
            _loc4_[0] = _loc3_ + 1;
            _loc4_[_loc2_] = _loc6_;
            _bagList.vectorListModel.append(_loc4_);
         }
         else
         {
            _loc5_ = _bagList.vectorListModel.elements[_loc3_] as Array;
            _loc5_[_loc2_] = _loc6_;
            _bagList.vectorListModel.replaceAt(_loc3_,_loc5_);
         }
      }
      
      private function __remove(param1:DictionaryEvent) : void
      {
         var _loc5_:CardInfo = param1.data as CardInfo;
         var _loc3_:int = _loc5_.Place % 4 == 0?_loc5_.Place / 4 - 2:Number(_loc5_.Place / 4 - 1);
         var _loc2_:int = _loc5_.Place % 4 == 0?4:Number(_loc5_.Place % 4);
         var _loc4_:Array = _bagList.vectorListModel.elements[_loc3_] as Array;
         _loc4_[_loc2_] = null;
         _bagList.vectorListModel.replaceAt(_loc3_,_loc4_);
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
      
      protected function bagLockHandler(param1:MouseEvent) : void
      {
         __openSettingLock(null);
      }
      
      protected function __bagArrangeOut(param1:MouseEvent) : void
      {
         if(_bagType == 21)
         {
            return;
         }
         if(_bagArrangeSprite && _bagArrangeSprite.parent && !containPoint(param1.localX,param1.localY))
         {
            removeChild(_bagArrangeSprite);
         }
      }
      
      private function containPoint(param1:int, param2:int) : Boolean
      {
         if(param1 > 0 && param1 < _bagArrangeSprite.width && param2 <= 3 && param2 > -_bagArrangeSprite.height)
         {
            return true;
         }
         return false;
      }
      
      private function __onAutoOpenBeadChanged(param1:BeadEvent) : void
      {
         if(!_beadOneKeyBtn || !_beadLockBtn || !_beadFeedBtn)
         {
            return;
         }
         if(param1.CellId == 0)
         {
            _beadOneKeyBtn.enable = true;
            _beadLockBtn.enable = true;
            _beadFeedBtn.enable = true;
         }
         else if(param1.CellId == 1)
         {
            _beadOneKeyBtn.enable = false;
            _beadLockBtn.enable = false;
            _beadFeedBtn.enable = false;
         }
      }
      
      private function isInBag(param1:InventoryItemInfo, param2:BeadBagList) : Boolean
      {
         if(param1.Place >= param2._startIndex && param1.Place <= param2._stopIndex)
         {
            return true;
         }
         return false;
      }
      
      protected function __onBeadBagChanged(param1:DictionaryEvent) : void
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         if(_bagType != 21)
         {
            return;
         }
         var _loc2_:Array = [_beadList,_beadList2,_beadList3];
         var _loc5_:int = 1;
         var _loc3_:InventoryItemInfo = InventoryItemInfo(param1.data);
         if(_loc3_.Place < 32)
         {
            return;
         }
         if(_info.BeadBag.getItemAt(_loc3_.Place))
         {
            _loc4_ = 1;
            _loc6_ = 0;
            while(_loc6_ < _loc2_.length)
            {
               if(isInBag(_loc3_,_loc2_[_loc6_]))
               {
                  _loc4_ = _loc6_ + 1;
                  break;
               }
               _loc6_++;
            }
            _loc5_ = _loc4_ > _loc5_?_loc4_:int(_loc5_);
         }
         if(_loc5_ > 3 || _loc5_ < 1)
         {
            _loc5_ = 1;
         }
         if(_currIndex == _loc5_)
         {
            return;
         }
         _currIndex = _loc5_;
         _beadList.visible = _loc5_ == 1;
         _beadList2.visible = _loc5_ == 2;
         _beadList3.visible = _loc5_ == 3;
         _pageTxt.text = _loc5_ + "/3";
         _currentBeadList = _loc2_[_loc5_ - 1];
      }
      
      private function __pgupHandler(param1:MouseEvent) : void
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
      
      private function setCurrPage(param1:int) : void
      {
      }
      
      public function __pgdnHandler(param1:MouseEvent) : void
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
      
      protected function __useColorShell(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc3_.readBoolean();
         if(_loc2_)
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
      
      protected function __itemtabBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = param1.currentTarget;
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
      
      public function enableOrdisableSB(param1:Boolean) : void
      {
         if(_equipSelectedBtn)
         {
            _equipSelectedBtn.enable = param1;
         }
         if(_propSelectedBtn)
         {
            _propSelectedBtn.enable = param1;
         }
         if(_dressSelectedBtn)
         {
            _dressSelectedBtn.enable = param1;
         }
         if(_tabBtn1)
         {
            _tabBtn1.visible = param1;
         }
         if(_tabBtn2)
         {
            _tabBtn2.visible = param1;
         }
         if(_tabBtn4)
         {
            _tabBtn4.visible = param1;
         }
      }
      
      public function showDressSelectedBtnOnly(param1:Boolean) : void
      {
         if(_equipSelectedBtn)
         {
            _equipSelectedBtn.enable = !param1;
         }
         if(_propSelectedBtn)
         {
            _propSelectedBtn.enable = !param1;
         }
         if(_dressSelectedBtn)
         {
            _dressSelectedBtn.enable = param1;
         }
         if(_tabBtn1)
         {
            _tabBtn1.visible = !param1;
         }
         if(_tabBtn2)
         {
            _tabBtn2.visible = !param1;
         }
         if(_tabBtn4)
         {
            _tabBtn4.visible = param1;
         }
      }
      
      public function enableDressSelectedBtn(param1:Boolean) : void
      {
         if(_dressSelectedBtn)
         {
            _dressSelectedBtn.enable = param1;
         }
         if(_tabBtn4)
         {
            _tabBtn4.visible = param1;
         }
      }
      
      public function showOrHideSB(param1:Boolean) : void
      {
         if(_equipSelectedBtn)
         {
            _equipSelectedBtn.visible = param1;
         }
         if(_propSelectedBtn)
         {
            _propSelectedBtn.visible = param1;
         }
         if(_dressSelectedBtn)
         {
            _dressSelectedBtn.visible = param1;
         }
      }
      
      protected function refreshSelectedButton(param1:int) : void
      {
         if(_equipSelectedBtn)
         {
            _equipSelectedBtn.selected = param1 == 1;
         }
         if(_propSelectedBtn)
         {
            _propSelectedBtn.selected = param1 == 2;
         }
         if(_beadSelectedBtn)
         {
            _beadSelectedBtn.selected = param1 == 3;
         }
         if(_dressSelectedBtn)
         {
            _dressSelectedBtn.selected = param1 == 4;
         }
      }
      
      public function setBagType(param1:int) : void
      {
         var _loc2_:* = null;
         if(param1 != 21)
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
         _bagType = param1;
         if(param1 == 5)
         {
            refreshSelectedButton(2);
         }
         if(param1 == 0)
         {
            refreshSelectedButton(1);
         }
         else if(param1 == 1)
         {
            refreshSelectedButton(2);
         }
         else if(param1 == 2)
         {
            param1 = 0;
            refreshSelectedButton(1);
         }
         else if(param1 == 21)
         {
            refreshSelectedButton(3);
            switchButtomVisible(false);
         }
         else if(param1 == 8)
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
         var _loc3_:* = _bagType != 2;
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
            _loc2_ = getQualifiedClassName(this);
            if(bagLockBtn && _loc2_ != "email.view::EmailBagView")
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
      
      protected function showDressBagView(param1:PlayerDressEvent) : void
      {
         if(!_dressbagView)
         {
            _dressbagView = param1.info;
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
      
      public function isNeedCard(param1:Boolean) : void
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
      
      private function __onBagUpdateEQUIPBAG(param1:BagEvent) : void
      {
         if(!(_dressbagView && _dressbagView.visible == true))
         {
            setBagCountShow(0);
         }
      }
      
      protected function __onBagUpdatePROPBAG(param1:BagEvent) : void
      {
         if(this.bagType != 21 && !_isScreenFood && this.bagType != 2)
         {
            setBagCountShow(1);
         }
      }
      
      private function __openSettingLock(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         BaglockedManager.Instance.onShow();
         SharedManager.Instance.setBagLocked = true;
         SharedManager.Instance.save();
      }
      
      protected function __bagArrangeOver(param1:MouseEvent) : void
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
      
      protected function __sortBagClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(_bagType != 21)
         {
            if(_isScreenFood && _bagType == 0)
            {
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  return;
               }
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("petBag.sortTips"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
               _loc2_.addEventListener("response",__onSortBagResponse);
               return;
            }
            if(_bagArrangeSprite)
            {
               PlayerManager.Instance.Self.PropBag.sortBag(_bagType,PlayerManager.Instance.Self.getBag(_bagType),0,48,_bagArrangeSprite.arrangeAdd);
            }
         }
         else
         {
            PlayerManager.Instance.Self.PropBag.sortBag(_bagType,PlayerManager.Instance.Self.getBag(_bagType),32,178,true);
         }
      }
      
      protected function __onSortBagResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onSortBagResponse);
         _loc2_.dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            PlayerManager.Instance.Self.getBag(_bagType).foldPetEquips(_bagType,PlayerManager.Instance.Self.getBag(_bagType),0,48);
         }
      }
      
      private function __frameEvent(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc2_.removeEventListener("response",__frameEvent);
         _loc2_.dispose();
         switch(int(param1.responseCode))
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
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["BandMoney"] || param1.changedProperties["Money"] || param1.changedProperties["Gold"] || param1.changedProperties["Money"])
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
      
      protected function __listChange(param1:Event) : void
      {
         if(!(_dressbagView && _dressbagView.visible == true))
         {
            setBagType(0);
         }
      }
      
      private function __feedClick(param1:MouseEvent) : void
      {
         if(!(bead_state & 1))
         {
            bead_state = bead_state | 1;
            SoundManager.instance.play("008");
            _beadFeedBtn.dragStart(param1.stageX,param1.stageY);
            _beadFeedBtn.addEventListener("stopfeed",__stopFeed);
            dispatchEvent(new Event("sellstart"));
            stage.addEventListener("click",__onStageClick_FeedBtn);
            param1.stopImmediatePropagation();
         }
         else
         {
            bead_state = ~1 & bead_state;
            _beadFeedBtn.stopDrag();
         }
      }
      
      private function __stopFeed(param1:Event) : void
      {
         bead_state = ~1 & bead_state;
         _beadFeedBtn.removeEventListener("stopsell",__stopSell);
         dispatchEvent(new Event("stopfeed"));
         if(stage)
         {
            stage.removeEventListener("click",__onStageClick_FeedBtn);
         }
      }
      
      private function __onStageClick_FeedBtn(param1:Event) : void
      {
         bead_state = ~1 & bead_state;
         dispatchEvent(new Event("stopfeed"));
         if(stage)
         {
            stage.removeEventListener("click",__onStageClick_FeedBtn);
         }
      }
      
      private function __sellClick(param1:MouseEvent) : void
      {
         if(!(state & 1))
         {
            state = state | 1;
            SoundManager.instance.play("008");
            _sellBtn.dragStart(param1.stageX,param1.stageY);
            _sellBtn.addEventListener("stopsell",__stopSell);
            dispatchEvent(new Event("sellstart"));
            stage.addEventListener("click",__onStageClick_SellBtn);
            param1.stopImmediatePropagation();
         }
         else
         {
            state = ~1 & state;
            _sellBtn.stopDrag();
         }
      }
      
      private function __stopSell(param1:Event) : void
      {
         state = ~1 & state;
         _sellBtn.removeEventListener("stopsell",__stopSell);
         dispatchEvent(new Event("sellstop"));
         if(stage)
         {
            stage.removeEventListener("click",__onStageClick_SellBtn);
         }
      }
      
      private function __onStageClick_SellBtn(param1:Event) : void
      {
         state = ~1 & state;
         dispatchEvent(new Event("sellstop"));
         if(stage)
         {
            stage.removeEventListener("click",__onStageClick_SellBtn);
         }
      }
      
      private function __breakClick(param1:MouseEvent) : void
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
               _breakBtn.dragStart(param1.stageX,param1.stageY);
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
      
      private function isOnlyGivingGoods(param1:InventoryItemInfo) : Boolean
      {
         return param1.IsBinds == false && EquipType.isPackage(param1) && param1.Property2 == "10";
      }
      
      protected function __cellClick(param1:CellEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(_sellBtn && !_sellBtn.isActive)
         {
            param1.stopImmediatePropagation();
            if(param1.data is BagCell)
            {
               _loc2_ = param1.data as BagCell;
            }
            else
            {
               _loc2_ = param1.data as BeadCell;
            }
            if(_loc2_)
            {
               _loc4_ = _loc2_.itemInfo as InventoryItemInfo;
            }
            if(_loc4_ == null)
            {
               return;
            }
            if(!_loc2_.locked)
            {
               SoundManager.instance.play("008");
               if(!isOnlyGivingGoods(_loc4_) && (_loc4_.getRemainDate() <= 0 && !EquipType.isProp(_loc4_) || EquipType.isPackage(_loc4_) || _loc4_.getRemainDate() <= 0 && _loc4_.TemplateID == 10200 || _loc4_.TemplateID == 11955 || _loc4_.TemplateID == 11963 || EquipType.canBeUsed(_loc4_) || DressUtils.isDress(_loc4_) || EquipType.isGetPackage(_loc4_) || EquipType.isFireworks(_loc4_) || _loc4_.CategoryID == 68 || _loc4_.CategoryID == 43 || _loc4_.CategoryID == 73))
               {
                  _loc3_ = _loc2_.parent.localToGlobal(new Point(_loc2_.x,_loc2_.y));
                  CellMenu.instance.show(_loc2_,_loc3_.x + 20,_loc3_.y + 20);
               }
               else
               {
                  _loc2_.dragStart();
               }
            }
         }
      }
      
      public function set cellDoubleClickEnable(param1:Boolean) : void
      {
         if(param1)
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
      
      protected function __cellDoubleClick(param1:CellEvent) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         param1.stopImmediatePropagation();
         var _loc4_:BagCell = param1.data as BagCell;
         var _loc7_:InventoryItemInfo = _loc4_.info as InventoryItemInfo;
         if(BagAndInfoManager.Instance.getBagAndGiftFrame() && BagAndInfoManager.Instance.getBagAndGiftFrame().infoFrame.currentType == 3)
         {
            if(_loc7_.CategoryID == TexpManager.Instance.texpType)
            {
               SocketManager.Instance.out.sendClearStoreBag();
               SocketManager.Instance.out.sendMoveGoods(_loc7_.BagType,_loc7_.Place,12,0,_loc7_.Count,true);
               return;
            }
            if(_loc7_.CategoryID == 53)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TextCell.texpTips"));
               return;
            }
            if(_loc7_.CategoryID == 20)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TextCell.magicTexpTips"));
               return;
            }
         }
         var _loc6_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_loc7_.TemplateID);
         var _loc2_:int = !!PlayerManager.Instance.Self.Sex?1:2;
         if(_loc7_.getRemainDate() <= 0)
         {
            return;
         }
         if(_loc6_.NeedSex != _loc2_ && _loc6_.NeedSex != 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.data.player.SelfInfo.object"));
            return;
         }
         if(!_loc4_.locked)
         {
            if(int(_loc4_.info.Property1) != 1100 && (_loc4_.info.BindType == 1 || _loc4_.info.BindType == 2 || _loc4_.info.BindType == 3) && _loc4_.itemInfo.IsBinds == false)
            {
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.BindsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
               _loc3_.addEventListener("response",__onResponse);
               temInfo = _loc7_;
            }
            else
            {
               SoundManager.instance.play("008");
               if(_loc7_.BagType == 1)
               {
                  if(param1.target is PetBagListView && _loc7_.CategoryID == 34)
                  {
                     PetsBagManager.instance().dispatchEvent(new UpdatePetInfoEvent("showPetFood",_loc7_));
                  }
                  else
                  {
                     CellMenu.instance.cell = _loc4_;
                     __cellUse(param1);
                  }
               }
               else if(PlayerManager.Instance.Self.canEquip(_loc7_))
               {
                  if(_loc7_.CategoryID == 50 || _loc7_.CategoryID == 51 || _loc7_.CategoryID == 52)
                  {
                     if(PetsBagManager.instance().view && PetsBagManager.instance().view.parent)
                     {
                        if(!PetsBagManager.instance().petModel.currentPetInfo)
                        {
                           MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.petEquipNo"));
                           return;
                        }
                        SocketManager.Instance.out.addPetEquip(_loc4_.place,PetsBagManager.instance().petModel.currentPetInfo.Place,0);
                     }
                     return;
                  }
                  if(EquipType.isArmShell(_loc7_))
                  {
                     return;
                  }
                  _loc5_ = PlayerManager.Instance.getDressEquipPlace(_loc7_);
                  SocketManager.Instance.out.sendMoveGoods(0,_loc7_.Place,0,_loc5_,_loc7_.Count);
               }
            }
         }
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onResponse);
         _loc2_.dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            sendDefy();
         }
      }
      
      private function sendDefy() : void
      {
         var _loc1_:int = 0;
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
            _loc1_ = PlayerManager.Instance.getDressEquipPlace(temInfo);
            SocketManager.Instance.out.sendMoveGoods(0,temInfo.Place,0,_loc1_,temInfo.Count);
         }
      }
      
      private function __cellAddPrice(param1:Event) : void
      {
         var _loc2_:BagCell = CellMenu.instance.cell;
         if(_loc2_)
         {
            if(ShopManager.Instance.canAddPrice(_loc2_.itemInfo.TemplateID))
            {
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  return;
               }
               AddPricePanel.Instance.setInfo(_loc2_.itemInfo,false);
               AddPricePanel.Instance.show();
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.cantAddPrice"));
            }
         }
      }
      
      protected function __cellMove(param1:Event) : void
      {
         var _loc2_:BagCell = CellMenu.instance.cell;
         if(_loc2_)
         {
            _loc2_.dragStart();
         }
      }
      
      protected function __cellOpenBatch(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:BagCell = CellMenu.instance.cell as BagCell;
         if(_loc3_ != null && _loc3_.itemInfo != null)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("bag.OpenBatchView");
            _loc2_.item = _loc3_.itemInfo;
            LayerManager.Instance.addToLayer(_loc2_,3,true,1);
         }
      }
      
      protected function __cellOpen(param1:Event) : void
      {
         var _loc9_:Number = NaN;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:BagCell = CellMenu.instance.cell as BagCell;
         _currentCell = _loc4_;
         if(_loc4_ != null && _loc4_.itemInfo != null)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            BagAndInfoManager.Instance.isUpgradePack = _loc4_.itemInfo.Property1 == "6" && _loc4_.itemInfo.Property2 == "9" && _loc4_.itemInfo.Property3 == "0";
            _loc9_ = !!PlayerManager.Instance.Self.Sex?1:2;
            if(_loc4_.info.NeedSex != 0 && _loc9_ != _loc4_.info.NeedSex)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.sexErr"));
               return;
            }
            if(PlayerManager.Instance.Self.Grade >= _loc4_.info.NeedLevel)
            {
               if(_loc4_.info.TemplateID == 112109)
               {
                  if(PlayerManager.Instance.Self.IsVIP)
                  {
                     RouletteManager.instance.useVipBox(_loc4_);
                  }
                  else
                  {
                     param1.stopImmediatePropagation();
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.vip.vipIcon.notVip"));
                  }
               }
               else if(_loc4_.info.TemplateID == 112019)
               {
                  RouletteManager.instance.useRouletteBox(_loc4_);
               }
               else if(EquipType.isCaddy(_loc4_.info))
               {
                  param1.stopImmediatePropagation();
                  RouletteManager.instance.useCaddy(_loc4_);
               }
               else if(_loc4_.info.TemplateID == 112222 || _loc4_.info.TemplateID == 112223 || _loc4_.info.TemplateID == 112224)
               {
                  param1.stopImmediatePropagation();
                  RouletteManager.instance.useBless(_loc4_);
               }
               else if(EquipType.isBeadNeedOpen(_loc4_.info))
               {
                  param1.stopImmediatePropagation();
                  RouletteManager.instance.useBead(_loc4_.info.TemplateID);
               }
               else if(_loc4_.info.TemplateID == 112255)
               {
                  param1.stopImmediatePropagation();
                  RouletteManager.instance.useCelebrationBox();
               }
               else if(_loc4_.info.TemplateID == 112262 && !_loc4_.itemInfo.IsBinds)
               {
                  param1.stopImmediatePropagation();
                  WonderfulActivityManager.Instance.useBattleCompanion(_loc4_.itemInfo);
               }
               else if(EquipType.isOfferPackage(_loc4_.info))
               {
                  param1.stopImmediatePropagation();
                  RouletteManager.instance.useOfferPack(_loc4_);
               }
               else if(EquipType.isTimeBox(_loc4_.info))
               {
                  _loc6_ = DateUtils.getDateByStr(InventoryItemInfo(_loc4_.info).BeginDate);
                  _loc5_ = int(_loc4_.info.Property3) * 60 - (TimeManager.Instance.Now().getTime() - _loc6_.getTime()) / 1000;
                  if(_loc5_ <= 0)
                  {
                     SocketManager.Instance.out.sendItemOpenUp(_loc4_.itemInfo.BagType,_loc4_["place"]);
                  }
                  else
                  {
                     _loc8_ = _loc5_ / 3600;
                     _loc7_ = _loc5_ % 3600 / 60;
                     _loc7_ = _loc7_ > 0?_loc7_:1;
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.userGuild.boxTip",_loc8_,_loc7_));
                  }
               }
               else if(_loc4_.info.CategoryID == 18)
               {
                  param1.stopImmediatePropagation();
                  SocketManager.Instance.out.sendOpenCardBox(_loc4_["place"],1,_loc4_.bagType);
               }
               else if(_loc4_.info.CategoryID == 66)
               {
                  param1.stopImmediatePropagation();
                  SocketManager.Instance.out.sendOpenSpecialCardBox(_loc4_["place"],1,_loc4_.bagType);
               }
               else if(_loc4_.info.TemplateID == 112108 || _loc4_.info.TemplateID == 112150 || _loc4_.info.TemplateID == 1120538 || _loc4_.info.TemplateID == 1120539)
               {
                  SocketManager.Instance.out.sendOpenRandomBox(_loc4_["place"],1);
               }
               else if(_loc4_.info.TemplateID == 11961 || _loc4_.info.TemplateID == 11965 || _loc4_.info.TemplateID == 11967)
               {
                  SocketManager.Instance.out.sendOpenNationWord(_loc4_.bagType,_loc4_.place,1);
               }
               else if(EquipType.isSpecilPackage(_loc4_.info))
               {
                  if(PlayerManager.Instance.Self.DDTMoney >= Number(_loc4_.info.Property3))
                  {
                     _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.AskGiftBag",_loc4_.info.Property3,_loc4_.info.Name),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
                     _loc3_.addEventListener("response",__GiftBagframeClose);
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.AskGiftBagII",_loc4_.info.Property3));
                  }
               }
               else if(35 == _loc4_.info.CategoryID)
               {
                  SocketManager.Instance.out.sendAddPet(_loc4_.itemInfo.Place,_loc4_.itemInfo.BagType);
               }
               else if(_loc4_.info.Property2 == "8")
               {
                  _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("bagView.consumePack.openTxt",_loc4_.info.Property3),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false);
                  _loc2_.addEventListener("response",onConsumePackResponse);
               }
               else if(_loc4_.itemInfo.CategoryID == 222222222)
               {
                  ItemActivityGiftManager.instance.showFrame(1,_loc4_.itemInfo);
               }
               else if(_loc4_.info.TemplateID == 1120412 || _loc4_.info.TemplateID == 1120413 || _loc4_.info.TemplateID == 1120414 || _loc4_.info.TemplateID == 1120433 || _loc4_.info.TemplateID == 1120434 || _loc4_.info.TemplateID == 12545)
               {
                  SocketManager.Instance.out.sendChangeSex(_loc4_.bagType,_loc4_.place);
               }
               else if(_loc4_.info.CategoryID == 72)
               {
                  SocketManager.Instance.out.sendItemOpenUp(_loc4_.itemInfo.BagType,_loc4_.itemInfo.Place);
               }
               else if(EquipType.isGetPackage(_loc4_.info))
               {
                  showGetFriendPackFrame(_loc4_.info,_loc4_.itemInfo.BagType,_loc4_.itemInfo.Place);
               }
               else if(EquipType.isFireworks(_loc4_.info))
               {
                  SocketManager.Instance.out.sendUseCard(_loc4_.itemInfo.BagType,_loc4_.itemInfo.Place,[_loc4_.info.TemplateID],_loc4_.info.PayType);
               }
               else if(_loc4_.info.CategoryID == 68)
               {
                  SocketManager.Instance.out.sendOpenAmuletBox(_loc4_.itemInfo.BagType,_loc4_.itemInfo.Place);
               }
               else if(_loc4_.info.CategoryID == 43)
               {
                  SocketManager.Instance.out.sendRoomBordenItemUp(_loc4_.place);
               }
               else
               {
                  SocketManager.Instance.out.sendItemOpenUp(_loc4_.itemInfo.BagType,_loc4_.itemInfo.Place);
               }
            }
            else if(_loc4_.info.CategoryID == 18)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cardSystem.bagView.openCardBox.level"));
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.level"));
            }
         }
      }
      
      private function showGetFriendPackFrame(param1:ItemTemplateInfo, param2:int, param3:int) : void
      {
         var _loc4_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(int(param1.Property8));
         if(_getFriendPackFrame)
         {
            _getFriendPackFrame.dispose();
            _getFriendPackFrame = null;
         }
         _getFriendPackFrame = ComponentFactory.Instance.creatComponentByStylename("bag.getFriendPackFrame");
         _getFriendPackFrame.updateView(_loc4_,param2,param3);
         _getFriendPackFrame.show();
      }
      
      protected function onConsumePackResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",onConsumePackResponse);
         if(param1.responseCode == 0 || param1.responseCode == 4 || param1.responseCode == 1)
         {
            _loc2_.dispose();
            return;
         }
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            if(_loc2_.isBand)
            {
               if(PlayerManager.Instance.Self.BandMoney < int(_currentCell.info.Property3))
               {
                  initAlertFarme();
               }
               else
               {
                  SocketManager.Instance.out.sendItemOpenUp(_currentCell.itemInfo.BagType,_currentCell.itemInfo.Place,1,_loc2_.isBand);
               }
            }
            else if(PlayerManager.Instance.Self.Money < int(_currentCell.info.Property3))
            {
               LeavePageManager.showFillFrame();
            }
            else
            {
               SocketManager.Instance.out.sendItemOpenUp(_currentCell.itemInfo.BagType,_currentCell.itemInfo.Place,1,_loc2_.isBand);
            }
         }
         _loc2_.dispose();
      }
      
      private function initAlertFarme() : void
      {
         var _loc1_:* = null;
         _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("buried.alertInfo.noBindMoney"),"",LanguageMgr.GetTranslation("cancel"),true,false,false,2);
         _loc1_.addEventListener("response",onResponseHander);
      }
      
      protected function onResponseHander(param1:FrameEvent) : void
      {
         if(param1.responseCode == 2 || param1.responseCode == 3)
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
         param1.currentTarget.dispose();
      }
      
      private function __GiftBagframeClose(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(_currentCell && _currentCell.itemInfo)
               {
                  SocketManager.Instance.out.sendItemOpenUp(_currentCell.itemInfo.BagType,_currentCell["place"]);
                  break;
               }
         }
         param1.currentTarget.removeEventListener("response",__GiftBagframeClose);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function __cellUse(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         param1.stopImmediatePropagation();
         var _loc4_:BagCell = CellMenu.instance.cell as BagCell;
         if(_loc4_.info.CategoryID == 73)
         {
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(!_loc4_ || _loc4_.info == null)
         {
            return;
         }
         if(_loc4_.info.TemplateID == 11560 || _loc4_.info.TemplateID == 11561 || _loc4_.info.TemplateID == 11562)
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
         if(_loc4_.info.TemplateID == 11961 || _loc4_.info.TemplateID == 11965 || _loc4_.info.TemplateID == 11967)
         {
            SocketManager.Instance.out.sendOpenNationWord(_loc4_.bagType,_loc4_.place,1);
            return;
         }
         if(_loc4_.info.TemplateID == 11994)
         {
            startReworkName(_loc4_.bagType,_loc4_.place);
            return;
         }
         if(_loc4_.info.CategoryID == 11 && _loc4_.info.Property1 == "5" && _loc4_.info.Property2 != "0")
         {
            showChatBugleInputFrame(_loc4_.info.TemplateID);
            return;
         }
         if(_loc4_.info.CategoryID == 23)
         {
            if(PlayerManager.Instance.Self.Grade < 13)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpCell.noGrade",13));
               return;
            }
            if(TexpManager.Instance.getLv(TexpManager.Instance.getExp(int(_loc4_.info.Property1))) >= PlayerManager.Instance.Self.Grade + 5)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpCell.lvToplimit"));
               return;
            }
            if(TaskManager.instance.texpQuests.length > 0)
            {
               _tmpCell = _loc4_;
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("texpSystem.view.TexpView.refreshTaskTip"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
               _loc3_.addEventListener("response",__texpResponse);
               return;
            }
            SocketManager.Instance.out.sendTexp(-1,_loc4_.info.TemplateID,1,_loc4_.place);
            return;
         }
         if(_loc4_.info.TemplateID == 11993)
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
            startupConsortiaReworkName(_loc4_.bagType,_loc4_.place);
            return;
         }
         if(_loc4_.info.TemplateID == 12604)
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
            startupBattleTeamReworkName(_loc4_.bagType,_loc4_.place);
            return;
         }
         if(_loc4_.info.TemplateID == 11569)
         {
            startupChangeSex(_loc4_.bagType,_loc4_.place);
            return;
         }
         if(_loc4_.info.CategoryID == 11 && int(_loc4_.info.Property1) == 37)
         {
            if(PlayerManager.Instance.Self.Bag.getItemAt(6))
            {
               if(PlayerManager.Instance.Self.Bag.getItemAt(6).StrengthenLevel >= 10)
               {
                  SocketManager.Instance.out.sendUseChangeColorShell(_loc4_.bagType,_loc4_.place);
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
         else if(_loc4_.info.CategoryID == 18)
         {
            SocketManager.Instance.out.sendOpenCardBox(_loc4_.place,1,_loc4_.bagType);
         }
         else if(_loc4_.info.CategoryID == 66)
         {
            SocketManager.Instance.out.sendOpenSpecialCardBox(_loc4_.place,1,_loc4_.bagType);
         }
         if(_loc4_.info.TemplateID == 12511)
         {
            CalendarManager.getInstance().open(1);
         }
         else if(_loc4_.info.TemplateID == 11999)
         {
            ChangeColorManager.instance.changeColorModel.place = _loc4_.place;
            ChangeColorManager.instance.changeColorModel.getColorEditableThings();
            ChangeColorManager.instance.show();
         }
         else if(_loc4_.info.TemplateID != 34101)
         {
            if(_loc4_.info.CategoryID == 11 && int(_loc4_.info.Property1) == 24)
            {
               if(TrusteeshipManager.instance.spiritValue >= TrusteeshipManager.instance.maxSpiritValue)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.trusteeship.maxSpiritCannotUseTxt"));
                  return;
               }
               SocketManager.Instance.out.sendTrusteeshipUseSpiritItem(_loc4_.place,_loc4_.bagType);
            }
            else if(_loc4_.info.CategoryID == 11 && int(_loc4_.info.Property1) == 39)
            {
               SocketManager.Instance.out.sendUseItemKingBless(_loc4_.place,_loc4_.bagType);
            }
            else if(_loc4_.info.CategoryID == 11 && int(_loc4_.info.Property1) == 39 && int(_loc4_.info.Property2) == 10)
            {
               SocketManager.Instance.out.sendUseItemDeed(_loc4_.place,_loc4_.bagType);
            }
            else if(_loc4_.info.CategoryID == 11 && int(_loc4_.info.Property1) == 101)
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
               BagStore.instance.openStore("forge_store",0);
            }
            else if(EquipType.isStrengthStone(_loc4_.info))
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
            else if(_loc4_.info.CategoryID == 11 && int(_loc4_.info.Property1) == 45)
            {
               if(PlayerManager.Instance.Self.Grade < 25)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.godTemple.openGodTempleBtn.text",25.toString()));
                  return;
               }
               _loc2_ = getQualifiedClassName(this);
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
            else if(_loc4_.info.CategoryID == 11 && int(_loc4_.info.Property1) == 82)
            {
               if((_loc4_.info as InventoryItemInfo).ValidDate == 0)
               {
                  if(_self.horsePicCherishDic.hasKey(_loc4_.info.Property2) && _self.horsePicCherishDic[_loc4_.info.Property2].isUsed)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.pic.alreadyActive"));
                     return;
                  }
                  HorseManager.instance.skipHorsePicCherishId = int(_loc4_.info.Property2);
                  HorseManager.instance.isSkipFromBagView = true;
                  HorseManager.instance.show();
               }
               else
               {
                  SocketManager.Instance.out.sendActiveHorsePicCherish((_loc4_.info as InventoryItemInfo).Place);
               }
            }
            else if(_loc4_.info.CategoryID == 62 && _loc4_.info.Property1 == "1")
            {
               if((_loc4_.info as InventoryItemInfo).ValidDate == 0)
               {
                  PetsAdvancedManager.Instance.showFrame(2,true);
               }
               else
               {
                  SocketManager.Instance.out.sendUsePetTemporaryCard((_loc4_.info as InventoryItemInfo).BagType,(_loc4_.info as InventoryItemInfo).Place);
               }
            }
            else if(_loc4_.info.CategoryID == 11 && _loc4_.info.Property1 == "47")
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
            else if(_loc4_.info.CategoryID == 11 && (int(_loc4_.info.Property1) == 27 || int(_loc4_.info.Property1) == 29 || int(_loc4_.info.Property1) == 107))
            {
               if(_self.Grade < 19)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.openTxt",19));
                  return;
               }
               PetsBagManager.instance().show();
            }
            else if(!(_loc4_.info.CategoryID == 11 && int(_loc4_.info.Property1) == 47))
            {
               if(_loc4_.info.CategoryID == 62 && int(_loc4_.info.Property1) == 0)
               {
                  if(_self.Grade < 25)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.openTxt",25));
                     return;
                  }
                  PetsBagManager.instance().show();
               }
               else if(24 == _loc4_.info.CategoryID)
               {
                  SocketManager.Instance.out.sendNewTitleCard(_loc4_.itemInfo.Place,_loc4_.itemInfo.BagType);
               }
               else if(EquipType.isComposeStone(_loc4_.info))
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
               else if(_loc4_.info.TemplateID == 100100)
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
               else if(_loc4_.info.TemplateID == 11164 || _loc4_.info.TemplateID == 11165)
               {
                  HorseManager.instance.show();
               }
               else if(_loc4_.info.TemplateID == 12568)
               {
                  VIPCouponsManager.instance.openShow(_loc4_.bagType,_loc4_.place);
               }
               else if(_loc4_.info.TemplateID == 12569)
               {
                  VIPCouponsManager.instance.useVipCoupons(_loc4_.bagType,_loc4_.place);
               }
               else if(_loc4_.info.CategoryID == 11 && int(_loc4_.info.Property1) == 104)
               {
                  if(PlayerManager.Instance.Self.Grade < 40)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.godTemple.openGodTempleBtn.text",40));
                     return;
                  }
                  BagStore.instance.openStore("forge_store",4);
               }
               else if(_loc4_.info.TemplateID == 11179)
               {
                  SocketManager.Instance.out.sendItemOpenUp(_loc4_.itemInfo.BagType,_loc4_["place"]);
               }
               else if(_loc4_.info.TemplateID == 12536 || _loc4_.info.TemplateID == 12537)
               {
                  if(PlayerManager.Instance.Self.IsMarried)
                  {
                     SocketManager.Instance.out.sendUseLoveFeelingly(_loc4_.itemInfo.BagType,_loc4_["place"]);
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtBagAndInfo.hasNoMerry.info"));
                  }
               }
               else if(_loc4_.info.TemplateID == 11966)
               {
                  RandomSuitCardManager.getInstance().useCard(_loc4_.itemInfo.Place);
               }
               else if(_loc4_.info.TemplateID == 12545)
               {
                  SocketManager.Instance.out.sendChangeSex(_loc4_.bagType,_loc4_.place);
               }
               else if(_loc4_.info.CategoryID == 68)
               {
                  SocketManager.Instance.out.sendOpenAmuletBox(_loc4_.itemInfo.BagType,_loc4_.itemInfo.Place);
               }
               else if((_loc4_.info.CategoryID == 20 || _loc4_.info.CategoryID == 53) && int(_loc4_.info.Property1) == 0)
               {
                  BagAndInfoManager.Instance.showBagAndInfo(2);
               }
               else if(_loc4_.info.CategoryID == 11 && int(_loc4_.info.Property1) == 108)
               {
                  BagAndInfoManager.Instance.showBagAndInfo(5);
               }
               else if(_loc4_.info.CategoryID == 11 && int(_loc4_.info.Property1) == 106)
               {
                  BagAndInfoManager.Instance.showBagAndInfo(9);
               }
               else if(_loc4_.info.CategoryID == 11 && (int(_loc4_.info.Property1) == 100 || int(_loc4_.info.Property1) == 1100 || int(_loc4_.info.Property1) == 115 || int(_loc4_.info.Property1) == 1200))
               {
                  useProp(_loc4_.itemInfo);
               }
               else if((_loc4_.info.CategoryID == 11 || _loc4_.info.CategoryID == 72) && int(_loc4_.info.Property1) == 6)
               {
                  __cellOpen(param1);
               }
               else
               {
                  useCard(_loc4_.itemInfo);
               }
            }
         }
      }
      
      protected function __onNecklacePtetrochemicalClose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 4)
         {
            SoundManager.instance.playButtonSound();
            _necklacePtetrochemicalView.removeEventListener("response",__onNecklacePtetrochemicalClose);
            ObjectUtils.disposeObject(_necklacePtetrochemicalView);
            _necklacePtetrochemicalView = null;
         }
      }
      
      private function isHomeBankBagView() : Boolean
      {
         var _loc1_:String = getQualifiedClassName(this);
         if(_loc1_ == "homeBank.view::HomeBankBagView")
         {
            return true;
         }
         return false;
      }
      
      protected function __cellColorChange(param1:Event) : void
      {
         var _loc2_:BagCell = CellMenu.instance.cell;
         if(_loc2_)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(_loc2_.itemInfo.CategoryID == 13 || _loc2_.itemInfo.CategoryID == 15)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.changeColor.suitAndWingCannotChange"));
               return;
            }
            if(checkDress(_loc2_))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("playerDress.canNotChangeColor"));
               return;
            }
            ChangeColorManager.instance.changeColorModel.place = -1;
            ChangeColorManager.instance.addOneThing(_loc2_);
            ChangeColorManager.instance.show();
         }
      }
      
      private function __alertChangeColor(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__alertChangeColor);
         SoundManager.instance.play("008");
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.Money < ShopManager.Instance.getGiftShopItemByTemplateID(11999).getItemPrice(1).bothMoneyValue)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.giftLack"));
               return;
            }
         }
      }
      
      protected function __cellSell(param1:Event) : void
      {
         var _loc2_:BagCell = CellMenu.instance.cell;
         if(_loc2_.info.CategoryID == 73)
         {
            return;
         }
         if(checkDress(_loc2_))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("playerDress.canNotSell"));
            return;
         }
         if(_loc2_)
         {
            _loc2_.sellItem(_loc2_.itemInfo);
         }
      }
      
      private function checkDress(param1:BagCell) : Boolean
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         if(!DressUtils.isDress(param1.itemInfo))
         {
            return false;
         }
         var _loc5_:Array = PlayerDressManager.instance.modelArr;
         var _loc9_:int = 0;
         var _loc8_:* = _loc5_;
         for each(var _loc3_ in _loc5_)
         {
            _loc7_ = 0;
            while(_loc7_ <= _loc3_.length - 1)
            {
               _loc6_ = _loc3_[_loc7_];
               if(_loc6_.itemId == param1.itemInfo.ItemID)
               {
                  return true;
               }
               _loc7_++;
            }
         }
         var _loc2_:DressModel = PlayerDressManager.instance.currentModel;
         if(_loc2_)
         {
            var _loc11_:int = 0;
            var _loc10_:* = _loc2_.model.Bag.items;
            for each(var _loc4_ in _loc2_.model.Bag.items)
            {
               if(_loc4_ && _loc4_.ItemID == param1.itemInfo.ItemID)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function __texpResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc2_.removeEventListener("response",__texpResponse);
         _loc2_.dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
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
      
      private function useCard(param1:InventoryItemInfo) : void
      {
         if(param1.TemplateID == 11995 || param1.TemplateID == 11998 || param1.TemplateID == 11997 || param1.TemplateID == 11996 || param1.TemplateID.toString().substring(0,3) == "119" || param1.TemplateID == 11992 || param1.TemplateID == 20150 || param1.TemplateID == 201145 || (param1.TemplateID == 12535 || param1.TemplateID == 1120435))
         {
            if(_self.Grade < 3 && (param1.TemplateID == 11992 || param1.CategoryID == 11 && param1.Property1 == "25"))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",3));
               return;
            }
            if(param1.TemplateID != 11916 && param1.TemplateID != 11957 && param1.TemplateID != 11968)
            {
               SocketManager.Instance.out.sendUseCard(param1.BagType,param1.Place,[param1.TemplateID],param1.PayType);
            }
         }
      }
      
      private function useProp(param1:InventoryItemInfo) : void
      {
         if(!param1)
         {
            return;
         }
         SocketManager.Instance.out.sendUseProp(param1.BagType,param1.Place,[param1.TemplateID],param1.PayType);
      }
      
      private function createBreakWin(param1:BagCell) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BreakGoodsView = ComponentFactory.Instance.creatComponentByStylename("breakGoodsView");
      }
      
      public function setCellInfo(param1:int, param2:InventoryItemInfo) : void
      {
         _currentList.setCellInfo(param1,param2);
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
      
      public function setBagCountShow(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:* = 0;
         switch(int(param1))
         {
            case 0:
               _loc3_ = PlayerManager.Instance.Self.getBag(param1).itemBgNumber(_equiplist._startIndex,_equiplist._stopIndex);
               if(_loc3_ >= 49)
               {
                  _loc2_ = uint(16711680);
                  _loc4_ = new GlowFilter(16777215,0.5,3,3,10);
               }
               else
               {
                  _loc2_ = uint(1310468);
                  _loc4_ = new GlowFilter(876032,0.5,3,3,10);
               }
               break;
            case 1:
               _loc3_ = PlayerManager.Instance.Self.getBag(param1).itemBgNumber(0,48);
               if(_loc3_ >= 48 + 1)
               {
                  _loc2_ = uint(16711680);
                  _loc4_ = new GlowFilter(16777215,0.5,3,3,10);
                  break;
               }
               _loc2_ = uint(1310468);
               _loc4_ = new GlowFilter(876032,0.5,3,3,10);
               break;
         }
         _goodsNumInfoText.textColor = _loc2_;
         _goodsNumInfoText.text = _loc3_.toString();
         setBagType(param1);
      }
      
      public function get info() : SelfInfo
      {
         return _info;
      }
      
      public function set info(param1:SelfInfo) : void
      {
         if(_info)
         {
            _info.removeEventListener("propertychange",__propertyChange);
            _info.getBag(0).removeEventListener("update",__onBagUpdateEQUIPBAG);
            _info.getBag(1).removeEventListener("update",__onBagUpdatePROPBAG);
            _info.BeadBag.items.removeEventListener("add",__onBeadBagChanged);
            PlayerManager.Instance.Self.removeEventListener("showBead",__showBead);
         }
         _info = param1;
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
      
      private function startReworkName(param1:int, param2:int) : void
      {
         _reworknameView = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.ReworkName.ReworkNameFrame");
         LayerManager.Instance.addToLayer(_reworknameView,3,true,1);
         _reworknameView.initialize(param1,param2);
         _reworknameView.addEventListener("complete",__onRenameComplete);
      }
      
      private function shutdownReworkName() : void
      {
         _reworknameView.removeEventListener("complete",__onRenameComplete);
         ObjectUtils.disposeObject(_reworknameView);
         _reworknameView = null;
      }
      
      private function __onRenameComplete(param1:Event) : void
      {
         shutdownReworkName();
      }
      
      private function startupConsortiaReworkName(param1:int, param2:int) : void
      {
         _consortaiReworkName = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.ReworkName.ReworkNameConsortia");
         LayerManager.Instance.addToLayer(_consortaiReworkName,3,true,1);
         _consortaiReworkName.initialize(param1,param2);
         _consortaiReworkName.addEventListener("complete",__onConsortiaRenameComplete);
      }
      
      private function startupBattleTeamReworkName(param1:int, param2:int) : void
      {
         _battleTeamReworkName = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.ReworkName.ReworkNameBattleTeam");
         LayerManager.Instance.addToLayer(_battleTeamReworkName,3,true,1);
         _battleTeamReworkName.initialize(param1,param2);
      }
      
      private function shutdownConsortiaReworkName() : void
      {
         _consortaiReworkName.removeEventListener("complete",__onConsortiaRenameComplete);
         ObjectUtils.disposeObject(_consortaiReworkName);
         _consortaiReworkName = null;
      }
      
      private function showChatBugleInputFrame(param1:int) : void
      {
         if(_chatBugleInputFrame == null)
         {
            _chatBugleInputFrame = ComponentFactory.Instance.creat("chat.BugleInputFrame");
         }
         _chatBugleInputFrame.templateID = param1;
         LayerManager.Instance.addToLayer(_chatBugleInputFrame,3,true,2);
      }
      
      private function shutdownBattleTeamReworkName() : void
      {
         _battleTeamReworkName.removeEventListener("complete",__onBattleTeamRenameComplete);
         ObjectUtils.disposeObject(_battleTeamReworkName);
         _battleTeamReworkName = null;
      }
      
      private function __onBattleTeamRenameComplete(param1:Event) : void
      {
         shutdownBattleTeamReworkName();
      }
      
      private function __onConsortiaRenameComplete(param1:Event) : void
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
         var _loc5_:ItemTemplateInfo = _currentCell.info;
         var _loc6_:DictionaryData = PlayerManager.Instance.Self.cardBagDic;
         var _loc9_:int = 0;
         var _loc8_:* = _loc6_;
         for each(var _loc3_ in _loc6_)
         {
            if(_loc3_.TemplateID == int(_loc5_.Property5))
            {
               return;
            }
         }
         SocketManager.Instance.out.sendFirstGetCards();
         dispatchEvent(new Event("firstGetCard",true));
         getNewCardMovie = ClassUtils.CreatInstance("asset.getNecCard.movie") as MovieClip;
         PositionUtils.setPos(getNewCardMovie,"BagView.NewCardMovie.Pos");
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(16777215,0);
         _loc2_.graphics.drawRect(0,0,113,156);
         _loc2_.graphics.endFill();
         var _loc7_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(int(_loc5_.Property5));
         var _loc4_:BaseCell = new BaseCell(_loc2_,_loc7_);
         getNewCardMovie["card"].addChild(_loc4_);
         var _loc1_:GradientText = ComponentFactory.Instance.creatComponentByStylename("getNewCardMovie.text");
         _loc1_.text = LanguageMgr.GetTranslation("ddt.cardSystem.getNewCard.name",_loc7_.Name);
         _loc1_.x = _loc1_.x - (_loc1_.textWidth - _loc4_.width) / 6;
         getNewCardMovie["word"].addChild(_loc1_);
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
      
      private function __showOver(param1:Event) : void
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
         var _loc1_:Boolean = false;
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(5) && PlayerManager.Instance.Self.IsWeakGuildFinish(2) && PlayerManager.Instance.Self.IsWeakGuildFinish(12) && PlayerManager.Instance.Self.IsWeakGuildFinish(51) && PlayerManager.Instance.Self.IsWeakGuildFinish(55))
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function startupChangeSex(param1:int, param2:int) : void
      {
         var _loc3_:ChangeSexAlertFrame = ComponentFactory.Instance.creat("bagAndInfo.bag.changeSexAlert");
         _loc3_.bagType = param1;
         _loc3_.place = param2;
         _loc3_.info = getAlertInfo("tank.view.bagII.changeSexAlert",true);
         _loc3_.addEventListener("propertiesChanged",__onAlertSizeChanged);
         _loc3_.addEventListener("response",__onAlertResponse);
         LayerManager.Instance.addToLayer(_loc3_,3,_loc3_.info.frameCenter,1);
         StageReferance.stage.focus = _loc3_;
      }
      
      private function getAlertInfo(param1:String, param2:Boolean = false) : AlertInfo
      {
         var _loc3_:AlertInfo = new AlertInfo();
         _loc3_.autoDispose = true;
         _loc3_.showSubmit = true;
         _loc3_.showCancel = param2;
         _loc3_.enterEnable = true;
         _loc3_.escEnable = true;
         _loc3_.moveEnable = false;
         _loc3_.title = LanguageMgr.GetTranslation("AlertDialog.Info");
         _loc3_.data = LanguageMgr.GetTranslation(param1);
         return _loc3_;
      }
      
      private function __onAlertSizeChanged(param1:ComponentEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         if(_loc2_.info.frameCenter)
         {
            _loc2_.x = (StageReferance.stageWidth - _loc2_.width) / 2;
            _loc2_.y = (StageReferance.stageHeight - _loc2_.height) / 2;
         }
      }
      
      private function __onAlertResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:ChangeSexAlertFrame = ChangeSexAlertFrame(param1.currentTarget);
         _loc2_.removeEventListener("propertiesChanged",__onAlertSizeChanged);
         _loc2_.removeEventListener("response",__onAlertResponse);
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               SocketManager.Instance.out.sendChangeSex(_loc2_.bagType,_loc2_.place);
         }
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      private function __changeSexHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:* = null;
         SocketManager.Instance.socket.close();
         var _loc3_:Boolean = param1.pkg.readBoolean();
         if(_loc3_)
         {
            _loc2_ = ComponentFactory.Instance.creat("sellGoodsAlert");
            _loc2_.info = getAlertInfo("tank.view.bagII.changeSexAlert.success",false);
            _loc2_.addEventListener("propertiesChanged",__onAlertSizeChanged);
            _loc2_.addEventListener("response",__onSuccessAlertResponse);
            LayerManager.Instance.addToLayer(_loc2_,3,_loc2_.info.frameCenter,1);
            StageReferance.stage.focus = _loc2_;
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.changeSexAlert.failed"));
         }
      }
      
      private function __onSuccessAlertResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         ExternalInterface.call("WindowReturn");
      }
      
      public function set isScreenFood(param1:Boolean) : void
      {
         this._isScreenFood = param1;
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
