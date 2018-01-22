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
      
      public function StoreBagListView(param1:Boolean = false)
      {
         super();
         showlock = param1;
      }
      
      public function setup(param1:int, param2:StoreBagController, param3:int, param4:int = 7) : void
      {
         _bagType = param1;
         _controller = param2;
         beginGridNumber = param3;
         _columnNum = param4;
         init();
      }
      
      private function init() : void
      {
         createPanel();
         _list = new SimpleTileList(_columnNum);
         _list.vSpace = 0;
         _list.hSpace = 0;
         panel.setView(_list);
         panel.invalidateViewport();
         createCells();
      }
      
      protected function createPanel() : void
      {
         panel = ComponentFactory.Instance.creat("ddtstore.StoreBagView.BagEquipScrollPanel");
         addChild(panel);
         panel.hScrollProxy = 2;
         panel.vScrollProxy = 0;
      }
      
      protected function createCells() : void
      {
         _cells = new DictionaryData();
      }
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         if(FineBringUpController.getInstance().usingLock)
         {
            return;
         }
         param1.stopImmediatePropagation();
         if((param1.currentTarget as BagCell).info != null)
         {
            if((param1.currentTarget as BagCell).info != null)
            {
               dispatchEvent(new CellEvent("doubleclick",param1.currentTarget,true));
               SoundManager.instance.play("008");
            }
         }
      }
      
      protected function __clickHandler(param1:InteractiveEvent) : void
      {
         if(FineBringUpController.getInstance().usingLock)
         {
            return;
         }
         if(!FineEvolutionManager.Instance.canClickBagList)
         {
            return;
         }
         if(param1.currentTarget)
         {
            dispatchEvent(new CellEvent("itemclick",param1.currentTarget));
         }
      }
      
      protected function __cellChanged(param1:Event) : void
      {
         dispatchEvent(new Event("change"));
      }
      
      protected function __cellClick(param1:MouseEvent) : void
      {
      }
      
      public function getCellByPlace(param1:int) : BagCell
      {
         return _cells[param1];
      }
      
      public function setCellInfo(param1:int, param2:InventoryItemInfo) : void
      {
         if(param2 == null)
         {
            if(_cells && _cells[param1])
            {
               _cells[param1].info = null;
            }
            return;
         }
         if(param2.Count == 0)
         {
            if(_cells && _cells[param1])
            {
               _cells[param1].info = null;
            }
         }
         else
         {
            if(!_cells[param1])
            {
               _appendCell(param1);
            }
            if(param2.BagType == 0 && param2.Place < 17)
            {
               _cells[param1].isUsed = true;
            }
            else
            {
               _cells[param1].isUsed = false;
            }
            _cells[param1].info = param2;
         }
      }
      
      public function setData(param1:DictionaryData) : void
      {
         var _loc2_:* = null;
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("add",__addGoods);
            _bagdata.removeEventListener("storeBagRemove",__removeGoods);
            _bagdata.removeEventListener("updateItemEvent",__updateGoods);
         }
         _bagdata = param1;
         addGrid(param1);
         if(param1)
         {
            _loc2_ = [];
            var _loc6_:int = 0;
            var _loc5_:* = param1;
            for(var _loc3_ in param1)
            {
               _loc2_.push(_loc3_);
            }
            _loc2_.sort(16);
            var _loc8_:int = 0;
            var _loc7_:* = _loc2_;
            for(var _loc4_ in _loc2_)
            {
               if(_cells[_loc4_] != null)
               {
                  _cells[_loc4_].info = param1[_loc2_[_loc4_]];
               }
            }
         }
         _bagdata.addEventListener("add",__addGoods);
         _bagdata.addEventListener("storeBagRemove",__removeGoods);
         _bagdata.addEventListener("updateItemEvent",__updateGoods);
         updateScrollBar();
      }
      
      private function addGrid(param1:DictionaryData) : void
      {
         var _loc5_:int = 0;
         _cells.clear();
         _list.disposeAllChildren();
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for(var _loc4_ in param1)
         {
            _loc3_++;
         }
         var _loc2_:int = (int((_loc3_ - 1) / _columnNum) + 1) * _columnNum;
         _loc2_ = _loc2_ < beginGridNumber?beginGridNumber:int(_loc2_);
         cellNum = _loc2_;
         _list.beginChanges();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            createCell(_loc5_);
            _loc5_++;
         }
         _list.commitChanges();
         invalidatePanel();
      }
      
      protected function createCell(param1:int) : void
      {
         var _loc2_:StoreBagCell = new StoreBagCell(param1);
         _loc2_.lockDisplayObject = ComponentFactory.Instance.creatBitmap("asset.store.bringup.lock");
         PositionUtils.setPos(_loc2_.lockDisplayObject,"storeBringUp.cellLockPos");
         _loc2_.showLock = showlock;
         _loc2_.bagType = _bagType;
         _loc2_.tipDirctions = "7,5,2,6,4,1";
         _loc2_.addEventListener("interactive_click",__clickHandler);
         _loc2_.addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(_loc2_);
         _loc2_.addEventListener("click",__cellClick);
         _loc2_.addEventListener("lockChanged",__cellChanged);
         _cells.add(_loc2_.place,_loc2_);
         _list.addChild(_loc2_);
      }
      
      private function _appendCell(param1:int) : void
      {
         var _loc2_:* = 0;
         _loc2_ = param1;
         while(_loc2_ < param1 + _columnNum)
         {
            createCell(_loc2_);
            _loc2_++;
         }
      }
      
      private function updateScrollBar(param1:Boolean = true) : void
      {
      }
      
      protected function __addGoods(param1:DictionaryEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         _loc3_ = 0;
         while(_loc3_ < cellNum)
         {
            if(_bagdata[_loc3_] == _loc2_)
            {
               setCellInfo(_loc3_,_loc2_);
               break;
            }
            _loc3_++;
         }
         updateScrollBar();
      }
      
      private function checkShouldAutoLink(param1:InventoryItemInfo) : Boolean
      {
         if(_controller.model.NeedAutoLink <= 0)
         {
            return false;
         }
         if(param1.TemplateID == 11018 || param1.TemplateID == 11020 || param1.TemplateID == 11023 || param1.StrengthenLevel >= 10)
         {
            return true;
         }
         return false;
      }
      
      protected function __removeGoods(param1:StoreBagEvent) : void
      {
         _cells[param1.pos].info = null;
         updateScrollBar(false);
      }
      
      private function __updateGoods(param1:UpdateItemEvent) : void
      {
         if(_cells && _cells.length > param1.pos)
         {
            _cells[param1.pos].info = param1.item as InventoryItemInfo;
            updateScrollBar(false);
         }
      }
      
      public function getCellByPos(param1:int) : BagCell
      {
         return _cells[param1];
      }
      
      private function invalidatePanel() : void
      {
         panel.invalidateViewport();
      }
      
      public function dispose() : void
      {
         _controller = null;
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("add",__addGoods);
            _bagdata.removeEventListener("storeBagRemove",__removeGoods);
            _bagdata.removeEventListener("updateItemEvent",__updateGoods);
            _bagdata = null;
         }
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            _loc1_.removeEventListener("interactive_click",__clickHandler);
            _loc1_.removeEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.disableDoubleClick(_loc1_);
            _loc1_.removeEventListener("click",__cellClick);
            _loc1_.removeEventListener("lockChanged",__cellChanged);
            ObjectUtils.disposeObject(_loc1_);
         }
         if(_cells)
         {
            _cells.clear();
         }
         DoubleClickManager.Instance.clearTarget();
         if(_list)
         {
            _list.disposeAllChildren();
            _list = null;
         }
         _cells = null;
         if(panel)
         {
            ObjectUtils.disposeObject(panel);
         }
         panel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get cells() : DictionaryData
      {
         return _cells;
      }
   }
}
