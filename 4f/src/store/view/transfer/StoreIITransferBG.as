package store.view.transfer{   import bagAndInfo.cell.BagCell;   import com.pickgliss.effect.EffectManager;   import com.pickgliss.effect.IEffect;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.QuickBuyFrame;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.external.ExternalInterface;   import flash.geom.Point;   import flash.net.URLRequest;   import flash.net.navigateToURL;   import flash.utils.Dictionary;   import store.IStoreViewBG;   import store.view.ConsortiaRateManager;   import store.view.StoneCellFrame;      public class StoreIITransferBG extends Sprite implements IStoreViewBG   {                   private var _bg:MutipleImage;            private var _area:TransferDragInArea;            private var _items:Vector.<TransferItemCell>;            private var _transferBtnAsset:BaseButton;            private var _transferHelpAsset:BaseButton;            private var transShine:MovieImage;            private var transArr:MutipleImage;            private var _pointArray:Vector.<Point>;            private var gold_txt:FilterFrameText;            private var _goldIcon:Image;            private var _transferBefore:Boolean = false;            private var _transferAfter:Boolean = false;            private var _equipmentCell1:StoneCellFrame;            private var _equipmentCell2:StoneCellFrame;            private var _transferArrow:Bitmap;            private var _transferTitleSmall:Bitmap;            private var _transferTitleLarge:Bitmap;            private var _neededGoldTipText:FilterFrameText;            private var _transferBtnAsset_shineEffect:IEffect;            public function StoreIITransferBG() { super(); }
            private function init() : void { }
            private function getCellsPoint() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function startShine(cellId:int) : void { }
            public function stopShine() : void { }
            private function showArr() : void { }
            private function hideArr() : void { }
            public function get area() : Vector.<TransferItemCell> { return null; }
            public function dragDrop(source:BagCell) : void { }
            private function __transferHandler(evt:MouseEvent) : void { }
            private function _responseV(evt:FrameEvent) : void { }
            private function okFastPurchaseGold() : void { }
            private function _response(e:FrameEvent) : void { }
            private function _responseII(e:FrameEvent) : void { }
            private function cannel() : void { }
            private function depositAction() : void { }
            private function isComposeStrengthen(info:BagCell) : Boolean { return false; }
            private function sendSocket() : void { }
            private function __itemInfoChange(evt:Event) : void { }
            private function _showDontClickTip() : Boolean { return false; }
            private function isHasBead(info:BagCell) : Boolean { return false; }
            private function isOpenHole(info:BagCell) : Boolean { return false; }
            private function goldMoney() : void { }
            public function show() : void { }
            public function refreshData(items:Dictionary) : void { }
            public function updateData() : void { }
            public function hide() : void { }
            public function clearTransferItemCell() : void { }
            public function dispose() : void { }
   }}