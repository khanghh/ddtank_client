package Indiana.model
{
   import Indiana.analyzer.IndianaGoodsItemInfo;
   import Indiana.analyzer.IndianaShopItemInfo;
   import ddt.manager.TimeManager;
   import road7th.utils.DateUtils;
   
   public class IndianaModel
   {
      
      public static var INDIANA_COUNTDOWN:int = 1;
      
      public static var INDIANA_SHOWING:int = 2;
      
      public static var INDIANA_DOING:int = 0;
      
      public static var INDIANA_START:int = 5;
      
      public static var INDIANA_END:int = 6;
       
      
      private var _items:Vector.<IndianaGoodsItemInfo>;
      
      private var _shopItems:Vector.<IndianaShopItemInfo>;
      
      private var _startTime:Date;
      
      private var _endTime:Date;
      
      public function IndianaModel()
      {
         super();
      }
      
      public function set Items(param1:Vector.<IndianaGoodsItemInfo>) : void
      {
         _items = param1;
      }
      
      public function get Items() : Vector.<IndianaGoodsItemInfo>
      {
         return _items;
      }
      
      public function set ShopItems(param1:Vector.<IndianaShopItemInfo>) : void
      {
         _shopItems = param1;
         calculationStartTime();
         calculationEndTime();
      }
      
      public function calculationIsNeedCheck() : Boolean
      {
         var _loc1_:Date = TimeManager.Instance.Now();
         if(_endTime == null && _startTime == null)
         {
            return false;
         }
         if(_loc1_.getTime() - _endTime.getTime() > 0)
         {
            return false;
         }
         return true;
      }
      
      public function get ShopItems() : Vector.<IndianaShopItemInfo>
      {
         return _shopItems;
      }
      
      public function getShopItemByid(param1:int) : IndianaShopItemInfo
      {
         var _loc3_:int = 0;
         var _loc2_:int = _shopItems.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_shopItems[_loc3_].PeriodId == param1)
            {
               return _shopItems[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      private function calculationEndTime() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         if(_shopItems && _shopItems.length > 0)
         {
            _loc3_ = _shopItems.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(_shopItems[_loc4_].Putaway == 1)
               {
                  if(_loc1_ == null)
                  {
                     _loc1_ = DateUtils.decodeDated(_shopItems[_loc4_].EndShowTime);
                  }
                  else
                  {
                     _loc2_ = DateUtils.decodeDated(_shopItems[_loc4_].EndShowTime);
                     if(_loc1_.valueOf() - _loc2_.valueOf() < 0)
                     {
                        _loc1_ = _loc2_;
                     }
                  }
               }
               _loc4_++;
            }
            _endTime = _loc1_;
         }
      }
      
      private function calculationStartTime() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         if(_shopItems && _shopItems.length > 0)
         {
            _loc3_ = _shopItems.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(_shopItems[_loc4_].Putaway == 1)
               {
                  if(_loc1_ == null)
                  {
                     _loc1_ = DateUtils.decodeDated(_shopItems[_loc4_].StartTime);
                  }
                  else
                  {
                     _loc2_ = DateUtils.decodeDated(_shopItems[_loc4_].StartTime);
                     if(_loc1_.valueOf() - _loc2_.valueOf() > 0)
                     {
                        _loc1_ = _loc2_;
                     }
                  }
               }
               _loc4_++;
            }
            _startTime = _loc1_;
         }
      }
      
      public function getActivateState() : int
      {
         var _loc1_:Date = TimeManager.Instance.Now();
         if(_endTime && _loc1_.getTime() - _endTime.getTime() >= 0)
         {
            return INDIANA_END;
         }
         if(_startTime && _loc1_.getTime() - _startTime.getTime() >= 0)
         {
            return INDIANA_START;
         }
         return -1;
      }
   }
}
