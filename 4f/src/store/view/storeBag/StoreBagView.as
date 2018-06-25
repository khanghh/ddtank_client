package store.view.storeBag{   import bagAndInfo.bag.BreakGoodsView;   import bagAndInfo.bag.CellMenu;   import bagAndInfo.bag.RichesButton;   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.CellEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SoundManager;   import ddt.view.goods.AddPricePanel;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.Event;   import store.StoreBagBgWHPoint;   import store.data.StoreModel;      public class StoreBagView extends Sprite implements Disposeable   {                   private var _controller:StoreBagController;            private var _model:StoreModel;            private var _equipmentView:StoreBagListView;            private var _propView:StoreBagListView;            private var _transerViewUp:StoreSingleBagListView;            private var _transerViewDown:StoreSingleBagListView;            private var _bitmapBg:StoreBagbgbmp;            private var bagBg:ScaleFrameImage;            private var _equipmentsColumnBg:Image;            private var _itemsColumnBg:Image;            public var msg_txt:ScaleFrameImage;            private var goldTxt:FilterFrameText;            private var moneyTxt:FilterFrameText;            private var giftTxt:FilterFrameText;            private var _goldButton:RichesButton;            private var _giftButton:RichesButton;            private var _moneyButton:RichesButton;            private var _bgPoint:StoreBagBgWHPoint;            private var _bgShape:Shape;            private var _equipmentTitleText:FilterFrameText;            private var _itemTitleText:FilterFrameText;            private var _equipmentTipText:FilterFrameText;            private var _itemTipText:FilterFrameText;            public function StoreBagView() { super(); }
            public function setup(controller:StoreBagController) : void { }
            private function init() : void { }
            private function showStoreBagViewText(equipmentTip:String, itemTip:String, isShowItemTip:Boolean = true) : void { }
            private function initEvents() : void { }
            public function enableCellDoubleClick(value:Boolean, handler:Function) : void { }
            private function removeEvents() : void { }
            public function setData(storeModel:StoreModel) : void { }
            private function changeToSingleBagView() : void { }
            private function changeToDoubleBagView() : void { }
            private function __cellClick(evt:CellEvent) : void { }
            private function createBreakWin(cell:BagCell) : void { }
            private function __cellAddPrice(evt:Event) : void { }
            private function __cellMove(evt:Event) : void { }
            public function getPropCell(pos:int) : BagCell { return null; }
            public function getEquipCell(pos:int) : BagCell { return null; }
            public function get EquipList() : StoreBagListView { return null; }
            public function get PropList() : StoreBagListView { return null; }
            public function __propertyChange(evt:PlayerPropertyEvent) : void { }
            private function updateMoney() : void { }
            public function dispose() : void { }
   }}