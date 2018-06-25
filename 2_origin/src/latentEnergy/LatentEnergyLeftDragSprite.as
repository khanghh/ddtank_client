package latentEnergy
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   
   public class LatentEnergyLeftDragSprite extends Sprite implements IAcceptDrag
   {
       
      
      public function LatentEnergyLeftDragSprite()
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
            tmpStr = "latentEnergy_equip_move";
         }
         else
         {
            tmpStr = "latentEnergy_item_move";
         }
         var event:LatentEnergyEvent = new LatentEnergyEvent(tmpStr);
         event.info = tmp;
         event.moveType = 1;
         LatentEnergyManager.instance.dispatchEvent(event);
      }
   }
}
