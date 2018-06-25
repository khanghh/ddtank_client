package groupPurchase.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import groupPurchase.GroupPurchaseManager;      public class GroupPurchaseQuickBuyFrame extends Frame   {                   public var canDispose:Boolean;            private var _view:GroupPurchaseQuickBuyFrameView;            private var _shopItemInfo:ShopItemInfo;            private var _submitButton:TextButton;            private var _unitPrice:Number;            private var _buyFrom:int;            public function GroupPurchaseQuickBuyFrame() { super(); }
            private function initView() : void { }
            private function initEvents() : void { }
            private function removeEvnets() : void { }
            private function _numberClose(e:Event) : void { }
            private function _numberEnter(e:Event) : void { }
            public function setTitleText(value:String) : void { }
            public function hideSelectedBand() : void { }
            public function hideSelected() : void { }
            public function set itemID(value:int) : void { }
            public function set stoneNumber(value:int) : void { }
            public function set maxLimit(value:int) : void { }
            private function perPrice() : void { }
            private function doPay(e:Event) : void { }
            private function _response(e:FrameEvent) : void { }
            private function cancelMoney() : void { }
            public function set buyFrom(value:int) : void { }
            public function get buyFrom() : int { return 0; }
            override public function dispose() : void { }
   }}