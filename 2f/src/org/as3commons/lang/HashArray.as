package org.as3commons.lang{   import flash.utils.Dictionary;      public class HashArray   {            private static const UNDERSCORE_CHAR:String = "_";            private static const _SUFFIX:String = UNDERSCORE_CHAR + (9999 + Math.floor(Math.random() * 9999)).toString();            private static const illegalKeys:Object = {         "hasOwnProperty_":true,         "isPrototypeOf_":true,         "propertyIsEnumerable_":true,         "setPropertyIsEnumerable_":true,         "toLocaleString_":true,         "toString_":true,         "valueOf_":true,         "prototype_":true,         "constructor_":true      };                   private var _allowDuplicates:Boolean = false;            private var _list:Array;            private var _lookUpPropertyName:String;            private var _lookup:Object;            public function HashArray(lookUpPropertyName:String, allowDuplicates:Boolean = false, items:Array = null) { super(); }
            public function get allowDuplicates() : Boolean { return false; }
            public function set allowDuplicates(value:Boolean) : void { }
            public function get length() : uint { return null; }
            public function get(lookupPropertyValue:String) : * { return null; }
            public function getArray() : Array { return null; }
            public function pop() : * { return null; }
            public function push(... parameters) : uint { return null; }
            public function rehash() : void { }
            public function shift() : * { return null; }
            public function splice(... parameters) : * { return null; }
            protected function add(items:Array) : void { }
            protected function addToLookup(newItem:*) : void { }
            protected function init(lookUpPropertyName:String, allowDuplicates:Boolean, items:Array) : void { }
            protected function makeValidKey(propertyValue:*) : * { return null; }
            protected function pushOne(item:*) : void { }
            protected function removeFromLookup(item:*) : void { }
   }}