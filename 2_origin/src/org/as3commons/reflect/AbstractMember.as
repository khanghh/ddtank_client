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
      
      public function AbstractMember(name:String, type:String, declaringType:String, isStatic:Boolean, applicationDomain:ApplicationDomain, metadata:HashArray = null)
      {
         super(metadata);
         this.initAbstractType(name,isStatic,type,declaringType,applicationDomain);
      }
      
      public static function newInstance(clazz:Class, name:String, type:String, declaringType:String, isStatic:Boolean, applicationDomain:ApplicationDomain, metadata:HashArray = null) : AbstractMember
      {
         var cacheKey:String = getCacheKey(clazz,name,type,declaringType,isStatic,applicationDomain,metadata);
         if(!_cache[cacheKey])
         {
            _cache[cacheKey] = new clazz(name,type,declaringType,isStatic,applicationDomain,metadata);
         }
         return _cache[cacheKey];
      }
      
      public static function getCacheKey(clazz:Class, name:String, type:String, declaringType:String, isStatic:Boolean, applicationDomain:ApplicationDomain, metadata:HashArray = null) : String
      {
         var appDomainIndex:int = CacheUtil.getApplicationDomainIndex(applicationDomain);
         var metadataString:String = CacheUtil.getMetadataString(metadata);
         return [clazz,name,type,declaringType,isStatic,appDomainIndex,metadataString].join(":");
      }
      
      protected function initAbstractType(name:String, isStatic:Boolean, type:String, declaringType:String, applicationDomain:ApplicationDomain) : void
      {
         Assert.hasText(name,"name argument must have text");
         Assert.notNull(applicationDomain,"applicationDomain argument must not be null");
         this._name = name;
         this._isStatic = isStatic;
         this.typeName = type;
         this.declaringTypeName = declaringType;
         this.applicationDomain = applicationDomain;
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
      
      public function equals(other:Object) : Boolean
      {
         var otherField:AbstractMember = other as AbstractMember;
         var result:Boolean = false;
         if(otherField != null)
         {
            result = otherField.name == this.name && otherField.typeName == this.typeName && otherField.declaringTypeName == this.declaringTypeName && otherField.isStatic == this.isStatic && otherField.applicationDomain === this.applicationDomain;
            if(result)
            {
               result = this.compareMetadata(otherField.metadata);
            }
         }
         return result;
      }
      
      protected function compareMetadata(metadataArray:Array) : Boolean
      {
         var md:Metadata = null;
         var mds:Array = null;
         var md2:Metadata = null;
         var result:Boolean = metadataArray.length == 0 && this.metadata.length == 0;
         for each(md in metadataArray)
         {
            mds = this.getMetadata(md.name);
            for each(md2 in mds)
            {
               if(md2 == null || !md2.equals(md))
               {
                  result = false;
                  break;
               }
            }
            if(!result)
            {
               break;
            }
         }
         return result;
      }
      
      as3commons_reflect function setDeclaringType(value:String) : void
      {
         this.declaringTypeName = value;
      }
      
      as3commons_reflect function setIsStatic(value:Boolean) : void
      {
         this._isStatic = value;
      }
      
      as3commons_reflect function setName(value:String) : void
      {
         this._name = value;
      }
      
      as3commons_reflect function setNamespaceURI(value:String) : void
      {
         this._namespaceURI = value;
      }
      
      as3commons_reflect function setType(value:String) : void
      {
         this.typeName = value;
      }
   }
}
