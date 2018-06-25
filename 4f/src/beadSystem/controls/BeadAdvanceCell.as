package beadSystem.controls{   import bagAndInfo.cell.DragEffect;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.DragManager;      public class BeadAdvanceCell extends BeadCell   {                   public function BeadAdvanceCell(index:int, $info:ItemTemplateInfo = null, showLoading:Boolean = true, showTip:Boolean = true) { super(null,null,null,null); }
            override public function dragStart() : void { }
            override public function dragDrop(effect:DragEffect) : void { }
            override public function dragStop(effect:DragEffect) : void { }
   }}