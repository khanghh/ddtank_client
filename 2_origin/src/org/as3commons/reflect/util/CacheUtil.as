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
      
      public static function getApplicationDomainIndex(param1:ApplicationDomain) : int
      {
         if(_appDomains.indexOf(param1) == -1)
         {
            _appDomains.push(param1);
         }
         return _appDomains.indexOf(param1);
      }
      
      public static function getMetadataString(param1:HashArray) : String
      {
         var _loc3_:Array = null;
         var _loc4_:Metadata = null;
         var _loc2_:String = "";
         if(param1)
         {
            _loc3_ = param1.getArray();
            for each(_loc4_ in _loc3_)
            {
               _loc2_ = _loc2_ + (Metadata.getCacheKey(_loc4_) + COMMA);
            }
         }
         return _loc2_;
      }
   }
}
