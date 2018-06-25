package ddt.command{   import bagAndInfo.cell.BaseCell;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.Price;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.utils.PositionUtils;   import dragonBoat.DragonBoatManager;   import flash.display.Sprite;   import flash.events.Event;      public class ScoreExchangeFrame extends BaseAlerFrame   {                   private var _sprite:Sprite;            private var _number:NumberSelecter;            private var _totalTipText:FilterFrameText;            private var totalText:FilterFrameText;            private var _cell:BaseCell;            private var _shopItem:ShopItemInfo;            private var _stoneNumber:int = 1;            private var _price:int;            private var _totalPrice:int;            public var type:int;            public function ScoreExchangeFrame() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function _numberEnter(e:Event) : void { }
            private function _numberClose(e:Event) : void { }
            private function responseHandler(event:FrameEvent) : void { }
            private function doBuy() : void { }
            private function selectHandler(e:Event) : void { }
            public function set shopItem(value:ShopItemInfo) : void { }
            private function refreshNumText() : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}