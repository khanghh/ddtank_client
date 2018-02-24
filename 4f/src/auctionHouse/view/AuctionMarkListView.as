package auctionHouse.view
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import flash.utils.Dictionary;
   import mark.MarkMgr;
   import mark.data.MarkBagData;
   import mark.data.MarkChipData;
   
   public class AuctionMarkListView extends BagListView
   {
       
      
      public var _startIndex:int;
      
      public var _stopIndex:int;
      
      private var _type:int = 1003;
      
      public function AuctionMarkListView(param1:int, param2:int = 31, param3:int = 80, param4:int = 7, param5:int = 1){super(null,null,null);}
      
      override protected function createCells() : void{}
      
      public function set type(param1:int) : void{}
      
      public function get type() : int{return 0;}
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      public function setMarkDic(param1:int = 1) : void{}
   }
}
