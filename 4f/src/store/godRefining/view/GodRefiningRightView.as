package store.godRefining.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CEvent;
   import ddt.events.CellEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   import store.events.StoreBagEvent;
   import store.events.StoreDargEvent;
   import store.events.UpdateItemEvent;
   import store.forge.ForgeRightBgView;
   import store.godRefining.GodRefiningManager;
   
   public class GodRefiningRightView extends ForgeRightBgView
   {
       
      
      private var _bagList:GodRefiningBagListView;
      
      private var _proBagList:GodRefiningBagListView;
      
      private var _equipBagInfo:DictionaryData;
      
      private var _propBagInfo:DictionaryData;
      
      private var _selectIndex:int;
      
      public function GodRefiningRightView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      public function updateView(param1:int) : void{}
      
      private function __startDargHandler(param1:StoreDargEvent) : void{}
      
      private function __stopDargHandler(param1:StoreDargEvent) : void{}
      
      private function cellClickHandler(param1:CellEvent) : void{}
      
      protected function __cellDoubleClick(param1:CellEvent) : void{}
      
      private function refreshBagList() : void{}
      
      private function refreshPropBagList() : void{}
      
      private function getEquipProData(param1:DictionaryData, param2:Boolean) : DictionaryData{return null;}
      
      public function refreshData(param1:Dictionary, param2:BagInfo) : void{}
      
      private function updateEquip(param1:InventoryItemInfo) : void{}
      
      private function updateProp(param1:InventoryItemInfo) : void{}
      
      private function isProperTo_CanEquipList(param1:InventoryItemInfo) : Boolean{return false;}
      
      private function isProperTo_CanPropList(param1:InventoryItemInfo) : Boolean{return false;}
      
      private function removeFrom(param1:InventoryItemInfo, param2:DictionaryData) : void{}
      
      private function updateDic(param1:DictionaryData, param2:InventoryItemInfo) : void{}
      
      private function addItemToTheFirstNullCell(param1:InventoryItemInfo, param2:DictionaryData) : void{}
      
      private function findFirstNullCellID(param1:DictionaryData) : int{return 0;}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
