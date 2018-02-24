package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   
   public class Constructor
   {
       
      
      protected var _parameters:Array;
      
      private var _applicationDomain:ApplicationDomain;
      
      private var _declaringType:String;
      
      public function Constructor(param1:String, param2:ApplicationDomain, param3:Array = null){super();}
      
      public function get parameters() : Array{return null;}
      
      public function get declaringType() : Type{return null;}
      
      public function hasNoArguments() : Boolean{return false;}
   }
}
