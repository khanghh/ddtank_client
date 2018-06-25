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
       
      
      public function CacheUtil()
      {
         super();
      }
      
      public static function getApplicationDomainIndex(applicationDomain:ApplicationDomain) : int
      {
         if(_appDomains.indexOf(applicationDomain) == -1)
         {
            _appDomains.push(applicationDomain);
         }
         return _appDomains.indexOf(applicationDomain);
      }
      
      public static function getMetadataString(metadataArray:HashArray) : String
      {
         var md:Array = null;
         var metadata:Metadata = null;
         var result:String = "";
         if(metadataArray)
         {
            md = metadataArray.getArray();
            for each(metadata in md)
            {
               result = result + (Metadata.getCacheKey(metadata) + COMMA);
            }
         }
         return result;
      }
   }
}
