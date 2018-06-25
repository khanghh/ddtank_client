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
      
      public function dragDrop(effect:DragEffect) : void
      {
         DragManager.acceptDrag(this,"none");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var tmp:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(tmp)
         {
            SocketManager.Instance.out.sendMoveGoods(tmp.BagType,tmp.Place,12,0);
         }
      }
   }
}
