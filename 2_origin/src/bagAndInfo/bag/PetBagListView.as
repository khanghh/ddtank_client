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
      
      public function PetBagListView(param1:int, param2:int = 7)
      {
         super(param1,param2,49);
      }
      
      override public function setData(param1:BagInfo) : void
      {
         if(_bagdata == param1)
         {
            return;
         }
         if(_bagdata != null)
         {
            _bagdata.removeEventListener("update",__updateGoods);
         }
         _bagdata = param1;
         _allBagData = param1;
         _bagdata.addEventListener("update",__updateGoods);
         sortItems();
      }
      
      private function sortItems() : void
      {
         var _loc1_:* = null;
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _bagdata.items;
         for(var _loc3_ in _bagdata.items)
         {
            _loc1_ = _bagdata.items[_loc3_];
            if(_cells[_loc3_] != null && _loc1_)
            {
               if(_loc1_.CategoryID == 34 || _loc1_.CategoryID == 32)
               {
                  BaseCell(_cells[_loc3_]).info = _loc1_;
                  _loc2_.push(_cells[_loc3_]);
               }
            }
         }
         _cellsSort(_loc2_);
      }
      
      override protected function __updateGoods(param1:BagEvent) : void
      {
         var _loc2_:* = null;
         if(!_bagdata)
         {
            return;
         }
         var _loc4_:Dictionary = param1.changedSlots;
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for each(var _loc3_ in _loc4_)
         {
            _loc2_ = _bagdata.getItemAt(_loc3_.Place);
            if(_loc2_ && _loc2_.CategoryID == 34)
            {
               setCellInfo(_loc3_.Place,_loc2_);
            }
            else
            {
               setCellInfo(_loc3_.Place,null);
            }
         }
         sortItems();
         dispatchEvent(new Event("change"));
      }
      
      private function updateFoodBagList() : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:BagInfo = new BagInfo(1,49);
         var _loc4_:DictionaryData = new DictionaryData();
         var _loc1_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < 49)
         {
            _loc3_ = _allBagData.items[_loc5_.toString()];
            if(_cells[_loc5_] != null)
            {
               if(_loc3_ && _loc3_.CategoryID == 34)
               {
                  _loc3_.isMoveSpace = false;
                  _cells[_loc1_].info = _loc3_;
                  _loc4_.add(_loc1_,_loc3_);
                  _loc1_++;
               }
            }
            _loc5_++;
         }
         _loc2_.items = _loc4_;
         _bagdata = _loc2_;
      }
      
      private function getItemIndex(param1:InventoryItemInfo) : int
      {
         var _loc3_:* = null;
         var _loc2_:int = -1;
         var _loc6_:int = 0;
         var _loc5_:* = _bagdata.items;
         for(var _loc4_ in _bagdata.items)
         {
            _loc3_ = _bagdata.items[_loc4_] as InventoryItemInfo;
            if(param1.Place == _loc3_.Place)
            {
               _loc2_ = _loc4_;
               break;
            }
         }
         return _loc2_;
      }
      
      private function _cellsSort(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(param1.length <= 0)
         {
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc4_ = param1[_loc6_].x;
            _loc5_ = param1[_loc6_].y;
            _loc3_ = _cellVec.indexOf(param1[_loc6_]);
            _loc2_ = _cellVec[_loc6_];
            param1[_loc6_].x = _loc2_.x;
            param1[_loc6_].y = _loc2_.y;
            _loc2_.x = _loc4_;
            _loc2_.y = _loc5_;
            _cellVec[_loc6_] = param1[_loc6_];
            _cellVec[_loc3_] = _loc2_;
            _loc6_++;
         }
      }
   }
}
