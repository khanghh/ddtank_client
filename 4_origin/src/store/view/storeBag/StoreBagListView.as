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
      
      public function StoreBagListView(_showLock:Boolean = false)
      {
         super();
         showlock = _showLock;
      }
      
      public function setup(bagType:int, controller:StoreBagController, number:int, columnNum:int = 7) : void
      {
         _bagType = bagType;
         _controller = controller;
         beginGridNumber = number;
         _columnNum = columnNum;
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
      
      protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         if(FineBringUpController.getInstance().usingLock)
         {
            return;
         }
         evt.stopImmediatePropagation();
         if((evt.currentTarget as BagCell).info != null)
         {
            if((evt.currentTarget as BagCell).info != null)
            {
               dispatchEvent(new CellEvent("doubleclick",evt.currentTarget,true));
               SoundManager.instance.play("008");
            }
         }
      }
      
      protected function __clickHandler(e:InteractiveEvent) : void
      {
         if(FineBringUpController.getInstance().usingLock)
         {
            return;
         }
         if(!FineEvolutionManager.Instance.canClickBagList)
         {
            return;
         }
         if(e.currentTarget)
         {
            dispatchEvent(new CellEvent("itemclick",e.currentTarget));
         }
      }
      
      protected function __cellChanged(event:Event) : void
      {
         dispatchEvent(new Event("change"));
      }
      
      protected function __cellClick(evt:MouseEvent) : void
      {
      }
      
      public function getCellByPlace(place:int) : BagCell
      {
         return _cells[place];
      }
      
      public function setCellInfo(index:int, info:InventoryItemInfo) : void
      {
         if(info == null)
         {
            if(_cells && _cells[index])
            {
               _cells[index].info = null;
            }
            return;
         }
         if(info.Count == 0)
         {
            if(_cells && _cells[index])
            {
               _cells[index].info = null;
            }
         }
         else
         {
            if(!_cells[index])
            {
               _appendCell(index);
            }
            if(info.BagType == 0 && info.Place < 17)
            {
               _cells[index].isUsed = true;
            }
            else
            {
               _cells[index].isUsed = false;
            }
            _cells[index].info = info;
         }
      }
      
      public function setData(list:DictionaryData) : void
      {
         var arr:* = null;
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("add",__addGoods);
            _bagdata.removeEventListener("storeBagRemove",__removeGoods);
            _bagdata.removeEventListener("updateItemEvent",__updateGoods);
         }
         _bagdata = list;
         addGrid(list);
         if(list)
         {
            arr = [];
            var _loc6_:int = 0;
            var _loc5_:* = list;
            for(var key in list)
            {
               arr.push(key);
            }
            arr.sort(16);
            var _loc8_:int = 0;
            var _loc7_:* = arr;
            for(var i in arr)
            {
               if(_cells[i] != null)
               {
                  _cells[i].info = list[arr[i]];
               }
            }
         }
         _bagdata.addEventListener("add",__addGoods);
         _bagdata.addEventListener("storeBagRemove",__removeGoods);
         _bagdata.addEventListener("updateItemEvent",__updateGoods);
         updateScrollBar();
      }
      
      private function addGrid(list:DictionaryData) : void
      {
         var i:int = 0;
         _cells.clear();
         _list.disposeAllChildren();
         var n:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = list;
         for(var key in list)
         {
            n++;
         }
         var needGrid:int = (int((n - 1) / _columnNum) + 1) * _columnNum;
         needGrid = needGrid < beginGridNumber?beginGridNumber:int(needGrid);
         cellNum = needGrid;
         _list.beginChanges();
         for(i = 0; i < needGrid; )
         {
            createCell(i);
            i++;
         }
         _list.commitChanges();
         invalidatePanel();
      }
      
      protected function createCell(index:int) : void
      {
         var cell:StoreBagCell = new StoreBagCell(index);
         cell.lockDisplayObject = ComponentFactory.Instance.creatBitmap("asset.store.bringup.lock");
         PositionUtils.setPos(cell.lockDisplayObject,"storeBringUp.cellLockPos");
         cell.showLock = showlock;
         cell.bagType = _bagType;
         cell.tipDirctions = "7,5,2,6,4,1";
         cell.addEventListener("interactive_click",__clickHandler);
         cell.addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(cell);
         cell.addEventListener("click",__cellClick);
         cell.addEventListener("lockChanged",__cellChanged);
         _cells.add(cell.place,cell);
         _list.addChild(cell);
      }
      
      private function _appendCell(sum:int) : void
      {
         var i:* = 0;
         for(i = sum; i < sum + _columnNum; )
         {
            createCell(i);
            i++;
         }
      }
      
      private function updateScrollBar(updatePosition:Boolean = true) : void
      {
      }
      
      protected function __addGoods(evt:DictionaryEvent) : void
      {
         var i:int = 0;
         var t:InventoryItemInfo = evt.data as InventoryItemInfo;
         for(i = 0; i < cellNum; )
         {
            if(_bagdata[i] == t)
            {
               setCellInfo(i,t);
               break;
            }
            i++;
         }
         updateScrollBar();
      }
      
      private function checkShouldAutoLink(item:InventoryItemInfo) : Boolean
      {
         if(_controller.model.NeedAutoLink <= 0)
         {
            return false;
         }
         if(item.TemplateID == 11018 || item.TemplateID == 11020 || item.TemplateID == 11023 || item.StrengthenLevel >= 10)
         {
            return true;
         }
         return false;
      }
      
      protected function __removeGoods(evt:StoreBagEvent) : void
      {
         _cells[evt.pos].info = null;
         updateScrollBar(false);
      }
      
      private function __updateGoods(evt:UpdateItemEvent) : void
      {
         if(_cells && _cells.length > evt.pos)
         {
            _cells[evt.pos].info = evt.item as InventoryItemInfo;
            updateScrollBar(false);
         }
      }
      
      public function getCellByPos(pos:int) : BagCell
      {
         return _cells[pos];
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
         for each(var i in _cells)
         {
            i.removeEventListener("interactive_click",__clickHandler);
            i.removeEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.disableDoubleClick(i);
            i.removeEventListener("click",__cellClick);
            i.removeEventListener("lockChanged",__cellChanged);
            ObjectUtils.disposeObject(i);
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
