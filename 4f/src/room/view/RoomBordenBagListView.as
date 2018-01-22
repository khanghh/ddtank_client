package room.view
{
   import bagAndInfo.bag.CellMenu;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import road7th.data.DictionaryData;
   import store.view.storeBag.StoreBagCell;
   
   public class RoomBordenBagListView extends Sprite implements Disposeable
   {
      
      public static const SMALLGRID:int = 21;
       
      
      protected var _list:SimpleTileList;
      
      protected var panel:ScrollPanel;
      
      protected var _cells:DictionaryData;
      
      protected var _bagdata:DictionaryData;
      
      protected var _bagType:int;
      
      private var cellNum:int = 70;
      
      private var beginGridNumber:int;
      
      private var _columnNum:int;
      
      private var _cell:BagCell;
      
      public function RoomBordenBagListView(){super();}
      
      public function setup(param1:int, param2:int, param3:int = 7) : void{}
      
      private function init() : void{}
      
      protected function createCells() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __cellRelieve(param1:Event) : void{}
      
      private function __cellUse(param1:Event) : void{}
      
      private function __cellSell(param1:Event) : void{}
      
      protected function onResponse(param1:FrameEvent) : void{}
      
      protected function createPanel() : void{}
      
      protected function createCell(param1:int) : void{}
      
      protected function __clickHandler(param1:InteractiveEvent) : void{}
      
      private function addGrid(param1:DictionaryData) : void{}
      
      private function invalidatePanel() : void{}
      
      public function setData(param1:DictionaryData) : void{}
      
      protected function __doubleCellClick(param1:MouseEvent) : void{}
      
      protected function __cellClick(param1:MouseEvent) : void{}
      
      public function get cells() : DictionaryData{return null;}
      
      public function dispose() : void{}
   }
}
