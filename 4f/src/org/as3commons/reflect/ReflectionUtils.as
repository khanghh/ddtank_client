package org.as3commons.reflect
{
   import flash.system.Capabilities;
   import flash.utils.describeType;
   import org.as3commons.lang.ClassUtils;
   
   public final class ReflectionUtils
   {
      
      private static var _version:String;
      
      private static var _isOldPlayer:Boolean = true;
       
      
      public function ReflectionUtils(){super();}
      
      public static function concatTypeMetadata(param1:Type, param2:Array, param3:String) : void{}
      
      public static function getTypeDescription(param1:Class) : XML{return null;}
      
      public static function playerHasConstructorBug() : Boolean{return false;}
   }
}
