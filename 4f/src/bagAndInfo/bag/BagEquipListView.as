package bagAndInfo.bag
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class BagEquipListView extends BagListView
   {
       
      
      public var _startIndex:int;
      
      public var _stopIndex:int;
      
      public function BagEquipListView(param1:int, param2:int = 31, param3:int = 80, param4:int = 7){super(null,null);}
      
      override protected function createCells() : void{}
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      override protected function __clickHandler(param1:InteractiveEvent) : void{}
      
      protected function __cellClick(param1:MouseEvent) : void{}
      
      override public function setCellInfo(param1:int, param2:InventoryItemInfo) : void{}
      
      override public function dispose() : void{}
   }
}
