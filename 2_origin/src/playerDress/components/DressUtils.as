package playerDress.components
{
   import ddt.data.goods.InventoryItemInfo;
   
   public class DressUtils
   {
       
      
      public function DressUtils()
      {
         super();
      }
      
      public static function getBagItems($id:int, $isIndex:Boolean = false) : int
      {
         var numArr:Array = [0,2,4,11,1,3,5,13];
         if(!$isIndex)
         {
            return numArr[$id] != null?numArr[$id]:-1;
         }
         return numArr.indexOf($id);
      }
      
      public static function isDress(item:InventoryItemInfo) : Boolean
      {
         var _loc2_:* = item.CategoryID;
         if(1 !== _loc2_)
         {
            if(2 !== _loc2_)
            {
               if(3 !== _loc2_)
               {
                  if(4 !== _loc2_)
                  {
                     if(5 !== _loc2_)
                     {
                        if(6 !== _loc2_)
                        {
                           if(13 !== _loc2_)
                           {
                              if(15 !== _loc2_)
                              {
                                 return false;
                              }
                           }
                           addr17:
                           return true;
                        }
                        addr16:
                        §§goto(addr17);
                     }
                     addr15:
                     §§goto(addr16);
                  }
                  addr14:
                  §§goto(addr15);
               }
               addr13:
               §§goto(addr14);
            }
            addr12:
            §§goto(addr13);
         }
         §§goto(addr12);
      }
      
      public static function findItemPlace(item:InventoryItemInfo) : int
      {
         var _loc2_:* = item.CategoryID;
         if(1 !== _loc2_)
         {
            if(2 !== _loc2_)
            {
               if(3 !== _loc2_)
               {
                  if(4 !== _loc2_)
                  {
                     if(5 !== _loc2_)
                     {
                        if(6 !== _loc2_)
                        {
                           if(13 !== _loc2_)
                           {
                              if(15 !== _loc2_)
                              {
                                 return item.Place;
                              }
                              return 13;
                           }
                           return 11;
                        }
                        return 5;
                     }
                     return 4;
                  }
                  return 3;
               }
               return 2;
            }
            return 1;
         }
         return 0;
      }
      
      public static function hasNoAddition(item:InventoryItemInfo) : Boolean
      {
         if(item.isGold == false && item.StrengthenLevel <= 0 && item.AttackCompose <= 0 && item.DefendCompose <= 0 && item.AgilityCompose <= 0 && item.LuckCompose <= 0 && item.Hole5Level <= 0 && item.Hole6Level <= 0 && item.Hole1 <= 0 && item.Hole2 <= 0 && item.Hole3 <= 0 && item.Hole4 <= 0 && item.Hole5 <= 0 && item.Hole6 <= 0 && item.Hole5Exp <= 0 && item.Hole6Exp <= 0 && item.StrengthenExp <= 0 && item.latentEnergyCurStr == "0,0,0,0")
         {
            return true;
         }
         return false;
      }
      
      public static function getBagGoodsCategoryIDSort(CategoryID:uint) : int
      {
         var i:int = 0;
         var arrCategoryIDSort:Array = [7,17,1,5,8,9,2,14,13,15,3,6,4,16];
         for(i = 0; i < arrCategoryIDSort.length; )
         {
            if(CategoryID == arrCategoryIDSort[i])
            {
               return i;
            }
            i++;
         }
         return 9999;
      }
   }
}
