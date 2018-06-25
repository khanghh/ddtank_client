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
      
      private function _numberClose(e:Event) : void
      {
         cancelMoney();
         ObjectUtils.disposeObject(this);
      }
      
      private function _numberEnter(e:Event) : void
      {
         e.stopImmediatePropagation();
         doPay(null);
      }
      
      public function setTitleText(value:String) : void
      {
         titleText = value;
      }
      
      public function hideSelectedBand() : void
      {
         _view.hideSelectedBand();
      }
      
      public function hideSelected() : void
      {
         _view.hideSelected();
      }
      
      public function set itemID(value:int) : void
      {
         _view.ItemID = value;
         _shopItemInfo = ShopManager.Instance.getMoneyShopItemByTemplateID(_view._itemID);
         perPrice();
      }
      
      public function set stoneNumber(value:int) : void
      {
         _view.stoneNumber = value;
      }
      
      public function set maxLimit(value:int) : void
      {
         _view.maxLimit = value;
      }
      
      private function perPrice() : void
      {
         _unitPrice = GroupPurchaseManager.instance.price;
      }
      
      private function doPay(e:Event) : void
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
      
      private function _response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(e.responseCode == 0 || e.responseCode == 1)
         {
            cancelMoney();
            ObjectUtils.disposeObject(this);
         }
         else if(e.responseCode == 2)
         {
            doPay(null);
         }
      }
      
      private function cancelMoney() : void
      {
      }
      
      public function set buyFrom(value:int) : void
      {
         _buyFrom = value;
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
