package store.fineStore.view.pageBringUp
{
   import bagAndInfo.cell.DragEffect;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import flash.display.Sprite;
   import latentEnergy.LatentEnergyEvent;
   import store.FineBringUpController;
   
   public class FineBringUpRightDragSprite extends Sprite implements IAcceptDrag
   {
       
      
      public function FineBringUpRightDragSprite()
      {
         super();
      }
      
      public function dragDrop(param1:DragEffect) : void
      {
         var _loc2_:* = null;
         DragManager.acceptDrag(this,"none");
         var _loc4_:InventoryItemInfo = param1.data as InventoryItemInfo;
         _loc2_ = "latentEnergy_equip_move2";
         var _loc3_:LatentEnergyEvent = new LatentEnergyEvent(_loc2_);
         _loc3_.info = _loc4_;
         _loc3_.moveType = 2;
         FineBringUpController.getInstance().dispatchEvent(_loc3_);
      }
   }
}
