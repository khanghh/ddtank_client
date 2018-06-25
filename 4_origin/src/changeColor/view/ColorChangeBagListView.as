package changeColor.view
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.ChangeColorCellEvent;
   import ddt.manager.PlayerManager;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class ColorChangeBagListView extends BagListView
   {
       
      
      public function ColorChangeBagListView()
      {
         super(1);
      }
      
      override protected function createCells() : void
      {
         var i:int = 0;
         var cell:* = null;
         _cells = new Dictionary();
         for(i = 0; i < 49; )
         {
            cell = new ChangeColorBagCell(i);
            addChild(cell);
            cell.bagType = _bagType;
            cell.addEventListener("click",__cellClick);
            cell.addEventListener("lockChanged",__cellChanged);
            _cells[cell.place] = cell;
            i++;
         }
      }
      
      override public function setData(bag:BagInfo) : void
      {
         if(_bagdata == bag)
         {
            return;
         }
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("update",__updateGoodsII);
         }
         _bagdata = bag;
         var j:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = _bagdata.items;
         for(var i in _bagdata.items)
         {
            if(_cells[j])
            {
               _cells[j].info = _bagdata.items[i];
               j++;
               continue;
            }
            break;
         }
         _bagdata.addEventListener("update",__updateGoodsII);
      }
      
      private function __updateGoodsII(evt:BagEvent) : void
      {
         var c:* = null;
         var changes:Dictionary = evt.changedSlots;
         var _loc6_:int = 0;
         var _loc5_:* = changes;
         for each(var i in changes)
         {
            c = PlayerManager.Instance.Self.Bag.getItemAt(i.Place);
            if(c)
            {
               updateItem(c);
            }
            else
            {
               removeBagItem(i);
            }
         }
      }
      
      public function updateItem(item:InventoryItemInfo) : void
      {
         var i:int = 0;
         var j:int = 0;
         for(i = 0; i < 49; )
         {
            if(_cells[i].itemInfo && _cells[i].itemInfo.Place == item.Place)
            {
               _cells[i].info = item;
               return;
            }
            i++;
         }
         for(j = 0; j < 49; )
         {
            if(_cells[j].itemInfo == null)
            {
               _cells[j].info = item;
               return;
            }
            j++;
         }
      }
      
      public function removeBagItem(item:InventoryItemInfo) : void
      {
         var i:int = 0;
         for(i = 0; i < 49; )
         {
            if(_cells[i].itemInfo && _cells[i].itemInfo.Place == item.Place)
            {
               _cells[i].info = null;
               return;
            }
            i++;
         }
      }
      
      private function __cellClick(evt:MouseEvent) : void
      {
         if((evt.currentTarget as BagCell).locked == false && (evt.currentTarget as BagCell).info != null)
         {
            dispatchEvent(new ChangeColorCellEvent("changeColorCellClickEvent",evt.currentTarget as BagCell,true));
         }
      }
      
      override public function dispose() : void
      {
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("update",__updateGoodsII);
            _bagdata = null;
         }
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for(var i in _cells)
         {
            _cells[i].removeEventListener("click",__cellClick);
            _cells[i].removeEventListener("lockChanged",__cellChanged);
            _cells[i].dispose();
            _cells[i] = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
