package store.fineStore.view.pageBringUp.evolution
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.Sprite;
   
   public class FineEvolutionUpLeftDragPanel extends Sprite implements IAcceptDrag
   {
       
      
      public function FineEvolutionUpLeftDragPanel()
      {
         super();
      }
      
      public function dragDrop(param1:DragEffect) : void
      {
         DragManager.acceptDrag(this,"none");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc2_)
         {
            SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,0);
         }
      }
   }
}
