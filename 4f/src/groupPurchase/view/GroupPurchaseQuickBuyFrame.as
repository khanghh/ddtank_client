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
      
      public function GroupPurchaseQuickBuyFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvnets() : void{}
      
      private function _numberClose(param1:Event) : void{}
      
      private function _numberEnter(param1:Event) : void{}
      
      public function setTitleText(param1:String) : void{}
      
      public function hideSelectedBand() : void{}
      
      public function hideSelected() : void{}
      
      public function set itemID(param1:int) : void{}
      
      public function set stoneNumber(param1:int) : void{}
      
      public function set maxLimit(param1:int) : void{}
      
      private function perPrice() : void{}
      
      private function doPay(param1:Event) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function cancelMoney() : void{}
      
      public function set buyFrom(param1:int) : void{}
      
      public function get buyFrom() : int{return 0;}
      
      override public function dispose() : void{}
   }
}
