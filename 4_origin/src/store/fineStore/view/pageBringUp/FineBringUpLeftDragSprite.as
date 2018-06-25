package store.fineStore.view.pageBringUp
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   import latentEnergy.LatentEnergyEvent;
   import store.FineBringUpController;
   
   public class FineBringUpLeftDragSprite extends Sprite implements IAcceptDrag
   {
       
      
      public function FineBringUpLeftDragSprite()
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
         tmpStr = "latentEnergy_equip_move";
         var event:LatentEnergyEvent = new LatentEnergyEvent(tmpStr);
         event.info = tmp;
         event.moveType = 1;
         FineBringUpController.getInstance().dispatchEvent(event);
      }
   }
}
