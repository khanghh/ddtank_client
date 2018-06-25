package org.as3commons.reflect
{
   import org.as3commons.lang.IEquals;
   
   public class MetadataArgument implements IEquals
   {
      
      private static const _cache:Object = {};
       
      
      private var _key:String;
      
      private var _value:String;
      
      public function MetadataArgument(key:String, value:String)
      {
         super();
         this._key = key;
         this._value = value;
      }
      
      public static function newInstance(name:String, value:String) : MetadataArgument
      {
         var cacheKey:String = getCacheKeyByNameAndValue(name,value);
         if(!_cache[cacheKey])
         {
            _cache[cacheKey] = new MetadataArgument(name,value);
         }
         return _cache[cacheKey];
      }
      
      public static function getCacheKey(arg:MetadataArgument) : String
      {
         return getCacheKeyByNameAndValue(arg.key,arg.value);
      }
      
      public static function getCacheKeyByNameAndValue(key:String, value:String) : String
      {
         return key + ":" + value;
      }
      
      public function get key() : String
      {
         return this._key;
      }
      
      public function get value() : String
      {
         return this._value;
      }
      
      public function equals(other:Object) : Boolean
      {
         if(this === other)
         {
            return true;
         }
         if(!(other is MetadataArgument))
         {
            return false;
         }
         var that:MetadataArgument = MetadataArgument(other);
         return that.key === this.key && that.value === this.value;
      }
   }
}
