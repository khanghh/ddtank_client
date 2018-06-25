package org.aswing.util{   public class ASWingVector implements List   {            public static const CASEINSENSITIVE:int = 1;            public static const DESCENDING:int = 2;            public static const UNIQUESORT:int = 4;            public static const RETURNINDEXEDARRAY:int = 8;            public static const NUMERIC:int = 16;                   protected var _elements:Array;            public function ASWingVector() { super(); }
            public function each(operation:Function) : void { }
            public function eachWithout(obj:Object, operation:Function) : void { }
            public function get(i:int) : * { return null; }
            public function elementAt(i:int) : * { return null; }
            public function append(obj:*, index:int = -1) : void { }
            public function appendAll(arr:Array, index:int = -1) : void { }
            public function replaceAt(index:int, obj:*) : * { return null; }
            public function removeAt(index:int) : * { return null; }
            public function remove(obj:*) : * { return null; }
            public function removeRange(fromIndex:int, toIndex:int) : Array { return null; }
            public function indexOf(obj:*) : int { return 0; }
            public function appendList(list:List, index:int = -1) : void { }
            public function pop() : * { return null; }
            public function shift() : * { return null; }
            public function lastIndexOf(obj:*) : int { return 0; }
            public function contains(obj:*) : Boolean { return false; }
            public function first() : * { return null; }
            public function last() : * { return null; }
            public function size() : int { return 0; }
            public function setElementAt(index:int, element:*) : void { }
            public function getSize() : int { return 0; }
            public function clear() : void { }
            public function clone() : ASWingVector { return null; }
            public function isEmpty() : Boolean { return false; }
            public function toArray() : Array { return null; }
            public function subArray(startIndex:int, length:int) : Array { return null; }
            public function sort(compare:Object, options:int) : Array { return null; }
            public function sortOn(key:Object, options:int) : Array { return null; }
            public function toString() : String { return null; }
   }}