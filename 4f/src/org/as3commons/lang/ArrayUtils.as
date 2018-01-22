package org.as3commons.lang
{
   public final class ArrayUtils
   {
       
      
      public function ArrayUtils(){super();}
      
      public static function containsAny(param1:Array, param2:Array) : Boolean{return false;}
      
      public static function containsAnyEquality(param1:Array, param2:Array) : Boolean{return false;}
      
      public static function containsAnyStrictEquality(param1:Array, param2:Array) : Boolean{return false;}
      
      public static function containsAnyEquals(param1:Array, param2:Array) : Boolean{return false;}
      
      private static function containsAnyWithComparisonFunction(param1:Array, param2:Array, param3:Function) : Boolean{return false;}
      
      public static function containsAll(param1:Array, param2:Array) : Boolean{return false;}
      
      public static function containsAllEquality(param1:Array, param2:Array) : Boolean{return false;}
      
      public static function containsAllStrictEquality(param1:Array, param2:Array) : Boolean{return false;}
      
      public static function containsAllEquals(param1:Array, param2:Array) : Boolean{return false;}
      
      private static function containsAllWithComparisonFunction(param1:Array, param2:Array, param3:Function) : Boolean{return false;}
      
      public static function contains(param1:Array, param2:*) : Boolean{return false;}
      
      public static function containsEquality(param1:Array, param2:*) : Boolean{return false;}
      
      public static function containsStrictEquality(param1:Array, param2:*) : Boolean{return false;}
      
      public static function containsEquals(param1:Array, param2:IEquals) : Boolean{return false;}
      
      public static function indexOf(param1:Array, param2:*) : int{return 0;}
      
      public static function indexOfEquality(param1:Array, param2:*) : int{return 0;}
      
      public static function indexOfStrictEquality(param1:Array, param2:*) : int{return 0;}
      
      public static function indexOfEquals(param1:Array, param2:IEquals) : int{return 0;}
      
      private static function indexOfWithComparisonFunction(param1:Array, param2:*, param3:Function) : int{return 0;}
      
      private static function compareEquality(param1:*, param2:*) : Boolean{return false;}
      
      private static function compareStrictEquality(param1:*, param2:*) : Boolean{return false;}
      
      private static function compareEquals(param1:IEquals, param2:IEquals) : Boolean{return false;}
      
      public static function removeAllItems(param1:Array, param2:Array) : Array{return null;}
      
      public static function removeAllItemsEquality(param1:Array, param2:Array) : Array{return null;}
      
      public static function removeAllItemsStrictEquality(param1:Array, param2:Array) : Array{return null;}
      
      public static function removeAllItemsEquals(param1:Array, param2:Array) : Array{return null;}
      
      private static function removeAllItemsWithRemoveFunction(param1:Array, param2:Array, param3:Function) : Array{return null;}
      
      public static function removeItem(param1:Array, param2:*) : Array{return null;}
      
      public static function removeItemEquality(param1:Array, param2:*) : Array{return null;}
      
      public static function removeItemStrictEquality(param1:Array, param2:*) : Array{return null;}
      
      public static function removeItemEquals(param1:Array, param2:*) : Array{return null;}
      
      private static function removeItemWithComparisonFunction(param1:Array, param2:*, param3:Function) : Array{return null;}
      
      public static function removeLastOccurance(param1:Array, param2:*) : int{return 0;}
      
      public static function removeFirstOccurance(param1:Array, param2:*) : int{return 0;}
      
      public static function shuffle(param1:Array) : void{}
      
      public static function isSame(param1:Array, param2:Array) : Boolean{return false;}
      
      public static function getLength(param1:Array) : int{return 0;}
      
      public static function getUniqueValues(param1:Array) : Array{return null;}
      
      public static function getItemAt(param1:Array, param2:int, param3:* = null) : *{return null;}
      
      public static function getItemsByType(param1:Array, param2:Class) : Array{return null;}
      
      public static function addAll(param1:Array, param2:Array) : void{}
      
      public static function addAllIgnoreNull(param1:Array, param2:Array) : void{}
      
      public static function addIgnoreNull(param1:Array, param2:*) : void{}
      
      public static function moveElement(param1:Array, param2:*, param3:int) : void{}
      
      public static function removeAll(param1:Array) : void{}
      
      public static function isNotEmpty(param1:Array) : Boolean{return false;}
      
      public static function isEmpty(param1:Array) : Boolean{return false;}
      
      public static function clone(param1:Array) : Array{return null;}
      
      public static function toString(param1:Array, param2:String = ", ") : String{return null;}
   }
}
