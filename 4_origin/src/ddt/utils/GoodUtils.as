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
      
      public static function getOverdueItemsFrom(param:DictionaryData) : Array
      {
         var date:* = null;
         var diff:Number = NaN;
         var remainDate:Number = NaN;
         var betoArr:Array = [];
         var hasArr:Array = [];
         var _loc9_:int = 0;
         var _loc8_:* = param;
         for each(var i in param)
         {
            if(i)
            {
               if(i.IsUsed)
               {
                  if(i.ValidDate != 0)
                  {
                     date = DateUtils.getDateByStr(i.BeginDate);
                     diff = TimeManager.Instance.TotalDaysToNow(date);
                     remainDate = (i.ValidDate - diff) * 24;
                     if(remainDate < 24 && remainDate > 0)
                     {
                        betoArr.push(i);
                     }
                     else if(remainDate <= 0)
                     {
                        hasArr.push(i);
                     }
                  }
               }
            }
         }
         return [betoArr,hasArr];
      }
   }
}
