package farm.viewx.shop{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopItemInfo;   import ddt.events.ItemEvent;   import ddt.manager.ShopManager;   import ddt.manager.SoundManager;   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.MouseEvent;   import petsBag.PetsBagManager;      public class FarmShopView extends Frame   {            public static const SEEDTYPE:int = 0;            public static const MANURETYPE:int = 1;            public static var CURRENT_PAGE:int = 1;            public static const SHOP_ITEM_NUM:uint = 10;                   private var _goodItems:Vector.<FarmShopItem>;            private var _currentType:int = 88;            private var _seedBtn:SelectedButton;            private var _btnGroup:SelectedButtonGroup;            private var _firstPage:BaseButton;            private var _prePageBtn:BaseButton;            private var _nextPageBtn:BaseButton;            private var _endPageBtn:BaseButton;            private var _currentPageTxt:FilterFrameText;            private var _goodItemContainerAll:SimpleTileList;            private var _titleShop:DisplayObject;            private var _pageInputBg:DisplayObject;            public function FarmShopView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __itemClick(evt:ItemEvent) : void { }
            private function __changeHandler(event:Event) : void { }
            private function __pageBtnClick(evt:MouseEvent) : void { }
            public function loadList() : void { }
            public function setList(list:Vector.<ShopItemInfo>) : void { }
            private function getType() : int { return 0; }
            public function show() : void { }
            override public function dispose() : void { }
   }}