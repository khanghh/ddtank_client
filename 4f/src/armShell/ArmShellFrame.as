package armShell
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import ddt.data.BagInfo;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   import store.events.StoreBagEvent;
   import store.events.StoreDargEvent;
   import store.events.UpdateItemEvent;
   
   public class ArmShellFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _preItemCell:ArmShellItemCell;
      
      private var _bagListView:ArmShellBagListView;
      
      private var _equipBagInfo:DictionaryData;
      
      private var _itemPlace:int;
      
      public function ArmShellFrame(){super();}
      
      override protected function init() : void{}
      
      private function initView() : void{}
      
      private function addEvents() : void{}
      
      private function updateBag(param1:BagEvent) : void{}
      
      public function refreshData(param1:Dictionary, param2:BagInfo) : void{}
      
      private function updateDic(param1:DictionaryData, param2:InventoryItemInfo) : void{}
      
      private function addItemToTheFirstNullCell(param1:InventoryItemInfo, param2:DictionaryData) : void{}
      
      private function findFirstNullCellID(param1:DictionaryData) : int{return 0;}
      
      private function removeFrom(param1:InventoryItemInfo, param2:DictionaryData) : void{}
      
      private function refreshBagList() : void{}
      
      private function getEquipProData(param1:DictionaryData) : DictionaryData{return null;}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function cellClickHandler(param1:CellEvent) : void{}
      
      protected function __cellDoubleClick(param1:CellEvent) : void{}
      
      private function __startDargHandler(param1:StoreDargEvent) : void{}
      
      private function __stopDargHandler(param1:StoreDargEvent) : void{}
      
      private function removeEvents() : void{}
      
      override public function dispose() : void{}
   }
}
