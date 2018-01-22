package magicStone.views
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import magicStone.components.MgStoneCell;
   
   public class MagicStoneBagList extends BagListView
   {
       
      
      private var _curPage:int;
      
      private var _startIndex:int;
      
      private var _endIndex:int;
      
      public function MagicStoneBagList(param1:int, param2:int = 7, param3:int = 49){super(null,null,null);}
      
      override protected function createCells() : void{}
      
      override public function setData(param1:BagInfo) : void{}
      
      override protected function __updateGoods(param1:BagEvent) : void{}
      
      override public function setCellInfo(param1:int, param2:InventoryItemInfo) : void{}
      
      public function updateBagList() : void{}
      
      public function set curPage(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
