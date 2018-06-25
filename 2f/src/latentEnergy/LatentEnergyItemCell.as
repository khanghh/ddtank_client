package latentEnergy{   import bagAndInfo.cell.BagCell;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.SoundManager;   import flash.display.DisplayObject;      public class LatentEnergyItemCell extends BagCell   {                   public function LatentEnergyItemCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true) { super(null,null,null,null,null); }
            override protected function createChildren() : void { }
            override protected function initEvent() : void { }
            private function itemMoveHandler(event:LatentEnergyEvent) : void { }
            private function itemMoveHandler2(event:LatentEnergyEvent) : void { }
            protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            override protected function removeEvent() : void { }
            protected function __clickHandler(evt:InteractiveEvent) : void { }
            public function clearInfo() : void { }
   }}