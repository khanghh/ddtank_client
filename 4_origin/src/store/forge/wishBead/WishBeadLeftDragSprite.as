package store.forge.wishBead
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   
   public class WishBeadLeftDragSprite extends Sprite implements IAcceptDrag
   {
       
      
      public function WishBeadLeftDragSprite()
      {
         super();
      }
      
      public function dragDrop(effect:DragEffect) : void
      {
         var tmpStr:* = null;
         DragManager.acceptDrag(this,"none");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var tmp:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(tmp.BagType == 0)
         {
            tmpStr = "wishBead_equip_move";
         }
         else
         {
            tmpStr = "wishBead_item_move";
         }
         var event:WishBeadEvent = new WishBeadEvent(tmpStr);
         event.info = tmp;
         event.moveType = 1;
         WishBeadManager.instance.dispatchEvent(event);
      }
   }
}
