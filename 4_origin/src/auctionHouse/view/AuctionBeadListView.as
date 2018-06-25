package auctionHouse.view
{
   import bagAndInfo.cell.BaseCell;
   import beadSystem.controls.BeadBagList;
   import com.pickgliss.events.InteractiveEvent;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class AuctionBeadListView extends BeadBagList
   {
       
      
      public function AuctionBeadListView(bagType:int, startIndex:int = 32, stopIndex:int = 80, columnNum:int = 7)
      {
         super(bagType,startIndex,stopIndex,columnNum);
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
         clearDataCells();
         _bagdata = bag;
         var _infoArr:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _bagdata.items;
         for(var i in _bagdata.items)
         {
            if(_cells[i] != null && InventoryItemInfo(_bagdata.items[i]).IsBinds == false)
            {
               _bagdata.items[i].isMoveSpace = true;
               _cells[i].itemInfo = _bagdata.items[i];
               _cells[i].info = _bagdata.items[i];
               _infoArr.push(_cells[i]);
            }
         }
         _bagdata.addEventListener("update",__updateGoods);
         _cellsSort(_infoArr);
      }
      
      override protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
      }
      
      override protected function __updateGoods(evt:BagEvent) : void
      {
         var c:* = null;
         var changes:Dictionary = evt.changedSlots;
         var _loc6_:int = 0;
         var _loc5_:* = changes;
         for each(var i in changes)
         {
            c = _bagdata.getItemAt(i.Place);
            if(c && c.IsBinds == false)
            {
               setCellInfo(c.Place,c);
            }
            else
            {
               setCellInfo(i.Place,null);
            }
            dispatchEvent(new Event("change"));
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
            _cellVec[n] = oldCell;
            i++;
         }
      }
   }
}
