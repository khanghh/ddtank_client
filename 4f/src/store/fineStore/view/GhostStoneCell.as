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
       
      
      public function GhostStoneCell(param1:Array, param2:int){super(null,null);}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
   }
}
