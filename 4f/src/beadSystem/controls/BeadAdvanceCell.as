package beadSystem.controls
{
   import bagAndInfo.cell.DragEffect;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   
   public class BeadAdvanceCell extends BeadCell
   {
       
      
      public function BeadAdvanceCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:Boolean = true){super(null,null,null,null);}
      
      override public function dragStart() : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override public function dragStop(param1:DragEffect) : void{}
   }
}
