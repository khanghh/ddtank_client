package org.as3commons.reflect
{
   import org.as3commons.lang.IEquals;
   
   public class MetadataArgument implements IEquals
   {
      
      private static const _cache:Object = {};
       
      
      private var _key:String;
      
      private var _value:String;
      
      public function MetadataArgument(param1:String, param2:String){super();}
      
      public static function newInstance(param1:String, param2:String) : MetadataArgument{return null;}
      
      public static function getCacheKey(param1:MetadataArgument) : String{return null;}
      
      public static function getCacheKeyByNameAndValue(param1:String, param2:String) : String{return null;}
      
      public function get key() : String{return null;}
      
      public function get value() : String{return null;}
      
      public function equals(param1:Object) : Boolean{return false;}
   }
}
