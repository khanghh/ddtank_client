package org.as3commons.reflect
{
   public class Parameter
   {
       
      
      private var _base:BaseParameter;
      
      private var _index:int;
      
      public function Parameter(param1:BaseParameter, param2:int){super();}
      
      public function get isOptional() : Boolean{return false;}
      
      public function get type() : Type{return null;}
      
      public function get index() : int{return 0;}
   }
}
