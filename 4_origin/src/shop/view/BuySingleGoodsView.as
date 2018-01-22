package shop.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import shop.manager.ShopSaleManager;
   
   public class BuySingleGoodsView extends Sprite implements Disposeable
   {
      
      public static const SHOP_CANNOT_FIND:String = "shopCannotfind";
       
      
      protected var _frame:Frame;
      
      protected var _shopCartItem:ShopCartItem;
      
      protected var _commodityPricesText1:FilterFrameText;
      
      protected var _commodityPricesText2:FilterFrameText;
      
      private var _commodityPricesText1Label:FilterFrameText;
      
      protected var _commodityPricesText2Label:FilterFrameText;
      
      private var _needToPayTip:FilterFrameText;
      
      protected var _purchaseConfirmationBtn:BaseButton;
      
      protected var _numberSelecter:NumberSelecter;
      
      private var _goodsID:int;
      
      private var _isDisCount:Boolean = false;
      
      public var isSale:Boolean = false;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _bandMoneyTxt:FilterFrameText;
      
      protected var _isBand:Boolean;
      
      private var _movie:MovieClip;
      
      protected var _type:int;
      
      private var _commodityPricesText3Label:FilterFrameText;
      
      private var _commodityPricesText3:FilterFrameText;
      
      protected var _askBtn:SimpleBitmapButton;
      
      private var _shopPresentClearingFrame:ShopPresentClearingFrame;
      
      public function BuySingleGoodsView(param1:int = 1)
      {
         super();
         _type = param1;
         initView();
         addEvent();
      }
      
      protected function initView() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.CheckOutViewFrame");
         _frame.titleText = LanguageMgr.GetTranslation("store.view.shortcutBuy.buyBtn");
         var _loc2_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.CheckOutViewBg");
         _frame.addToContent(_loc2_);
         _purchaseConfirmationBtn = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.SingleGoodView.PurchaseBtn");
         _frame.addToContent(_purchaseConfirmationBtn);
         var _loc3_:Image = ComponentFactory.Instance.creatComponentByStylename("ddtshop.TotalMoneyPanel2");
         PositionUtils.setPos(_loc3_,"ddtshop.CheckOutViewBgPos");
         _frame.addToContent(_loc3_);
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtshop.PurchaseAmount");
         PositionUtils.setPos(_loc1_,"ddtshop.PurchaseAmountTextImgPos");
         _frame.addToContent(_loc1_);
         _numberSelecter = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.NumberSelecter");
         _numberSelecter.valueLimit = "1,999";
         _frame.addToContent(_numberSelecter);
         _needToPayTip = ComponentFactory.Instance.creatComponentByStylename("ddtshop.NeedToPayTip");
         _needToPayTip.text = LanguageMgr.GetTranslation("shop.CheckOutView.NeedToPayTipText");
         PositionUtils.setPos(_needToPayTip,"ddtshop.NeedToPayTipTextPos");
         _frame.addToContent(_needToPayTip);
         _commodityPricesText1Label = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText1Label");
         _commodityPricesText1Label.text = LanguageMgr.GetTranslation("shop.CheckOutView.CommodityPricesText1Label");
         _commodityPricesText2Label = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText2Label");
         _commodityPricesText2Label.text = LanguageMgr.GetTranslation("shop.CheckOutView.CommodityPricesText2Label");
         _commodityPricesText3Label = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText3Label");
         _commodityPricesText3Label.text = LanguageMgr.GetTranslation("medalMoney");
         if(_type != 4)
         {
            if(_type == 3)
            {
               _purchaseConfirmationBtn.visible = false;
               _frame.titleText = LanguageMgr.GetTranslation("shop.ShopIIPresentView.ask");
               _askBtn = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.askButton");
               _askBtn.x = 120;
               _askBtn.y = 312;
               _askBtn.addEventListener("click",askBtnHander);
               _frame.addToContent(_askBtn);
            }
            else if(_type == -8)
            {
               _isBand = false;
            }
            else if(_type == -9)
            {
               _isBand = true;
            }
            else if(_type != -2)
            {
               _movie = ComponentFactory.Instance.creat("asset.core.stranDown");
               _movie.x = 216;
               _movie.y = 209;
               _frame.addToContent(_movie);
               _selectedBtn = ComponentFactory.Instance.creatComponentByStylename("com.quickBuyFrame.selectBtn");
               _selectedBtn.x = 99;
               _selectedBtn.y = 193;
               _selectedBtn.enable = false;
               _selectedBtn.selected = true;
               _frame.addToContent(_selectedBtn);
               _selectedBtn.addEventListener("click",seletedHander);
               _selectedBandBtn = ComponentFactory.Instance.creatComponentByStylename("com.quickBuyFrame.selectbandBtn");
               _selectedBandBtn.x = 237;
               _selectedBandBtn.y = 193;
               _frame.addToContent(_selectedBandBtn);
               _selectedBandBtn.addEventListener("click",selectedBandHander);
               _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.choosePricesTypeText");
               _moneyTxt.text = LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.stipple");
               _moneyTxt.x = 134;
               _moneyTxt.y = 200;
               _frame.addToContent(_moneyTxt);
               _bandMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.choosePricesTypeText");
               _bandMoneyTxt.x = 272;
               _bandMoneyTxt.y = 200;
               _bandMoneyTxt.text = LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.bandStipple");
               _frame.addToContent(_bandMoneyTxt);
            }
         }
         _commodityPricesText1 = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.CommodityPricesText");
         _commodityPricesText1.text = "0";
         PositionUtils.setPos(_commodityPricesText1,"ddtshop.commodityPricesText1Pos");
         _frame.addToContent(_commodityPricesText1);
         _commodityPricesText2 = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.CommodityPricesText");
         _commodityPricesText2.text = "0";
         PositionUtils.setPos(_commodityPricesText2,"ddtshop.commodityPricesText2Pos");
         _frame.addToContent(_commodityPricesText2);
         _commodityPricesText3 = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.CommodityPricesText");
         _commodityPricesText3.text = "0";
         PositionUtils.setPos(_commodityPricesText3,"ddtshop.commodityPricesText3Pos");
         _frame.addToContent(_commodityPricesText3);
         PositionUtils.setPos(_commodityPricesText1Label,"ddtshop.commodityPricesText1LabelPos");
         PositionUtils.setPos(_commodityPricesText2Label,"ddtshop.commodityPricesText2LabelPos");
         PositionUtils.setPos(_commodityPricesText3Label,"ddtshop.commodityPricesText3LabelPos");
         _frame.addToContent(_commodityPricesText1Label);
         _frame.addToContent(_commodityPricesText2Label);
         _frame.addToContent(_commodityPricesText3Label);
         addChild(_frame);
      }
      
      private function askBtnHander(param1:MouseEvent) : void
      {
         payPanl();
      }
      
      private function payPanl() : void
      {
         _shopPresentClearingFrame = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.ShopPresentClearingFrame");
         _shopPresentClearingFrame.show();
         _shopPresentClearingFrame.setType(2);
         _shopPresentClearingFrame.presentBtn.addEventListener("click",presentBtnClick);
         _shopPresentClearingFrame.addEventListener("response",shopPresentClearingFrameResponseHandler);
      }
      
      protected function shopPresentClearingFrameResponseHandler(param1:FrameEvent) : void
      {
         _shopPresentClearingFrame.removeEventListener("response",shopPresentClearingFrameResponseHandler);
         if(_shopPresentClearingFrame.presentBtn)
         {
            _shopPresentClearingFrame.presentBtn.removeEventListener("click",presentBtnClick);
         }
         if(param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 4)
         {
            _shopPresentClearingFrame.dispose();
            _shopPresentClearingFrame = null;
         }
      }
      
      protected function presentBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:String = _shopPresentClearingFrame.nameInput.text;
         if(_loc2_ == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.askPay"));
            return;
         }
         if(FilterWordManager.IsNullorEmpty(_loc2_))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.askSpace"));
            return;
         }
         _shopPresentClearingFrame.presentBtn.removeEventListener("click",presentBtnClick);
         _shopPresentClearingFrame.removeEventListener("response",shopPresentClearingFrameResponseHandler);
         sendAsk();
         _shopPresentClearingFrame.dispose();
         _shopPresentClearingFrame = null;
         dispose();
      }
      
      private function sendAsk() : void
      {
         var _loc7_:int = 0;
         var _loc1_:* = null;
         var _loc2_:Array = [];
         var _loc5_:Array = [];
         var _loc4_:Array = [];
         var _loc3_:Array = [];
         var _loc6_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _numberSelecter.currentValue)
         {
            _loc1_ = _shopCartItem.shopItemInfo;
            _loc2_.push(_loc1_.GoodsID);
            _loc5_.push(_loc1_.currentBuyType);
            _loc4_.push(_loc1_.isDiscount);
            _loc3_.push(_loc1_.Color);
            _loc6_.push(_loc1_.skin);
            _loc7_++;
         }
         SocketManager.Instance.out.requestShopPay(_loc2_,_loc5_,_loc4_,_loc3_,_loc6_,_shopPresentClearingFrame.Name,_shopPresentClearingFrame.textArea.text);
      }
      
      protected function selectedBandHander(param1:MouseEvent) : void
      {
         if(_selectedBandBtn.selected)
         {
            _isBand = true;
            _selectedBandBtn.enable = false;
            _selectedBtn.selected = false;
            _selectedBtn.enable = true;
         }
         else
         {
            _isBand = false;
         }
         updateCommodityPrices();
      }
      
      protected function seletedHander(param1:MouseEvent) : void
      {
         if(_selectedBtn.selected)
         {
            _isBand = false;
            _selectedBandBtn.selected = false;
            _selectedBandBtn.enable = true;
            _selectedBtn.enable = false;
         }
         else
         {
            _isBand = true;
         }
         updateCommodityPrices();
      }
      
      public function set isDisCount(param1:Boolean) : void
      {
         _isDisCount = param1;
      }
      
      public function set goodsID(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_shopCartItem)
         {
            _shopCartItem.removeEventListener("conditionchange",__shopCartItemChange);
            _shopCartItem.dispose();
         }
         _goodsID = param1;
         if(isSale)
         {
            _loc3_ = ShopManager.Instance.getMoneySaleShopItemByTemplateID(_goodsID);
         }
         else if(_isDisCount)
         {
            _loc3_ = ShopManager.Instance.getDisCountShopItemByGoodsID(_goodsID);
         }
         else
         {
            _loc3_ = ShopManager.Instance.getShopItemByGoodsID(_goodsID);
         }
         if(!_loc3_)
         {
            _loc3_ = ShopManager.Instance.getGoodsByTemplateID(_goodsID);
         }
         if(_loc3_)
         {
            _loc2_ = new ShopCarItemInfo(_loc3_.GoodsID,_loc3_.TemplateID);
            ObjectUtils.copyProperties(_loc2_,_loc3_);
            _shopCartItem = new ShopCartItem();
            PositionUtils.setPos(_shopCartItem,"ddtshop.shopCartItemPos");
            _shopCartItem.closeBtn.visible = false;
            _shopCartItem.setShopItemInfo(_loc2_);
            _shopCartItem.setColor(_loc2_.Color);
            _frame.addToContent(_shopCartItem);
            _shopCartItem.addEventListener("conditionchange",__shopCartItemChange);
            updateCommodityPrices();
         }
      }
      
      private function addEvent() : void
      {
         _purchaseConfirmationBtn.addEventListener("click",__purchaseConfirmationBtnClick);
         _numberSelecter.addEventListener("change",__numberSelecterChange);
         _frame.addEventListener("response",__framePesponse);
         SocketManager.Instance.addEventListener(PkgEvent.format(44),onBuyedGoods);
      }
      
      private function removeEvent() : void
      {
         if(_askBtn)
         {
            _askBtn.removeEventListener("click",askBtnHander);
         }
         if(_purchaseConfirmationBtn)
         {
            _purchaseConfirmationBtn.removeEventListener("click",__purchaseConfirmationBtnClick);
         }
         if(_numberSelecter)
         {
            _numberSelecter.removeEventListener("change",__numberSelecterChange);
         }
         if(_shopCartItem)
         {
            _shopCartItem.removeEventListener("conditionchange",__shopCartItemChange);
         }
         if(_frame)
         {
            _frame.removeEventListener("response",__framePesponse);
         }
         if(_selectedBtn)
         {
            _selectedBtn.removeEventListener("click",seletedHander);
         }
         if(_selectedBandBtn)
         {
            _selectedBandBtn.removeEventListener("click",selectedBandHander);
         }
         SocketManager.Instance.removeEventListener(PkgEvent.format(44),onBuyedGoods);
         CheckMoneyUtils.instance.removeEventListener("complete",onCheckComplete);
      }
      
      protected function updateCommodityPrices() : void
      {
         if(_type == -2)
         {
            _commodityPricesText3.text = (_shopCartItem.shopItemInfo.getCurrentPrice().ddtMoneyValue * _numberSelecter.currentValue).toString();
         }
         else if(_type == -1)
         {
            if(_isBand)
            {
               _commodityPricesText1.text = "0";
               _commodityPricesText2.text = (_shopCartItem.shopItemInfo.getCurrentPrice().bothMoneyValue * _numberSelecter.currentValue).toString();
            }
            else
            {
               _commodityPricesText1.text = (_shopCartItem.shopItemInfo.getCurrentPrice().bothMoneyValue * _numberSelecter.currentValue).toString();
               _commodityPricesText2.text = "0";
            }
            _shopCartItem.setDianquanType(_isBand);
         }
         else if(_type == -8)
         {
            _commodityPricesText1.text = (_shopCartItem.shopItemInfo.getCurrentPrice().moneyValue * _numberSelecter.currentValue).toString();
            _commodityPricesText2.text = "0";
            _shopCartItem.setDianquanType(false);
         }
         else if(_type == -9)
         {
            _commodityPricesText1.text = "0";
            _commodityPricesText2.text = (_shopCartItem.shopItemInfo.getCurrentPrice().bandDdtMoneyValue * _numberSelecter.currentValue).toString();
            _shopCartItem.setDianquanType(true);
         }
         else
         {
            _commodityPricesText1.text = (_shopCartItem.shopItemInfo.getCurrentPrice().bothMoneyValue * _numberSelecter.currentValue).toString();
            _shopCartItem.setDianquanType(false);
         }
      }
      
      protected function __purchaseConfirmationBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_shopCartItem.shopItemInfo.ShopID == 110 && ShopSaleManager.Instance.goodsBuyMaxNum > 0)
         {
            if(_numberSelecter.currentValue > ShopSaleManager.Instance.goodsBuyMaxNum)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("asset.ddtshop.notBuyMaxNum",ShopSaleManager.Instance.goodsBuyMaxNum));
               return;
            }
         }
         var _loc3_:Boolean = true;
         if(_type == -8)
         {
            _loc2_ = _shopCartItem.shopItemInfo.getCurrentPrice().moneyValue;
         }
         else if(_type == -9)
         {
            _loc2_ = _shopCartItem.shopItemInfo.getCurrentPrice().bandDdtMoneyValue;
            _loc3_ = false;
         }
         else
         {
            _loc2_ = _shopCartItem.shopItemInfo.getCurrentPrice().bothMoneyValue;
         }
         CheckMoneyUtils.instance.checkMoney(_isBand,_loc2_,onCheckComplete,null,_loc3_);
      }
      
      protected function onCheckComplete() : void
      {
         _purchaseConfirmationBtn.enable = false;
         var _loc1_:ShopCarItemInfo = _shopCartItem.shopItemInfo;
         SocketManager.Instance.out.sendNewBuyGoods(_loc1_.GoodsID,_loc1_.currentBuyType,_numberSelecter.currentValue,"",0,false,"",0,_loc1_.isDiscount,CheckMoneyUtils.instance.isBind);
      }
      
      protected function onBuyedGoods(param1:PkgEvent) : void
      {
         _purchaseConfirmationBtn.enable = true;
         param1.pkg.position = 20;
         var _loc2_:int = param1.pkg.readInt();
         if(_loc2_ != 0)
         {
            dispose();
         }
      }
      
      protected function __numberSelecterChange(param1:Event) : void
      {
         SoundManager.instance.play("008");
         updateCommodityPrices();
      }
      
      protected function __shopCartItemChange(param1:Event) : void
      {
         updateCommodityPrices();
      }
      
      protected function __framePesponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_frame)
         {
            ObjectUtils.disposeObject(_frame);
         }
         _frame = null;
         ObjectUtils.disposeObject(_askBtn);
         _askBtn = null;
         if(_shopCartItem)
         {
            ObjectUtils.disposeObject(_shopCartItem);
         }
         _shopCartItem = null;
         if(_needToPayTip)
         {
            ObjectUtils.disposeObject(_needToPayTip);
         }
         _needToPayTip = null;
         if(_commodityPricesText1)
         {
            ObjectUtils.disposeObject(_commodityPricesText1);
         }
         _commodityPricesText1 = null;
         if(_commodityPricesText2)
         {
            ObjectUtils.disposeObject(_commodityPricesText2);
         }
         _commodityPricesText2 = null;
         if(_purchaseConfirmationBtn)
         {
            ObjectUtils.disposeObject(_purchaseConfirmationBtn);
         }
         _purchaseConfirmationBtn = null;
         if(_numberSelecter)
         {
            ObjectUtils.disposeObject(_numberSelecter);
         }
         _numberSelecter = null;
         ObjectUtils.disposeObject(_selectedBandBtn);
         ObjectUtils.disposeObject(_selectedBtn);
         if(_commodityPricesText1Label)
         {
            ObjectUtils.disposeObject(_commodityPricesText1Label);
         }
         _commodityPricesText1Label = null;
         if(_commodityPricesText2Label)
         {
            ObjectUtils.disposeObject(_commodityPricesText2Label);
         }
         _commodityPricesText2Label = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get numberSelecter() : NumberSelecter
      {
         return _numberSelecter;
      }
   }
}
