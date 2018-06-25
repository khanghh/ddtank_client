package store.forge.wishBead
{
   import bagAndInfo.cell.DragEffect;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import flash.display.Sprite;
   
   public class WishBeadRightDragSprite extends Sprite implements IAcceptDrag
   {
       
      
      public function WishBeadRightDragSprite()
      {
         super();
      }
      
      public function dragDrop(effect:DragEffect) : void
      {
         var tmpStr:* = null;
         DragManager.acceptDrag(this,"none");
         var tmp:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(tmp.BagType == 0)
         {
            tmpStr = "wishBead_equip_move2";
         }
         else
         {
            tmpStr = "wishBead_item_move2";
         }
         var event:WishBeadEvent = new WishBeadEvent(tmpStr);
         event.info = tmp;
         event.moveType = 2;
         WishBeadManager.instance.dispatchEvent(event);
      }
   }
}
