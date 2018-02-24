package equipretrieve.view
{
   import bagAndInfo.bag.BagEquipListView;
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.ItemManager;
   import equipretrieve.RetrieveModel;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class RetrieveBagEquipListView extends BagEquipListView
   {
       
      
      public function RetrieveBagEquipListView(param1:int, param2:int = 31, param3:int = 80){super(null,null,null);}
      
      override protected function createCells() : void{}
      
      private function _stopDrag(param1:CellEvent) : void{}
      
      override public function setData(param1:BagInfo) : void{}
      
      override public function setCellInfo(param1:int, param2:InventoryItemInfo) : void{}
      
      private function _cellsSort(param1:Array) : void{}
      
      public function returnNullPoint(param1:Number, param2:Number) : Object{return null;}
   }
}
