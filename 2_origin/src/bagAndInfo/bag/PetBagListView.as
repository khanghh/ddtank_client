package bagAndInfo.bag
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.BaseCell;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   
   public class PetBagListView extends BagListView
   {
      
      public static const PET_BAG_CAPABILITY:int = 49;
       
      
      private var _allBagData:BagInfo;
      
      public function PetBagListView(bagType:int, columnNum:int = 7)
      {
         super(bagType,columnNum,49);
      }
      
      override public function setData(bag:BagInfo) : void
      {
         if(_bagdata == bag)
         {
            return;
         }
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("update",__updateGoods);
         }
         _bagdata = bag;
         _allBagData = bag;
         _bagdata.addEventListener("update",__updateGoods);
         sortItems();
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
               if(item.CategoryID == 34 || item.CategoryID == 32)
               {
                  BaseCell(_cells[i]).info = item;
                  infoArr.push(_cells[i]);
               }
            }
         }
         _cellsSort(infoArr);
      }
      
      override protected function __updateGoods(evt:BagEvent) : void
      {
         var c:* = null;
         if(!_bagdata)
         {
            return;
         }
         var changes:Dictionary = evt.changedSlots;
         var _loc6_:int = 0;
         var _loc5_:* = changes;
         for each(var item in changes)
         {
            c = _bagdata.getItemAt(item.Place);
            if(c && c.CategoryID == 34)
            {
               setCellInfo(item.Place,c);
            }
            else
            {
               setCellInfo(item.Place,null);
            }
         }
         sortItems();
         dispatchEvent(new Event("change"));
      }
      
      private function updateFoodBagList() : void
      {
         var i:int = 0;
         var itemInfo:* = null;
         var foodBagInfo:BagInfo = new BagInfo(1,49);
         var dictionaryData:DictionaryData = new DictionaryData();
         var index:int = 0;
         for(i = 0; i < 49; )
         {
            itemInfo = _allBagData.items[i.toString()];
            if(_cells[i] != null)
            {
               if(itemInfo && itemInfo.CategoryID == 34)
               {
                  itemInfo.isMoveSpace = false;
                  _cells[index].info = itemInfo;
                  dictionaryData.add(index,itemInfo);
                  index++;
               }
            }
            i++;
         }
         foodBagInfo.items = dictionaryData;
         _bagdata = foodBagInfo;
      }
      
      private function getItemIndex(i:InventoryItemInfo) : int
      {
         var inventoryItemInfo:* = null;
         var index:int = -1;
         var _loc6_:int = 0;
         var _loc5_:* = _bagdata.items;
         for(var j in _bagdata.items)
         {
            inventoryItemInfo = _bagdata.items[j] as InventoryItemInfo;
            if(i.Place == inventoryItemInfo.Place)
            {
               index = j;
               break;
            }
         }
         return index;
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
   }
}
