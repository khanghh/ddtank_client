package beadSystem.controls
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import beadSystem.beadSystemManager;
   import beadSystem.model.BeadModel;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class BeadBagList extends BagListView
   {
       
      
      public var _startIndex:int;
      
      public var _stopIndex:int;
      
      private var _toPlace:int;
      
      private var _beadInfo:InventoryItemInfo;
      
      public function BeadBagList(param1:int, param2:int = 32, param3:int = 80, param4:int = 7){super(null,null);}
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      private function doBeadEquip() : void{}
      
      protected function __onBindRespones(param1:FrameEvent) : void{}
      
      public function get BeadCells() : Dictionary{return null;}
      
      override protected function createCells() : void{}
      
      override public function setData(param1:BagInfo) : void{}
      
      override protected function __updateGoods(param1:BagEvent) : void{}
      
      override protected function __clickHandler(param1:InteractiveEvent) : void{}
      
      override public function setCellInfo(param1:int, param2:InventoryItemInfo) : void{}
      
      override public function dispose() : void{}
   }
}
