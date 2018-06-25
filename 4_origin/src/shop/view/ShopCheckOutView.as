package shop.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
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
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import shop.ShopController;
   import shop.ShopEvent;
   import shop.ShopModel;
   import shop.manager.ShopBuyManager;
   
   public class ShopCheckOutView extends Sprite implements Disposeable
   {
      
      public static const COUNT:uint = 3;
      
      public static const DDT_MONEY:uint = 1;
      
      public static const BAND_MONEY:uint = 2;
      
      public static const LACK:uint = 1;
      
      public static const MONEY:uint = 0;
      
      public static const PLAYER:uint = 0;
      
      public static const PRESENT:int = 2;
      
      public static const PURCHASE:int = 1;
      
      public static const SAVE:int = 3;
      
      public static const ASKTYPE:int = 4;
       
      
      protected var _commodityNumberText:FilterFrameText;
      
      protected var _commodityNumberTip:FilterFrameText;
      
      protected var _commodityPricesText1:FilterFrameText;
      
      protected var _commodityPricesText2:FilterFrameText;
      
      private var _commodityPricesText1Bg:Scale9CornerImage;
      
      private var _commodityPricesText2Bg:Scale9CornerImage;
      
      private var _commodityPricesText3Bg:Scale9CornerImage;
      
      protected var _commodityPricesText1Label:FilterFrameText;
      
      protected var _commodityPricesText2Label:FilterFrameText;
      
      protected var _needToPayTip:FilterFrameText;
      
      protected var _purchaseConfirmationBtn:BaseButton;
      
      protected var _giftsBtn:BaseButton;
      
      protected var _askBtn:SimpleBitmapButton;
      
      protected var _saveImageBtn:BaseButton;
      
      private var _buyArray:Array;
      
      protected var _cartList:VBox;
      
      private var _castList2:Sprite;
      
      private var _cartItemList:Vector.<ShopCartItem>;
      
      private var _cartScroll:ScrollPanel;
      
      protected var _controller:ShopController;
      
      protected var _frame:Frame;
      
      private var _giveArray:Array;
      
      protected var _innerBg1:Image;
      
      private var _innerBg:Image;
      
      protected var _model:ShopModel;
      
      protected var _tempList:Array;
      
      protected var _type:int;
      
      private var _isDisposed:Boolean;
      
      private var shopPresent:ShopPresentView;
      
      protected var _list:Array;
      
      private var _bandMoneyTotal:int;
      
      private var _MoneyTotal:int;
      
      private var _shopPresentClearingFrame:ShopPresentClearingFrame;
      
      private var _commodityPricesText3Label:FilterFrameText;
      
      private var _commodityPricesText3:FilterFrameText;
      
      private var _isAsk:Boolean;
      
      public function ShopCheckOutView()
      {
         _buyArray = [];
         _giveArray = [];
         super();
      }
      
      protected function drawFrame() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CheckOutViewFrame");
         _frame.titleText = LanguageMgr.GetTranslation("shop.Shop.car");
         addChild(_frame);
      }
      
      protected function drawItemCountField() : void
      {
         _innerBg1 = ComponentFactory.Instance.creatComponentByStylename("ddtshop.TotalMoneyPanel");
         _frame.addToContent(_innerBg1);
         _commodityNumberTip = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityNumberTipText");
         _frame.addToContent(_commodityNumberTip);
         _commodityNumberText = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityNumberText");
         _commodityNumberText.x = 247;
         _frame.addToContent(_commodityNumberText);
         _needToPayTip = ComponentFactory.Instance.creatComponentByStylename("ddtshop.NeedToPayTip");
         _needToPayTip.text = LanguageMgr.GetTranslation("shop.CheckOutView.NeedToPayTipText");
         _frame.addToContent(_needToPayTip);
         _commodityPricesText1 = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText1");
         _commodityPricesText2 = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText2");
         _commodityPricesText2.x = 115;
         _commodityPricesText3 = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CommodityPricesText3");
         _commodityPricesText3.x = 235;
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
      }
      
      protected function drawPayListField() : void
      {
         _innerBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CheckOutViewBg");
         _frame.addToContent(_innerBg);
      }
      
      protected function init() : void
      {
         _cartList = new VBox();
         _castList2 = new Sprite();
         drawFrame();
         _purchaseConfirmationBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.PurchaseBtn");
         _purchaseConfirmationBtn.visible = false;
         _askBtn = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.askButton");
         _askBtn.visible = false;
         _giftsBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GiftsBtn");
         _giftsBtn.visible = false;
         _saveImageBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.SaveImageBtn");
         _saveImageBtn.visible = false;
         _cartScroll = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CheckOutViewItemList");
         _cartScroll.setView(_castList2);
         _cartScroll.vScrollProxy = 0;
         _cartList.spacing = 5;
         _cartList.strictSize = 80;
         _cartList.isReverAdd = true;
         drawItemCountField();
         drawPayListField();
         _frame.addToContent(_cartScroll);
         _frame.addToContent(_askBtn);
         _frame.addToContent(_purchaseConfirmationBtn);
         _frame.addToContent(_giftsBtn);
         _frame.addToContent(_saveImageBtn);
         setList(_tempList,0,true);
         updateTxt();
         if(_type == 3)
         {
            _saveImageBtn.visible = true;
         }
         else if(_type == 1)
         {
            _purchaseConfirmationBtn.visible = true;
         }
         else if(_type == 2)
         {
            _giftsBtn.visible = true;
         }
         else if(_type == 4)
         {
            _askBtn.visible = true;
         }
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
      
      protected function initEvent() : void
      {
         _frame.addEventListener("response",__frameEventHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(44),onBuyedGoods);
         SocketManager.Instance.addEventListener(PkgEvent.format(57),onPresent);
         _purchaseConfirmationBtn.addEventListener("click",__purchaseConfirmationBtnClick);
         _saveImageBtn.addEventListener("click",__purchaseConfirmationBtnClick);
         _giftsBtn.addEventListener("click",__purchaseConfirmationBtnClick);
         _askBtn.addEventListener("click",__purchaseConfirmationBtnClick);
      }
      
      protected function __purchaseConfirmationBtnClick(event:MouseEvent = null) : void
      {
         SoundManager.instance.play("008");
         var money:int = _commodityPricesText1.text;
         var bandMoney:int = _commodityPricesText2.text;
         var orderMoney:int = _commodityPricesText3.text;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_type == 4)
         {
            sendAsk();
         }
         else if(_type == 3)
         {
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
            saveFigureCheckOut();
         }
         else if(_type == 1)
         {
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
            shopCarCheckOut();
         }
         else if(_type == 2)
         {
            if(money > PlayerManager.Instance.Self.Money)
            {
               LeavePageManager.showFillFrame();
               dispose();
               return;
            }
            presentCheckOut();
         }
      }
      
      private function sendAsk() : void
      {
         _isAsk = true;
         if(_shopPresentClearingFrame)
         {
            _shopPresentClearingFrame.dispose();
            _shopPresentClearingFrame = null;
         }
         var askArray:Array = _model.allItems;
         if(askArray.length > 0)
         {
            _shopPresentClearingFrame = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.ShopPresentClearingFrame");
            _shopPresentClearingFrame.show();
            _shopPresentClearingFrame.setType(2);
            _shopPresentClearingFrame.presentBtn.addEventListener("click",__presentBtnClick);
            _shopPresentClearingFrame.addEventListener("response",__shopPresentClearingFrameResponseHandler);
            this.visible = false;
         }
         else
         {
            LeavePageManager.showFillFrame();
         }
      }
      
      private function seleBand(id:int, num:int, bool:Boolean) : void
      {
         _model.isBandList[id] = bool;
         updateTxt();
      }
      
      protected function addItemEvent(item:ShopCartItem) : void
      {
         item.addEventListener("deleteitem",__deleteItem);
         item.addEventListener("add_length",addLength);
         item.addEventListener("conditionchange",__conditionChange);
      }
      
      protected function addLength(event:Event) : void
      {
         var items:ShopCartItem = event.currentTarget as ShopCartItem;
         ShopBuyManager.crrItemId = items.id;
         setList(_tempList,items.id);
      }
      
      protected function removeItemEvent(item:ShopCartItem) : void
      {
         item.removeEventListener("deleteitem",__deleteItem);
         item.removeEventListener("conditionchange",__conditionChange);
      }
      
      public function setList(arr:Array, id:int = 0, isfst:Boolean = false) : void
      {
         var i:int = 0;
         var cItem:* = null;
         clearList();
         _cartItemList = new Vector.<ShopCartItem>();
         _list = arr;
         if(isfst)
         {
            _model.isBandList = [];
         }
         var len:int = arr.length;
         for(i = 0; i < len; )
         {
            cItem = createShopItem();
            cItem.id = i;
            if(_type == 2 || _type == 4)
            {
               cItem.setShopItemInfo(arr[i]);
               cItem.type = 2;
            }
            else if(ShopBuyManager.crrItemId != 0)
            {
               cItem.setShopItemInfo(arr[i],ShopBuyManager.crrItemId,_model.isBandList[i]);
            }
            else
            {
               cItem.setShopItemInfo(arr[i],id,_model.isBandList[i]);
            }
            cItem.seleBand = seleBand;
            cItem.upDataBtnState = upDataBtnState;
            cItem.setColor(arr[i].Color);
            _castList2.addChild(cItem);
            if(isfst)
            {
               _model.isBandList.push(cItem.isBand);
            }
            else
            {
               cItem.setDianquanType(_model.isBandList[i]);
            }
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
         _model.dispatchEvent(new ShopEvent("costChange"));
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
      
      protected function createShopItem() : ShopCartItem
      {
         return new ShopCartItem();
      }
      
      public function setup(controller:ShopController, model:ShopModel, list:Array, type:int) : void
      {
         _controller = controller;
         _model = model;
         _tempList = list;
         _type = type;
         _isDisposed = false;
         this.visible = true;
         init();
         initEvent();
      }
      
      private function __conditionChange(evt:Event) : void
      {
         updateTxt();
      }
      
      private function upDataListInfo(id:int) : void
      {
         var i:int = 0;
         var len:int = _cartItemList.length;
         for(i = 0; i < len; )
         {
            if(id == _cartItemList[i].id)
            {
               _cartItemList.splice(i,1);
               _tempList.splice(i,1);
               if(id == ShopBuyManager.crrItemId)
               {
                  ShopBuyManager.crrItemId = 0;
                  if(_cartItemList.length > 0 && _type != 2)
                  {
                     _cartItemList[0].addItem(_model.isBandList[0]);
                  }
               }
               break;
            }
            i++;
         }
      }
      
      private function __deleteItem(evt:Event) : void
      {
         var item:ShopCartItem = evt.currentTarget as ShopCartItem;
         var shopItemInfo:ShopCarItemInfo = item.shopItemInfo;
         item.removeEventListener("deleteitem",__deleteItem);
         item.removeEventListener("conditionchange",__conditionChange);
         _model.isBandList.splice(item.id,1);
         _castList2.removeChild(item);
         if(ShopBuyManager.crrItemId > item.id)
         {
            ShopBuyManager.crrItemId--;
         }
         item.dispose();
         if(_type == 3)
         {
            _controller.removeTempEquip(shopItemInfo);
            updateTxt();
            updateList();
            _cartScroll.invalidateViewport();
            if(_model.currentTempList.length == 0)
            {
               dispose();
            }
         }
         if(_type == 1 || _type == 4)
         {
            _controller.removeFromCar(shopItemInfo);
            upDataListInfo(item.id);
            updateTxt();
            updateList();
            _cartScroll.invalidateViewport();
            if(_model.allItems.length == 0)
            {
               dispose();
            }
         }
         if(_type == 2)
         {
            _controller.removeFromCar(shopItemInfo);
            upDataListInfo(item.id);
            updateTxt();
            updateList();
            _cartScroll.invalidateViewport();
            if(_tempList.length == 0)
            {
               dispose();
            }
         }
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
      
      public function get extraButton() : BaseButton
      {
         return null;
      }
      
      protected function removeEvent() : void
      {
         _frame.removeEventListener("response",__frameEventHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(44),onBuyedGoods);
         SocketManager.Instance.removeEventListener(PkgEvent.format(57),onPresent);
         _purchaseConfirmationBtn.removeEventListener("click",__purchaseConfirmationBtnClick);
         _saveImageBtn.removeEventListener("click",__purchaseConfirmationBtnClick);
         _giftsBtn.removeEventListener("click",__purchaseConfirmationBtnClick);
      }
      
      private function __dispatchFrameEvent(e:MouseEvent) : void
      {
         _frame.dispatchEvent(new FrameEvent(3));
      }
      
      private function isMoneyGoods(item:*, index:int, array:Array) : Boolean
      {
         if(item is ShopItemInfo)
         {
            return ShopItemInfo(item).getItemPrice(1).IsBothMoneyType;
         }
         return false;
      }
      
      private function notPresentGoods() : Array
      {
         var notPresent:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _tempList;
         for each(var item in _tempList)
         {
            if(_giveArray.indexOf(item) == -1)
            {
               notPresent.push(item);
            }
         }
         return notPresent;
      }
      
      private function onBuyedGoods(event:PkgEvent) : void
      {
         var j:int = 0;
         event.pkg.position = 20;
         var success:int = event.pkg.readInt();
         var isDispose:Boolean = false;
         if(success != 0)
         {
            if(_type == 3)
            {
               _model.clearCurrentTempList(!!_model.fittingSex?1:2);
            }
            else if(_type == 1)
            {
               _model.clearAllitems();
            }
         }
         else if(_type == 3)
         {
            _model.clearCurrentTempList(!!_model.fittingSex?1:2);
            var _loc7_:int = 0;
            var _loc6_:* = _model.currentLeftList;
            for each(var item in _model.currentLeftList)
            {
               _model.addTempEquip(item);
            }
            setList(_model.currentTempList);
            if(_model.currentTempList.length < 1)
            {
               isDispose = true;
            }
         }
         else if(_type == 1)
         {
            for(j = 0; j < _buyArray.length; )
            {
               _model.removeFromShoppingCar(_buyArray[j] as ShopCarItemInfo);
               j++;
            }
            setList(_model.allItems);
            if(_model.allItems.length < 1)
            {
               isDispose = true;
            }
         }
         if(success != 0)
         {
            dispose();
         }
         else if(isDispose)
         {
            dispose();
         }
      }
      
      private function onPresent(event:PkgEvent) : void
      {
         var k:int = 0;
         _shopPresentClearingFrame.presentBtn.enable = true;
         _shopPresentClearingFrame.dispose();
         _shopPresentClearingFrame = null;
         this.visible = true;
         var boo:Boolean = event.pkg.readBoolean();
         for(k = 0; k < _giveArray.length; )
         {
            _model.removeFromShoppingCar(_giveArray[k] as ShopCarItemInfo);
            _tempList.splice(_tempList.indexOf(_giveArray[k] as ShopCarItemInfo),1);
            k++;
         }
         if(_tempList.length == 0)
         {
            dispose();
            return;
         }
         if(_tempList.length > 0)
         {
            setList(notPresentGoods());
            return;
         }
      }
      
      private function presentCheckOut() : void
      {
         _isAsk = false;
         if(_shopPresentClearingFrame)
         {
            _shopPresentClearingFrame.dispose();
            _shopPresentClearingFrame = null;
         }
         _giveArray = ShopManager.Instance.giveGift(_model.allItems,_model.Self);
         if(_giveArray.length > 0)
         {
            _shopPresentClearingFrame = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.ShopPresentClearingFrame");
            _shopPresentClearingFrame.show();
            _shopPresentClearingFrame.presentBtn.addEventListener("click",__presentBtnClick);
            _shopPresentClearingFrame.addEventListener("response",__shopPresentClearingFrameResponseHandler);
            this.visible = false;
         }
         else
         {
            LeavePageManager.showFillFrame();
         }
      }
      
      private function __shopPresentClearingFrameResponseHandler(event:FrameEvent) : void
      {
         _shopPresentClearingFrame.removeEventListener("response",__shopPresentClearingFrameResponseHandler);
         if(event.responseCode == 0 || event.responseCode == 1 || event.responseCode == 4)
         {
            StageReferance.stage.focus = _frame;
            this.visible = true;
         }
      }
      
      protected function __presentBtnClick(event:MouseEvent) : void
      {
         var len:int = 0;
         var goodsIDs:* = null;
         var types:* = null;
         var goodsTypes:* = null;
         var colors:* = null;
         var skins:* = null;
         var i:int = 0;
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
         if(_isAsk)
         {
            _shopPresentClearingFrame.presentBtn.removeEventListener("click",__presentBtnClick);
            _shopPresentClearingFrame.removeEventListener("response",__shopPresentClearingFrameResponseHandler);
            len = _cartItemList.length;
            goodsIDs = [];
            types = [];
            goodsTypes = [];
            colors = [];
            skins = [];
            for(i = 0; i < len; )
            {
               goodsIDs.push(_cartItemList[i].shopItemInfo.GoodsID);
               types.push(_cartItemList[i].shopItemInfo.currentBuyType);
               goodsTypes.push(_cartItemList[i].shopItemInfo.isDiscount);
               colors.push(_cartItemList[i].shopItemInfo.Color);
               skins.push(_cartItemList[i].shopItemInfo.skin);
               i++;
            }
            SocketManager.Instance.out.requestShopPay(goodsIDs,types,goodsTypes,colors,skins,_shopPresentClearingFrame.Name);
         }
         else
         {
            _shopPresentClearingFrame.presentBtn.enable = false;
            _controller.presentItems(_tempList,_shopPresentClearingFrame.textArea.text,_shopPresentClearingFrame.nameInput.text);
         }
         _shopPresentClearingFrame.dispose();
         _shopPresentClearingFrame = null;
         dispose();
      }
      
      private function saveFigureCheckOut() : void
      {
         _buyArray = ShopManager.Instance.buyIt(_model.currentTempList);
         _controller.buyItems(_model.currentTempList,true,_model.currentModel.Skin,_model.isBandList);
      }
      
      private function shopCarCheckOut() : void
      {
         _buyArray = ShopManager.Instance.buyIt(_model.allItems);
         _controller.buyItems(_model.allItems,false,"",_model.isBandList);
      }
      
      protected function updateTxt() : void
      {
         var tempArray:Array = _type == 3?_model.currentTempList:_model.allItems;
         if(_type == 2)
         {
            tempArray = _tempList;
         }
         var prices:Array = _model.calcPrices(tempArray,_model.isBandList);
         var _loc3_:* = LanguageMgr.GetTranslation("shop.CheckOutView.CommodityNumberTip",tempArray.length);
         _commodityNumberTip.htmlText = _loc3_;
         _commodityNumberTip.htmlText = _loc3_;
         _commodityPricesText1.text = String(prices[0 + 1]);
         _commodityPricesText2.text = String(prices[2 + 1]);
         _commodityPricesText3.text = String(prices[1 + 1]);
      }
      
      public function dispose() : void
      {
         var item:* = null;
         if(_shopPresentClearingFrame)
         {
            if(_shopPresentClearingFrame.presentBtn)
            {
               _shopPresentClearingFrame.presentBtn.removeEventListener("click",__presentBtnClick);
            }
            _shopPresentClearingFrame.removeEventListener("response",__shopPresentClearingFrameResponseHandler);
            _shopPresentClearingFrame.dispose();
            _shopPresentClearingFrame = null;
         }
         _model.isBandList = [];
         if(!_isDisposed)
         {
            removeEvent();
            ObjectUtils.disposeAllChildren(this);
            while(_cartList.numChildren > 0)
            {
               item = _cartList.getChildAt(_cartList.numChildren - 1) as ShopCartItem;
               removeItemEvent(item);
               _cartList.removeChild(item);
               item.dispose();
               item = null;
            }
            ObjectUtils.disposeObject(_needToPayTip);
            _needToPayTip = null;
            _buyArray = null;
            _cartList = null;
            _cartScroll = null;
            _controller = null;
            _giveArray = null;
            _innerBg = null;
            _frame = null;
            shopPresent = null;
            _commodityNumberText = null;
            _commodityPricesText1 = null;
            _commodityNumberTip = null;
            _commodityPricesText2 = null;
            _commodityPricesText3 = null;
            _commodityPricesText1Bg = null;
            _commodityPricesText2Bg = null;
            _commodityPricesText3Bg = null;
            _commodityPricesText1Label = null;
            _commodityPricesText2Label = null;
            _commodityPricesText3Label = null;
            _purchaseConfirmationBtn = null;
            _giftsBtn = null;
            _saveImageBtn = null;
            _innerBg1 = null;
            _innerBg = null;
            _model = null;
            if(parent)
            {
               parent.removeChild(this);
            }
            _isDisposed = true;
         }
      }
   }
}
