package magicHouse.magicBox{   import bagAndInfo.cell.DragEffect;   import baglocked.BaglockedManager;   import com.pickgliss.ui.ComponentFactory;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.DragManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import flash.display.Sprite;   import store.StoreCell;      public class MagicBoxExtractionCell extends StoreCell   {                   private var _aler:MagicBoxExtractionSelectedNumAlertFrame;            public function MagicBoxExtractionCell(bg:Sprite, $index:int) { super(null,null); }
            override public function set info(value:ItemTemplateInfo) : void { }
            override public function dragDrop(effect:DragEffect) : void { }
            private function showNumAlert(info:InventoryItemInfo, index:int) : void { }
            private function sellFunction(_nowNum:int, goodsinfo:InventoryItemInfo, index:int) : void { }
            private function notSellFunction() : void { }
            override protected function createChildren() : void { }
            override public function dispose() : void { }
   }}