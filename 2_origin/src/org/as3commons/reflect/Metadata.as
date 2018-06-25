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
      
      public function Metadata(name:String, arguments:Array = null)
      {
         super();
         this._name = name != null?name.toLowerCase():null;
         this._arguments = arguments == null?[]:arguments;
      }
      
      public static function newInstance(name:String, arguments:Array = null) : Metadata
      {
         name = name.toLowerCase();
         var cacheKey:String = getCacheKeyByNameAndArgs(name,arguments);
         if(!_cache[cacheKey])
         {
            _cache[cacheKey] = new Metadata(name,arguments);
         }
         return _cache[cacheKey];
      }
      
      public static function getCacheKey(metadata:Metadata) : String
      {
         return getCacheKeyByNameAndArgs(metadata.name,metadata.arguments);
      }
      
      private static function getCacheKeyByNameAndArgs(key:String, metadataArgs:Array) : String
      {
         var numArgs:int = 0;
         var i:int = 0;
         var result:String = key + CacheUtil.SEMI_COLON;
         if(metadataArgs)
         {
            numArgs = metadataArgs.length;
            for(i = 0; i < numArgs; i++)
            {
               result = result + MetadataArgument.getCacheKey(metadataArgs[i]);
               result = result + CacheUtil.SEMI_COLON;
            }
         }
         return result;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get arguments() : Array
      {
         return this._arguments;
      }
      
      public function hasArgumentWithKey(key:String) : Boolean
      {
         return this.getArgument(key) != null;
      }
      
      public function getArgument(key:String) : MetadataArgument
      {
         var arg:MetadataArgument = null;
         for each(arg in this._arguments)
         {
            if(arg.key === key)
            {
               return arg;
            }
         }
         return null;
      }
      
      public function equals(other:Object) : Boolean
      {
         if(this === other)
         {
            return true;
         }
         if(!(other is Metadata))
         {
            return false;
         }
         var that:Metadata = Metadata(other);
         return that._name === this._name && this.argumentsAreEqual(that._arguments);
      }
      
      public function toString() : String
      {
         return "[Metadata(" + this.name + ", " + this._arguments + ")]";
      }
      
      private function argumentsAreEqual(metadataArgs:Array) : Boolean
      {
         var otherArg:MetadataArgument = null;
         var arg:MetadataArgument = null;
         if(metadataArgs.length !== this._arguments.length)
         {
            return false;
         }
         for each(otherArg in metadataArgs)
         {
            arg = this.getArgument(otherArg.key);
            if(!otherArg.equals(arg))
            {
               return false;
            }
         }
         return true;
      }
      
      as3commons_reflect function setName(value:String) : void
      {
         this._name = value;
      }
   }
}
