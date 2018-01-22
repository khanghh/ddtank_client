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
      
      public function AbstractMember(param1:String, param2:String, param3:String, param4:Boolean, param5:ApplicationDomain, param6:HashArray = null){super(null);}
      
      public static function newInstance(param1:Class, param2:String, param3:String, param4:String, param5:Boolean, param6:ApplicationDomain, param7:HashArray = null) : AbstractMember{return null;}
      
      public static function getCacheKey(param1:Class, param2:String, param3:String, param4:String, param5:Boolean, param6:ApplicationDomain, param7:HashArray = null) : String{return null;}
      
      protected function initAbstractType(param1:String, param2:Boolean, param3:String, param4:String, param5:ApplicationDomain) : void{}
      
      public function get declaringType() : Type{return null;}
      
      public function get isStatic() : Boolean{return false;}
      
      public function get name() : String{return null;}
      
      public function get qName() : QName{return null;}
      
      public function get namespaceURI() : String{return null;}
      
      public function get type() : Type{return null;}
      
      public function equals(param1:Object) : Boolean{return false;}
      
      protected function compareMetadata(param1:Array) : Boolean{return false;}
      
      as3commons_reflect function setDeclaringType(param1:String) : void{}
      
      as3commons_reflect function setIsStatic(param1:Boolean) : void{}
      
      as3commons_reflect function setName(param1:String) : void{}
      
      as3commons_reflect function setNamespaceURI(param1:String) : void{}
      
      as3commons_reflect function setType(param1:String) : void{}
   }
}
