package ddt.command
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import shop.manager.ShopBuyManager;
   import shop.view.ShopCartItem;
   
   public class GeneralCheckoutView extends Sprite implements Disposeable
   {
       
      
      protected var _frame:Frame;
      
      protected var _cartList:VBox;
      
      private var _castList2:Sprite;
      
      protected var _purchaseConfirmationBtn:BaseButton;
      
      private var _cartScroll:ScrollPanel;
      
      protected var _innerBg1:Image;
      
      protected var _needToPayTip:FilterFrameText;
      
      protected var _commodityNumberText:FilterFrameText;
      
      protected var _commodityNumberTip:FilterFrameText;
      
      protected var _commodityPricesText1:FilterFrameText;
      
      protected var _commodityPricesText2:FilterFrameText;
      
      protected var _commodityPricesText3:FilterFrameText;
      
      protected var _commodityPricesText1Label:FilterFrameText;
      
      protected var _commodityPricesText2Label:FilterFrameText;
      
      protected var _commodityPricesText3Label:FilterFrameText;
      
      private var _commodityPricesText1Bg:Scale9CornerImage;
      
      private var _commodityPricesText2Bg:Scale9CornerImage;
      
      private var _commodityPricesText3Bg:Scale9CornerImage;
      
      private var _innerBg:Image;
      
      protected var _cartItemList:Vector.<ShopCartItem>;
      
      protected var _infoArr:Array;
      
      protected var _isBandList:Array;
      
      public function GeneralCheckoutView()
      {
         _infoArr = [];
         _isBandList = [];
         super();
         initView();
         addEvents();
      }
      
      private function initView() : void
      {
         _cartList = new VBox();
         _castList2 = new Sprite();
         _frame = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CheckOutViewFrame");
         _frame.titleText = LanguageMgr.GetTranslation("shop.Shop.car");
         addChild(_frame);
         _purchaseConfirmationBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.PurchaseBtn");
         _frame.addToContent(_purchaseConfirmationBtn);
         _cartScroll = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CheckOutViewItemList");
         _cartScroll.setView(_castList2);
         _cartScroll.vScrollProxy = 0;
         _cartList.spacing = 5;
         _cartList.strictSize = 80;
         _cartList.isReverAdd = true;
         _innerBg1 = ComponentFactory.Instance.creatComponentByStylename("ddtshop.TotalMoneyPanel");
         _frame.addToContent(_innerBg1);
         _commodityNumberTip = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityNumberTipText");
         _commodityNumberTip.text = LanguageMgr.GetTranslation("shop.CheckOutView.CommodityNumberTip");
         _frame.addToContent(_commodityNumberTip);
         _commodityNumberText = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityNumberText");
         _frame.addToContent(_commodityNumberText);
         _needToPayTip = ComponentFactory.Instance.creatComponentByStylename("ddtshop.NeedToPayTip");
         _needToPayTip.text = LanguageMgr.GetTranslation("shop.CheckOutView.NeedToPayTipText");
         _frame.addToContent(_needToPayTip);
         _commodityPricesText1 = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText1");
         _commodityPricesText2 = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText2");
         _commodityPricesText3 = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText3");
         _commodityPricesText3.text = "0";
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
         _innerBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CheckOutViewBg");
         _frame.addToContent(_innerBg);
         _frame.addToContent(_cartScroll);
      }
      
      private function addEvents() : void
      {
         _frame.addEventListener("response",__frameEventHandler);
         _purchaseConfirmationBtn.addEventListener("click",__purchaseConfirmationBtnClick);
      }
      
      public function initList(arr:Array) : void
      {
         var i:int = 0;
         _infoArr = arr;
         for(i = 0; i <= _infoArr.length - 1; )
         {
            _isBandList.push(false);
            i++;
         }
         update();
      }
      
      private function update() : void
      {
         var i:int = 0;
         var cItem:* = null;
         clearList();
         _cartItemList = new Vector.<ShopCartItem>();
         for(i = 0; i <= _infoArr.length - 1; )
         {
            cItem = new ShopCartItem();
            cItem.id = i;
            cItem.setShopItemInfo(_infoArr[i],ShopBuyManager.crrItemId,_isBandList[i]);
            cItem.seleBand = seleBand;
            cItem.upDataBtnState = upDataBtnState;
            cItem.setColor(_infoArr[i].Color);
            _castList2.addChild(cItem);
            _cartItemList.push(cItem);
            addItemEvent(cItem);
            i++;
         }
         updateList();
         _cartScroll.invalidateViewport();
         updateTxt();
      }
      
      private function upDataBtnState() : void
      {
      }
      
      private function seleBand(id:int, num:int, bool:Boolean) : void
      {
         _isBandList[id] = bool;
         update();
      }
      
      private function updateList() : void
      {
         var i:int = 0;
         var len:int = _cartItemList.length;
         for(i = 0; i < len; )
         {
            _cartItemList[i].id = i;
            if(i > 0)
            {
               _cartItemList[i].y = _cartItemList[i - 1].y + _cartItemList[i - 1].height;
            }
            else
            {
               _cartItemList[i].y = 0;
            }
            i++;
         }
      }
      
      protected function updateTxt() : void
      {
         var i:int = 0;
         var item:* = null;
         _commodityNumberText.text = String(_infoArr.length);
         var money:int = 0;
         var bindMoney:int = 0;
         for(i = 0; i <= _cartItemList.length - 1; )
         {
            item = _cartItemList[i] as ShopCartItem;
            if(_isBandList[i])
            {
               bindMoney = bindMoney + item.shopItemInfo.getCurrentPrice().bothMoneyValue;
            }
            else
            {
               money = money + item.shopItemInfo.getCurrentPrice().bothMoneyValue;
            }
            i++;
         }
         _commodityPricesText1.text = String(money);
         _commodityPricesText2.text = String(bindMoney);
         _commodityPricesText3.text = "0";
      }
      
      protected function addItemEvent(item:ShopCartItem) : void
      {
         item.addEventListener("deleteitem",__deleteItem);
         item.addEventListener("add_length",addLength);
         item.addEventListener("conditionchange",__conditionChange);
      }
      
      private function clearList() : void
      {
         var item:* = null;
         while(_castList2.numChildren > 0)
         {
            item = _castList2.getChildAt(_castList2.numChildren - 1) as ShopCartItem;
            removeItemEvent(item);
            _castList2.removeChild(item);
            item.dispose();
            item = null;
         }
      }
      
      protected function addLength(event:Event) : void
      {
         var items:ShopCartItem = event.currentTarget as ShopCartItem;
         ShopBuyManager.crrItemId = items.id;
         update();
      }
      
      private function __conditionChange(evt:Event) : void
      {
         updateTxt();
      }
      
      private function __deleteItem(evt:Event) : void
      {
         var item:ShopCartItem = evt.currentTarget as ShopCartItem;
         var info:ShopItemInfo = item.shopItemInfo;
         item.removeEventListener("deleteitem",__deleteItem);
         item.removeEventListener("conditionchange",__conditionChange);
         _castList2.removeChild(item);
         if(ShopBuyManager.crrItemId > item.id)
         {
            ShopBuyManager.crrItemId--;
         }
         item.dispose();
         deleteInfo(item.id);
         updateTxt();
         updateList();
         _cartScroll.invalidateViewport();
         if(_castList2.numChildren == 0)
         {
            dispose();
         }
      }
      
      private function deleteInfo(id:int) : void
      {
         var i:int = 0;
         var len:int = _cartItemList.length;
         for(i = 0; i < len; )
         {
            if(id == _cartItemList[i].id)
            {
               _cartItemList.splice(i,1);
               _infoArr.splice(i,1);
               _isBandList.splice(i,1);
               if(id == ShopBuyManager.crrItemId)
               {
                  ShopBuyManager.crrItemId = 0;
                  if(_cartItemList.length > 0)
                  {
                     _cartItemList[0].addItem(_isBandList[0]);
                  }
               }
               break;
            }
            i++;
         }
      }
      
      protected function removeItemEvent(item:ShopCartItem) : void
      {
         item.removeEventListener("deleteitem",__deleteItem);
         item.removeEventListener("add_length",addLength);
         item.removeEventListener("conditionchange",__conditionChange);
      }
      
      private function __frameEventHandler(evt:FrameEvent) : void
      {
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               dispose();
         }
      }
      
      protected function __purchaseConfirmationBtnClick(event:MouseEvent = null) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function removeEvents() : void
      {
         _frame.removeEventListener("response",__frameEventHandler);
         _purchaseConfirmationBtn.removeEventListener("click",__purchaseConfirmationBtnClick);
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_cartList);
         _cartList = null;
         ObjectUtils.disposeObject(_castList2);
         _castList2 = null;
         ObjectUtils.disposeObject(_purchaseConfirmationBtn);
         _purchaseConfirmationBtn = null;
         ObjectUtils.disposeObject(_cartScroll);
         _cartScroll = null;
         ObjectUtils.disposeObject(_innerBg1);
         _innerBg1 = null;
         ObjectUtils.disposeObject(_needToPayTip);
         _needToPayTip = null;
         ObjectUtils.disposeObject(_commodityNumberText);
         _commodityNumberText = null;
         ObjectUtils.disposeObject(_commodityNumberTip);
         _commodityNumberTip = null;
         ObjectUtils.disposeObject(_commodityPricesText1);
         _commodityPricesText1 = null;
         ObjectUtils.disposeObject(_commodityPricesText2);
         _commodityPricesText2 = null;
         ObjectUtils.disposeObject(_commodityPricesText3);
         _commodityPricesText3 = null;
         ObjectUtils.disposeObject(_commodityPricesText1Label);
         _commodityPricesText1Label = null;
         ObjectUtils.disposeObject(_commodityPricesText2Label);
         _commodityPricesText2Label = null;
         ObjectUtils.disposeObject(_commodityPricesText3Label);
         _commodityPricesText3Label = null;
         ObjectUtils.disposeObject(_commodityPricesText1Bg);
         _commodityPricesText1Bg = null;
         ObjectUtils.disposeObject(_commodityPricesText2Bg);
         _commodityPricesText2Bg = null;
         ObjectUtils.disposeObject(_commodityPricesText3Bg);
         _commodityPricesText3Bg = null;
         ObjectUtils.disposeObject(_innerBg);
         _innerBg = null;
         ObjectUtils.disposeObject(_frame);
         _frame = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
