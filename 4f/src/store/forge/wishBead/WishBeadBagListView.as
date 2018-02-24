package store.forge.wishBead
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.interfaces.ICell;
   import flash.utils.Dictionary;
   
   public class WishBeadBagListView extends BagListView
   {
       
      
      public function WishBeadBagListView(param1:int, param2:int = 7, param3:int = 49){super(null,null,null);}
      
      override protected function createCells() : void{}
      
      private function createBagCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true) : WishBeadEquipListCell{return null;}
      
      private function fillTipProp(param1:ICell) : void{}
      
      private function equipMoveHandler(param1:WishBeadEvent) : void{}
      
      private function equipMoveHandler2(param1:WishBeadEvent) : void{}
      
      override public function setData(param1:BagInfo) : void{}
      
      override public function dispose() : void{}
   }
}
