package store.forge.wishBead{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.BagEvent;   import ddt.events.CellEvent;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.Dictionary;      public class WishBeadMainView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _bagList:WishBeadBagListView;            private var _proBagList:WishBeadBagListView;            private var _leftDrapSprite:WishBeadLeftDragSprite;            private var _rightDrapSprite:WishBeadRightDragSprite;            private var _itemCell:WishBeadItemCell;            private var _equipCell:WishBeadEquipCell;            private var _continuousBtn:SelectedCheckButton;            private var _doBtn:SimpleBitmapButton;            private var _tip:WishTips;            private var _helpBtn:BaseButton;            private var _isDispose:Boolean = false;            private var _equipBagInfo:BagInfo;            public function WishBeadMainView() { super(); }
            private function initView() : void { }
            private function refreshBagList() : void { }
            private function initEvent() : void { }
            private function bagInfoChangeHandler(event:BagEvent) : void { }
            private function propInfoChangeHandler(event:BagEvent) : void { }
            private function __showTip(evt:PkgEvent) : void { }
            private function judgeAgain() : void { }
            private function doHandler(event:MouseEvent) : void { }
            private function __confirm(evt:FrameEvent) : void { }
            private function sendMess() : void { }
            private function itemEquipChangeHandler(event:Event) : void { }
            private function judgeDoBtnStatus(isShowTip:Boolean) : void { }
            protected function __cellDoubleClick(evt:CellEvent) : void { }
            private function cellClickHandler(event:CellEvent) : void { }
            private function createAcceptDragSprite() : void { }
            override public function set visible(value:Boolean) : void { }
            public function clearCellInfo() : void { }
            public function refreshListData() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}