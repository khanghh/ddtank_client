package horse.amulet
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import horse.HorseAmuletManager;
   import horse.data.HorseAmuletVo;
   
   public class HorseAmuletBagListView extends BagListView
   {
      
      public static const MIN_PLACE:int = 20;
      
      public static const MAX_PLACE:int = 167;
       
      
      private var _startIndex:int;
      
      private var _endIndex:int;
      
      private var _currentPage:int;
      
      public function HorseAmuletBagListView(param1:int, param2:int = 7, param3:int = 49){super(null,null,null);}
      
      public function set currentPage(param1:int) : void{}
      
      override protected function createCells() : void{}
      
      override public function setData(param1:BagInfo) : void{}
      
      private function updateBag() : void{}
      
      override protected function __updateGoods(param1:BagEvent) : void{}
      
      override public function setCellInfo(param1:int, param2:InventoryItemInfo) : void{}
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      private function _cellsSort(param1:Array) : void{}
      
      public function getAllEnableSmashPlaceList() : Array{return null;}
      
      public function lockCellByPlace(param1:Boolean, param2:Array) : void{}
      
      override public function dispose() : void{}
   }
}
