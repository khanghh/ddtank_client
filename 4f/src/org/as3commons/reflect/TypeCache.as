package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import org.as3commons.lang.Assert;
   
   public class TypeCache
   {
       
      
      protected var cache:Dictionary;
      
      public function TypeCache(){super();}
      
      public function clear(param1:ApplicationDomain = null) : void{}
      
      public function contains(param1:String, param2:ApplicationDomain) : Boolean{return false;}
      
      public function getKeys(param1:ApplicationDomain) : Array{return null;}
      
      public function get(param1:String, param2:ApplicationDomain) : Type{return null;}
      
      public function put(param1:String, param2:Type, param3:ApplicationDomain) : void{}
      
      public function size(param1:ApplicationDomain) : int{return 0;}
   }
}
