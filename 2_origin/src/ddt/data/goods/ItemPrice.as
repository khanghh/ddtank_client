package ddt.data.goods
{
   import ddt.manager.ItemManager;
   import flash.utils.Dictionary;
   
   public class ItemPrice
   {
       
      
      private var _prices:Dictionary;
      
      private var _pricesArr:Array;
      
      public function ItemPrice(param1:Price, param2:Price, param3:Price)
      {
         super();
         _pricesArr = [];
         _prices = new Dictionary();
         addPrice(param1);
         addPrice(param2);
         addPrice(param3);
      }
      
      public function addPrice(param1:Price, param2:Boolean = false, param3:int = 0) : void
      {
         if(param1 == null)
         {
            return;
         }
         _pricesArr.push(param1);
         if(param2)
         {
            param1.Unit = -11;
         }
         if(param3 == 1)
         {
            param1.Unit = -1;
         }
         else if(param3 == 2)
         {
            param1.Unit = -11;
         }
         else if(param3 == 3)
         {
            param1.Unit = -2;
         }
         if(_prices[param1.UnitToString] == null)
         {
            _prices[param1.UnitToString] = param1.Value;
         }
         else
         {
            _prices[param1.UnitToString] = _prices[param1.UnitToString] + param1.Value;
         }
      }
      
      public function addItemPrice(param1:ItemPrice, param2:Boolean = false, param3:int = 0) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = param1.pricesArr;
         for each(var _loc4_ in param1.pricesArr)
         {
            addPrice(_loc4_,param2,param3);
         }
      }
      
      public function multiply(param1:int) : ItemPrice
      {
         var _loc3_:int = 0;
         if(param1 <= 0)
         {
            throw new Error("Multiply Invalide value!");
         }
         var _loc2_:ItemPrice = this.clone();
         _loc3_ = 0;
         while(_loc3_ < param1 - 1)
         {
            _loc2_.addItemPrice(_loc2_.clone());
            _loc3_++;
         }
         return _loc2_;
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
      
      public function getOtherValue(param1:int) : int
      {
         var _loc2_:String = ItemManager.Instance.getTemplateById(param1).Name;
         if(_prices[_loc2_] == null)
         {
            return 0;
         }
         return _prices[_loc2_];
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
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _prices;
         for(var _loc2_ in _prices)
         {
            if(_prices[_loc2_] > 0)
            {
               _loc1_++;
            }
         }
         return _loc1_ > 1;
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
         for(var _loc1_ in _prices)
         {
            if(_prices[_loc1_] > 0)
            {
               return _prices[_loc1_];
            }
         }
         return 0;
      }
      
      public function get goodsPriceToString() : String
      {
         var _loc3_:int = 0;
         var _loc2_:* = _prices;
         for(var _loc1_ in _prices)
         {
            if(_prices[_loc1_] > 0)
            {
               return _loc1_;
            }
         }
         return "";
      }
      
      public function toString(param1:Boolean = false) : String
      {
         var _loc2_:String = "";
         if(bothMoneyValue > 0)
         {
            if(param1)
            {
               _loc2_ = _loc2_ + (bothMoneyValue.toString() + " " + Price.DDTMONEYTOSTRING);
            }
            else
            {
               _loc2_ = _loc2_ + (bothMoneyValue.toString() + " " + Price.MONEYTOSTRING);
            }
         }
         if(moneyValue > 0)
         {
            _loc2_ = _loc2_ + (moneyValue.toString() + " " + Price.MONEYTOSTRING);
         }
         if(goldValue > 0)
         {
            _loc2_ = _loc2_ + (goldValue.toString() + " " + Price.GOLDTOSTRING);
         }
         if(gesteValue > 0)
         {
            _loc2_ = _loc2_ + (gesteValue.toString() + " " + Price.GESTETOSTRING);
         }
         if(ddtMoneyValue > 0)
         {
            _loc2_ = _loc2_ + (ddtMoneyValue.toString() + " " + Price.MEDALMONEYTOSTRING);
         }
         if(bandDdtMoneyValue > 0)
         {
            _loc2_ = _loc2_ + (bandDdtMoneyValue.toString() + " " + Price.DDTMONEYTOSTRING);
         }
         if(ddtPetScoreValue > 0)
         {
            _loc2_ = _loc2_ + (ddtPetScoreValue.toString() + " " + Price.PETSCORETOSTRING);
         }
         var _loc5_:int = 0;
         var _loc4_:* = _prices;
         for(var _loc3_ in _prices)
         {
            if(_loc3_ != Price.MONEYTOSTRING && _loc3_ != Price.GOLDTOSTRING && _loc3_ != Price.GESTETOSTRING && _loc3_ != Price.DDTMONEYTOSTRING && _loc3_ != Price.PETSCORETOSTRING && _loc3_ != Price.MEDALMONEYTOSTRING && _loc3_ != Price.BOTHMONEYTOSTRING)
            {
               _loc2_ = _loc2_ + (_prices[_loc3_].toString() + " " + _loc3_);
            }
         }
         return _loc2_;
      }
      
      public function toStringI() : String
      {
         var _loc1_:String = "";
         if(moneyValue > 0)
         {
            _loc1_ = _loc1_ + (moneyValue.toString() + " " + Price.MONEYTOSTRING);
         }
         if(goldValue > 0)
         {
            _loc1_ = _loc1_ + (goldValue.toString() + " " + Price.GOLDTOSTRING);
         }
         if(gesteValue > 0)
         {
            _loc1_ = _loc1_ + (gesteValue.toString() + " " + Price.GESTETOSTRING);
         }
         if(bandDdtMoneyValue > 0)
         {
            _loc1_ = _loc1_ + (bandDdtMoneyValue.toString() + " " + Price.DDTMONEYTOSTRING);
         }
         if(badgeValue > 0)
         {
            _loc1_ = _loc1_ + (badgeValue.toString() + " " + 12567);
         }
         var _loc4_:int = 0;
         var _loc3_:* = _prices;
         for(var _loc2_ in _prices)
         {
            if(_loc2_ != Price.MONEYTOSTRING && _loc2_ != Price.GOLDTOSTRING && _loc2_ != Price.GESTETOSTRING && _loc2_ != Price.DDTMONEYTOSTRING)
            {
               _loc1_ = _loc1_ + (_prices[_loc2_].toString() + " " + _loc2_);
            }
         }
         return _loc1_;
      }
   }
}
