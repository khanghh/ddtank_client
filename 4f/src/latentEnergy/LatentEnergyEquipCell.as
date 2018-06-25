package latentEnergy{   import bagAndInfo.cell.BagCell;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.utils.DoubleClickManager;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.SoundManager;   import ddt.view.tips.GoodTipInfo;   import flash.display.DisplayObject;      public class LatentEnergyEquipCell extends BagCell   {                   private var _latentEnergyItemId:int;            public function LatentEnergyEquipCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true) { super(null,null,null,null,null); }
            public function set latentEnergyItemId(value:int) : void { }
            override public function set info(value:ItemTemplateInfo) : void { }
            override public function get tipStyle() : String { return null; }
            override protected function initEvent() : void { }
            private function equipMoveHandler(event:LatentEnergyEvent) : void { }
            private function equipMoveHandler2(event:LatentEnergyEvent) : void { }
            protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            override protected function removeEvent() : void { }
            protected function __clickHandler(evt:InteractiveEvent) : void { }
            public function clearInfo() : void { }
   }}