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
      
      public function HashArray(param1:String, param2:Boolean = false, param3:Array = null){super();}
      
      public function get allowDuplicates() : Boolean{return false;}
      
      public function set allowDuplicates(param1:Boolean) : void{}
      
      public function get length() : uint{return null;}
      
      public function get(param1:String) : *{return null;}
      
      public function getArray() : Array{return null;}
      
      public function pop() : *{return null;}
      
      public function push(... rest) : uint{return null;}
      
      public function rehash() : void{}
      
      public function shift() : *{return null;}
      
      public function splice(... rest) : *{return null;}
      
      protected function add(param1:Array) : void{}
      
      protected function addToLookup(param1:*) : void{}
      
      protected function init(param1:String, param2:Boolean, param3:Array) : void{}
      
      protected function makeValidKey(param1:*) : *{return null;}
      
      protected function pushOne(param1:*) : void{}
      
      protected function removeFromLookup(param1:*) : void{}
   }
}
