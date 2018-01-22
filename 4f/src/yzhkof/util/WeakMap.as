package yzhkof.util
{
   import flash.utils.Dictionary;
   
   public class WeakMap
   {
       
      
      private var map:Dictionary;
      
      private var key_set:Array;
      
      private var _length:int = 0;
      
      public function WeakMap(){super();}
      
      public function get length() : int{return 0;}
      
      public function get keySet() : Array{return null;}
      
      public function get valueSet() : Array{return null;}
      
      public function contentValue(param1:*) : Boolean{return false;}
      
      public function contentKey(param1:*) : Boolean{return false;}
      
      public function add(param1:*, param2:*) : void{}
      
      public function getValue(param1:*) : *{return null;}
      
      public function remove(param1:*) : void{}
   }
}
