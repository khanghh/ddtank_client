package playerDress.components
{
   import ddt.data.goods.InventoryItemInfo;
   
   public class DressUtils
   {
       
      
      public function DressUtils()
      {
         super();
      }
      
      public static function getBagItems(param1:int, param2:Boolean = false) : int
      {
         var _loc3_:Array = [0,2,4,11,1,3,5,13];
         if(!param2)
         {
            return _loc3_[param1] != null?_loc3_[param1]:-1;
         }
         return _loc3_.indexOf(param1);
      }
      
      public static function isDress(param1:InventoryItemInfo) : Boolean
      {
         var _loc2_:* = param1.CategoryID;
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
                           addr13:
                           return true;
                        }
                        addr12:
                        §§goto(addr13);
                     }
                     addr11:
                     §§goto(addr12);
                  }
                  addr10:
                  §§goto(addr11);
               }
               addr9:
               §§goto(addr10);
            }
            addr8:
            §§goto(addr9);
         }
         §§goto(addr8);
      }
      
      public static function findItemPlace(param1:InventoryItemInfo) : int
      {
         var _loc2_:* = param1.CategoryID;
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
                                 return param1.Place;
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
      
      public static function hasNoAddition(param1:InventoryItemInfo) : Boolean
      {
         if(param1.isGold == false && param1.StrengthenLevel <= 0 && param1.AttackCompose <= 0 && param1.DefendCompose <= 0 && param1.AgilityCompose <= 0 && param1.LuckCompose <= 0 && param1.Hole5Level <= 0 && param1.Hole6Level <= 0 && param1.Hole1 <= 0 && param1.Hole2 <= 0 && param1.Hole3 <= 0 && param1.Hole4 <= 0 && param1.Hole5 <= 0 && param1.Hole6 <= 0 && param1.Hole5Exp <= 0 && param1.Hole6Exp <= 0 && param1.StrengthenExp <= 0 && param1.latentEnergyCurStr == "0,0,0,0")
         {
            return true;
         }
         return false;
      }
      
      public static function getBagGoodsCategoryIDSort(param1:uint) : int
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [7,17,1,5,8,9,2,14,13,15,3,6,4,16];
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(param1 == _loc2_[_loc3_])
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return 9999;
      }
   }
}
