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
      
      public function set Items(value:Vector.<IndianaGoodsItemInfo>) : void
      {
         _items = value;
      }
      
      public function get Items() : Vector.<IndianaGoodsItemInfo>
      {
         return _items;
      }
      
      public function set ShopItems(value:Vector.<IndianaShopItemInfo>) : void
      {
         _shopItems = value;
         calculationStartTime();
         calculationEndTime();
      }
      
      public function calculationIsNeedCheck() : Boolean
      {
         var data:Date = TimeManager.Instance.Now();
         if(_endTime == null && _startTime == null)
         {
            return false;
         }
         if(data.getTime() - _endTime.getTime() > 0)
         {
            return false;
         }
         return true;
      }
      
      public function get ShopItems() : Vector.<IndianaShopItemInfo>
      {
         return _shopItems;
      }
      
      public function getShopItemByid(value:int) : IndianaShopItemInfo
      {
         var i:int = 0;
         var len:int = _shopItems.length;
         for(i = 0; i < len; )
         {
            if(_shopItems[i].PeriodId == value)
            {
               return _shopItems[i];
            }
            i++;
         }
         return null;
      }
      
      private function calculationEndTime() : void
      {
         var len:int = 0;
         var data:* = null;
         var temp:* = null;
         var i:int = 0;
         if(_shopItems && _shopItems.length > 0)
         {
            len = _shopItems.length;
            for(i = 0; i < len; )
            {
               if(_shopItems[i].Putaway == 1)
               {
                  if(data == null)
                  {
                     data = DateUtils.decodeDated(_shopItems[i].EndShowTime);
                  }
                  else
                  {
                     temp = DateUtils.decodeDated(_shopItems[i].EndShowTime);
                     if(data.valueOf() - temp.valueOf() < 0)
                     {
                        data = temp;
                     }
                  }
               }
               i++;
            }
            _endTime = data;
         }
      }
      
      private function calculationStartTime() : void
      {
         var len:int = 0;
         var data:* = null;
         var temp:* = null;
         var i:int = 0;
         if(_shopItems && _shopItems.length > 0)
         {
            len = _shopItems.length;
            for(i = 0; i < len; )
            {
               if(_shopItems[i].Putaway == 1)
               {
                  if(data == null)
                  {
                     data = DateUtils.decodeDated(_shopItems[i].StartTime);
                  }
                  else
                  {
                     temp = DateUtils.decodeDated(_shopItems[i].StartTime);
                     if(data.valueOf() - temp.valueOf() > 0)
                     {
                        data = temp;
                     }
                  }
               }
               i++;
            }
            _startTime = data;
         }
      }
      
      public function getActivateState() : int
      {
         var nowTime:Date = TimeManager.Instance.Now();
         if(_endTime && nowTime.getTime() - _endTime.getTime() >= 0)
         {
            return INDIANA_END;
         }
         if(_startTime && nowTime.getTime() - _startTime.getTime() >= 0)
         {
            return INDIANA_START;
         }
         return -1;
      }
   }
}
