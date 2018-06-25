package yzhkof.util{   import flash.utils.Dictionary;      public class WeakMap   {                   private var map:Dictionary;            private var key_set:Array;            private var _length:int = 0;            public function WeakMap() { super(); }
            public function get length() : int { return 0; }
            public function get keySet() : Array { return null; }
            public function get valueSet() : Array { return null; }
            public function contentValue(value:*) : Boolean { return false; }
            public function contentKey(key:*) : Boolean { return false; }
            public function add(key:*, value:*) : void { }
            public function getValue(key:*) : * { return null; }
            public function remove(key:*) : void { }
   }}