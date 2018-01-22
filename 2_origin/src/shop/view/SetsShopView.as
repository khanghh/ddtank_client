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
      
      public function initialize(param1:Array) : void
      {
         init();
         initEvent();
         setList(param1);
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
      
      protected function __soundPlay(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _allCheckBox.removeEventListener("click",__soundPlay);
         _allCheckBox.removeEventListener("select",__allSelected);
      }
      
      private function __allSelected(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(_allCheckBox.selected)
         {
            _loc4_ = 0;
            while(_loc4_ < _cartList.numChildren)
            {
               _loc2_ = _cartList.getChildAt(_loc4_) as SetsShopItem;
               if(_loc2_)
               {
                  _loc2_.selected = true;
               }
               _loc4_++;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < _cartList.numChildren)
            {
               _loc2_ = _cartList.getChildAt(_loc3_) as SetsShopItem;
               if(_loc2_)
               {
                  _loc2_.selected = false;
               }
               _loc3_++;
            }
         }
         updateTxt();
      }
      
      override protected function addItemEvent(param1:ShopCartItem) : void
      {
         super.addItemEvent(param1);
         param1.addEventListener("select",__itemSelectedChanged);
      }
      
      private function __itemSelectedChanged(param1:Event) : void
      {
         updateTxt();
      }
      
      override protected function removeItemEvent(param1:ShopCartItem) : void
      {
         super.removeItemEvent(param1);
         param1.removeEventListener("select",__itemSelectedChanged);
      }
      
      override protected function createShopItem() : ShopCartItem
      {
         return new SetsShopItem();
      }
      
      override protected function updateTxt() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         _totalPrice = 0;
         _loc4_ = 0;
         while(_loc4_ < _cartList.numChildren)
         {
            _loc2_ = _cartList.getChildAt(_loc4_) as SetsShopItem;
            if(_loc2_)
            {
               _loc3_++;
               if(_loc2_.selected)
               {
                  _totalPrice = _totalPrice + _loc2_.shopItemInfo.AValue1;
                  _loc1_++;
               }
            }
            _loc4_++;
         }
         _commodityNumberText.text = _loc1_.toString();
         if(_loc3_ > 0 && _loc1_ >= _loc3_)
         {
            _commodityPricesText1.text = _setsPrice.toString();
            _totalPrice = _setsPrice;
         }
         else if(_loc3_ > 0)
         {
            _commodityPricesText1.text = _totalPrice.toString();
         }
         _commodityNumberText.text = String(_loc1_);
         if(_loc1_ > 0)
         {
            _purchaseConfirmationBtn.enable = true;
         }
         else
         {
            _purchaseConfirmationBtn.enable = false;
         }
      }
      
      override protected function __purchaseConfirmationBtnClick(param1:MouseEvent = null) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Money < _totalPrice)
         {
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("poorNote"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            _loc3_.moveEnable = false;
            _loc3_.addEventListener("response",__poorManResponse);
            return;
         }
         var _loc2_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _cartList.numChildren)
         {
            _loc4_ = _cartList.getChildAt(_loc5_) as SetsShopItem;
            if(_loc4_ && _loc4_.selected)
            {
               _loc2_.push(_loc4_.shopItemInfo.GoodsID);
            }
            _loc5_++;
         }
         SocketManager.Instance.out.sendUseCard(-1,-1,_loc2_,1);
         ObjectUtils.disposeObject(this);
      }
      
      private function __poorManResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         param1.currentTarget.removeEventListener("response",__poorManResponse);
         ObjectUtils.disposeObject(param1.currentTarget);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
      }
   }
}
