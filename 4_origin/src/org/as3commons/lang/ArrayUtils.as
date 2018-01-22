package org.as3commons.lang
{
   public final class ArrayUtils
   {
       
      
      public function ArrayUtils()
      {
         super();
      }
      
      public static function containsAny(param1:Array, param2:Array) : Boolean
      {
         return containsAnyStrictEquality(param1,param2);
      }
      
      public static function containsAnyEquality(param1:Array, param2:Array) : Boolean
      {
         return containsAnyWithComparisonFunction(param1,param2,containsEquality);
      }
      
      public static function containsAnyStrictEquality(param1:Array, param2:Array) : Boolean
      {
         return containsAnyWithComparisonFunction(param1,param2,containsStrictEquality);
      }
      
      public static function containsAnyEquals(param1:Array, param2:Array) : Boolean
      {
         return containsAnyWithComparisonFunction(param1,param2,containsEquals);
      }
      
      private static function containsAnyWithComparisonFunction(param1:Array, param2:Array, param3:Function) : Boolean
      {
         var _loc4_:* = undefined;
         if(isNotEmpty(param1) && isNotEmpty(param2))
         {
            for each(_loc4_ in param2)
            {
               if(param3(param1,_loc4_))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public static function containsAll(param1:Array, param2:Array) : Boolean
      {
         return containsAllStrictEquality(param1,param2);
      }
      
      public static function containsAllEquality(param1:Array, param2:Array) : Boolean
      {
         return containsAllWithComparisonFunction(param1,param2,containsEquality);
      }
      
      public static function containsAllStrictEquality(param1:Array, param2:Array) : Boolean
      {
         return containsAllWithComparisonFunction(param1,param2,containsStrictEquality);
      }
      
      public static function containsAllEquals(param1:Array, param2:Array) : Boolean
      {
         return containsAllWithComparisonFunction(param1,param2,containsEquals);
      }
      
      private static function containsAllWithComparisonFunction(param1:Array, param2:Array, param3:Function) : Boolean
      {
         var _loc5_:* = undefined;
         var _loc4_:Boolean = false;
         if(isNotEmpty(param1) && isNotEmpty(param2))
         {
            _loc4_ = true;
            for each(_loc5_ in param2)
            {
               _loc4_ = _loc4_ && param3(param1,_loc5_);
            }
         }
         return _loc4_;
      }
      
      public static function contains(param1:Array, param2:*) : Boolean
      {
         return containsStrictEquality(param1,param2);
      }
      
      public static function containsEquality(param1:Array, param2:*) : Boolean
      {
         return indexOfEquality(param1,param2) > -1;
      }
      
      public static function containsStrictEquality(param1:Array, param2:*) : Boolean
      {
         return indexOfStrictEquality(param1,param2) > -1;
      }
      
      public static function containsEquals(param1:Array, param2:IEquals) : Boolean
      {
         return indexOfEquals(param1,param2) > -1;
      }
      
      public static function indexOf(param1:Array, param2:*) : int
      {
         return indexOfStrictEquality(param1,param2);
      }
      
      public static function indexOfEquality(param1:Array, param2:*) : int
      {
         return indexOfWithComparisonFunction(param1,param2,compareEquality);
      }
      
      public static function indexOfStrictEquality(param1:Array, param2:*) : int
      {
         return indexOfWithComparisonFunction(param1,param2,compareStrictEquality);
      }
      
      public static function indexOfEquals(param1:Array, param2:IEquals) : int
      {
         return indexOfWithComparisonFunction(param1,param2,compareEquals);
      }
      
      private static function indexOfWithComparisonFunction(param1:Array, param2:*, param3:Function) : int
      {
         var _loc5_:int = 0;
         var _loc4_:int = getLength(param1);
         if(_loc4_ > 0 && param2)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(param3(param2,param1[_loc5_]))
               {
                  return _loc5_;
               }
               _loc5_++;
            }
         }
         return -1;
      }
      
      private static function compareEquality(param1:*, param2:*) : Boolean
      {
         return param1 == param2;
      }
      
      private static function compareStrictEquality(param1:*, param2:*) : Boolean
      {
         return param1 === param2;
      }
      
      private static function compareEquals(param1:IEquals, param2:IEquals) : Boolean
      {
         return param1.equals(param2);
      }
      
      public static function removeAllItems(param1:Array, param2:Array) : Array
      {
         return removeAllItemsStrictEquality(param1,param2);
      }
      
      public static function removeAllItemsEquality(param1:Array, param2:Array) : Array
      {
         return removeAllItemsWithRemoveFunction(param1,param2,removeItemEquality);
      }
      
      public static function removeAllItemsStrictEquality(param1:Array, param2:Array) : Array
      {
         return removeAllItemsWithRemoveFunction(param1,param2,removeItemStrictEquality);
      }
      
      public static function removeAllItemsEquals(param1:Array, param2:Array) : Array
      {
         return removeAllItemsWithRemoveFunction(param1,param2,removeItemEquals);
      }
      
      private static function removeAllItemsWithRemoveFunction(param1:Array, param2:Array, param3:Function) : Array
      {
         var _loc5_:* = undefined;
         var _loc4_:Array = [];
         if(isNotEmpty(param1) && isNotEmpty(param2))
         {
            for each(_loc5_ in param2)
            {
               param3(param1,_loc5_);
            }
         }
         return param1;
      }
      
      public static function removeItem(param1:Array, param2:*) : Array
      {
         return removeItemStrictEquality(param1,param2);
      }
      
      public static function removeItemEquality(param1:Array, param2:*) : Array
      {
         return removeItemWithComparisonFunction(param1,param2,compareEquality);
      }
      
      public static function removeItemStrictEquality(param1:Array, param2:*) : Array
      {
         return removeItemWithComparisonFunction(param1,param2,compareStrictEquality);
      }
      
      public static function removeItemEquals(param1:Array, param2:*) : Array
      {
         return removeItemWithComparisonFunction(param1,param2,compareEquals);
      }
      
      private static function removeItemWithComparisonFunction(param1:Array, param2:*, param3:Function) : Array
      {
         var _loc5_:Number = NaN;
         var _loc4_:Array = [];
         if(isNotEmpty(param1))
         {
            _loc5_ = param1.length;
            while(--_loc5_ - -1)
            {
               if(param3(param1[_loc5_],param2))
               {
                  _loc4_.unshift(_loc5_);
                  param1.splice(_loc5_,1);
               }
            }
         }
         return _loc4_;
      }
      
      public static function removeLastOccurance(param1:Array, param2:*) : int
      {
         var _loc3_:int = param1.lastIndexOf(param2);
         if(_loc3_ > -1)
         {
            param1.splice(_loc3_,1);
         }
         return _loc3_;
      }
      
      public static function removeFirstOccurance(param1:Array, param2:*) : int
      {
         var _loc3_:int = param1.indexOf(param2);
         if(_loc3_ > -1)
         {
            param1.splice(_loc3_,1);
         }
         return _loc3_;
      }
      
      public static function shuffle(param1:Array) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:* = undefined;
         var _loc2_:Number = param1.length;
         var _loc5_:Number = _loc2_ - 1;
         while(_loc5_ >= 0)
         {
            _loc3_ = Math.floor(Math.random() * _loc2_);
            _loc4_ = param1[_loc5_];
            param1[_loc5_] = param1[_loc3_];
            param1[_loc3_] = _loc4_;
            _loc5_--;
         }
      }
      
      public static function isSame(param1:Array, param2:Array) : Boolean
      {
         var _loc3_:Number = param1.length;
         if(_loc3_ != param2.length)
         {
            return false;
         }
         while(--_loc3_ - -1)
         {
            if(param1[_loc3_] !== param2[_loc3_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function getLength(param1:Array) : int
      {
         if(isNotEmpty(param1))
         {
            return param1.length;
         }
         return 0;
      }
      
      public static function getUniqueValues(param1:Array) : Array
      {
         var _loc3_:Object = null;
         var _loc2_:Array = [];
         if(isNotEmpty(param1))
         {
            for each(_loc3_ in param1)
            {
               if(!contains(_loc2_,_loc3_))
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      public static function getItemAt(param1:Array, param2:int, param3:* = null) : *
      {
         if(isNotEmpty(param1) && param1.length > param2)
         {
            return param1[param2];
         }
         return param3;
      }
      
      public static function getItemsByType(param1:Array, param2:Class) : Array
      {
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_] is param2)
            {
               _loc3_.push(param1[_loc4_]);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function addAll(param1:Array, param2:Array) : void
      {
         var _loc3_:* = undefined;
         if(param1 != null && isNotEmpty(param2))
         {
            for each(_loc3_ in param2)
            {
               param1.push(_loc3_);
            }
         }
      }
      
      public static function addAllIgnoreNull(param1:Array, param2:Array) : void
      {
         var _loc3_:* = undefined;
         if(param1 != null && isNotEmpty(param2))
         {
            for each(_loc3_ in param2)
            {
               addIgnoreNull(param1,_loc3_);
            }
         }
      }
      
      public static function addIgnoreNull(param1:Array, param2:*) : void
      {
         if(param1 != null && param2 != null)
         {
            param1.push(param2);
         }
      }
      
      public static function moveElement(param1:Array, param2:*, param3:int) : void
      {
         if(isNotEmpty(param1) && contains(param1,param2))
         {
            param1.splice(param1.indexOf(param2),1);
            param1.splice(param3,0,param2);
         }
      }
      
      public static function removeAll(param1:Array) : void
      {
         if(isNotEmpty(param1))
         {
            param1.splice(0,param1.length);
         }
      }
      
      public static function isNotEmpty(param1:Array) : Boolean
      {
         return !isEmpty(param1);
      }
      
      public static function isEmpty(param1:Array) : Boolean
      {
         return param1 == null || param1.length == 0;
      }
      
      public static function clone(param1:Array) : Array
      {
         return param1.concat();
      }
      
      public static function toString(param1:Array, param2:String = ", ") : String
      {
         return !param1?"":param1.join(param2);
      }
   }
}
