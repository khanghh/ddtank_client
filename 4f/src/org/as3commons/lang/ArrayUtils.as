package org.as3commons.lang{   public final class ArrayUtils   {                   public function ArrayUtils() { super(); }
            public static function containsAny(array:Array, items:Array) : Boolean { return false; }
            public static function containsAnyEquality(array:Array, items:Array) : Boolean { return false; }
            public static function containsAnyStrictEquality(array:Array, items:Array) : Boolean { return false; }
            public static function containsAnyEquals(array:Array, items:Array) : Boolean { return false; }
            private static function containsAnyWithComparisonFunction(array:Array, items:Array, comparisonFunction:Function) : Boolean { return false; }
            public static function containsAll(array:Array, find:Array) : Boolean { return false; }
            public static function containsAllEquality(array:Array, items:Array) : Boolean { return false; }
            public static function containsAllStrictEquality(array:Array, items:Array) : Boolean { return false; }
            public static function containsAllEquals(array:Array, items:Array) : Boolean { return false; }
            private static function containsAllWithComparisonFunction(array:Array, items:Array, comparisonFunction:Function) : Boolean { return false; }
            public static function contains(array:Array, item:*) : Boolean { return false; }
            public static function containsEquality(array:Array, item:*) : Boolean { return false; }
            public static function containsStrictEquality(array:Array, item:*) : Boolean { return false; }
            public static function containsEquals(array:Array, item:IEquals) : Boolean { return false; }
            public static function indexOf(array:Array, item:*) : int { return 0; }
            public static function indexOfEquality(array:Array, item:*) : int { return 0; }
            public static function indexOfStrictEquality(array:Array, item:*) : int { return 0; }
            public static function indexOfEquals(array:Array, item:IEquals) : int { return 0; }
            private static function indexOfWithComparisonFunction(array:Array, item:*, comparisonFunction:Function) : int { return 0; }
            private static function compareEquality(item1:*, item2:*) : Boolean { return false; }
            private static function compareStrictEquality(item1:*, item2:*) : Boolean { return false; }
            private static function compareEquals(item1:IEquals, item2:IEquals) : Boolean { return false; }
            public static function removeAllItems(array:Array, itemsToRemove:Array) : Array { return null; }
            public static function removeAllItemsEquality(array:Array, itemsToRemove:Array) : Array { return null; }
            public static function removeAllItemsStrictEquality(array:Array, itemsToRemove:Array) : Array { return null; }
            public static function removeAllItemsEquals(array:Array, itemsToRemove:Array) : Array { return null; }
            private static function removeAllItemsWithRemoveFunction(array:Array, itemsToRemove:Array, removeFunction:Function) : Array { return null; }
            public static function removeItem(array:Array, item:*) : Array { return null; }
            public static function removeItemEquality(array:Array, item:*) : Array { return null; }
            public static function removeItemStrictEquality(array:Array, item:*) : Array { return null; }
            public static function removeItemEquals(array:Array, item:*) : Array { return null; }
            private static function removeItemWithComparisonFunction(array:Array, item:*, comparisonFunction:Function) : Array { return null; }
            public static function removeLastOccurance(array:Array, item:*) : int { return 0; }
            public static function removeFirstOccurance(array:Array, item:*) : int { return 0; }
            public static function shuffle(array:Array) : void { }
            public static function isSame(array1:Array, array2:Array) : Boolean { return false; }
            public static function getLength(array:Array) : int { return 0; }
            public static function getUniqueValues(array:Array) : Array { return null; }
            public static function getItemAt(array:Array, index:int, defaultValue:* = null) : * { return null; }
            public static function getItemsByType(items:Array, type:Class) : Array { return null; }
            public static function addAll(array:Array, itemsToAdd:Array) : void { }
            public static function addAllIgnoreNull(array:Array, itemsToAdd:Array) : void { }
            public static function addIgnoreNull(array:Array, element:*) : void { }
            public static function moveElement(array:Array, element:*, newIndex:int) : void { }
            public static function removeAll(array:Array) : void { }
            public static function isNotEmpty(array:Array) : Boolean { return false; }
            public static function isEmpty(array:Array) : Boolean { return false; }
            public static function clone(array:Array) : Array { return null; }
            public static function toString(array:Array, separator:String = ", ") : String { return null; }
   }}