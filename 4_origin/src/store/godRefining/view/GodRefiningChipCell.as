package store.godRefining.view
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import store.StoneCell;
   
   public class GodRefiningChipCell extends StoneCell
   {
       
      
      public function GodRefiningChipCell(param1:Array, param2:int)
      {
         super(param1,param2);
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc2_.BagType == 12 && info != null)
         {
            return;
         }
         if(_loc2_ && param1.action != "split")
         {
            param1.action = "none";
            if(EquipType.isArmShellClip(_loc2_))
            {
               SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,index,_loc2_.Count,true);
               param1.action = "none";
               DragManager.acceptDrag(this);
            }
         }
      }
   }
}
