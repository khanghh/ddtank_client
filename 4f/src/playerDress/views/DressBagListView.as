package playerDress.views
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.BaseCell;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.SocketManager;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import playerDress.PlayerDressControl;
   import playerDress.components.DressUtils;
   
   public class DressBagListView extends BagListView
   {
      
      public static const DRESS_INDEX:int = 80;
       
      
      private var _dressType:int;
      
      private var _sex:int;
      
      private var _searchStr:String;
      
      private var _displayItems:Dictionary;
      
      private var _equipBag:BagInfo;
      
      private var _virtualBag:BagInfo;
      
      private var _currentPage:int = 1;
      
      public var locked:Boolean = false;
      
      public function DressBagListView(param1:int, param2:int = 7, param3:int = 49){super(null,null,null);}
      
      public function setSortType(param1:int, param2:Boolean, param3:String = "") : void{}
      
      override public function setData(param1:BagInfo) : void{}
      
      private function setVirtualBagData() : void{}
      
      override protected function __updateGoods(param1:BagEvent) : void{}
      
      private function sortItems() : void{}
      
      private function sequenceItems() : void{}
      
      private function bagComparison(param1:Array, param2:Array) : Boolean{return false;}
      
      public function foldItems() : void{}
      
      public function fillPage(param1:int) : void{}
      
      public function displayItemsLength() : int{return 0;}
      
      private function _cellsSort(param1:Array) : void{}
      
      public function unlockBag() : void{}
      
      override public function dispose() : void{}
   }
}
