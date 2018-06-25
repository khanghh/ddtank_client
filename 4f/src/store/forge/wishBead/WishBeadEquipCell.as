package store.forge.wishBead{   import bagAndInfo.cell.BagCell;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.utils.DoubleClickManager;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.SoundManager;   import flash.display.DisplayObject;      public class WishBeadEquipCell extends BagCell   {                   public function WishBeadEquipCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true) { super(null,null,null,null,null); }
            override protected function initEvent() : void { }
            private function equipMoveHandler(event:WishBeadEvent) : void { }
            private function equipMoveHandler2(event:WishBeadEvent) : void { }
            protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            override protected function removeEvent() : void { }
            protected function __clickHandler(evt:InteractiveEvent) : void { }
            public function clearInfo() : void { }
   }}