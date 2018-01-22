package ddt.utils
{
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.TimeManager;
   import road7th.data.DictionaryData;
   import road7th.utils.DateUtils;
   
   public class GoodUtils
   {
       
      
      public function GoodUtils()
      {
         super();
      }
      
      public static function getOverdueItemsFrom(param1:DictionaryData) : Array
      {
         var _loc6_:* = null;
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:Array = [];
         var _loc4_:Array = [];
         var _loc9_:int = 0;
         var _loc8_:* = param1;
         for each(var _loc7_ in param1)
         {
            if(_loc7_)
            {
               if(_loc7_.IsUsed)
               {
                  if(_loc7_.ValidDate != 0)
                  {
                     _loc6_ = DateUtils.getDateByStr(_loc7_.BeginDate);
                     _loc3_ = TimeManager.Instance.TotalDaysToNow(_loc6_);
                     _loc5_ = (_loc7_.ValidDate - _loc3_) * 24;
                     if(_loc5_ < 24 && _loc5_ > 0)
                     {
                        _loc2_.push(_loc7_);
                     }
                     else if(_loc5_ <= 0)
                     {
                        _loc4_.push(_loc7_);
                     }
                  }
               }
            }
         }
         return [_loc2_,_loc4_];
      }
   }
}
