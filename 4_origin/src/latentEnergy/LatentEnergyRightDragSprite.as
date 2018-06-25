package latentEnergy
{
   import bagAndInfo.cell.DragEffect;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import flash.display.Sprite;
   
   public class LatentEnergyRightDragSprite extends Sprite implements IAcceptDrag
   {
       
      
      public function LatentEnergyRightDragSprite()
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
            tmpStr = "latentEnergy_equip_move2";
         }
         else
         {
            tmpStr = "latentEnergy_item_move2";
         }
         var event:LatentEnergyEvent = new LatentEnergyEvent(tmpStr);
         event.info = tmp;
         event.moveType = 2;
         LatentEnergyManager.instance.dispatchEvent(event);
      }
   }
}
