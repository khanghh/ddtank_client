package petsBag.view.item{   import bagAndInfo.cell.BagCell;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.ShineObject;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.CellEvent;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import petsBag.view.ShowPet;      public class PetEquipItem extends Sprite   {                   private var _back:Bitmap;            private var _cell:BagCell;            public var id:int;            private var _shiner:ShineObject;            public function PetEquipItem(type:int) { super(); }
            private function initView(type:int) : void { }
            public function shinePlay() : void { }
            public function shineStop() : void { }
            private function onClick(e:InteractiveEvent) : void { }
            protected function onDoubleClick(event:InteractiveEvent) : void { }
            public function initBagCell(data:InventoryItemInfo) : void { }
            public function clearBagCell() : void { }
            public function dispose() : void { }
   }}