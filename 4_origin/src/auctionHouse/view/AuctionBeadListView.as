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
       
      
      public function AuctionBeadListView(param1:int, param2:int = 32, param3:int = 80, param4:int = 7)
      {
         super(param1,param2,param3,param4);
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
         clearDataCells();
         _bagdata = param1;
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _bagdata.items;
         for(var _loc3_ in _bagdata.items)
         {
            if(_cells[_loc3_] != null && InventoryItemInfo(_bagdata.items[_loc3_]).IsBinds == false)
            {
               _bagdata.items[_loc3_].isMoveSpace = true;
               _cells[_loc3_].itemInfo = _bagdata.items[_loc3_];
               _cells[_loc3_].info = _bagdata.items[_loc3_];
               _loc2_.push(_cells[_loc3_]);
            }
         }
         _bagdata.addEventListener("update",__updateGoods);
         _cellsSort(_loc2_);
      }
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
      }
      
      override protected function __updateGoods(param1:BagEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:Dictionary = param1.changedSlots;
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for each(var _loc3_ in _loc4_)
         {
            _loc2_ = _bagdata.getItemAt(_loc3_.Place);
            if(_loc2_ && _loc2_.IsBinds == false)
            {
               setCellInfo(_loc2_.Place,_loc2_);
            }
            else
            {
               setCellInfo(_loc3_.Place,null);
            }
            dispatchEvent(new Event("change"));
         }
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
