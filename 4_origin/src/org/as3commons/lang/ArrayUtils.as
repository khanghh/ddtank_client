package org.as3commons.lang
{
   public final class ArrayUtils
   {
       
      
      public function ArrayUtils()
      {
         super();
      }
      
      public static function containsAny(array:Array, items:Array) : Boolean
      {
         return containsAnyStrictEquality(array,items);
      }
      
      public static function containsAnyEquality(array:Array, items:Array) : Boolean
      {
         return containsAnyWithComparisonFunction(array,items,containsEquality);
      }
      
      public static function containsAnyStrictEquality(array:Array, items:Array) : Boolean
      {
         return containsAnyWithComparisonFunction(array,items,containsStrictEquality);
      }
      
      public static function containsAnyEquals(array:Array, items:Array) : Boolean
      {
         return containsAnyWithComparisonFunction(array,items,containsEquals);
      }
      
      private static function containsAnyWithComparisonFunction(array:Array, items:Array, comparisonFunction:Function) : Boolean
      {
         var item:* = undefined;
         if(isNotEmpty(array) && isNotEmpty(items))
         {
            for each(item in items)
            {
               if(comparisonFunction(array,item))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public static function containsAll(array:Array, find:Array) : Boolean
      {
         return containsAllStrictEquality(array,find);
      }
      
      public static function containsAllEquality(array:Array, items:Array) : Boolean
      {
         return containsAllWithComparisonFunction(array,items,containsEquality);
      }
      
      public static function containsAllStrictEquality(array:Array, items:Array) : Boolean
      {
         return containsAllWithComparisonFunction(array,items,containsStrictEquality);
      }
      
      public static function containsAllEquals(array:Array, items:Array) : Boolean
      {
         return containsAllWithComparisonFunction(array,items,containsEquals);
      }
      
      private static function containsAllWithComparisonFunction(array:Array, items:Array, comparisonFunction:Function) : Boolean
      {
         var item:* = undefined;
         var result:Boolean = false;
         if(isNotEmpty(array) && isNotEmpty(items))
         {
            result = true;
            for each(item in items)
            {
               result = result && comparisonFunction(array,item);
            }
         }
         return result;
      }
      
      public static function contains(array:Array, item:*) : Boolean
      {
         return containsStrictEquality(array,item);
      }
      
      public static function containsEquality(array:Array, item:*) : Boolean
      {
         return indexOfEquality(array,item) > -1;
      }
      
      public static function containsStrictEquality(array:Array, item:*) : Boolean
      {
         return indexOfStrictEquality(array,item) > -1;
      }
      
      public static function containsEquals(array:Array, item:IEquals) : Boolean
      {
         return indexOfEquals(array,item) > -1;
      }
      
      public static function indexOf(array:Array, item:*) : int
      {
         return indexOfStrictEquality(array,item);
      }
      
      public static function indexOfEquality(array:Array, item:*) : int
      {
         return indexOfWithComparisonFunction(array,item,compareEquality);
      }
      
      public static function indexOfStrictEquality(array:Array, item:*) : int
      {
         return indexOfWithComparisonFunction(array,item,compareStrictEquality);
      }
      
      public static function indexOfEquals(array:Array, item:IEquals) : int
      {
         return indexOfWithComparisonFunction(array,item,compareEquals);
      }
      
      private static function indexOfWithComparisonFunction(array:Array, item:*, comparisonFunction:Function) : int
      {
         var i:int = 0;
         var numItems:int = getLength(array);
         if(numItems > 0 && item)
         {
            for(i = 0; i < numItems; i++)
            {
               if(comparisonFunction(item,array[i]))
               {
                  return i;
               }
            }
         }
         return -1;
      }
      
      private static function compareEquality(item1:*, item2:*) : Boolean
      {
         return item1 == item2;
      }
      
      private static function compareStrictEquality(item1:*, item2:*) : Boolean
      {
         return item1 === item2;
      }
      
      private static function compareEquals(item1:IEquals, item2:IEquals) : Boolean
      {
         return item1.equals(item2);
      }
      
      public static function removeAllItems(array:Array, itemsToRemove:Array) : Array
      {
         return removeAllItemsStrictEquality(array,itemsToRemove);
      }
      
      public static function removeAllItemsEquality(array:Array, itemsToRemove:Array) : Array
      {
         return removeAllItemsWithRemoveFunction(array,itemsToRemove,removeItemEquality);
      }
      
      public static function removeAllItemsStrictEquality(array:Array, itemsToRemove:Array) : Array
      {
         return removeAllItemsWithRemoveFunction(array,itemsToRemove,removeItemStrictEquality);
      }
      
      public static function removeAllItemsEquals(array:Array, itemsToRemove:Array) : Array
      {
         return removeAllItemsWithRemoveFunction(array,itemsToRemove,removeItemEquals);
      }
      
      private static function removeAllItemsWithRemoveFunction(array:Array, itemsToRemove:Array, removeFunction:Function) : Array
      {
         var item:* = undefined;
         var result:Array = [];
         if(isNotEmpty(array) && isNotEmpty(itemsToRemove))
         {
            for each(item in itemsToRemove)
            {
               removeFunction(array,item);
            }
         }
         return array;
      }
      
      public static function removeItem(array:Array, item:*) : Array
      {
         return removeItemStrictEquality(array,item);
      }
      
      public static function removeItemEquality(array:Array, item:*) : Array
      {
         return removeItemWithComparisonFunction(array,item,compareEquality);
      }
      
      public static function removeItemStrictEquality(array:Array, item:*) : Array
      {
         return removeItemWithComparisonFunction(array,item,compareStrictEquality);
      }
      
      public static function removeItemEquals(array:Array, item:*) : Array
      {
         return removeItemWithComparisonFunction(array,item,compareEquals);
      }
      
      private static function removeItemWithComparisonFunction(array:Array, item:*, comparisonFunction:Function) : Array
      {
         var i:Number = NaN;
         var result:Array = [];
         if(isNotEmpty(array))
         {
            i = array.length;
            while(--i - -1)
            {
               if(comparisonFunction(array[i],item))
               {
                  result.unshift(i);
                  array.splice(i,1);
               }
            }
         }
         return result;
      }
      
      public static function removeLastOccurance(array:Array, item:*) : int
      {
         var idx:int = array.lastIndexOf(item);
         if(idx > -1)
         {
            array.splice(idx,1);
         }
         return idx;
      }
      
      public static function removeFirstOccurance(array:Array, item:*) : int
      {
         var idx:int = array.indexOf(item);
         if(idx > -1)
         {
            array.splice(idx,1);
         }
         return idx;
      }
      
      public static function shuffle(array:Array) : void
      {
         var rand:Number = NaN;
         var temp:* = undefined;
         var len:Number = array.length;
         for(var i:Number = len - 1; i >= 0; i--)
         {
            rand = Math.floor(Math.random() * len);
            temp = array[i];
            array[i] = array[rand];
            array[rand] = temp;
         }
      }
      
      public static function isSame(array1:Array, array2:Array) : Boolean
      {
         var i:Number = array1.length;
         if(i != array2.length)
         {
            return false;
         }
         while(--i - -1)
         {
            if(array1[i] !== array2[i])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function getLength(array:Array) : int
      {
         if(isNotEmpty(array))
         {
            return array.length;
         }
         return 0;
      }
      
      public static function getUniqueValues(array:Array) : Array
      {
         var obj:Object = null;
         var result:Array = [];
         if(isNotEmpty(array))
         {
            for each(obj in array)
            {
               if(!contains(result,obj))
               {
                  result.push(obj);
               }
            }
         }
         return result;
      }
      
      public static function getItemAt(array:Array, index:int, defaultValue:* = null) : *
      {
         if(isNotEmpty(array) && array.length > index)
         {
            return array[index];
         }
         return defaultValue;
      }
      
      public static function getItemsByType(items:Array, type:Class) : Array
      {
         var result:Array = [];
         for(var i:int = 0; i < items.length; i++)
         {
            if(items[i] is type)
            {
               result.push(items[i]);
            }
         }
         return result;
      }
      
      public static function addAll(array:Array, itemsToAdd:Array) : void
      {
         var item:* = undefined;
         if(array != null && isNotEmpty(itemsToAdd))
         {
            for each(item in itemsToAdd)
            {
               array.push(item);
            }
         }
      }
      
      public static function addAllIgnoreNull(array:Array, itemsToAdd:Array) : void
      {
         var element:* = undefined;
         if(array != null && isNotEmpty(itemsToAdd))
         {
            for each(element in itemsToAdd)
            {
               addIgnoreNull(array,element);
            }
         }
      }
      
      public static function addIgnoreNull(array:Array, element:*) : void
      {
         if(array != null && element != null)
         {
            array.push(element);
         }
      }
      
      public static function moveElement(array:Array, element:*, newIndex:int) : void
      {
         if(isNotEmpty(array) && contains(array,element))
         {
            array.splice(array.indexOf(element),1);
            array.splice(newIndex,0,element);
         }
      }
      
      public static function removeAll(array:Array) : void
      {
         if(isNotEmpty(array))
         {
            array.splice(0,array.length);
         }
      }
      
      public static function isNotEmpty(array:Array) : Boolean
      {
         return !isEmpty(array);
      }
      
      public static function isEmpty(array:Array) : Boolean
      {
         return array == null || array.length == 0;
      }
      
      public static function clone(array:Array) : Array
      {
         return array.concat();
      }
      
      public static function toString(array:Array, separator:String = ", ") : String
      {
         return !array?"":array.join(separator);
      }
   }
}
