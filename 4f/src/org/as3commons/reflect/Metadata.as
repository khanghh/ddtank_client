package org.as3commons.reflect
{
   import org.as3commons.lang.IEquals;
   import org.as3commons.reflect.util.CacheUtil;
   
   public class Metadata implements IEquals
   {
      
      public static const TRANSIENT:String = "Transient";
      
      public static const BINDABLE:String = "Bindable";
      
      private static const _cache:Object = {};
       
      
      private var _name:String;
      
      private var _arguments:Array;
      
      public function Metadata(param1:String, param2:Array = null){super();}
      
      public static function newInstance(param1:String, param2:Array = null) : Metadata{return null;}
      
      public static function getCacheKey(param1:Metadata) : String{return null;}
      
      private static function getCacheKeyByNameAndArgs(param1:String, param2:Array) : String{return null;}
      
      public function get name() : String{return null;}
      
      public function get arguments() : Array{return null;}
      
      public function hasArgumentWithKey(param1:String) : Boolean{return false;}
      
      public function getArgument(param1:String) : MetadataArgument{return null;}
      
      public function equals(param1:Object) : Boolean{return false;}
      
      public function toString() : String{return null;}
      
      private function argumentsAreEqual(param1:Array) : Boolean{return false;}
      
      as3commons_reflect function setName(param1:String) : void{}
   }
}
