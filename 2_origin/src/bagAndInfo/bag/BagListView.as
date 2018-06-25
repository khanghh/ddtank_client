package bagAndInfo.bag
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class BagListView extends SimpleTileList
   {
      
      public static const BAG_CAPABILITY:int = 49;
       
      
      private var _allBagData:BagInfo;
      
      protected var _cellNum:int;
      
      protected var _bagdata:BagInfo;
      
      protected var _bagType:int;
      
      protected var _cells:Dictionary;
      
      protected var _cellMouseOverBg:Bitmap;
      
      protected var _cellVec:Array;
      
      private var _isSetFoodData:Boolean;
      
      private var _currentBagType:int;
      
      public function BagListView(bagType:int, columnNum:int = 7, cellNun:int = 49)
      {
         _cellNum = cellNun;
         _bagType = bagType;
         super(columnNum);
         _vSpace = 0;
         _hSpace = 0;
         _cellVec = [];
         createCells();
      }
      
      protected function createCells() : void
      {
         var i:int = 0;
         var cell:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         for(i = 0; i < _cellNum; )
         {
            cell = BagCell(CellFactory.instance.createBagCell(i));
            cell.mouseOverEffBoolean = false;
            addChild(cell);
            cell.bagType = _bagType;
            cell.addEventListener("interactive_click",__clickHandler);
            cell.addEventListener("mouseOver",_cellOverEff);
            cell.addEventListener("mouseOut",_cellOutEff);
            cell.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(cell);
            cell.addEventListener("lockChanged",__cellChanged);
            _cells[cell.place] = cell;
            _cellVec.push(cell);
            i++;
         }
      }
      
      protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         if((evt.currentTarget as BagCell).info != null)
         {
            SoundManager.instance.play("008");
            dispatchEvent(new CellEvent("doubleclick",evt.currentTarget));
         }
      }
      
      protected function __cellChanged(event:Event) : void
      {
         dispatchEvent(new Event("change"));
      }
      
      protected function __clickHandler(evt:InteractiveEvent) : void
      {
         if((evt.currentTarget as BagCell).info != null)
         {
            dispatchEvent(new CellEvent("itemclick",evt.currentTarget,false,false,evt.ctrlKey));
         }
      }
      
      protected function _cellOverEff(e:MouseEvent) : void
      {
         BagCell(e.currentTarget).onParentMouseOver(_cellMouseOverBg);
      }
      
      protected function _cellOutEff(e:MouseEvent) : void
      {
         BagCell(e.currentTarget).onParentMouseOut();
      }
      
      public function setCellInfo(index:int, info:InventoryItemInfo) : void
      {
         if(info == null)
         {
            if(_cells[index])
            {
               _cells[index].info = null;
            }
            return;
         }
         if(info.Count == 0)
         {
            _cells[index].info = null;
         }
         else
         {
            _cells[index].info = info;
         }
      }
      
      protected function clearDataCells() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.info = null;
         }
      }
      
      public function set currentBagType(value:int) : void
      {
         _currentBagType = value;
      }
      
      public function setData(bag:BagInfo) : void
      {
         _isSetFoodData = false;
         if(_bagdata == bag)
         {
            return;
         }
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("update",__updateGoods);
         }
         clearDataCells();
         _bagdata = bag;
         var infoArr:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _bagdata.items;
         for(var i in _bagdata.items)
         {
            if(_cells[i] != null)
            {
               if(_currentBagType == 5)
               {
                  if(_bagdata.items[i].CategoryID == 50 || _bagdata.items[i].CategoryID == 51 || _bagdata.items[i].CategoryID == 52)
                  {
                     _bagdata.items[i].isMoveSpace = true;
                     _cells[i].info = _bagdata.items[i];
                     infoArr.push(_cells[i]);
                  }
               }
               else
               {
                  _bagdata.items[i].isMoveSpace = true;
                  _cells[i].info = _bagdata.items[i];
               }
            }
         }
         _bagdata.addEventListener("update",__updateGoods);
         if(_currentBagType == 5)
         {
            _cellsSort(infoArr);
         }
      }
      
      private function sortItems() : void
      {
         var item:* = null;
         var infoArr:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _bagdata.items;
         for(var i in _bagdata.items)
         {
            item = _bagdata.items[i];
            if(_cells[i] != null && item)
            {
               if(item.CategoryID == 50 || item.CategoryID == 51 || item.CategoryID == 52)
               {
                  BaseCell(_cells[i]).info = item;
                  infoArr.push(_cells[i]);
               }
            }
         }
         _cellsSort(infoArr);
      }
      
      private function _cellsSort(arr:Array) : void
      {
         var i:int = 0;
         var oldx:Number = NaN;
         var oldy:Number = NaN;
         var n:int = 0;
         var oldCell:* = null;
         if(arr.length <= 0)
         {
            return;
         }
         i = 0;
         while(i < arr.length)
         {
            oldx = arr[i].x;
            oldy = arr[i].y;
            n = _cellVec.indexOf(arr[i]);
            oldCell = _cellVec[i];
            arr[i].x = oldCell.x;
            arr[i].y = oldCell.y;
            oldCell.x = oldx;
            oldCell.y = oldy;
            _cellVec[i] = arr[i];
            _cellVec[n] = oldCell;
            i++;
         }
      }
      
      protected function __updateFoodGoods(evt:BagEvent) : void
      {
         var index:int = 0;
         var c:* = null;
         var inventoryItemInfo:* = null;
         var d:* = null;
         if(!_bagdata)
         {
            return;
         }
         var changes:Dictionary = evt.changedSlots;
         var _loc12_:int = 0;
         var _loc11_:* = changes;
         for each(var i in changes)
         {
            index = -1;
            c = null;
            var _loc10_:int = 0;
            var _loc9_:* = _bagdata.items;
            for(var j in _bagdata.items)
            {
               inventoryItemInfo = _bagdata.items[j] as InventoryItemInfo;
               if(i.ItemID == inventoryItemInfo.ItemID)
               {
                  c = i;
                  index = j;
                  break;
               }
            }
            if(index != -1)
            {
               d = _bagdata.getItemAt(index);
               if(d)
               {
                  d.Count = c.Count;
                  if(_cells[index].info)
                  {
                     setCellInfo(index,null);
                  }
                  else
                  {
                     setCellInfo(index,d);
                  }
               }
               else
               {
                  setCellInfo(index,null);
               }
               dispatchEvent(new Event("change"));
            }
         }
      }
      
      protected function __updateGoods(evt:BagEvent) : void
      {
         var changes:* = null;
         var c:* = null;
         if(_isSetFoodData)
         {
            __updateFoodGoods(evt);
         }
         else
         {
            changes = evt.changedSlots;
            var _loc6_:int = 0;
            var _loc5_:* = changes;
            for each(var i in changes)
            {
               c = _bagdata.getItemAt(i.Place);
               if(c)
               {
                  if(_currentBagType == 5)
                  {
                     if(c.CategoryID != 50 && c.CategoryID != 51 && c.CategoryID != 52)
                     {
                        setCellInfo(i.Place,null);
                        continue;
                     }
                  }
                  setCellInfo(c.Place,c);
               }
               else
               {
                  setCellInfo(i.Place,null);
               }
               dispatchEvent(new Event("change"));
            }
         }
         if(_currentBagType == 5)
         {
            sortItems();
         }
      }
      
      override public function dispose() : void
      {
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("update",__updateGoods);
            _bagdata = null;
         }
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var i in _cells)
         {
            i.removeEventListener("interactive_click",__clickHandler);
            i.removeEventListener("lockChanged",__cellChanged);
            i.removeEventListener("mouseOver",_cellOverEff);
            i.removeEventListener("mouseOut",_cellOutEff);
            i.removeEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.disableDoubleClick(i);
            i.dispose();
         }
         _cells = null;
         _cellVec = null;
         if(_cellMouseOverBg)
         {
            if(_cellMouseOverBg.parent)
            {
               _cellMouseOverBg.parent.removeChild(_cellMouseOverBg);
            }
            _cellMouseOverBg.bitmapData.dispose();
         }
         _cellMouseOverBg = null;
         super.dispose();
      }
      
      public function get cells() : Dictionary
      {
         return _cells;
      }
      
      public function updateBankBag(count:int) : void
      {
      }
      
      public function checkBankCell() : int
      {
         return 0;
      }
   }
}
