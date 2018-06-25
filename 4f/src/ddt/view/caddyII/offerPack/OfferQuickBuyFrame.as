package ddt.view.caddyII.offerPack{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.NumberSelecter;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.events.MouseEvent;      public class OfferQuickBuyFrame extends BaseAlerFrame   {                   private var _list:HBox;            private var _cellItems:Vector.<OfferQuickCell>;            private var _moneyTxt:FilterFrameText;            private var _selectNumber:NumberSelecter;            private var _itemGroup:SelectedButtonGroup;            private var _money:int;            private var _select:int = -1;            private var _selectCell:OfferQuickCell;            private var _shopInfoList:Vector.<ShopItemInfo>;            private var _itemTempLateID:Array;            public function OfferQuickBuyFrame() { super(); }
            private function initView() : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            public function set offShopList(pValue:Vector.<ShopItemInfo>) : void { }
            public function get offShopList() : Vector.<ShopItemInfo> { return null; }
            private function createCell() : void { }
            private function removeListChildEvent() : void { }
            private function _numberChange(e:Event) : void { }
            private function _numberClose(e:Event) : void { }
            private function _numberEnter(e:Event) : void { }
            private function _response(e:FrameEvent) : void { }
            private function _itemClick(e:MouseEvent) : void { }
            private function buy() : void { }
            private function _responseI(e:FrameEvent) : void { }
            public function set money(value:int) : void { }
            public function get money() : int { return 0; }
            public function set select(value:int) : void { }
            public function get select() : int { return 0; }
            public function show(number:int) : void { }
            override public function dispose() : void { }
   }}