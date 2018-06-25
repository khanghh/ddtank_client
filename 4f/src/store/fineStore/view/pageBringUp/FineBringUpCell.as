package store.fineStore.view.pageBringUp{   import bagAndInfo.cell.LockableBagCell;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.view.tips.GoodTipInfo;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.Shape;   import latentEnergy.LatentEnergyEvent;   import store.FineBringUpController;      public class FineBringUpCell extends LockableBagCell   {                   private var _observer:IObserver;            private var _text:FilterFrameText;            private var _latentEnergyItemId:int;            private var _lastLevel:int;            public function FineBringUpCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true) { super(null,null,null,null,null); }
            public function get lastLevel() : int { return 0; }
            public function set latentEnergyItemId(value:int) : void { }
            override public function get tipStyle() : String { return null; }
            public function register(ob:IObserver) : void { }
            override protected function addEnchantMc() : void { }
            override public function set info(value:ItemTemplateInfo) : void { }
            override protected function initEvent() : void { }
            private function equipMoveHandler(event:LatentEnergyEvent) : void { }
            private function equipMoveHandler2(event:LatentEnergyEvent) : void { }
            protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            override protected function removeEvent() : void { }
            protected function __clickHandler(evt:InteractiveEvent) : void { }
            public function clearInfo() : void { }
            override public function dispose() : void { }
   }}