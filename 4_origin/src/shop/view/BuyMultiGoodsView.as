package shop.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import shop.manager.ShopBuyManager;
   
   public class BuyMultiGoodsView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Image;
      
      private var _commodityNumberTip:FilterFrameText;
      
      private var _commodityNumberText:FilterFrameText;
      
      private var _commodityPricesText1:FilterFrameText;
      
      private var _commodityPricesText2:FilterFrameText;
      
      private var _commodityPricesText1Label:FilterFrameText;
      
      private var _commodityPricesText2Label:FilterFrameText;
      
      private var _needToPayTip:FilterFrameText;
      
      private var _purchaseConfirmationBtn:BaseButton;
      
      private var _buyArray:Vector.<ShopCarItemInfo>;
      
      private var _cartList:VBox;
      
      private var _cartScroll:ScrollPanel;
      
      private var _frame:Frame;
      
      private var _innerBg1:Image;
      
      private var _innerBg:Bitmap;
      
      private var _extraTextButton:BaseButton;
      
      public var dressing:Boolean = false;
      
      private var _commodityPricesText3Label:FilterFrameText;
      
      private var _commodityPricesText3:FilterFrameText;
      
      public function BuyMultiGoodsView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CheckOutViewFrame");
         _frame.titleText = LanguageMgr.GetTranslation("shop.Shop.car");
         addChild(_frame);
         _cartList = new VBox();
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CheckOutViewBg");
         _purchaseConfirmationBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.PurchaseBtn");
         _cartScroll = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CheckOutViewItemList");
         _extraTextButton = ComponentFactory.Instance.creatComponentByStylename("ddtshop.PurchaseBtn");
         _cartScroll.setView(_cartList);
         _cartScroll.vScrollProxy = 0;
         _cartList.spacing = 5;
         _cartList.strictSize = 80;
         _cartList.isReverAdd = true;
         _frame.addToContent(_bg);
         _innerBg1 = ComponentFactory.Instance.creatComponentByStylename("ddtshop.TotalMoneyPanel");
         _frame.addToContent(_innerBg1);
         _commodityNumberTip = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityNumberTipText");
         _frame.addToContent(_commodityNumberTip);
         _commodityNumberText = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityNumberText");
         _frame.addToContent(_commodityNumberText);
         _needToPayTip = ComponentFactory.Instance.creatComponentByStylename("ddtshop.NeedToPayTip");
         _needToPayTip.text = LanguageMgr.GetTranslation("shop.CheckOutView.NeedToPayTipText");
         _frame.addToContent(_needToPayTip);
         _commodityPricesText1 = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText1");
         _commodityPricesText2 = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText2");
         _commodityPricesText3 = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText3");
         _commodityPricesText1Label = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText1Label");
         _commodityPricesText1Label.text = LanguageMgr.GetTranslation("shop.CheckOutView.CommodityPricesText1Label");
         _commodityPricesText2Label = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText2Label");
         _commodityPricesText2Label.text = LanguageMgr.GetTranslation("shop.CheckOutView.CommodityPricesText2Label");
         _commodityPricesText3Label = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText3Label");
         _commodityPricesText3Label.text = LanguageMgr.GetTranslation("medalMoney");
         _frame.addToContent(_commodityPricesText1Label);
         _frame.addToContent(_commodityPricesText2Label);
         _frame.addToContent(_commodityPricesText3Label);
         _frame.addToContent(_commodityPricesText1);
         _frame.addToContent(_commodityPricesText2);
         _frame.addToContent(_commodityPricesText3);
         _frame.addToContent(_cartScroll);
         _frame.addToContent(_purchaseConfirmationBtn);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,true,2,true);
      }
      
      protected function updateTxt() : void
      {
         var _loc1_:Array = ShopBuyManager.calcPrices(_buyArray);
         _commodityNumberTip.htmlText = LanguageMgr.GetTranslation("shop.CheckOutView.CommodityNumberTip",_buyArray.length);
         _commodityPricesText1.text = String(_loc1_[1]);
         _commodityPricesText3.text = String(_loc1_[2]);
         _commodityPricesText2.text = String(_loc1_[2]);
      }
      
      private function initEvents() : void
      {
         _purchaseConfirmationBtn.addEventListener("click",__buyAvatar);
         _frame.addEventListener("response",__onResponse);
      }
      
      private function removeEvents() : void
      {
         _purchaseConfirmationBtn.removeEventListener("click",__buyAvatar);
         _frame.removeEventListener("response",__onResponse);
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.playButtonSound();
               dispose();
         }
      }
      
      private function __buyAvatar(param1:MouseEvent) : void
      {
         var _loc9_:int = 0;
         var _loc11_:* = null;
         var _loc7_:int = 0;
         SoundManager.instance.play("008");
         var _loc15_:int = _commodityPricesText1.text;
         var _loc8_:int = _commodityPricesText2.text;
         var _loc17_:int = _commodityPricesText3.text;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_loc8_ > PlayerManager.Instance.Self.BandMoney)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.lijinbuzu"));
            return;
         }
         if(_loc15_ > PlayerManager.Instance.Self.Money)
         {
            LeavePageManager.showFillFrame();
            return;
         }
         if(_loc17_ > PlayerManager.Instance.Self.DDTMoney)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.madelLack"));
            return;
         }
         var _loc4_:Array = [];
         var _loc21_:int = 0;
         var _loc20_:* = _buyArray;
         for each(var _loc13_ in _buyArray)
         {
            _loc4_.push(_loc13_);
         }
         var _loc10_:Array = ShopManager.Instance.buyIt(_loc4_);
         if(_loc10_.length == 0)
         {
            var _loc23_:int = 0;
            var _loc22_:* = _buyArray;
            for each(var _loc3_ in _buyArray)
            {
               if(_loc3_.getCurrentPrice().bothMoneyValue > 0)
               {
                  LeavePageManager.showFillFrame();
                  return;
               }
            }
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.lackCoin"));
            return;
         }
         if(_loc10_.length < _buyArray.length)
         {
         }
         var _loc12_:Array = [];
         var _loc18_:Array = [];
         var _loc5_:Array = [];
         var _loc14_:Array = [];
         var _loc6_:Array = [];
         var _loc19_:Array = [];
         _loc9_ = 0;
         while(_loc9_ < _loc10_.length)
         {
            _loc11_ = _loc10_[_loc9_];
            _loc12_.push(_loc11_.GoodsID);
            _loc18_.push(_loc11_.currentBuyType);
            _loc5_.push(_loc11_.Color);
            _loc6_.push(_loc11_.place);
            if(_loc11_.CategoryID == 6)
            {
               _loc19_.push(_loc11_.skin);
            }
            else
            {
               _loc19_.push("");
            }
            _loc14_.push(dressing);
            _loc9_++;
         }
         SocketManager.Instance.out.sendBuyGoods(_loc12_,_loc18_,_loc5_,_loc6_,_loc14_,_loc19_);
         var _loc16_:Array = [];
         _loc7_ = _cartList.numChildren - 1;
         while(_loc7_ >= 0)
         {
            _loc16_.push(_cartList.getChildAt(_loc7_));
            _loc7_--;
         }
         var _loc25_:int = 0;
         var _loc24_:* = _loc16_;
         for each(var _loc2_ in _loc16_)
         {
            if(_loc10_.indexOf(_loc2_.shopItemInfo) > -1)
            {
               _loc2_.removeEventListener("deleteitem",__deleteItem);
               _loc2_.removeEventListener("conditionchange",__conditionChange);
               _cartList.removeChild(_loc2_);
               _buyArray.splice(_buyArray.indexOf(_loc2_.shopItemInfo),1);
               _loc2_.dispose();
            }
         }
         if(_cartList.numChildren == 0)
         {
            dispose();
         }
         else
         {
            updateTxt();
         }
      }
      
      public function setGoods(param1:Vector.<ShopCarItemInfo>) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         while(_cartList.numChildren > 0)
         {
            _loc3_ = _cartList.getChildAt(_cartList.numChildren - 1) as ShopCartItem;
            _loc3_.removeEventListener("deleteitem",__deleteItem);
            _loc3_.removeEventListener("conditionchange",__conditionChange);
            _cartList.removeChild(_loc3_);
            _loc3_.dispose();
         }
         _buyArray = param1;
         var _loc6_:int = 0;
         var _loc5_:* = _buyArray;
         for each(var _loc4_ in _buyArray)
         {
            _loc2_ = new ShopCartItem();
            _loc2_.setShopItemInfo(_loc4_);
            _loc2_.setColor(_loc4_.Color);
            _cartList.addChild(_loc2_);
            _loc2_.addEventListener("deleteitem",__deleteItem);
            _loc2_.addEventListener("conditionchange",__conditionChange);
         }
         _cartScroll.invalidateViewport();
         updateTxt();
      }
      
      private function __conditionChange(param1:Event) : void
      {
         updateTxt();
      }
      
      private function __deleteItem(param1:Event) : void
      {
         var _loc3_:ShopCartItem = param1.currentTarget as ShopCartItem;
         var _loc4_:ShopCarItemInfo = _loc3_.shopItemInfo;
         _loc3_.removeEventListener("deleteitem",__deleteItem);
         _loc3_.removeEventListener("conditionchange",__conditionChange);
         _cartList.removeChild(_loc3_);
         var _loc2_:int = _buyArray.indexOf(_loc4_);
         _buyArray.splice(_loc2_,1);
         updateTxt();
         _cartScroll.invalidateViewport();
         if(_buyArray.length < 1)
         {
            dispose();
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         removeEvents();
         while(_cartList.numChildren > 0)
         {
            _loc1_ = _cartList.getChildAt(_cartList.numChildren - 1) as ShopCartItem;
            _loc1_.removeEventListener("deleteitem",__deleteItem);
            _loc1_.removeEventListener("conditionchange",__conditionChange);
            _cartList.removeChild(_loc1_);
            _loc1_.dispose();
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_commodityNumberTip);
         _commodityNumberTip = null;
         ObjectUtils.disposeObject(_commodityNumberText);
         _commodityNumberText = null;
         ObjectUtils.disposeObject(_commodityPricesText1);
         _commodityPricesText1 = null;
         ObjectUtils.disposeObject(_commodityPricesText2);
         _commodityPricesText2 = null;
         ObjectUtils.disposeObject(_commodityPricesText3);
         _commodityPricesText3 = null;
         ObjectUtils.disposeObject(_commodityPricesText1Label);
         ObjectUtils.disposeObject(_commodityPricesText2Label);
         ObjectUtils.disposeObject(_commodityPricesText3Label);
         _commodityPricesText1Label = null;
         _commodityPricesText2Label = null;
         ObjectUtils.disposeObject(_needToPayTip);
         _needToPayTip = null;
         ObjectUtils.disposeObject(_purchaseConfirmationBtn);
         _purchaseConfirmationBtn = null;
         _buyArray = null;
         ObjectUtils.disposeObject(_cartList);
         _cartList = null;
         ObjectUtils.disposeObject(_cartScroll);
         _cartScroll = null;
         ObjectUtils.disposeObject(_frame);
         _frame = null;
         ObjectUtils.disposeObject(_bg);
         _innerBg1 = null;
         ObjectUtils.disposeObject(_innerBg1);
         _innerBg = null;
         ObjectUtils.disposeObject(_extraTextButton);
         _extraTextButton = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
