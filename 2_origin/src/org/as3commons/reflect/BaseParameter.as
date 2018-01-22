package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   import org.as3commons.lang.IEquals;
   import org.as3commons.reflect.util.CacheUtil;
   
   public class BaseParameter implements IEquals
   {
      
      private static const _cache:Object = {};
       
      
      private var _applicationDomain:ApplicationDomain;
      
      private var _isOptional:Boolean;
      
      protected var typeName:String;
      
      public function BaseParameter(param1:String, param2:ApplicationDomain, param3:Boolean = false)
      {
         super();
         this.typeName = param1;
         this._applicationDomain = param2;
         this._isOptional = param3;
      }
      
      public static function newInstance(param1:String, param2:ApplicationDomain, param3:Boolean = false) : BaseParameter
      {
         var _loc4_:String = getCacheKey(param1,param2,param3);
         if(!_cache[_loc4_])
         {
            _cache[_loc4_] = new BaseParameter(param1,param2,param3);
         }
         return _cache[_loc4_];
      }
      
      private static function getCacheKey(param1:String, param2:ApplicationDomain, param3:Boolean) : String
      {
         var _loc4_:int = CacheUtil.getApplicationDomainIndex(param2);
         return [param1,_loc4_,param3].join(":");
      }
      
      public function get isOptional() : Boolean
      {
         return this._isOptional;
      }
      
      public function get type() : Type
      {
         return this.typeName != null?Type.forName(this.typeName,this._applicationDomain):null;
      }
      
      as3commons_reflect function setIsOptional(param1:Boolean) : void
      {
         this._isOptional = param1;
      }
      
      as3commons_reflect function setType(param1:String) : void
      {
         this.typeName = param1;
      }
      
      public function equals(param1:Object) : Boolean
      {
         var _loc2_:BaseParameter = param1 as BaseParameter;
         if(_loc2_)
         {
            return this.valuesAreEqual(_loc2_.typeName,_loc2_._applicationDomain,_loc2_.isOptional);
         }
         return false;
      }
      
      private function valuesAreEqual(param1:String, param2:ApplicationDomain, param3:Boolean) : Boolean
      {
         return param2 === this._applicationDomain && param1 == this.typeName && param3 == this.isOptional;
      }
   }
}
