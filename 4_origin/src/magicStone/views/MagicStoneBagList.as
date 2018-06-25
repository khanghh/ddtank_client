package magicStone.views
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import magicStone.components.MgStoneCell;
   
   public class MagicStoneBagList extends BagListView
   {
       
      
      private var _curPage:int;
      
      private var _startIndex:int;
      
      private var _endIndex:int;
      
      public function MagicStoneBagList(bagType:int, columnNum:int = 7, cellNun:int = 49)
      {
         _curPage = 1;
         _startIndex = 32;
         _endIndex = 32 + cellNun - 1;
         super(bagType,columnNum,cellNun);
      }
      
      override protected function createCells() : void
      {
         var i:int = 0;
         var cell:* = null;
         _cells = new Dictionary();
         _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
         for(i = 32; i <= 143; )
         {
            cell = new MgStoneCell(i,null,true);
            CellFactory.instance.fillTipProp(cell);
            cell.addEventListener("interactive_click",__clickHandler);
            cell.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(cell);
            cell.addEventListener("lockChanged",__cellChanged);
            if(i >= _startIndex && i <= _endIndex)
            {
               addChild(cell);
            }
            _cells[i] = cell;
            _cellVec.push(cell);
            i++;
         }
      }
      
      override public function setData(bag:BagInfo) : void
      {
         if(_bagdata == bag)
         {
            return;
         }
         if(_bagdata)
         {
            _bagdata.removeEventListener("update",__updateGoods);
         }
         _bagdata = bag;
         updateBagList();
         _bagdata.addEventListener("update",__updateGoods);
      }
      
      override protected function __updateGoods(evt:BagEvent) : void
      {
         var c:* = null;
         var changes:Dictionary = evt.changedSlots;
         var _loc6_:int = 0;
         var _loc5_:* = changes;
         for each(var item in changes)
         {
            if(item.Place >= 32 && item.Place <= 143)
            {
               c = _bagdata.getItemAt(item.Place);
               if(c)
               {
                  setCellInfo(c.Place,c);
               }
               else
               {
                  setCellInfo(item.Place,null);
               }
               dispatchEvent(new Event("change"));
            }
         }
      }
      
      override public function setCellInfo(index:int, info:InventoryItemInfo) : void
      {
         var key:String = String(index);
         if(info == null)
         {
            if(_cells[key])
            {
               _cells[key].info = null;
            }
            return;
         }
         if(info.Count == 0)
         {
            _cells[key].info = null;
         }
         else
         {
            _cells[key].info = info;
         }
      }
      
      public function updateBagList() : void
      {
         var i:int = 0;
         clearDataCells();
         removeAllChild();
         for(i = 32; i <= 143; )
         {
            if(i >= _startIndex && i <= _endIndex)
            {
               addChild(_cells[i]);
            }
            i++;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _bagdata.items;
         for(var index in _bagdata.items)
         {
            if(_cells[index] != null)
            {
               _bagdata.items[index].isMoveSpace = true;
               _cells[index].info = _bagdata.items[index];
            }
         }
      }
      
      public function set curPage(value:int) : void
      {
         _curPage = value;
         _startIndex = 32 + (_curPage - 1) * _cellNum;
         _endIndex = 32 + _curPage * _cellNum - 1;
      }
      
      override public function dispose() : void
      {
         if(_bagdata)
         {
            _bagdata.removeEventListener("update",__updateGoods);
         }
         super.dispose();
      }
   }
}
