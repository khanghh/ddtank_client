package ddt.command{   import bagAndInfo.cell.BaseCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.goods.Price;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.ShopManager;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class QuickBuyFrameView extends Sprite implements Disposeable   {                   private var _number:NumberSelecter;            private var _itemTemplateInfo:ItemTemplateInfo;            private var _shopItem:ShopItemInfo;            private var _cell:BaseCell;            private var _totalTipText:FilterFrameText;            protected var _totalText:FilterFrameText;            public var _itemID:int;            protected var _stoneNumber:int = 1;            private var _price:int;            private var _selectedBtn:SelectedCheckButton;            private var _selectedBandBtn:SelectedCheckButton;            private var _moneyTxt:FilterFrameText;            private var _bandMoney:FilterFrameText;            protected var _isBand:Boolean;            private var _movieBack:MovieClip;            private var _type:int = 0;            private var _time:int = 1;            public function QuickBuyFrameView() { super(); }
            public function get time() : int { return 0; }
            public function set time(value:int) : void { }
            public function get type() : int { return 0; }
            public function set type(value:int) : void { }
            public function get isBand() : Boolean { return false; }
            public function set isBand(b:Boolean) : void { }
            private function initView() : void { }
            protected function selectedBandHander(event:MouseEvent) : void { }
            protected function seletedHander(event:MouseEvent) : void { }
            private function initEvents() : void { }
            private function selectHandler(e:Event) : void { }
            private function _numberClose(e:Event) : void { }
            public function hideSelectedBand() : void { }
            public function hideSelected() : void { }
            public function set ItemID(ID:int) : void { }
            public function setItemID(ID:int, type:int, time:int) : void { }
            public function set stoneNumber(value:int) : void { }
            public function get stoneNumber() : int { return 0; }
            public function get ItemID() : int { return 0; }
            public function set maxLimit(value:int) : void { }
            private function initInfo() : void { }
            protected function refreshNumText() : void { }
            public function get numberSelecter() : NumberSelecter { return null; }
            public function get totalTipText() : FilterFrameText { return null; }
            public function get totalText() : FilterFrameText { return null; }
            public function dispose() : void { }
   }}