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
         var _loc1_:* = null;
         while(_castList2.numChildren > 0)
         {
            _loc1_ = _castList2.getChildAt(_castList2.numChildren - 1) as ShopCartItem;
            removeItemEvent(_loc1_);
            _castList2.removeChild(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
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
      
      protected function __purchaseConfirmationBtnClick(param1:MouseEvent = null) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:int = _commodityPricesText1.text;
         var _loc4_:int = _commodityPricesText2.text;
         var _loc3_:int = _commodityPricesText3.text;
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
            if(_loc4_ > PlayerManager.Instance.Self.BandMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.lijinbuzu"));
               return;
            }
            if(_loc2_ > PlayerManager.Instance.Self.Money)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if(_loc3_ > PlayerManager.Instance.Self.DDTMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.madelLack"));
               return;
            }
            saveFigureCheckOut();
         }
         else if(_type == 1)
         {
            if(_loc4_ > PlayerManager.Instance.Self.BandMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.lijinbuzu"));
               return;
            }
            if(_loc2_ > PlayerManager.Instance.Self.Money)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if(_loc3_ > PlayerManager.Instance.Self.DDTMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.madelLack"));
               return;
            }
            shopCarCheckOut();
         }
         else if(_type == 2)
         {
            if(_loc2_ > PlayerManager.Instance.Self.Money)
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
         var _loc1_:Array = _model.allItems;
         if(_loc1_.length > 0)
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
      
      private function seleBand(param1:int, param2:int, param3:Boolean) : void
      {
         _model.isBandList[param1] = param3;
         updateTxt();
      }
      
      protected function addItemEvent(param1:ShopCartItem) : void
      {
         param1.addEventListener("deleteitem",__deleteItem);
         param1.addEventListener("add_length",addLength);
         param1.addEventListener("conditionchange",__conditionChange);
      }
      
      protected function addLength(param1:Event) : void
      {
         var _loc2_:ShopCartItem = param1.currentTarget as ShopCartItem;
         ShopBuyManager.crrItemId = _loc2_.id;
         setList(_tempList,_loc2_.id);
      }
      
      protected function removeItemEvent(param1:ShopCartItem) : void
      {
         param1.removeEventListener("deleteitem",__deleteItem);
         param1.removeEventListener("conditionchange",__conditionChange);
      }
      
      public function setList(param1:Array, param2:int = 0, param3:Boolean = false) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         clearList();
         _cartItemList = new Vector.<ShopCartItem>();
         _list = param1;
         if(param3)
         {
            _model.isBandList = [];
         }
         var _loc5_:int = param1.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = createShopItem();
            _loc4_.id = _loc6_;
            if(_type == 2 || _type == 4)
            {
               _loc4_.setShopItemInfo(param1[_loc6_]);
               _loc4_.type = 2;
            }
            else if(ShopBuyManager.crrItemId != 0)
            {
               _loc4_.setShopItemInfo(param1[_loc6_],ShopBuyManager.crrItemId,_model.isBandList[_loc6_]);
            }
            else
            {
               _loc4_.setShopItemInfo(param1[_loc6_],param2,_model.isBandList[_loc6_]);
            }
            _loc4_.seleBand = seleBand;
            _loc4_.upDataBtnState = upDataBtnState;
            _loc4_.setColor(param1[_loc6_].Color);
            _castList2.addChild(_loc4_);
            if(param3)
            {
               _model.isBandList.push(_loc4_.isBand);
            }
            else
            {
               _loc4_.setDianquanType(_model.isBandList[_loc6_]);
            }
            _cartItemList.push(_loc4_);
            addItemEvent(_loc4_);
            _loc6_++;
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
         var _loc2_:int = 0;
         var _loc1_:int = _cartItemList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _cartItemList[_loc2_].id = _loc2_;
            if(_loc2_ > 0)
            {
               _cartItemList[_loc2_].y = _cartItemList[_loc2_ - 1].y + _cartItemList[_loc2_ - 1].height;
            }
            else
            {
               _cartItemList[_loc2_].y = 0;
            }
            _loc2_++;
         }
      }
      
      protected function createShopItem() : ShopCartItem
      {
         return new ShopCartItem();
      }
      
      public function setup(param1:ShopController, param2:ShopModel, param3:Array, param4:int) : void
      {
         _controller = param1;
         _model = param2;
         _tempList = param3;
         _type = param4;
         _isDisposed = false;
         this.visible = true;
         init();
         initEvent();
      }
      
      private function __conditionChange(param1:Event) : void
      {
         updateTxt();
      }
      
      private function upDataListInfo(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _cartItemList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1 == _cartItemList[_loc3_].id)
            {
               _cartItemList.splice(_loc3_,1);
               _tempList.splice(_loc3_,1);
               if(param1 == ShopBuyManager.crrItemId)
               {
                  ShopBuyManager.crrItemId = 0;
                  if(_cartItemList.length > 0 && _type != 2)
                  {
                     _cartItemList[0].addItem(_model.isBandList[0]);
                  }
               }
               break;
            }
            _loc3_++;
         }
      }
      
      private function __deleteItem(param1:Event) : void
      {
         var _loc2_:ShopCartItem = param1.currentTarget as ShopCartItem;
         var _loc3_:ShopCarItemInfo = _loc2_.shopItemInfo;
         _loc2_.removeEventListener("deleteitem",__deleteItem);
         _loc2_.removeEventListener("conditionchange",__conditionChange);
         _model.isBandList.splice(_loc2_.id,1);
         _castList2.removeChild(_loc2_);
         if(ShopBuyManager.crrItemId > _loc2_.id)
         {
            ShopBuyManager.crrItemId--;
         }
         _loc2_.dispose();
         if(_type == 3)
         {
            _controller.removeTempEquip(_loc3_);
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
            _controller.removeFromCar(_loc3_);
            upDataListInfo(_loc2_.id);
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
            _controller.removeFromCar(_loc3_);
            upDataListInfo(_loc2_.id);
            updateTxt();
            updateList();
            _cartScroll.invalidateViewport();
            if(_tempList.length == 0)
            {
               dispose();
            }
         }
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
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
      
      private function __dispatchFrameEvent(param1:MouseEvent) : void
      {
         _frame.dispatchEvent(new FrameEvent(3));
      }
      
      private function isMoneyGoods(param1:*, param2:int, param3:Array) : Boolean
      {
         if(param1 is ShopItemInfo)
         {
            return ShopItemInfo(param1).getItemPrice(1).IsBothMoneyType;
         }
         return false;
      }
      
      private function notPresentGoods() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _tempList;
         for each(var _loc2_ in _tempList)
         {
            if(_giveArray.indexOf(_loc2_) == -1)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      private function onBuyedGoods(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         param1.pkg.position = 20;
         var _loc5_:int = param1.pkg.readInt();
         var _loc4_:Boolean = false;
         if(_loc5_ != 0)
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
            for each(var _loc2_ in _model.currentLeftList)
            {
               _model.addTempEquip(_loc2_);
            }
            setList(_model.currentTempList);
            if(_model.currentTempList.length < 1)
            {
               _loc4_ = true;
            }
         }
         else if(_type == 1)
         {
            _loc3_ = 0;
            while(_loc3_ < _buyArray.length)
            {
               _model.removeFromShoppingCar(_buyArray[_loc3_] as ShopCarItemInfo);
               _loc3_++;
            }
            setList(_model.allItems);
            if(_model.allItems.length < 1)
            {
               _loc4_ = true;
            }
         }
         if(_loc5_ != 0)
         {
            dispose();
         }
         else if(_loc4_)
         {
            dispose();
         }
      }
      
      private function onPresent(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         _shopPresentClearingFrame.presentBtn.enable = true;
         _shopPresentClearingFrame.dispose();
         _shopPresentClearingFrame = null;
         this.visible = true;
         var _loc2_:Boolean = param1.pkg.readBoolean();
         _loc3_ = 0;
         while(_loc3_ < _giveArray.length)
         {
            _model.removeFromShoppingCar(_giveArray[_loc3_] as ShopCarItemInfo);
            _tempList.splice(_tempList.indexOf(_giveArray[_loc3_] as ShopCarItemInfo),1);
            _loc3_++;
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
      
      private function __shopPresentClearingFrameResponseHandler(param1:FrameEvent) : void
      {
         _shopPresentClearingFrame.removeEventListener("response",__shopPresentClearingFrameResponseHandler);
         if(param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 4)
         {
            StageReferance.stage.focus = _frame;
            this.visible = true;
         }
      }
      
      protected function __presentBtnClick(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc7_:* = null;
         var _loc8_:int = 0;
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
            _loc5_ = _cartItemList.length;
            _loc4_ = [];
            _loc6_ = [];
            _loc3_ = [];
            _loc2_ = [];
            _loc7_ = [];
            _loc8_ = 0;
            while(_loc8_ < _loc5_)
            {
               _loc4_.push(_cartItemList[_loc8_].shopItemInfo.GoodsID);
               _loc6_.push(_cartItemList[_loc8_].shopItemInfo.currentBuyType);
               _loc3_.push(_cartItemList[_loc8_].shopItemInfo.isDiscount);
               _loc2_.push(_cartItemList[_loc8_].shopItemInfo.Color);
               _loc7_.push(_cartItemList[_loc8_].shopItemInfo.skin);
               _loc8_++;
            }
            SocketManager.Instance.out.requestShopPay(_loc4_,_loc6_,_loc3_,_loc2_,_loc7_,_shopPresentClearingFrame.Name);
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
         var _loc1_:Array = _type == 3?_model.currentTempList:_model.allItems;
         if(_type == 2)
         {
            _loc1_ = _tempList;
         }
         var _loc2_:Array = _model.calcPrices(_loc1_,_model.isBandList);
         var _loc3_:* = LanguageMgr.GetTranslation("shop.CheckOutView.CommodityNumberTip",_loc1_.length);
         _commodityNumberTip.htmlText = _loc3_;
         _commodityNumberTip.htmlText = _loc3_;
         _commodityPricesText1.text = String(_loc2_[0 + 1]);
         _commodityPricesText2.text = String(_loc2_[2 + 1]);
         _commodityPricesText3.text = String(_loc2_[1 + 1]);
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
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
               _loc1_ = _cartList.getChildAt(_cartList.numChildren - 1) as ShopCartItem;
               removeItemEvent(_loc1_);
               _cartList.removeChild(_loc1_);
               _loc1_.dispose();
               _loc1_ = null;
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
