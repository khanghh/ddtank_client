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
      
      public function HashArray(param1:String, param2:Boolean = false, param3:Array = null)
      {
         super();
         this.init(param1,param2,param3);
      }
      
      public function get allowDuplicates() : Boolean
      {
         return this._allowDuplicates;
      }
      
      public function set allowDuplicates(param1:Boolean) : void
      {
         this._allowDuplicates = param1;
      }
      
      public function get length() : uint
      {
         return this._list.length;
      }
      
      public function get(param1:String) : *
      {
         param1 = this.makeValidKey(param1);
         return this._lookup[param1];
      }
      
      public function getArray() : Array
      {
         return this._list.concat();
      }
      
      public function pop() : *
      {
         var _loc1_:* = this._list.pop();
         this.removeFromLookup(_loc1_);
         return _loc1_;
      }
      
      public function push(... rest) : uint
      {
         var _loc3_:Array = null;
         var _loc2_:uint = rest.length;
         if(_loc2_ == 1 && rest[0] is Array)
         {
            _loc3_ = rest[0] as Array;
            _loc2_ = _loc3_.length;
         }
         else
         {
            _loc3_ = rest;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            this.pushOne(_loc3_[_loc4_]);
            _loc4_++;
         }
         return this._list.length;
      }
      
      public function rehash() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:uint = 0;
         this._lookup = new Dictionary();
         var _loc1_:uint = this._list.length;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._list[_loc3_];
            if(_loc2_ != null)
            {
               this.addToLookup(_loc2_);
            }
            _loc3_++;
         }
      }
      
      public function shift() : *
      {
         var _loc1_:* = this._list.shift();
         this.removeFromLookup(_loc1_);
         return _loc1_;
      }
      
      public function splice(... rest) : *
      {
         var _loc2_:* = this._list.splice.apply(this._list,rest);
         this.rehash();
         return _loc2_;
      }
      
      protected function add(param1:Array) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(param1 != null)
         {
            _loc2_ = param1.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this.pushOne(param1[_loc3_]);
               _loc3_++;
            }
         }
      }
      
      protected function addToLookup(param1:*) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:Array = null;
         var _loc5_:* = undefined;
         var _loc2_:* = this.makeValidKey(param1[this._lookUpPropertyName]);
         if(this._allowDuplicates)
         {
            _loc3_ = this._lookup[_loc2_];
            if(_loc3_ == null)
            {
               this._lookup[_loc2_] = [param1];
            }
            else if(_loc3_ is Array)
            {
               _loc4_ = _loc3_ as Array;
               _loc4_[_loc4_.length] = param1;
            }
            else
            {
               _loc4_ = [];
               _loc4_[_loc4_.length] = _loc3_;
               _loc4_[_loc4_.length] = param1;
               this._lookup[_loc2_] = _loc4_;
            }
         }
         else
         {
            _loc5_ = this._lookup[_loc2_];
            if(_loc5_ != null)
            {
               ArrayUtils.removeFirstOccurance(this._list,_loc5_);
            }
            this._lookup[_loc2_] = param1;
         }
      }
      
      protected function init(param1:String, param2:Boolean, param3:Array) : void
      {
         this._lookup = {};
         this._lookUpPropertyName = this.makeValidKey(param1);
         this._allowDuplicates = param2;
         this._list = [];
         this.add(param3);
      }
      
      protected function makeValidKey(param1:*) : *
      {
         if(!(param1 is String))
         {
            return param1;
         }
         if(illegalKeys.hasOwnProperty(String(param1) + UNDERSCORE_CHAR))
         {
            return String(param1) + _SUFFIX;
         }
         return param1;
      }
      
      protected function pushOne(param1:*) : void
      {
         this.addToLookup(param1);
         this._list[this._list.length] = param1;
      }
      
      protected function removeFromLookup(param1:*) : void
      {
         var _loc3_:Array = null;
         var _loc2_:* = this._lookup[param1[this._lookUpPropertyName]];
         if(_loc2_ is Array && this._allowDuplicates)
         {
            _loc3_ = _loc2_ as Array;
            _loc3_.splice(_loc3_.length - 1,1);
            if(_loc3_.length < 1)
            {
               delete this._lookup[param1[this._lookUpPropertyName]];
            }
         }
         else
         {
            delete this._lookup[param1[this._lookUpPropertyName]];
         }
      }
   }
}
