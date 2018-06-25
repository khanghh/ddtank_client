package equipretrieve.view
{
   import bagAndInfo.bag.BagEquipListView;
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.ItemManager;
   import equipretrieve.RetrieveModel;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class RetrieveBagEquipListView extends BagEquipListView
   {
       
      
      public function RetrieveBagEquipListView(bagType:int, startIndex:int = 31, stopIndex:int = 80)
      {
         super(bagType,startIndex,stopIndex);
      }
      
      override protected function createCells() : void
      {
         var i:int = 0;
         var cell:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         for(i = _startIndex; i < _stopIndex; )
         {
            cell = new RetrieveBagcell(i);
            cell.mouseOverEffBoolean = false;
            addChild(cell);
            cell.addEventListener("interactive_click",__clickHandler);
            cell.addEventListener("interactive_double_click",__doubleClickHandler);
            cell.addEventListener("dragStop",_stopDrag);
            cell.addEventListener("mouseOver",_cellOverEff);
            cell.addEventListener("mouseOut",_cellOutEff);
            DoubleClickManager.Instance.enableDoubleClick(cell);
            cell.bagType = _bagType;
            cell.addEventListener("lockChanged",__cellChanged);
            _cells[cell.place] = cell;
            _cellVec.push(cell);
            i++;
         }
      }
      
      private function _stopDrag(e:CellEvent) : void
      {
         dispatchEvent(new CellEvent("dragStop",e.currentTarget));
      }
      
      override public function setData(bag:BagInfo) : void
      {
         var infoSLevel:int = 0;
         if(_bagdata == bag)
         {
            return;
         }
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("update",__updateGoods);
         }
         _bagdata = bag;
         var _infoArr:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _bagdata.items;
         for(var i in _bagdata.items)
         {
            if(_cells[i] != null && _bagdata.items[i] && ItemManager.Instance.getTemplateById(_bagdata.items[i].TemplateID).CanRecycle != 0)
            {
               infoSLevel = _bagdata.items[i].StrengthenLevel;
               if(infoSLevel < 7)
               {
                  _cells[i].info = _bagdata.items[i];
                  _infoArr.push(_cells[i]);
               }
            }
         }
         _bagdata.addEventListener("update",__updateGoods);
         _cellsSort(_infoArr);
      }
      
      override public function setCellInfo(index:int, info:InventoryItemInfo) : void
      {
         var infoSLevel:int = 0;
         if(index >= _startIndex && index < _stopIndex)
         {
            if(info == null)
            {
               _cells[index].info = null;
               return;
            }
            infoSLevel = info.StrengthenLevel;
            if(info.Count > 0 && ItemManager.Instance.getTemplateById(info.TemplateID).CanRecycle != 0 && infoSLevel < 7)
            {
               _cells[index].info = info;
            }
            else
            {
               _cells[index].info = null;
            }
         }
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
            _cellVec[n] = oldCell as RetrieveBagcell;
            i++;
         }
      }
      
      public function returnNullPoint(_dx:Number, _dy:Number) : Object
      {
         var i:int = 0;
         var point:Point = new Point(0,0);
         var obj:Object = {};
         for(i = _startIndex; i < _stopIndex; )
         {
            if(_bagdata.items[i] == null)
            {
               point.x = this.localToGlobal(new Point(_cells[i].x,_cells[i].y)).x;
               point.y = this.localToGlobal(new Point(_cells[i].x,_cells[i].y)).y;
               obj.point = point;
               obj.bagType = 0;
               obj.place = i;
               obj.cell = _cells[i];
               return obj;
            }
            i++;
         }
         point.x = 776;
         point.y = 572;
         obj.point = point;
         obj.bagType = 0;
         obj.place = i;
         obj.cell = _cells[i];
         RetrieveModel.Instance.isFull = true;
         return obj;
      }
   }
}
