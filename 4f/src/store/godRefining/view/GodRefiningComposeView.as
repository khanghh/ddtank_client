package store.godRefining.view{   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.CEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.utils.Dictionary;   import store.StoreCell;      public class GodRefiningComposeView extends Sprite implements Disposeable   {                   private var _bg:MutipleImage;            private var _cellBg:Bitmap;            private var _titleBmp:Bitmap;            private var _tipText:FilterFrameText;            private var _needNumText:FilterFrameText;            private var _startComposeBtn:BaseButton;            private var _items:Vector.<BagCell>;            public function GodRefiningComposeView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            public function updateView() : void { }
            private function getCurCellIndex(itemInfo:ItemTemplateInfo) : int { return 0; }
            public function refreshData(items:Dictionary) : void { }
            public function quitStartDrag(evt:CEvent) : void { }
            public function quitStopDrag(evt:CEvent) : void { }
            public function startShine(cellId:int) : void { }
            public function stopShine() : void { }
            public function equipDoubleClickMove(event:CEvent) : void { }
            public function propDoubleClickMove(event:CEvent) : void { }
            private function __startComposeBtnHandler(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}