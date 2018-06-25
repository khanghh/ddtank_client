package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import org.as3commons.lang.HashArray;
   import org.as3commons.lang.IEquals;
   
   public class Accessor extends Field implements IEquals
   {
      
      private static const _cache:Dictionary = new Dictionary();
       
      
      private var _access:AccessorAccess;
      
      public function Accessor(name:String, access:AccessorAccess, type:String, declaringType:String, isStatic:Boolean, applicationDomain:ApplicationDomain, metadata:HashArray = null)
      {
         super(name,type,declaringType,isStatic,applicationDomain,metadata);
         this._access = access;
      }
      
      public static function newInstance(name:String, access:AccessorAccess, type:String, declaringType:String, isStatic:Boolean, applicationDomain:ApplicationDomain, metadata:HashArray = null) : Accessor
      {
         var cacheKey:String = getCacheKey(name,access,type,declaringType,isStatic,applicationDomain,metadata);
         if(!_cache[cacheKey])
         {
            _cache[cacheKey] = new Accessor(name,access,type,declaringType,isStatic,applicationDomain,metadata);
         }
         return _cache[cacheKey];
      }
      
      private static function getCacheKey(name:String, access:AccessorAccess, type:String, declaringType:String, isStatic:Boolean, applicationDomain:ApplicationDomain, metadata:HashArray) : String
      {
         var cacheKey:String = AbstractMember.getCacheKey(Accessor,name,type,declaringType,isStatic,applicationDomain,metadata);
         return [cacheKey,access.name].join(":");
      }
      
      public function get access() : AccessorAccess
      {
         return this._access;
      }
      
      public function get readable() : Boolean
      {
         return this.isReadable();
      }
      
      public function get writeable() : Boolean
      {
         return this.isWriteable();
      }
      
      public function isReadable() : Boolean
      {
         return this._access == AccessorAccess.READ_ONLY || this._access == AccessorAccess.READ_WRITE;
      }
      
      public function isWriteable() : Boolean
      {
         return this._access == AccessorAccess.WRITE_ONLY || this._access == AccessorAccess.READ_WRITE;
      }
      
      override public function equals(other:Object) : Boolean
      {
         var otherAccessor:Accessor = other as Accessor;
         var result:* = false;
         if(otherAccessor != null)
         {
            result = Boolean(super.equals(other));
            if(result)
            {
               result = otherAccessor.access === this.access;
            }
            if(result)
            {
               result = Boolean(compareMetadata(otherAccessor.metadata));
            }
         }
         return result;
      }
      
      as3commons_reflect function setAccess(value:AccessorAccess) : void
      {
         this._access = value;
      }
   }
}
