package org.as3commons.reflect.util
{
   import flash.system.ApplicationDomain;
   import org.as3commons.lang.HashArray;
   import org.as3commons.reflect.Metadata;
   
   public final class CacheUtil
   {
      
      private static var _appDomains:Array = [];
      
      public static const SEMI_COLON:String = ";";
      
      public static const COMMA:String = ",";
       
      
      public function CacheUtil(){super();}
      
      public static function getApplicationDomainIndex(param1:ApplicationDomain) : int{return 0;}
      
      public static function getMetadataString(param1:HashArray) : String{return null;}
   }
}
