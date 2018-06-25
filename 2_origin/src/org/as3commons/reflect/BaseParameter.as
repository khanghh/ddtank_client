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
      
      public function BaseParameter(type:String, applicationDomain:ApplicationDomain, isOptional:Boolean = false)
      {
         super();
         this.typeName = type;
         this._applicationDomain = applicationDomain;
         this._isOptional = isOptional;
      }
      
      public static function newInstance(type:String, applicationDomain:ApplicationDomain, isOptional:Boolean = false) : BaseParameter
      {
         var cacheKey:String = getCacheKey(type,applicationDomain,isOptional);
         if(!_cache[cacheKey])
         {
            _cache[cacheKey] = new BaseParameter(type,applicationDomain,isOptional);
         }
         return _cache[cacheKey];
      }
      
      private static function getCacheKey(type:String, applicationDomain:ApplicationDomain, isOptional:Boolean) : String
      {
         var appDomainIndex:int = CacheUtil.getApplicationDomainIndex(applicationDomain);
         return [type,appDomainIndex,isOptional].join(":");
      }
      
      public function get isOptional() : Boolean
      {
         return this._isOptional;
      }
      
      public function get type() : Type
      {
         return this.typeName != null?Type.forName(this.typeName,this._applicationDomain):null;
      }
      
      as3commons_reflect function setIsOptional(value:Boolean) : void
      {
         this._isOptional = value;
      }
      
      as3commons_reflect function setType(value:String) : void
      {
         this.typeName = value;
      }
      
      public function equals(other:Object) : Boolean
      {
         var that:BaseParameter = other as BaseParameter;
         if(that)
         {
            return this.valuesAreEqual(that.typeName,that._applicationDomain,that.isOptional);
         }
         return false;
      }
      
      private function valuesAreEqual(typeName:String, appDomain:ApplicationDomain, isOptional:Boolean) : Boolean
      {
         return appDomain === this._applicationDomain && typeName == this.typeName && isOptional == this.isOptional;
      }
   }
}
