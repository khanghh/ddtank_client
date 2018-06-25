package store.fineStore.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import store.StoneCell;
   import store.equipGhost.EquipGhostManager;
   
   public class GhostStoneCell extends StoneCell
   {
       
      
      public function GhostStoneCell(stoneType:Array, $index:int)
      {
         super(stoneType,$index);
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var sourceInfo:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(sourceInfo.BagType == 12 && info != null)
         {
            return;
         }
         if(sourceInfo && effect.action != "split")
         {
            effect.action = "none";
            if(_types.indexOf(sourceInfo.Property1) == -1)
            {
               return;
            }
            if(sourceInfo.CategoryID == 11)
            {
               if(sourceInfo.Property1 == "117")
               {
                  EquipGhostManager.getInstance().chooseLuckyMaterial(sourceInfo);
               }
               else if(sourceInfo.Property1 == "118")
               {
                  EquipGhostManager.getInstance().chooseStoneMaterial(sourceInfo);
               }
               SocketManager.Instance.out.sendMoveGoods(sourceInfo.BagType,sourceInfo.Place,12,index,sourceInfo.Count,true);
               DragManager.acceptDrag(this);
            }
         }
      }
      
      override protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         if(!DoubleClickEnabled)
         {
            return;
         }
         if(info == null)
         {
            return;
         }
         if((evt.currentTarget as BagCell).info != null)
         {
            SocketManager.Instance.out.sendMoveGoods(12,index,itemBagType,-1);
            if(info.Property1 == "117")
            {
               EquipGhostManager.getInstance().chooseLuckyMaterial(null);
            }
            else if(info.Property1 == "118")
            {
               EquipGhostManager.getInstance().chooseStoneMaterial(null);
            }
            if(!mouseSilenced)
            {
               SoundManager.instance.play("008");
            }
         }
      }
   }
}
