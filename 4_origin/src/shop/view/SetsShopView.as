package shop.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SetsShopView extends ShopCheckOutView
   {
       
      
      private var _allCheckBox:SelectedCheckButton;
      
      private var _setsPrice:int = 99;
      
      private var _selectedAll:Boolean = true;
      
      private var _totalPrice:int;
      
      public function SetsShopView()
      {
         super();
      }
      
      public function initialize(list:Array) : void
      {
         init();
         initEvent();
         setList(list);
         _commodityPricesText2.text = "0";
         _purchaseConfirmationBtn.visible = true;
         _commodityNumberTip.htmlText = LanguageMgr.GetTranslation("shop.setsshopview.commodity");
         PositionUtils.setPos(_commodityNumberTip,"ddt.setsShopView.pos");
         _commodityNumberText.visible = false;
         _allCheckBox.selected = true;
         _allCheckBox.dispatchEvent(new Event("select"));
      }
      
      override protected function drawFrame() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.setsShopView");
         _frame.titleText = LanguageMgr.GetTranslation("shop.SetsTitle");
         addChild(_frame);
      }
      
      override protected function init() : void
      {
         super.init();
         _allCheckBox = ComponentFactory.Instance.creatComponentByStylename("ddtshop.SetsShopView.SetsShopALLCheckBox");
         _allCheckBox.text = LanguageMgr.GetTranslation("tank.view.emailII.readView.textBtnFont1");
         _frame.addToContent(_allCheckBox);
         fixPos();
      }
      
      private function fixPos() : void
      {
         _commodityNumberTip.y = _commodityNumberTip.y + 8;
         _commodityNumberText.y = _commodityNumberText.y + 8;
         _innerBg1.y = _innerBg1.y + 18;
         _needToPayTip.y = _needToPayTip.y + 18;
         _commodityPricesText1.y = _commodityPricesText1.y + 18;
         _commodityPricesText2.y = _commodityPricesText2.y + 18;
         _commodityPricesText1Label.y = _commodityPricesText1Label.y + 18;
         _commodityPricesText2Label.y = _commodityPricesText2Label.y + 18;
         _purchaseConfirmationBtn.y = _purchaseConfirmationBtn.y + 18;
         _giftsBtn.y = _giftsBtn.y + 18;
         _saveImageBtn.y = _saveImageBtn.y + 18;
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _allCheckBox.addEventListener("click",__soundPlay);
         _allCheckBox.addEventListener("select",__allSelected);
      }
      
      protected function __soundPlay(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _allCheckBox.removeEventListener("click",__soundPlay);
         _allCheckBox.removeEventListener("select",__allSelected);
      }
      
      private function __allSelected(event:Event) : void
      {
         var item:* = null;
         var i:int = 0;
         var j:int = 0;
         if(_allCheckBox.selected)
         {
            for(i = 0; i < _cartList.numChildren; )
            {
               item = _cartList.getChildAt(i) as SetsShopItem;
               if(item)
               {
                  item.selected = true;
               }
               i++;
            }
         }
         else
         {
            j = 0;
            while(j < _cartList.numChildren)
            {
               item = _cartList.getChildAt(j) as SetsShopItem;
               if(item)
               {
                  item.selected = false;
               }
               j++;
            }
         }
         updateTxt();
      }
      
      override protected function addItemEvent(item:ShopCartItem) : void
      {
         super.addItemEvent(item);
         item.addEventListener("select",__itemSelectedChanged);
      }
      
      private function __itemSelectedChanged(event:Event) : void
      {
         updateTxt();
      }
      
      override protected function removeItemEvent(item:ShopCartItem) : void
      {
         super.removeItemEvent(item);
         item.removeEventListener("select",__itemSelectedChanged);
      }
      
      override protected function createShopItem() : ShopCartItem
      {
         return new SetsShopItem();
      }
      
      override protected function updateTxt() : void
      {
         var selectedCount:int = 0;
         var itemCount:int = 0;
         var i:int = 0;
         var item:* = null;
         _totalPrice = 0;
         for(i = 0; i < _cartList.numChildren; )
         {
            item = _cartList.getChildAt(i) as SetsShopItem;
            if(item)
            {
               itemCount++;
               if(item.selected)
               {
                  _totalPrice = _totalPrice + item.shopItemInfo.AValue1;
                  selectedCount++;
               }
            }
            i++;
         }
         _commodityNumberText.text = selectedCount.toString();
         if(itemCount > 0 && selectedCount >= itemCount)
         {
            _commodityPricesText1.text = _setsPrice.toString();
            _totalPrice = _setsPrice;
         }
         else if(itemCount > 0)
         {
            _commodityPricesText1.text = _totalPrice.toString();
         }
         _commodityNumberText.text = String(selectedCount);
         if(selectedCount > 0)
         {
            _purchaseConfirmationBtn.enable = true;
         }
         else
         {
            _purchaseConfirmationBtn.enable = false;
         }
      }
      
      override protected function __purchaseConfirmationBtnClick(event:MouseEvent = null) : void
      {
         var alert:* = null;
         var item:* = null;
         var j:int = 0;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Money < _totalPrice)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("poorNote"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            alert.moveEnable = false;
            alert.addEventListener("response",__poorManResponse);
            return;
         }
         var items:Array = [];
         for(j = 0; j < _cartList.numChildren; )
         {
            item = _cartList.getChildAt(j) as SetsShopItem;
            if(item && item.selected)
            {
               items.push(item.shopItemInfo.GoodsID);
            }
            j++;
         }
         SocketManager.Instance.out.sendUseCard(-1,-1,items,1);
         ObjectUtils.disposeObject(this);
      }
      
      private function __poorManResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         event.currentTarget.removeEventListener("response",__poorManResponse);
         ObjectUtils.disposeObject(event.currentTarget);
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
      }
   }
}
