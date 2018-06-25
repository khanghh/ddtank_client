package shop.manager
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import shop.view.ShopCartItem;
   import shop.view.ShopPresentClearingFrame;
   
   public class ShopGiftsManager
   {
      
      private static var _instance:ShopGiftsManager;
       
      
      private var _frame:Frame;
      
      private var _shopCartItem:ShopCartItem;
      
      private var _titleTxt:FilterFrameText;
      
      private var _commodityPricesText1:FilterFrameText;
      
      private var _commodityPricesText2:FilterFrameText;
      
      private var _commodityPricesText1Label:FilterFrameText;
      
      private var _commodityPricesText2Label:FilterFrameText;
      
      private var _needToPayTip:FilterFrameText;
      
      private var _giftsBtn:BaseButton;
      
      private var _numberSelecter:NumberSelecter;
      
      private var _goodsID:int;
      
      private var _isDiscountType:Boolean = true;
      
      private var _shopPresentClearingFrame:ShopPresentClearingFrame;
      
      private var _isBand:Boolean;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _bandMoneyTxt:FilterFrameText;
      
      private var _back:MovieClip;
      
      private var _type:int = 0;
      
      private var _commodityPricesText3Label:FilterFrameText;
      
      private var _commodityPricesText3:FilterFrameText;
      
      public function ShopGiftsManager()
      {
         super();
      }
      
      public static function get Instance() : ShopGiftsManager
      {
         if(_instance == null)
         {
            _instance = new ShopGiftsManager();
         }
         return _instance;
      }
      
      public function buy($goodsID:int, $isDiscountType:Boolean = false, type:int = 1) : void
      {
         if(_frame)
         {
            return;
         }
         _goodsID = $goodsID;
         _isDiscountType = $isDiscountType;
         _type = type;
         initView();
         addEvent();
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      private function initView() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.CheckOutViewFrame");
         _frame.titleText = LanguageMgr.GetTranslation("shop.view.present");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("shop.PresentFrame.titleText");
         _titleTxt.text = LanguageMgr.GetTranslation("shop.PresentFrame.titleText");
         _frame.addToContent(_titleTxt);
         var bg:Image = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.CheckOutViewBg");
         _frame.addToContent(bg);
         _giftsBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GiftManager.GiftBtn");
         _frame.addToContent(_giftsBtn);
         if(_type == 1)
         {
            _back = ComponentFactory.Instance.creat("asset.core.stranDown");
            _back.x = 208;
            _back.y = 210;
            _frame.addToContent(_back);
            _selectedBtn = ComponentFactory.Instance.creatComponentByStylename("com.quickBuyFrame.selectBtn");
            _selectedBtn.x = 99;
            _selectedBtn.y = 193;
            _selectedBtn.enable = false;
            _selectedBtn.selected = true;
            _frame.addToContent(_selectedBtn);
            _selectedBtn.addEventListener("click",seletedHander);
            _isBand = false;
            _selectedBandBtn = ComponentFactory.Instance.creatComponentByStylename("com.quickBuyFrame.selectbandBtn");
            _selectedBandBtn.x = 237;
            _selectedBandBtn.y = 193;
            _frame.addToContent(_selectedBandBtn);
            _selectedBandBtn.addEventListener("click",selectedBandHander);
            _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.CommodityPricesText");
            _moneyTxt.text = LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.stipple");
            _moneyTxt.x = 100;
            _moneyTxt.y = 199;
            _frame.addToContent(_moneyTxt);
            _bandMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.CommodityPricesText");
            _bandMoneyTxt.x = 253;
            _bandMoneyTxt.y = 199;
            _bandMoneyTxt.text = LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.bandStipple");
            _frame.addToContent(_bandMoneyTxt);
         }
         var innerBg:Image = ComponentFactory.Instance.creatComponentByStylename("ddtshop.TotalMoneyPanel2");
         PositionUtils.setPos(innerBg,"ddtshop.CheckOutViewBgPos");
         _frame.addToContent(innerBg);
         var shopItemInfo:ShopItemInfo = null;
         if(!_isDiscountType)
         {
            shopItemInfo = ShopManager.Instance.getShopItemByGoodsID(_goodsID);
            if(shopItemInfo == null)
            {
               shopItemInfo = ShopManager.Instance.getGoodsByTemplateID(_goodsID);
            }
         }
         else
         {
            shopItemInfo = ShopManager.Instance.getDisCountShopItemByGoodsID(_goodsID);
         }
         var shopItem:ShopCarItemInfo = new ShopCarItemInfo(shopItemInfo.GoodsID,shopItemInfo.TemplateID);
         ObjectUtils.copyProperties(shopItem,shopItemInfo);
         _shopCartItem = new ShopCartItem();
         PositionUtils.setPos(_shopCartItem,"ddtshop.shopCartItemPos");
         _shopCartItem.closeBtn.visible = false;
         _shopCartItem.setShopItemInfo(shopItem);
         _shopCartItem.setColor(shopItem.Color);
         _frame.addToContent(_shopCartItem);
         var textImg:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtshop.PurchaseAmount");
         PositionUtils.setPos(textImg,"ddtshop.PurchaseAmountTextImgPos");
         _frame.addToContent(textImg);
         _numberSelecter = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.NumberSelecter");
         _frame.addToContent(_numberSelecter);
         _needToPayTip = ComponentFactory.Instance.creatComponentByStylename("ddtshop.NeedToPayTip");
         _needToPayTip.text = LanguageMgr.GetTranslation("shop.CheckOutView.NeedToPayTipText");
         PositionUtils.setPos(_needToPayTip,"ddtshop.NeedToPayTipTextPos");
         _frame.addToContent(_needToPayTip);
         _commodityPricesText1 = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.CommodityPricesText");
         PositionUtils.setPos(_commodityPricesText1,"ddtshop.commodityPricesText1Pos");
         _commodityPricesText1.text = "0";
         _frame.addToContent(_commodityPricesText1);
         _commodityPricesText2 = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.CommodityPricesText");
         PositionUtils.setPos(_commodityPricesText2,"ddtshop.commodityPricesText2Pos");
         _commodityPricesText2.text = "0";
         _frame.addToContent(_commodityPricesText2);
         _commodityPricesText3 = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.CommodityPricesText");
         PositionUtils.setPos(_commodityPricesText3,"ddtshop.commodityPricesText3Pos");
         _commodityPricesText3.text = "0";
         _frame.addToContent(_commodityPricesText3);
         _commodityPricesText1Label = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText1Label");
         _commodityPricesText1Label.text = LanguageMgr.GetTranslation("shop.CheckOutView.CommodityPricesText1Label");
         _commodityPricesText2Label = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText2Label");
         _commodityPricesText2Label.text = LanguageMgr.GetTranslation("shop.CheckOutView.CommodityPricesText2Label");
         _commodityPricesText3Label = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText3Label");
         _commodityPricesText3Label.text = LanguageMgr.GetTranslation("medalMoney");
         PositionUtils.setPos(_commodityPricesText1Label,"ddtshop.commodityPricesText1LabelPos");
         PositionUtils.setPos(_commodityPricesText2Label,"ddtshop.commodityPricesText2LabelPos");
         PositionUtils.setPos(_commodityPricesText3Label,"ddtshop.commodityPricesText3LabelPos");
         _frame.addToContent(_commodityPricesText1Label);
         _frame.addToContent(_commodityPricesText2Label);
         _frame.addToContent(_commodityPricesText3Label);
         updateCommodityPrices();
      }
      
      private function addEvent() : void
      {
         _giftsBtn.addEventListener("click",__giftsBtnClick);
         _numberSelecter.addEventListener("change",__numberSelecterChange);
         _shopCartItem.addEventListener("conditionchange",__shopCartItemChange);
         _frame.addEventListener("response",__framePesponse);
         SocketManager.Instance.addEventListener(PkgEvent.format(57),onPresent);
      }
      
      protected function selectedBandHander(event:MouseEvent) : void
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
      
      protected function seletedHander(event:MouseEvent) : void
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
      
      private function removeEvent() : void
      {
         _giftsBtn.removeEventListener("click",__giftsBtnClick);
         _numberSelecter.removeEventListener("change",__numberSelecterChange);
         _shopCartItem.removeEventListener("conditionchange",__shopCartItemChange);
         _frame.removeEventListener("response",__framePesponse);
         SocketManager.Instance.removeEventListener(PkgEvent.format(57),onPresent);
      }
      
      private function updateCommodityPrices() : void
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
      }
      
      protected function __giftsBtnClick(event:MouseEvent) : void
      {
         var money:int = _shopCartItem.shopItemInfo.getCurrentPrice().bothMoneyValue * _numberSelecter.currentValue;
         if(money > PlayerManager.Instance.Self.Money)
         {
            LeavePageManager.showFillFrame();
            return;
         }
         SoundManager.instance.play("008");
         _shopPresentClearingFrame = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.ShopPresentClearingFrame");
         _shopPresentClearingFrame.show();
         _shopPresentClearingFrame.presentBtn.addEventListener("click",__presentBtnClick);
         _shopPresentClearingFrame.addEventListener("response",__responseHandler);
      }
      
      private function __responseHandler(event:FrameEvent) : void
      {
         if(event.responseCode == 0 || event.responseCode == 1)
         {
            StageReferance.stage.focus = _frame;
         }
      }
      
      protected function __presentBtnClick(event:MouseEvent) : void
      {
         var i:int = 0;
         var t:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_shopPresentClearingFrame.nameInput.text == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.give"));
            return;
         }
         if(FilterWordManager.IsNullorEmpty(_shopPresentClearingFrame.nameInput.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.space"));
            return;
         }
         var moneyValue:int = _shopCartItem.shopItemInfo.getCurrentPrice().bothMoneyValue;
         if(PlayerManager.Instance.Self.Money < moneyValue && moneyValue != 0)
         {
            LeavePageManager.showFillFrame();
            return;
         }
         _shopPresentClearingFrame.presentBtn.enable = false;
         var items:Array = [];
         var types:Array = [];
         var colors:Array = [];
         var dresses:Array = [];
         var places:Array = [];
         var goodTypes:Array = [];
         for(i = 0; i < _numberSelecter.currentValue; )
         {
            t = _shopCartItem.shopItemInfo;
            items.push(t.GoodsID);
            types.push(t.currentBuyType);
            colors.push(t.Color);
            dresses.push("");
            places.push("");
            goodTypes.push(t.isDiscount);
            i++;
         }
         var msg:String = FilterWordManager.filterWrod(_shopPresentClearingFrame.textArea.text);
         SocketManager.Instance.out.sendPresentGoods(items,types,colors,goodTypes,msg,_shopPresentClearingFrame.nameInput.text,null,[false]);
      }
      
      protected function onPresent(event:PkgEvent) : void
      {
         if(_shopPresentClearingFrame)
         {
            _shopPresentClearingFrame.presentBtn.enable = true;
            _shopPresentClearingFrame.presentBtn.removeEventListener("click",__presentBtnClick);
            _shopPresentClearingFrame.dispose();
            _shopPresentClearingFrame = null;
         }
         var boo:Boolean = event.pkg.readBoolean();
         dispose();
      }
      
      protected function __numberSelecterChange(event:Event) : void
      {
         SoundManager.instance.play("008");
         updateCommodityPrices();
      }
      
      protected function __shopCartItemChange(event:Event) : void
      {
         updateCommodityPrices();
      }
      
      protected function __framePesponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function dispose() : void
      {
         removeEvent();
         if(_titleTxt)
         {
            ObjectUtils.disposeObject(_titleTxt);
         }
         _titleTxt = null;
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
         if(_commodityPricesText1)
         {
            ObjectUtils.disposeObject(_commodityPricesText3);
         }
         _commodityPricesText3 = null;
         if(_giftsBtn)
         {
            ObjectUtils.disposeObject(_giftsBtn);
         }
         _giftsBtn = null;
         if(_numberSelecter)
         {
            ObjectUtils.disposeObject(_numberSelecter);
         }
         _numberSelecter = null;
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
         if(_commodityPricesText3Label)
         {
            ObjectUtils.disposeObject(_commodityPricesText3Label);
         }
         _commodityPricesText3Label = null;
         if(_frame)
         {
            ObjectUtils.disposeObject(_frame);
         }
         _frame = null;
      }
   }
}
