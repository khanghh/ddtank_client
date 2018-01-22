package store.view.storeBag
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import store.FineBringUpController;
   import store.FineEvolutionManager;
   import store.events.StoreBagEvent;
   import store.events.UpdateItemEvent;
   
   public class StoreBagListView extends Sprite implements Disposeable
   {
      
      public static const SMALLGRID:int = 21;
       
      
      protected var _list:SimpleTileList;
      
      protected var panel:ScrollPanel;
      
      protected var _cells:DictionaryData;
      
      protected var _bagdata:DictionaryData;
      
      protected var _controller:StoreBagController;
      
      protected var _bagType:int;
      
      private var cellNum:int = 70;
      
      private var beginGridNumber:int;
      
      private var _columnNum:int;
      
      private var showlock:Boolean = false;
      
      public function StoreBagListView(param1:Boolean = false){super();}
      
      public function setup(param1:int, param2:StoreBagController, param3:int, param4:int = 7) : void{}
      
      private function init() : void{}
      
      protected function createPanel() : void{}
      
      protected function createCells() : void{}
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      protected function __clickHandler(param1:InteractiveEvent) : void{}
      
      protected function __cellChanged(param1:Event) : void{}
      
      protected function __cellClick(param1:MouseEvent) : void{}
      
      public function getCellByPlace(param1:int) : BagCell{return null;}
      
      public function setCellInfo(param1:int, param2:InventoryItemInfo) : void{}
      
      public function setData(param1:DictionaryData) : void{}
      
      private function addGrid(param1:DictionaryData) : void{}
      
      protected function createCell(param1:int) : void{}
      
      private function _appendCell(param1:int) : void{}
      
      private function updateScrollBar(param1:Boolean = true) : void{}
      
      protected function __addGoods(param1:DictionaryEvent) : void{}
      
      private function checkShouldAutoLink(param1:InventoryItemInfo) : Boolean{return false;}
      
      protected function __removeGoods(param1:StoreBagEvent) : void{}
      
      private function __updateGoods(param1:UpdateItemEvent) : void{}
      
      public function getCellByPos(param1:int) : BagCell{return null;}
      
      private function invalidatePanel() : void{}
      
      public function dispose() : void{}
      
      public function get cells() : DictionaryData{return null;}
   }
}
