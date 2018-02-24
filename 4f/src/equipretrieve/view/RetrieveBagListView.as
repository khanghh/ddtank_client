package equipretrieve.view
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.SoundManager;
   import equipretrieve.RetrieveModel;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class RetrieveBagListView extends BagListView
   {
       
      
      public function RetrieveBagListView(param1:int, param2:int = 7){super(null,null);}
      
      override protected function createCells() : void{}
      
      private function _stopDrag(param1:CellEvent) : void{}
      
      override protected function __clickHandler(param1:InteractiveEvent) : void{}
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      override public function setData(param1:BagInfo) : void{}
      
      override public function setCellInfo(param1:int, param2:InventoryItemInfo) : void{}
      
      private function _cellsSort(param1:Array) : void{}
      
      public function returnNullPoint(param1:Number, param2:Number) : Object{return null;}
      
      override public function dispose() : void{}
   }
}
