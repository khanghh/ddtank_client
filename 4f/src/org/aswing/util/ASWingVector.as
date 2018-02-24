package org.aswing.util
{
   public class ASWingVector implements List
   {
      
      public static const CASEINSENSITIVE:int = 1;
      
      public static const DESCENDING:int = 2;
      
      public static const UNIQUESORT:int = 4;
      
      public static const RETURNINDEXEDARRAY:int = 8;
      
      public static const NUMERIC:int = 16;
       
      
      protected var _elements:Array;
      
      public function ASWingVector(){super();}
      
      public function each(param1:Function) : void{}
      
      public function eachWithout(param1:Object, param2:Function) : void{}
      
      public function get(param1:int) : *{return null;}
      
      public function elementAt(param1:int) : *{return null;}
      
      public function append(param1:*, param2:int = -1) : void{}
      
      public function appendAll(param1:Array, param2:int = -1) : void{}
      
      public function replaceAt(param1:int, param2:*) : *{return null;}
      
      public function removeAt(param1:int) : *{return null;}
      
      public function remove(param1:*) : *{return null;}
      
      public function removeRange(param1:int, param2:int) : Array{return null;}
      
      public function indexOf(param1:*) : int{return 0;}
      
      public function appendList(param1:List, param2:int = -1) : void{}
      
      public function pop() : *{return null;}
      
      public function shift() : *{return null;}
      
      public function lastIndexOf(param1:*) : int{return 0;}
      
      public function contains(param1:*) : Boolean{return false;}
      
      public function first() : *{return null;}
      
      public function last() : *{return null;}
      
      public function size() : int{return 0;}
      
      public function setElementAt(param1:int, param2:*) : void{}
      
      public function getSize() : int{return 0;}
      
      public function clear() : void{}
      
      public function clone() : ASWingVector{return null;}
      
      public function isEmpty() : Boolean{return false;}
      
      public function toArray() : Array{return null;}
      
      public function subArray(param1:int, param2:int) : Array{return null;}
      
      public function sort(param1:Object, param2:int) : Array{return null;}
      
      public function sortOn(param1:Object, param2:int) : Array{return null;}
      
      public function toString() : String{return null;}
   }
}
