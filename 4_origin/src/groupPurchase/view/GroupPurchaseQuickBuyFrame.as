package groupPurchase.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import groupPurchase.GroupPurchaseManager;
   
   public class GroupPurchaseQuickBuyFrame extends Frame
   {
       
      
      public var canDispose:Boolean;
      
      private var _view:GroupPurchaseQuickBuyFrameView;
      
      private var _shopItemInfo:ShopItemInfo;
      
      private var _submitButton:TextButton;
      
      private var _unitPrice:Number;
      
      private var _buyFrom:int;
      
      public function GroupPurchaseQuickBuyFrame()
      {
         super();
         canDispose = true;
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _view = new GroupPurchaseQuickBuyFrameView();
         addToContent(_view);
         _submitButton = ComponentFactory.Instance.creatComponentByStylename("ddtcore.quickEnter");
         _submitButton.text = LanguageMgr.GetTranslation("store.view.shortcutBuy.buyBtn");
         _view.addChild(_submitButton);
         escEnable = true;
         enterEnable = true;
      }
      
      private function initEvents() : void
      {
         addEventListener("response",_response);
         _submitButton.addEventListener("click",doPay);
         _view.addEventListener("number_close",_numberClose);
         addEventListener("number_enter",_numberEnter);
      }
      
      private function removeEvnets() : void
      {
         removeEventListener("response",_response);
         if(_submitButton)
         {
            _submitButton.removeEventListener("click",doPay);
         }
         if(_view)
         {
            _view.removeEventListener("number_close",_numberClose);
         }
         removeEventListener("number_enter",_numberEnter);
      }
      
      private function _numberClose(param1:Event) : void
      {
         cancelMoney();
         ObjectUtils.disposeObject(this);
      }
      
      private function _numberEnter(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         doPay(null);
      }
      
      public function setTitleText(param1:String) : void
      {
         titleText = param1;
      }
      
      public function hideSelectedBand() : void
      {
         _view.hideSelectedBand();
      }
      
      public function hideSelected() : void
      {
         _view.hideSelected();
      }
      
      public function set itemID(param1:int) : void
      {
         _view.ItemID = param1;
         _shopItemInfo = ShopManager.Instance.getMoneyShopItemByTemplateID(_view._itemID);
         perPrice();
      }
      
      public function set stoneNumber(param1:int) : void
      {
         _view.stoneNumber = param1;
      }
      
      public function set maxLimit(param1:int) : void
      {
         _view.maxLimit = param1;
      }
      
      private function perPrice() : void
      {
         _unitPrice = GroupPurchaseManager.instance.price;
      }
      
      private function doPay(param1:Event) : void
      {
         SoundManager.instance.play("008");
         if(_view.isBand && PlayerManager.Instance.Self.BandMoney < _view.stoneNumber * _unitPrice)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.lijinbuzu"));
            return;
         }
         if(!_view.isBand && PlayerManager.Instance.Self.Money < _view.stoneNumber * _unitPrice)
         {
            LeavePageManager.showFillFrame();
            return;
         }
         SocketManager.Instance.out.sendGroupPurchaseBuy(_view.stoneNumber,_view.isBand);
         dispose();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            cancelMoney();
            ObjectUtils.disposeObject(this);
         }
         else if(param1.responseCode == 2)
         {
            doPay(null);
         }
      }
      
      private function cancelMoney() : void
      {
      }
      
      public function set buyFrom(param1:int) : void
      {
         _buyFrom = param1;
      }
      
      public function get buyFrom() : int
      {
         return _buyFrom;
      }
      
      override public function dispose() : void
      {
         canDispose = false;
         super.dispose();
         removeEvnets();
         _view = null;
         _shopItemInfo = null;
         if(_submitButton)
         {
            ObjectUtils.disposeObject(_submitButton);
         }
         _submitButton = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
