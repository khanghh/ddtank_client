package changeColor.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import flash.display.Sprite;
   
   public class ChangeColorBagCell extends BagCell
   {
       
      
      public function ChangeColorBagCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:Sprite = null)
      {
         super(index,info,showLoading,bg);
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var info:* = null;
         if(effect.data is InventoryItemInfo)
         {
            info = effect.data as InventoryItemInfo;
            if(locked)
            {
               if(info == this.info)
               {
                  this.locked = false;
                  DragManager.acceptDrag(this);
               }
               else
               {
                  DragManager.acceptDrag(this,"none");
               }
            }
            else
            {
               effect.action = "none";
               DragManager.acceptDrag(this);
            }
         }
      }
   }
}
