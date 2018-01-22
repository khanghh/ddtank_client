package org.as3commons.reflect
{
   import org.as3commons.lang.IEquals;
   
   public class MetadataArgument implements IEquals
   {
      
      private static const _cache:Object = {};
       
      
      private var _key:String;
      
      private var _value:String;
      
      public function MetadataArgument(param1:String, param2:String)
      {
         super();
         this._key = param1;
         this._value = param2;
      }
      
      public static function newInstance(param1:String, param2:String) : MetadataArgument
      {
         var _loc3_:String = getCacheKeyByNameAndValue(param1,param2);
         if(!_cache[_loc3_])
         {
            _cache[_loc3_] = new MetadataArgument(param1,param2);
         }
         return _cache[_loc3_];
      }
      
      public static function getCacheKey(param1:MetadataArgument) : String
      {
         return getCacheKeyByNameAndValue(param1.key,param1.value);
      }
      
      public static function getCacheKeyByNameAndValue(param1:String, param2:String) : String
      {
         return param1 + ":" + param2;
      }
      
      public function get key() : String
      {
         return this._key;
      }
      
      public function get value() : String
      {
         return this._value;
      }
      
      public function equals(param1:Object) : Boolean
      {
         if(this === param1)
         {
            return true;
         }
         if(!(param1 is MetadataArgument))
         {
            return false;
         }
         var _loc2_:MetadataArgument = MetadataArgument(param1);
         return _loc2_.key === this.key && _loc2_.value === this.value;
      }
   }
}
