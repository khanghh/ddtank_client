package ddt.command{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.events.BagEvent;   import ddt.events.ShortcutBuyEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.events.Event;      public class QuickBuyFrame extends Frame   {                   public var canDispose:Boolean;            protected var _view:QuickBuyFrameView;            protected var _shopItemInfo:ShopItemInfo;            protected var _submitButton:TextButton;            protected var _unitPrice:Number;            protected var _buyFrom:int;            protected var _recordLastBuyCount:Boolean;            private var _flag:Boolean;            public function QuickBuyFrame() { super(); }
            private function initView() : void { }
            private function initEvents() : void { }
            private function removeEvnets() : void { }
            private function _numberClose(e:Event) : void { }
            private function _numberEnter(e:Event) : void { }
            public function setTitleText(value:String) : void { }
            public function hideSelectedBand() : void { }
            public function set itemID(value:int) : void { }
            public function setIsStoneExploreView(value:Boolean) : void { }
            public function setItemID(ID:int, type:int, param:int = 1) : void { }
            public function set stoneNumber(value:int) : void { }
            public function set maxLimit(value:int) : void { }
            protected function perPrice() : void { }
            public function set recordLastBuyCount(value:Boolean) : void { }
            protected function doPay(e:Event) : void { }
            private function _response(e:FrameEvent) : void { }
            private function _responseI(e:FrameEvent) : void { }
            private function doMoney() : void { }
            private function cancelMoney() : void { }
            public function set buyFrom(value:int) : void { }
            public function get buyFrom() : int { return 0; }
            override public function dispose() : void { }
   }}