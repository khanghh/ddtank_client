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
      
      public function Accessor(param1:String, param2:AccessorAccess, param3:String, param4:String, param5:Boolean, param6:ApplicationDomain, param7:HashArray = null)
      {
         super(param1,param3,param4,param5,param6,param7);
         this._access = param2;
      }
      
      public static function newInstance(param1:String, param2:AccessorAccess, param3:String, param4:String, param5:Boolean, param6:ApplicationDomain, param7:HashArray = null) : Accessor
      {
         var _loc8_:String = getCacheKey(param1,param2,param3,param4,param5,param6,param7);
         if(!_cache[_loc8_])
         {
            _cache[_loc8_] = new Accessor(param1,param2,param3,param4,param5,param6,param7);
         }
         return _cache[_loc8_];
      }
      
      private static function getCacheKey(param1:String, param2:AccessorAccess, param3:String, param4:String, param5:Boolean, param6:ApplicationDomain, param7:HashArray) : String
      {
         var _loc8_:String = AbstractMember.getCacheKey(Accessor,param1,param3,param4,param5,param6,param7);
         return [_loc8_,param2.name].join(":");
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
      
      override public function equals(param1:Object) : Boolean
      {
         var _loc2_:Accessor = param1 as Accessor;
         var _loc3_:* = false;
         if(_loc2_ != null)
         {
            _loc3_ = Boolean(super.equals(param1));
            if(_loc3_)
            {
               _loc3_ = _loc2_.access === this.access;
            }
            if(_loc3_)
            {
               _loc3_ = Boolean(compareMetadata(_loc2_.metadata));
            }
         }
         return _loc3_;
      }
      
      as3commons_reflect function setAccess(param1:AccessorAccess) : void
      {
         this._access = param1;
      }
   }
}
