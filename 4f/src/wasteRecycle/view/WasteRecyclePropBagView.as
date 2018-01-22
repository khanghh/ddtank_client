package wasteRecycle.view
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import wasteRecycle.WasteRecycleController;
   
   public class WasteRecyclePropBagView extends BagListView
   {
       
      
      private var _waitBagUpdate:Array;
      
      public function WasteRecyclePropBagView(param1:int, param2:int = 7, param3:int = 49){super(null,null,null);}
      
      override protected function createCells() : void{}
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      override public function setData(param1:BagInfo) : void{}
      
      override protected function __updateGoods(param1:BagEvent) : void{}
      
      private function __onWaitUpdate(param1:Event) : void{}
      
      private function _cellsSort(param1:Array) : void{}
      
      override public function dispose() : void{}
   }
}
