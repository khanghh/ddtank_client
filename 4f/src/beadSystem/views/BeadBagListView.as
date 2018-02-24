package beadSystem.views
{
   import bagAndInfo.cell.BagCell;
   import beadSystem.controls.BeadBagList;
   import beadSystem.controls.BeadLockButton;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BeadBagListView extends Sprite implements Disposeable
   {
       
      
      private var _beadLockBtn:BeadLockButton;
      
      private var _beadBagList:BeadBagList;
      
      public function BeadBagListView(){super();}
      
      protected function __cellClick(param1:CellEvent) : void{}
      
      public function dispose() : void{}
      
      private function lockBead(param1:MouseEvent) : void{}
   }
}
