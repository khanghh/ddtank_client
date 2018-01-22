package store.view.strength
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import store.StoreDragInArea;
   
   public class StrengthDragInArea extends StoreDragInArea
   {
       
      
      private var _hasStone:Boolean = false;
      
      private var _hasItem:Boolean = false;
      
      private var _stonePlace:int = -1;
      
      private var _effect:DragEffect;
      
      public function StrengthDragInArea(param1:Array){super(null);}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      private function findCellAndDrop() : void{}
      
      private function reset() : void{}
      
      override public function dispose() : void{}
   }
}
