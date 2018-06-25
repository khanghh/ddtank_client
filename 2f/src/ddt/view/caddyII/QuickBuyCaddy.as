package ddt.view.caddyII{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.view.caddyII.bead.QuickBuyItem;   import flash.events.Event;   import flash.events.MouseEvent;      public class QuickBuyCaddy extends BaseAlerFrame   {            public static const CADDYKEY_NUMBER:int = 0;            public static const CADDY_NUMBER:int = 1;                   private var _list:HBox;            private var _cellItems:Vector.<QuickBuyItem>;            private var _shopItemInfoList:Vector.<ShopItemInfo>;            private var _moneyTxt:FilterFrameText;            private var _giftTxt:FilterFrameText;            private var _money:int;            private var _gift:int;            private var _clickNumber:int;            private var _cellId:Array;            private var _selectedItem:QuickBuyItem;            public function QuickBuyCaddy() { super(); }
            private function initView() : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function creatCell() : void { }
            private function __itemClick(evt:MouseEvent) : void { }
            private function _response(e:FrameEvent) : void { }
            private function _numberChange(e:Event) : void { }
            private function _numberClose(e:Event) : void { }
            private function _numberEnter(e:Event) : void { }
            private function buy() : void { }
            private function _responseI(e:FrameEvent) : void { }
            private function _showTip() : void { }
            public function set money(value:int) : void { }
            public function get money() : int { return 0; }
            public function set gift(value:int) : void { }
            public function get gift() : int { return 0; }
            public function set clickNumber(value:int) : void { }
            public function show(number:int) : void { }
            override public function dispose() : void { }
            public function get selectedItem() : QuickBuyItem { return null; }
            public function set selectedItem(val:QuickBuyItem) : void { }
   }}