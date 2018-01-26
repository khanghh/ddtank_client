package ddt.data.goods
{
   import ddt.manager.ItemManager;
   import flash.utils.Dictionary;
   
   public class ItemPrice
   {
       
      
      private var _prices:Dictionary;
      
      private var _pricesArr:Array;
      
      public function ItemPrice(param1:Price, param2:Price, param3:Price){super();}
      
      public function addPrice(param1:Price, param2:Boolean = false, param3:int = 0) : void{}
      
      public function addItemPrice(param1:ItemPrice, param2:Boolean = false, param3:int = 0) : void{}
      
      public function multiply(param1:int) : ItemPrice{return null;}
      
      public function clone() : ItemPrice{return null;}
      
      public function get pricesArr() : Array{return null;}
      
      public function get lightStoneValue() : int{return 0;}
      
      public function get hardCurrencyValue() : int{return 0;}
      
      public function get bothMoneyValue() : int{return 0;}
      
      public function get moneyValue() : int{return 0;}
      
      public function get ddtMoneyValue() : int{return 0;}
      
      public function get ddtPetScoreValue() : int{return 0;}
      
      public function get bandDdtMoneyValue() : int{return 0;}
      
      public function get goldValue() : int{return 0;}
      
      public function get gesteValue() : int{return 0;}
      
      public function get scoreValue() : int{return 0;}
      
      public function get leagueValue() : int{return 0;}
      
      public function get fishScoreValue() : int{return 0;}
      
      public function get armShellClipValue() : int{return 0;}
      
      public function getOtherValue(param1:int) : int{return 0;}
      
      public function get badgeValue() : int{return 0;}
      
      public function get IsValid() : Boolean{return false;}
      
      public function get IsMixed() : Boolean{return false;}
      
      public function get petStoneValue() : int{return 0;}
      
      public function get PriceType() : int{return 0;}
      
      public function get IsBothMoneyType() : Boolean{return false;}
      
      public function get IsMoneyType() : Boolean{return false;}
      
      public function get IsPetStoneType() : Boolean{return false;}
      
      public function get isLeagueType() : Boolean{return false;}
      
      public function get isArmShellClipType() : Boolean{return false;}
      
      public function get IsDDTMoneyType() : Boolean{return false;}
      
      public function get IsBandDDTMoneyType() : Boolean{return false;}
      
      public function get IsGoldType() : Boolean{return false;}
      
      public function get IsGesteType() : Boolean{return false;}
      
      public function get IsBadgeType() : Boolean{return false;}
      
      public function toString(param1:Boolean = false) : String{return null;}
      
      public function toStringI() : String{return null;}
   }
}
