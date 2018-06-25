package auctionHouse.view{   import bagAndInfo.bag.BagView;   import bagAndInfo.cell.BaseCell;   import com.pickgliss.events.ListItemEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ComboBox;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.CellEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import mark.MarkMgr;   import mark.event.MarkEvent;   import playerDress.PlayerDressControl;   import playerDress.event.PlayerDressEvent;      public class AuctionBagView extends BagView   {            public static var MARKBAG:int = 100;                   protected var _markSelectedBtn:SelectedButton;            protected var _tabBtn5:Sprite;            protected var _auctionMarkList:AuctionMarkListView;            private var _rankCombo:ComboBox = null;            private var _nextBtn:SimpleBitmapButton;            private var _preBtn:SimpleBitmapButton;            private var _pageTxtBg:Bitmap;            private var _pageTxt:FilterFrameText;            private var pageBox:Sprite;            private var _currentPage:int = 1;            private var _totalPage:int = 3;            public function AuctionBagView() { super(); }
            override protected function initBackGround() : void { }
            override protected function initTabButtons() : void { }
            override protected function __itemtabBtnClick(event:MouseEvent) : void { }
            override protected function refreshSelectedButton(tag:int) : void { }
            override protected function initBagList() : void { }
            private function __onUpdataMarkBag(e:MarkEvent) : void { }
            private function initMarkPage() : void { }
            private function changePage(event:MouseEvent) : void { }
            private function initMarkSelectComboBox() : void { }
            private function itemClickHander(event:ListItemEvent) : void { }
            override protected function set_breakBtn_enable() : void { }
            override protected function showDressBagView(event:PlayerDressEvent) : void { }
            override protected function adjustEvent() : void { }
            override protected function __cellOpen(evt:Event) : void { }
            override protected function __cellClick(evt:CellEvent) : void { }
            override protected function __cellDoubleClick(evt:CellEvent) : void { }
            override public function setBagType(type:int) : void { }
            override public function dispose() : void { }
   }}