package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   import org.as3commons.lang.Assert;
   import org.as3commons.lang.HashArray;
   import org.as3commons.lang.IEquals;
   import org.as3commons.lang.StringUtils;
   import org.as3commons.reflect.util.CacheUtil;
   
   public class AbstractMember extends MetadataContainer implements IEquals, IMember, INamespaceOwner
   {
      
      private static const _cache:Object = {};
       
      
      protected var applicationDomain:ApplicationDomain;
      
      protected var declaringTypeName:String;
      
      protected var typeName:String;
      
      private var _isStatic:Boolean;
      
      private var _name:String;
      
      private var _qName:QName;
      
      private var _namespaceURI:String;
      
      public function AbstractMember(param1:String, param2:String, param3:String, param4:Boolean, param5:ApplicationDomain, param6:HashArray = null)
      {
         super(param6);
         this.initAbstractType(param1,param4,param2,param3,param5);
      }
      
      public static function newInstance(param1:Class, param2:String, param3:String, param4:String, param5:Boolean, param6:ApplicationDomain, param7:HashArray = null) : AbstractMember
      {
         var _loc8_:String = getCacheKey(param1,param2,param3,param4,param5,param6,param7);
         if(!_cache[_loc8_])
         {
            _cache[_loc8_] = new param1(param2,param3,param4,param5,param6,param7);
         }
         return _cache[_loc8_];
      }
      
      public static function getCacheKey(param1:Class, param2:String, param3:String, param4:String, param5:Boolean, param6:ApplicationDomain, param7:HashArray = null) : String
      {
         var _loc8_:int = CacheUtil.getApplicationDomainIndex(param6);
         var _loc9_:String = CacheUtil.getMetadataString(param7);
         return [param1,param2,param3,param4,param5,_loc8_,_loc9_].join(":");
      }
      
      protected function initAbstractType(param1:String, param2:Boolean, param3:String, param4:String, param5:ApplicationDomain) : void
      {
         Assert.hasText(param1,"name argument must have text");
         Assert.notNull(param5,"applicationDomain argument must not be null");
         this._name = param1;
         this._isStatic = param2;
         this.typeName = param3;
         this.declaringTypeName = param4;
         this.applicationDomain = param5;
      }
      
      public function get declaringType() : Type
      {
         return !!StringUtils.hasText(this.declaringTypeName)?Type.forName(this.declaringTypeName,this.applicationDomain):null;
      }
      
      public function get isStatic() : Boolean
      {
         return this._isStatic;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get qName() : QName
      {
         return new QName(this._namespaceURI,this._name);
      }
      
      public function get namespaceURI() : String
      {
         return this._namespaceURI;
      }
      
      public function get type() : Type
      {
         return Type.forName(this.typeName,this.applicationDomain);
      }
      
      public function equals(param1:Object) : Boolean
      {
         var _loc2_:AbstractMember = param1 as AbstractMember;
         var _loc3_:Boolean = false;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.name == this.name && _loc2_.typeName == this.typeName && _loc2_.declaringTypeName == this.declaringTypeName && _loc2_.isStatic == this.isStatic && _loc2_.applicationDomain === this.applicationDomain;
            if(_loc3_)
            {
               _loc3_ = this.compareMetadata(_loc2_.metadata);
            }
         }
         return _loc3_;
      }
      
      protected function compareMetadata(param1:Array) : Boolean
      {
         var _loc3_:Metadata = null;
         var _loc4_:Array = null;
         var _loc5_:Metadata = null;
         var _loc2_:Boolean = param1.length == 0 && this.metadata.length == 0;
         for each(_loc3_ in param1)
         {
            _loc4_ = this.getMetadata(_loc3_.name);
            for each(_loc5_ in _loc4_)
            {
               if(_loc5_ == null || !_loc5_.equals(_loc3_))
               {
                  _loc2_ = false;
                  break;
               }
            }
            if(_loc2_)
            {
               continue;
            }
            break;
         }
         return _loc2_;
      }
      
      as3commons_reflect function setDeclaringType(param1:String) : void
      {
         this.declaringTypeName = param1;
      }
      
      as3commons_reflect function setIsStatic(param1:Boolean) : void
      {
         this._isStatic = param1;
      }
      
      as3commons_reflect function setName(param1:String) : void
      {
         this._name = param1;
      }
      
      as3commons_reflect function setNamespaceURI(param1:String) : void
      {
         this._namespaceURI = param1;
      }
      
      as3commons_reflect function setType(param1:String) : void
      {
         this.typeName = param1;
      }
   }
}
