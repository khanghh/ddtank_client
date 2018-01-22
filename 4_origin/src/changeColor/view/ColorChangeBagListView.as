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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cells = new Dictionary();
         _loc2_ = 0;
         while(_loc2_ < 49)
         {
            _loc1_ = new ChangeColorBagCell(_loc2_);
            addChild(_loc1_);
            _loc1_.bagType = _bagType;
            _loc1_.addEventListener("click",__cellClick);
            _loc1_.addEventListener("lockChanged",__cellChanged);
            _cells[_loc1_.place] = _loc1_;
            _loc2_++;
         }
      }
      
      override public function setData(param1:BagInfo) : void
      {
         if(_bagdata == param1)
         {
            return;
         }
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("update",__updateGoodsII);
         }
         _bagdata = param1;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = _bagdata.items;
         for(var _loc3_ in _bagdata.items)
         {
            if(_cells[_loc2_])
            {
               _cells[_loc2_].info = _bagdata.items[_loc3_];
               _loc2_++;
               continue;
            }
            break;
         }
         _bagdata.addEventListener("update",__updateGoodsII);
      }
      
      private function __updateGoodsII(param1:BagEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:Dictionary = param1.changedSlots;
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for each(var _loc3_ in _loc4_)
         {
            _loc2_ = PlayerManager.Instance.Self.Bag.getItemAt(_loc3_.Place);
            if(_loc2_)
            {
               updateItem(_loc2_);
            }
            else
            {
               removeBagItem(_loc3_);
            }
         }
      }
      
      public function updateItem(param1:InventoryItemInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 49)
         {
            if(_cells[_loc3_].itemInfo && _cells[_loc3_].itemInfo.Place == param1.Place)
            {
               _cells[_loc3_].info = param1;
               return;
            }
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 49)
         {
            if(_cells[_loc2_].itemInfo == null)
            {
               _cells[_loc2_].info = param1;
               return;
            }
            _loc2_++;
         }
      }
      
      public function removeBagItem(param1:InventoryItemInfo) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 49)
         {
            if(_cells[_loc2_].itemInfo && _cells[_loc2_].itemInfo.Place == param1.Place)
            {
               _cells[_loc2_].info = null;
               return;
            }
            _loc2_++;
         }
      }
      
      private function __cellClick(param1:MouseEvent) : void
      {
         if((param1.currentTarget as BagCell).locked == false && (param1.currentTarget as BagCell).info != null)
         {
            dispatchEvent(new ChangeColorCellEvent("changeColorCellClickEvent",param1.currentTarget as BagCell,true));
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
         for(var _loc1_ in _cells)
         {
            _cells[_loc1_].removeEventListener("click",__cellClick);
            _cells[_loc1_].removeEventListener("lockChanged",__cellChanged);
            _cells[_loc1_].dispose();
            _cells[_loc1_] = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
