package mx.utils
{
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import mx.binding.BindabilityInfo;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   [ExcludeClass]
   public class DescribeTypeCache
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      private static var typeCache:Object = {};
      
      private static var cacheHandlers:Object = {};
      
      {
         registerCacheHandler("bindabilityInfo",bindabilityInfoHandler);
      }
      
      public function DescribeTypeCache(){super();}
      
      public static function describeType(param1:*) : DescribeTypeCacheRecord{return null;}
      
      public static function registerCacheHandler(param1:String, param2:Function) : void{}
      
      static function extractValue(param1:String, param2:DescribeTypeCacheRecord) : *{return null;}
      
      private static function bindabilityInfoHandler(param1:DescribeTypeCacheRecord) : *{return null;}
   }
}
