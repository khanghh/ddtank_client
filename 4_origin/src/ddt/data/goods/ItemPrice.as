package ddt.data.goods
{
   import ddt.manager.ItemManager;
   import flash.utils.Dictionary;
   
   public class ItemPrice
   {
       
      
      private var _prices:Dictionary;
      
      private var _pricesArr:Array;
      
      public function ItemPrice(price1:Price, price2:Price, price3:Price)
      {
         super();
         _pricesArr = [];
         _prices = new Dictionary();
         addPrice(price1);
         addPrice(price2);
         addPrice(price3);
      }
      
      public function addPrice(price:Price, bool:Boolean = false, type:int = 0) : void
      {
         if(price == null)
         {
            return;
         }
         _pricesArr.push(price);
         if(bool)
         {
            price.Unit = -11;
         }
         if(type == 1)
         {
            price.Unit = -1;
         }
         else if(type == 2)
         {
            price.Unit = -11;
         }
         else if(type == 3)
         {
            price.Unit = -2;
         }
         if(_prices[price.UnitToString] == null)
         {
            _prices[price.UnitToString] = price.Value;
         }
         else
         {
            _prices[price.UnitToString] = _prices[price.UnitToString] + price.Value;
         }
      }
      
      public function addItemPrice(itemPrice:ItemPrice, bool:Boolean = false, type:int = 0) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = itemPrice.pricesArr;
         for each(var price in itemPrice.pricesArr)
         {
            addPrice(price,bool,type);
         }
      }
      
      public function multiply(value:int) : ItemPrice
      {
         var i:int = 0;
         if(value <= 0)
         {
            throw new Error("Multiply Invalide value!");
         }
         var result:ItemPrice = this.clone();
         for(i = 0; i < value - 1; )
         {
            result.addItemPrice(result.clone());
            i++;
         }
         return result;
      }
      
      public function clone() : ItemPrice
      {
         return new ItemPrice(_pricesArr[0],_pricesArr[1],_pricesArr[2]);
      }
      
      public function get pricesArr() : Array
      {
         return _pricesArr;
      }
      
      public function get lightStoneValue() : int
      {
         if(_prices[Price.LIGHT_STONE_STRING] == null)
         {
            return 0;
         }
         return _prices[Price.LIGHT_STONE_STRING];
      }
      
      public function get hardCurrencyValue() : int
      {
         if(_prices[Price.HARD_CURRENCY_TO_STRING] == null)
         {
            return 0;
         }
         return _prices[Price.HARD_CURRENCY_TO_STRING];
      }
      
      public function get bothMoneyValue() : int
      {
         if(_prices[Price.BOTHMONEYTOSTRING] == null)
         {
            return 0;
         }
         return _prices[Price.BOTHMONEYTOSTRING];
      }
      
      public function get moneyValue() : int
      {
         if(_prices[Price.MONEYTOSTRING] == null)
         {
            return 0;
         }
         return _prices[Price.MONEYTOSTRING];
      }
      
      public function get ddtMoneyValue() : int
      {
         if(_prices[Price.MEDALMONEYTOSTRING] == null)
         {
            return 0;
         }
         return _prices[Price.MEDALMONEYTOSTRING];
      }
      
      public function get ddtPetScoreValue() : int
      {
         if(_prices[Price.PETSCORETOSTRING] == null)
         {
            return 0;
         }
         return _prices[Price.PETSCORETOSTRING];
      }
      
      public function get bandDdtMoneyValue() : int
      {
         if(_prices[Price.DDTMONEYTOSTRING] == null)
         {
            return 0;
         }
         return _prices[Price.DDTMONEYTOSTRING];
      }
      
      public function get goldValue() : int
      {
         if(_prices[Price.GOLDTOSTRING] == null)
         {
            return 0;
         }
         return _prices[Price.GOLDTOSTRING];
      }
      
      public function get gesteValue() : int
      {
         if(_prices[Price.GESTETOSTRING] == null)
         {
            return 0;
         }
         return _prices[Price.GESTETOSTRING];
      }
      
      public function get scoreValue() : int
      {
         if(_prices[Price.SCORETOSTRING] == null)
         {
            return 0;
         }
         return _prices[Price.SCORETOSTRING];
      }
      
      public function get leagueValue() : int
      {
         if(_prices[Price.LEAGUESTRING] == null)
         {
            return 0;
         }
         return _prices[Price.LEAGUESTRING];
      }
      
      public function get fishScoreValue() : int
      {
         if(_prices[Price.FISH_SCORE_STRING] == null)
         {
            return 0;
         }
         return _prices[Price.FISH_SCORE_STRING];
      }
      
      public function get armShellClipValue() : int
      {
         if(_prices[Price.ARM_SHELLCLIP_STRING] == null)
         {
            return 0;
         }
         return _prices[Price.ARM_SHELLCLIP_STRING];
      }
      
      public function getOtherValue(unit:int) : int
      {
         var name:String = ItemManager.Instance.getTemplateById(unit).Name;
         if(_prices[name] == null)
         {
            return 0;
         }
         return _prices[name];
      }
      
      public function get badgeValue() : int
      {
         if(_prices[Price.BADGE_STRING] == null)
         {
            return 0;
         }
         return _prices[Price.BADGE_STRING];
      }
      
      public function get IsValid() : Boolean
      {
         return _pricesArr.length > 0;
      }
      
      public function get IsMixed() : Boolean
      {
         var result:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _prices;
         for(var i in _prices)
         {
            if(_prices[i] > 0)
            {
               result++;
            }
         }
         return result > 1;
      }
      
      public function get petStoneValue() : int
      {
         if(_prices[Price.LIGHT_STONE_STRING] == null)
         {
            return 0;
         }
         return _prices[Price.LIGHT_STONE_STRING];
      }
      
      public function get PriceType() : int
      {
         if(!IsMixed)
         {
            if(bothMoneyValue > 0)
            {
               return -1;
            }
            if(moneyValue > 0)
            {
               return -8;
            }
            if(goldValue > 0)
            {
               return -3;
            }
            if(gesteValue > 0)
            {
               return -4;
            }
            if(scoreValue > 0)
            {
               return -6;
            }
            if(ddtMoneyValue > 0)
            {
               return -2;
            }
            if(hardCurrencyValue > 0)
            {
               return -9;
            }
            if(bandDdtMoneyValue > 0)
            {
               return -9;
            }
            if(petStoneValue > 0)
            {
               return -11;
            }
            if(armShellClipValue > 0)
            {
               return 13000;
            }
            if(leagueValue > 0)
            {
               return -1000;
            }
            return -5;
         }
         return 0;
      }
      
      public function get IsBothMoneyType() : Boolean
      {
         return !IsMixed && bothMoneyValue > 0;
      }
      
      public function get IsMoneyType() : Boolean
      {
         return !IsMixed && moneyValue > 0;
      }
      
      public function get IsPetStoneType() : Boolean
      {
         return !IsMixed && petStoneValue > 0;
      }
      
      public function get isLeagueType() : Boolean
      {
         return !IsMixed && leagueValue > 0;
      }
      
      public function get isArmShellClipType() : Boolean
      {
         return !IsMixed && armShellClipValue > 0;
      }
      
      public function get IsDDTMoneyType() : Boolean
      {
         return !IsMixed && ddtMoneyValue > 0;
      }
      
      public function get IsBandDDTMoneyType() : Boolean
      {
         return !IsMixed && bandDdtMoneyValue > 0;
      }
      
      public function get IsGoldType() : Boolean
      {
         return !IsMixed && goldValue > 0;
      }
      
      public function get IsGesteType() : Boolean
      {
         return !IsMixed && gesteValue > 0;
      }
      
      public function get IsBadgeType() : Boolean
      {
         return !IsMixed && badgeValue > 0;
      }
      
      public function get goodsPrice() : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = _prices;
         for(var key in _prices)
         {
            if(_prices[key] > 0)
            {
               return _prices[key];
            }
         }
         return 0;
      }
      
      public function get goodsPriceToString() : String
      {
         var _loc3_:int = 0;
         var _loc2_:* = _prices;
         for(var key in _prices)
         {
            if(_prices[key] > 0)
            {
               return key;
            }
         }
         return "";
      }
      
      public function toString(bool:Boolean = false) : String
      {
         var result:String = "";
         if(bothMoneyValue > 0)
         {
            if(bool)
            {
               result = result + (bothMoneyValue.toString() + " " + Price.DDTMONEYTOSTRING);
            }
            else
            {
               result = result + (bothMoneyValue.toString() + " " + Price.MONEYTOSTRING);
            }
         }
         if(moneyValue > 0)
         {
            result = result + (moneyValue.toString() + " " + Price.MONEYTOSTRING);
         }
         if(goldValue > 0)
         {
            result = result + (goldValue.toString() + " " + Price.GOLDTOSTRING);
         }
         if(gesteValue > 0)
         {
            result = result + (gesteValue.toString() + " " + Price.GESTETOSTRING);
         }
         if(ddtMoneyValue > 0)
         {
            result = result + (ddtMoneyValue.toString() + " " + Price.MEDALMONEYTOSTRING);
         }
         if(bandDdtMoneyValue > 0)
         {
            result = result + (bandDdtMoneyValue.toString() + " " + Price.DDTMONEYTOSTRING);
         }
         if(ddtPetScoreValue > 0)
         {
            result = result + (ddtPetScoreValue.toString() + " " + Price.PETSCORETOSTRING);
         }
         var _loc5_:int = 0;
         var _loc4_:* = _prices;
         for(var i in _prices)
         {
            if(i != Price.MONEYTOSTRING && i != Price.GOLDTOSTRING && i != Price.GESTETOSTRING && i != Price.DDTMONEYTOSTRING && i != Price.PETSCORETOSTRING && i != Price.MEDALMONEYTOSTRING && i != Price.BOTHMONEYTOSTRING)
            {
               result = result + (_prices[i].toString() + " " + i);
            }
         }
         return result;
      }
      
      public function toStringI() : String
      {
         var result:String = "";
         if(moneyValue > 0)
         {
            result = result + (moneyValue.toString() + " " + Price.MONEYTOSTRING);
         }
         if(goldValue > 0)
         {
            result = result + (goldValue.toString() + " " + Price.GOLDTOSTRING);
         }
         if(gesteValue > 0)
         {
            result = result + (gesteValue.toString() + " " + Price.GESTETOSTRING);
         }
         if(bandDdtMoneyValue > 0)
         {
            result = result + (bandDdtMoneyValue.toString() + " " + Price.DDTMONEYTOSTRING);
         }
         if(badgeValue > 0)
         {
            result = result + (badgeValue.toString() + " " + 12567);
         }
         var _loc4_:int = 0;
         var _loc3_:* = _prices;
         for(var i in _prices)
         {
            if(i != Price.MONEYTOSTRING && i != Price.GOLDTOSTRING && i != Price.GESTETOSTRING && i != Price.DDTMONEYTOSTRING)
            {
               result = result + (_prices[i].toString() + " " + i);
            }
         }
         return result;
      }
   }
}
