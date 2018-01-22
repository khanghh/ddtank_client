package bagAndInfo.bag
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.BaseCell;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   
   public class PetBagListView extends BagListView
   {
      
      public static const PET_BAG_CAPABILITY:int = 49;
       
      
      private var _allBagData:BagInfo;
      
      public function PetBagListView(param1:int, param2:int = 7){super(null,null,null);}
      
      override public function setData(param1:BagInfo) : void{}
      
      private function sortItems() : void{}
      
      override protected function __updateGoods(param1:BagEvent) : void{}
      
      private function updateFoodBagList() : void{}
      
      private function getItemIndex(param1:InventoryItemInfo) : int{return 0;}
      
      private function _cellsSort(param1:Array) : void{}
   }
}
