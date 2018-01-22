package beadSystem.controls
{
   import bagAndInfo.cell.DragEffect;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   
   public class BeadAdvanceCell extends BeadCell
   {
       
      
      public function BeadAdvanceCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:Boolean = true)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dragStart() : void
      {
         if(_info && !locked && stage && _allowDrag)
         {
            DragManager.startDrag(this,_info,createDragImg(),stage.mouseX,stage.mouseY,"move");
         }
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc2_:* = null;
         if(param1.data is InventoryItemInfo && this.info == null)
         {
            param1.action = "none";
            _loc2_ = param1.data;
            this.itemInfo = _loc2_;
            this.info = _loc2_;
            DragManager.acceptDrag(this);
         }
      }
      
      override public function dragStop(param1:DragEffect) : void
      {
         if(param1.action == "none")
         {
            locked = false;
         }
         if(param1.action == "none" && param1.target != null)
         {
            this.itemInfo = null;
            this.info = null;
         }
      }
   }
}
