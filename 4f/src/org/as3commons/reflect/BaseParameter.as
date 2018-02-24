package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   import org.as3commons.lang.IEquals;
   import org.as3commons.reflect.util.CacheUtil;
   
   public class BaseParameter implements IEquals
   {
      
      private static const _cache:Object = {};
       
      
      private var _applicationDomain:ApplicationDomain;
      
      private var _isOptional:Boolean;
      
      protected var typeName:String;
      
      public function BaseParameter(param1:String, param2:ApplicationDomain, param3:Boolean = false){super();}
      
      public static function newInstance(param1:String, param2:ApplicationDomain, param3:Boolean = false) : BaseParameter{return null;}
      
      private static function getCacheKey(param1:String, param2:ApplicationDomain, param3:Boolean) : String{return null;}
      
      public function get isOptional() : Boolean{return false;}
      
      public function get type() : Type{return null;}
      
      as3commons_reflect function setIsOptional(param1:Boolean) : void{}
      
      as3commons_reflect function setType(param1:String) : void{}
      
      public function equals(param1:Object) : Boolean{return false;}
      
      private function valuesAreEqual(param1:String, param2:ApplicationDomain, param3:Boolean) : Boolean{return false;}
   }
}
