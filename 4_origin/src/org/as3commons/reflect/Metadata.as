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
      
      public function Metadata(param1:String, param2:Array = null)
      {
         super();
         this._name = param1 != null?param1.toLowerCase():null;
         this._arguments = param2 == null?[]:param2;
      }
      
      public static function newInstance(param1:String, param2:Array = null) : Metadata
      {
         param1 = param1.toLowerCase();
         var _loc3_:String = getCacheKeyByNameAndArgs(param1,param2);
         if(!_cache[_loc3_])
         {
            _cache[_loc3_] = new Metadata(param1,param2);
         }
         return _cache[_loc3_];
      }
      
      public static function getCacheKey(param1:Metadata) : String
      {
         return getCacheKeyByNameAndArgs(param1.name,param1.arguments);
      }
      
      private static function getCacheKeyByNameAndArgs(param1:String, param2:Array) : String
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:String = param1 + CacheUtil.SEMI_COLON;
         if(param2)
         {
            _loc4_ = param2.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc3_ = _loc3_ + MetadataArgument.getCacheKey(param2[_loc5_]);
               _loc3_ = _loc3_ + CacheUtil.SEMI_COLON;
               _loc5_++;
            }
         }
         return _loc3_;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get arguments() : Array
      {
         return this._arguments;
      }
      
      public function hasArgumentWithKey(param1:String) : Boolean
      {
         return this.getArgument(param1) != null;
      }
      
      public function getArgument(param1:String) : MetadataArgument
      {
         var _loc2_:MetadataArgument = null;
         for each(_loc2_ in this._arguments)
         {
            if(_loc2_.key === param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function equals(param1:Object) : Boolean
      {
         if(this === param1)
         {
            return true;
         }
         if(!(param1 is Metadata))
         {
            return false;
         }
         var _loc2_:Metadata = Metadata(param1);
         return _loc2_._name === this._name && this.argumentsAreEqual(_loc2_._arguments);
      }
      
      public function toString() : String
      {
         return "[Metadata(" + this.name + ", " + this._arguments + ")]";
      }
      
      private function argumentsAreEqual(param1:Array) : Boolean
      {
         var _loc2_:MetadataArgument = null;
         var _loc3_:MetadataArgument = null;
         if(param1.length !== this._arguments.length)
         {
            return false;
         }
         for each(_loc2_ in param1)
         {
            _loc3_ = this.getArgument(_loc2_.key);
            if(!_loc2_.equals(_loc3_))
            {
               return false;
            }
         }
         return true;
      }
      
      as3commons_reflect function setName(param1:String) : void
      {
         this._name = param1;
      }
   }
}
