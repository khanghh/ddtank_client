package bagAndInfo.bag
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class BagListView extends SimpleTileList
   {
      
      public static const BAG_CAPABILITY:int = 49;
       
      
      private var _allBagData:BagInfo;
      
      protected var _cellNum:int;
      
      protected var _bagdata:BagInfo;
      
      protected var _bagType:int;
      
      protected var _cells:Dictionary;
      
      protected var _cellMouseOverBg:Bitmap;
      
      protected var _cellVec:Array;
      
      private var _isSetFoodData:Boolean;
      
      private var _currentBagType:int;
      
      public function BagListView(param1:int, param2:int = 7, param3:int = 49){super(null);}
      
      protected function createCells() : void{}
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      protected function __cellChanged(param1:Event) : void{}
      
      protected function __clickHandler(param1:InteractiveEvent) : void{}
      
      protected function _cellOverEff(param1:MouseEvent) : void{}
      
      protected function _cellOutEff(param1:MouseEvent) : void{}
      
      public function setCellInfo(param1:int, param2:InventoryItemInfo) : void{}
      
      protected function clearDataCells() : void{}
      
      public function set currentBagType(param1:int) : void{}
      
      public function setData(param1:BagInfo) : void{}
      
      private function sortItems() : void{}
      
      private function _cellsSort(param1:Array) : void{}
      
      protected function __updateFoodGoods(param1:BagEvent) : void{}
      
      protected function __updateGoods(param1:BagEvent) : void{}
      
      override public function dispose() : void{}
      
      public function get cells() : Dictionary{return null;}
      
      public function updateBankBag(param1:int) : void{}
      
      public function checkBankCell() : int{return 0;}
   }
}
