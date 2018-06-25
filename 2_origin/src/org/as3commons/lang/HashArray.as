package org.as3commons.lang
{
   import flash.utils.Dictionary;
   
   public class HashArray
   {
      
      private static const UNDERSCORE_CHAR:String = "_";
      
      private static const _SUFFIX:String = UNDERSCORE_CHAR + (9999 + Math.floor(Math.random() * 9999)).toString();
      
      private static const illegalKeys:Object = {
         "hasOwnProperty_":true,
         "isPrototypeOf_":true,
         "propertyIsEnumerable_":true,
         "setPropertyIsEnumerable_":true,
         "toLocaleString_":true,
         "toString_":true,
         "valueOf_":true,
         "prototype_":true,
         "constructor_":true
      };
       
      
      private var _allowDuplicates:Boolean = false;
      
      private var _list:Array;
      
      private var _lookUpPropertyName:String;
      
      private var _lookup:Object;
      
      public function HashArray(lookUpPropertyName:String, allowDuplicates:Boolean = false, items:Array = null)
      {
         super();
         this.init(lookUpPropertyName,allowDuplicates,items);
      }
      
      public function get allowDuplicates() : Boolean
      {
         return this._allowDuplicates;
      }
      
      public function set allowDuplicates(value:Boolean) : void
      {
         this._allowDuplicates = value;
      }
      
      public function get length() : uint
      {
         return this._list.length;
      }
      
      public function get(lookupPropertyValue:String) : *
      {
         lookupPropertyValue = this.makeValidKey(lookupPropertyValue);
         return this._lookup[lookupPropertyValue];
      }
      
      public function getArray() : Array
      {
         return this._list.concat();
      }
      
      public function pop() : *
      {
         var value:* = this._list.pop();
         this.removeFromLookup(value);
         return value;
      }
      
      public function push(... parameters) : uint
      {
         var args:Array = null;
         var len:uint = parameters.length;
         if(len == 1 && parameters[0] is Array)
         {
            args = parameters[0] as Array;
            len = args.length;
         }
         else
         {
            args = parameters;
         }
         for(var i:uint = 0; i < len; i++)
         {
            this.pushOne(args[i]);
         }
         return this._list.length;
      }
      
      public function rehash() : void
      {
         var val:* = undefined;
         var i:uint = 0;
         this._lookup = new Dictionary();
         for(var len:uint = this._list.length; i < len; )
         {
            val = this._list[i];
            if(val != null)
            {
               this.addToLookup(val);
            }
            i++;
         }
      }
      
      public function shift() : *
      {
         var item:* = this._list.shift();
         this.removeFromLookup(item);
         return item;
      }
      
      public function splice(... parameters) : *
      {
         var result:* = this._list.splice.apply(this._list,parameters);
         this.rehash();
         return result;
      }
      
      protected function add(items:Array) : void
      {
         var len:uint = 0;
         var i:uint = 0;
         if(items != null)
         {
            len = items.length;
            for(i = 0; i < len; i++)
            {
               this.pushOne(items[i]);
            }
         }
      }
      
      protected function addToLookup(newItem:*) : void
      {
         var items:* = undefined;
         var arr:Array = null;
         var oldItem:* = undefined;
         var validKey:* = this.makeValidKey(newItem[this._lookUpPropertyName]);
         if(this._allowDuplicates)
         {
            items = this._lookup[validKey];
            if(items == null)
            {
               this._lookup[validKey] = [newItem];
            }
            else if(items is Array)
            {
               arr = items as Array;
               arr[arr.length] = newItem;
            }
            else
            {
               arr = [];
               arr[arr.length] = items;
               arr[arr.length] = newItem;
               this._lookup[validKey] = arr;
            }
         }
         else
         {
            oldItem = this._lookup[validKey];
            if(oldItem != null)
            {
               ArrayUtils.removeFirstOccurance(this._list,oldItem);
            }
            this._lookup[validKey] = newItem;
         }
      }
      
      protected function init(lookUpPropertyName:String, allowDuplicates:Boolean, items:Array) : void
      {
         this._lookup = {};
         this._lookUpPropertyName = this.makeValidKey(lookUpPropertyName);
         this._allowDuplicates = allowDuplicates;
         this._list = [];
         this.add(items);
      }
      
      protected function makeValidKey(propertyValue:*) : *
      {
         if(!(propertyValue is String))
         {
            return propertyValue;
         }
         if(illegalKeys.hasOwnProperty(String(propertyValue) + UNDERSCORE_CHAR))
         {
            return String(propertyValue) + _SUFFIX;
         }
         return propertyValue;
      }
      
      protected function pushOne(item:*) : void
      {
         this.addToLookup(item);
         this._list[this._list.length] = item;
      }
      
      protected function removeFromLookup(item:*) : void
      {
         var arr:Array = null;
         var value:* = this._lookup[item[this._lookUpPropertyName]];
         if(value is Array && this._allowDuplicates)
         {
            arr = value as Array;
            arr.splice(arr.length - 1,1);
            if(arr.length < 1)
            {
               delete this._lookup[item[this._lookUpPropertyName]];
            }
         }
         else
         {
            delete this._lookup[item[this._lookUpPropertyName]];
         }
      }
   }
}
