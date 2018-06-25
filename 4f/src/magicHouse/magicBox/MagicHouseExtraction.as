package magicHouse.magicBox{   import bagAndInfo.bag.RichesButton;   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.events.CellEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.Dictionary;   import invite.InviteManager;   import magicHouse.MagicBoxExtractionDragInArea;   import magicHouse.MagicHouseManager;   import magicHouse.MagicHouseModel;   import road7th.data.DictionaryData;   import store.events.StoreDargEvent;   import store.view.storeBag.StoreBagCell;   import store.view.storeBag.StoreBagListView;   import store.view.storeBag.StoreBagbgbmp;      public class MagicHouseExtraction extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _selfEliteCounts:Bitmap;            private var _selfEliteCountsTxt:FilterFrameText;            private var _selfEliteCountsTxt2:FilterFrameText;            private var _cellContentBg:Bitmap;            private var _getCountBg:Bitmap;            private var _getCounts:Bitmap;            private var _getCountsTxt:FilterFrameText;            private var _tempTxt:FilterFrameText;            private var _extractionBtn:SimpleBitmapButton;            private var _helpBtn:SimpleBitmapButton;            private var _helpFrame:Frame;            private var _bgHelp:Scale9CornerImage;            private var _content:MovieClip;            private var _btnOk:TextButton;            private var _equipListView:StoreBagListView;            private var _propListView:StoreBagListView;            private var _equipmentTitleText:FilterFrameText;            private var _equipmentTipText:FilterFrameText;            private var _itemTitleText:FilterFrameText;            private var _itemTipText:FilterFrameText;            private var _bitmapBg:StoreBagbgbmp;            private var bagBg:ScaleFrameImage;            private var moneyTxt:FilterFrameText;            private var giftTxt:FilterFrameText;            private var goldTxt:FilterFrameText;            private var _goldButton:RichesButton;            private var _giftButton:RichesButton;            private var _moneyButton:RichesButton;            private var _extractionCell:MagicBoxExtractionCell;            private var _area:MagicBoxExtractionDragInArea;            private var _extractionMc:MovieClip;            private var _numBox:HBox;            private var _mashArea:MagicBoxMashArea;            private var _aler:MagicBoxExtractionSelectedNumAlertFrame;            public function MagicHouseExtraction() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __messageUpdate(e:Event) : void { }
            private function __fusionComplete(e:Event) : void { }
            private function __extractionMcComplete(e:Event) : void { }
            private function __numberMcProgress(e:Event) : void { }
            private function __mashAreaClickHandler(e:MouseEvent) : void { }
            private function __cellDoubleClick(evt:CellEvent) : void { }
            private function __extractionBtnHandler(e:MouseEvent) : void { }
            private function __cellClick(evt:CellEvent) : void { }
            private function startShine(evt:StoreDargEvent) : void { }
            private function stopShine(evt:StoreDargEvent) : void { }
            private function __itemInfoChange(e:Event) : void { }
            private function _getItemInfoByCellInfo(count:int = 1) : String { return null; }
            private function __helpClick(e:MouseEvent) : void { }
            private function __helpFrameRespose(e:FrameEvent) : void { }
            private function __closeHelpFrame(e:MouseEvent) : void { }
            public function refreshEquipPropList() : void { }
            private function refreshTxtData() : void { }
            private function dragDrop(source:BagCell) : void { }
            private function showNumAlert(info:InventoryItemInfo, index:int) : void { }
            private function sellFunction(_nowNum:int, goodsinfo:InventoryItemInfo, index:int) : void { }
            private function notSellFunction() : void { }
            private function __updateStoreBag(evt:BagEvent) : void { }
            private function __updateBag(evt:BagEvent) : void { }
            private function _refreshData(items:Dictionary) : void { }
            private function _createExtractionCell(info:InventoryItemInfo) : void { }
            private function _deleteExtractionCell() : void { }
            private function __extractionCellClickHandler(evt:InteractiveEvent) : void { }
            private function __extractionCellDoubleClickHandler(evt:InteractiveEvent) : void { }
            public function dispose() : void { }
   }}