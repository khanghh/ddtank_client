package changeColor.view
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.ChangeColorCellEvent;
   import ddt.manager.PlayerManager;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class ColorChangeBagListView extends BagListView
   {
       
      
      public function ColorChangeBagListView(){super(null);}
      
      override protected function createCells() : void{}
      
      override public function setData(param1:BagInfo) : void{}
      
      private function __updateGoodsII(param1:BagEvent) : void{}
      
      public function updateItem(param1:InventoryItemInfo) : void{}
      
      public function removeBagItem(param1:InventoryItemInfo) : void{}
      
      private function __cellClick(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
