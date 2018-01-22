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
      
      public function initList(param1:Array) : void
      {
         var _loc2_:int = 0;
         _infoArr = param1;
         _loc2_ = 0;
         while(_loc2_ <= _infoArr.length - 1)
         {
            _isBandList.push(false);
            _loc2_++;
         }
         update();
      }
      
      private function update() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         clearList();
         _cartItemList = new Vector.<ShopCartItem>();
         _loc2_ = 0;
         while(_loc2_ <= _infoArr.length - 1)
         {
            _loc1_ = new ShopCartItem();
            _loc1_.id = _loc2_;
            _loc1_.setShopItemInfo(_infoArr[_loc2_],ShopBuyManager.crrItemId,_isBandList[_loc2_]);
            _loc1_.seleBand = seleBand;
            _loc1_.upDataBtnState = upDataBtnState;
            _loc1_.setColor(_infoArr[_loc2_].Color);
            _castList2.addChild(_loc1_);
            _cartItemList.push(_loc1_);
            addItemEvent(_loc1_);
            _loc2_++;
         }
         updateList();
         _cartScroll.invalidateViewport();
         updateTxt();
      }
      
      private function upDataBtnState() : void
      {
      }
      
      private function seleBand(param1:int, param2:int, param3:Boolean) : void
      {
         _isBandList[param1] = param3;
         update();
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
      
      protected function updateTxt() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         _commodityNumberText.text = String(_infoArr.length);
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ <= _cartItemList.length - 1)
         {
            _loc1_ = _cartItemList[_loc4_] as ShopCartItem;
            if(_isBandList[_loc4_])
            {
               _loc3_ = _loc3_ + _loc1_.shopItemInfo.getCurrentPrice().bothMoneyValue;
            }
            else
            {
               _loc2_ = _loc2_ + _loc1_.shopItemInfo.getCurrentPrice().bothMoneyValue;
            }
            _loc4_++;
         }
         _commodityPricesText1.text = String(_loc2_);
         _commodityPricesText2.text = String(_loc3_);
         _commodityPricesText3.text = "0";
      }
      
      protected function addItemEvent(param1:ShopCartItem) : void
      {
         param1.addEventListener("deleteitem",__deleteItem);
         param1.addEventListener("add_length",addLength);
         param1.addEventListener("conditionchange",__conditionChange);
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
      
      protected function addLength(param1:Event) : void
      {
         var _loc2_:ShopCartItem = param1.currentTarget as ShopCartItem;
         ShopBuyManager.crrItemId = _loc2_.id;
         update();
      }
      
      private function __conditionChange(param1:Event) : void
      {
         updateTxt();
      }
      
      private function __deleteItem(param1:Event) : void
      {
         var _loc2_:ShopCartItem = param1.currentTarget as ShopCartItem;
         var _loc3_:ShopItemInfo = _loc2_.shopItemInfo;
         _loc2_.removeEventListener("deleteitem",__deleteItem);
         _loc2_.removeEventListener("conditionchange",__conditionChange);
         _castList2.removeChild(_loc2_);
         if(ShopBuyManager.crrItemId > _loc2_.id)
         {
            ShopBuyManager.crrItemId--;
         }
         _loc2_.dispose();
         deleteInfo(_loc2_.id);
         updateTxt();
         updateList();
         _cartScroll.invalidateViewport();
         if(_castList2.numChildren == 0)
         {
            dispose();
         }
      }
      
      private function deleteInfo(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _cartItemList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1 == _cartItemList[_loc3_].id)
            {
               _cartItemList.splice(_loc3_,1);
               _infoArr.splice(_loc3_,1);
               _isBandList.splice(_loc3_,1);
               if(param1 == ShopBuyManager.crrItemId)
               {
                  ShopBuyManager.crrItemId = 0;
                  if(_cartItemList.length > 0)
                  {
                     _cartItemList[0].addItem(_isBandList[0]);
                  }
               }
               break;
            }
            _loc3_++;
         }
      }
      
      protected function removeItemEvent(param1:ShopCartItem) : void
      {
         param1.removeEventListener("deleteitem",__deleteItem);
         param1.removeEventListener("add_length",addLength);
         param1.removeEventListener("conditionchange",__conditionChange);
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
      
      protected function __purchaseConfirmationBtnClick(param1:MouseEvent = null) : void
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
