package shop.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.events.Event;   import flash.events.MouseEvent;      public class SetsShopView extends ShopCheckOutView   {                   private var _allCheckBox:SelectedCheckButton;            private var _setsPrice:int = 99;            private var _selectedAll:Boolean = true;            private var _totalPrice:int;            public function SetsShopView() { super(); }
            public function initialize(list:Array) : void { }
            override protected function drawFrame() : void { }
            override protected function init() : void { }
            private function fixPos() : void { }
            override protected function initEvent() : void { }
            protected function __soundPlay(event:MouseEvent) : void { }
            override protected function removeEvent() : void { }
            private function __allSelected(event:Event) : void { }
            override protected function addItemEvent(item:ShopCartItem) : void { }
            private function __itemSelectedChanged(event:Event) : void { }
            override protected function removeItemEvent(item:ShopCartItem) : void { }
            override protected function createShopItem() : ShopCartItem { return null; }
            override protected function updateTxt() : void { }
            override protected function __purchaseConfirmationBtnClick(event:MouseEvent = null) : void { }
            private function __poorManResponse(event:FrameEvent) : void { }
   }}