package beadSystem.controls
{
   import bagAndInfo.cell.DragEffect;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   
   public class BeadAdvanceCell extends BeadCell
   {
       
      
      public function BeadAdvanceCell(index:int, $info:ItemTemplateInfo = null, showLoading:Boolean = true, showTip:Boolean = true)
      {
         super(index,$info,showLoading,showTip);
      }
      
      override public function dragStart() : void
      {
         if(_info && !locked && stage && _allowDrag)
         {
            DragManager.startDrag(this,_info,createDragImg(),stage.mouseX,stage.mouseY,"move");
         }
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var temInfo:* = null;
         if(effect.data is InventoryItemInfo && this.info == null)
         {
            effect.action = "none";
            temInfo = effect.data;
            this.itemInfo = temInfo;
            this.info = temInfo;
            DragManager.acceptDrag(this);
         }
      }
      
      override public function dragStop(effect:DragEffect) : void
      {
         if(effect.action == "none")
         {
            locked = false;
         }
         if(effect.action == "none" && effect.target != null)
         {
            this.itemInfo = null;
            this.info = null;
         }
      }
   }
}
