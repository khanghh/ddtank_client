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
         var prices:Array = ShopBuyManager.calcPrices(_buyArray);
         _commodityNumberTip.htmlText = LanguageMgr.GetTranslation("shop.CheckOutView.CommodityNumberTip",_buyArray.length);
         _commodityPricesText1.text = String(prices[1]);
         _commodityPricesText3.text = String(prices[2]);
         _commodityPricesText2.text = String(prices[2]);
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
      
      private function __onResponse(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.playButtonSound();
               dispose();
         }
      }
      
      private function __buyAvatar(event:MouseEvent) : void
      {
         var i:int = 0;
         var t:* = null;
         var j:int = 0;
         SoundManager.instance.play("008");
         var money:int = _commodityPricesText1.text;
         var bandMoney:int = _commodityPricesText2.text;
         var orderMoney:int = _commodityPricesText3.text;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(bandMoney > PlayerManager.Instance.Self.BandMoney)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.lijinbuzu"));
            return;
         }
         if(money > PlayerManager.Instance.Self.Money)
         {
            LeavePageManager.showFillFrame();
            return;
         }
         if(orderMoney > PlayerManager.Instance.Self.DDTMoney)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.madelLack"));
            return;
         }
         var buy:Array = [];
         var _loc21_:int = 0;
         var _loc20_:* = _buyArray;
         for each(var item in _buyArray)
         {
            buy.push(item);
         }
         var canbuy:Array = ShopManager.Instance.buyIt(buy);
         if(canbuy.length == 0)
         {
            var _loc23_:int = 0;
            var _loc22_:* = _buyArray;
            for each(var item1 in _buyArray)
            {
               if(item1.getCurrentPrice().bothMoneyValue > 0)
               {
                  LeavePageManager.showFillFrame();
                  return;
               }
            }
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.lackCoin"));
            return;
         }
         if(canbuy.length < _buyArray.length)
         {
         }
         var items:Array = [];
         var types:Array = [];
         var colors:Array = [];
         var dresses:Array = [];
         var places:Array = [];
         var skins:Array = [];
         for(i = 0; i < canbuy.length; )
         {
            t = canbuy[i];
            items.push(t.GoodsID);
            types.push(t.currentBuyType);
            colors.push(t.Color);
            places.push(t.place);
            if(t.CategoryID == 6)
            {
               skins.push(t.skin);
            }
            else
            {
               skins.push("");
            }
            dresses.push(dressing);
            i++;
         }
         SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,skins);
         var ch:Array = [];
         for(j = _cartList.numChildren - 1; j >= 0; )
         {
            ch.push(_cartList.getChildAt(j));
            j--;
         }
         var _loc25_:int = 0;
         var _loc24_:* = ch;
         for each(var item2 in ch)
         {
            if(canbuy.indexOf(item2.shopItemInfo) > -1)
            {
               item2.removeEventListener("deleteitem",__deleteItem);
               item2.removeEventListener("conditionchange",__conditionChange);
               _cartList.removeChild(item2);
               _buyArray.splice(_buyArray.indexOf(item2.shopItemInfo),1);
               item2.dispose();
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
      
      public function setGoods(value:Vector.<ShopCarItemInfo>) : void
      {
         var item:* = null;
         var cItem:* = null;
         while(_cartList.numChildren > 0)
         {
            item = _cartList.getChildAt(_cartList.numChildren - 1) as ShopCartItem;
            item.removeEventListener("deleteitem",__deleteItem);
            item.removeEventListener("conditionchange",__conditionChange);
            _cartList.removeChild(item);
            item.dispose();
         }
         _buyArray = value;
         var _loc6_:int = 0;
         var _loc5_:* = _buyArray;
         for each(var info in _buyArray)
         {
            cItem = new ShopCartItem();
            cItem.setShopItemInfo(info);
            cItem.setColor(info.Color);
            _cartList.addChild(cItem);
            cItem.addEventListener("deleteitem",__deleteItem);
            cItem.addEventListener("conditionchange",__conditionChange);
         }
         _cartScroll.invalidateViewport();
         updateTxt();
      }
      
      private function __conditionChange(evt:Event) : void
      {
         updateTxt();
      }
      
      private function __deleteItem(evt:Event) : void
      {
         var item:ShopCartItem = evt.currentTarget as ShopCartItem;
         var shopItemInfo:ShopCarItemInfo = item.shopItemInfo;
         item.removeEventListener("deleteitem",__deleteItem);
         item.removeEventListener("conditionchange",__conditionChange);
         _cartList.removeChild(item);
         var index:int = _buyArray.indexOf(shopItemInfo);
         _buyArray.splice(index,1);
         updateTxt();
         _cartScroll.invalidateViewport();
         if(_buyArray.length < 1)
         {
            dispose();
         }
      }
      
      public function dispose() : void
      {
         var item:* = null;
         removeEvents();
         while(_cartList.numChildren > 0)
         {
            item = _cartList.getChildAt(_cartList.numChildren - 1) as ShopCartItem;
            item.removeEventListener("deleteitem",__deleteItem);
            item.removeEventListener("conditionchange",__conditionChange);
            _cartList.removeChild(item);
            item.dispose();
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
