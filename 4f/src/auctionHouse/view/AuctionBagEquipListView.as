package auctionHouse.view
{
   import bagAndInfo.bag.BagEquipListView;
   import bagAndInfo.cell.BagCell;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class AuctionBagEquipListView extends BagEquipListView
   {
       
      
      public function AuctionBagEquipListView(param1:int, param2:int = 31, param3:int = 80){super(null,null,null);}
      
      override public function setData(param1:BagInfo) : void{}
      
      override protected function __updateGoods(param1:BagEvent) : void{}
      
      private function _cellsSort(param1:Array) : void{}
   }
}
