package auctionHouse.view
{
   import bagAndInfo.cell.BaseCell;
   import beadSystem.controls.BeadBagList;
   import com.pickgliss.events.InteractiveEvent;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class AuctionBeadListView extends BeadBagList
   {
       
      
      public function AuctionBeadListView(param1:int, param2:int = 32, param3:int = 80, param4:int = 7){super(null,null,null,null);}
      
      override public function setData(param1:BagInfo) : void{}
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      override protected function __updateGoods(param1:BagEvent) : void{}
      
      private function _cellsSort(param1:Array) : void{}
   }
}
