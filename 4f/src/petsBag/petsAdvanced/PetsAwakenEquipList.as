package petsBag.petsAdvanced
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   
   public class PetsAwakenEquipList extends Sprite implements Disposeable
   {
       
      
      private var _equipPanel:ScrollPanel;
      
      private var _equipList:SimpleTileList;
      
      private var _cellNum:int;
      
      private var _info:BagInfo;
      
      private var _store:BagInfo;
      
      private var _equipArr:Array;
      
      private var _bagType:int;
      
      public function PetsAwakenEquipList(param1:int = 18){super();}
      
      private function initView() : void{}
      
      private function initEquipCell(param1:int) : void{}
      
      public function set bagType(param1:int) : void{}
      
      public function get bagType() : int{return 0;}
      
      public function setInfo(param1:BagInfo, param2:BagInfo) : void{}
      
      private function clareEquipCache() : void{}
      
      private function appendEvent(param1:BaseCell) : void{}
      
      private function __equipClickHandler(param1:InteractiveEvent) : void{}
      
      private function __equipDoubleClickHandler(param1:InteractiveEvent) : void{}
      
      public function dispose() : void{}
   }
}
