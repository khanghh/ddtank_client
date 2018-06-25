package org.as3commons.reflect{   import flash.system.ApplicationDomain;   import org.as3commons.lang.Assert;   import org.as3commons.lang.HashArray;   import org.as3commons.lang.IEquals;   import org.as3commons.lang.StringUtils;   import org.as3commons.reflect.util.CacheUtil;      public class AbstractMember extends MetadataContainer implements IEquals, IMember, INamespaceOwner   {            private static const _cache:Object = {};                   protected var applicationDomain:ApplicationDomain;            protected var declaringTypeName:String;            protected var typeName:String;            private var _isStatic:Boolean;            private var _name:String;            private var _qName:QName;            private var _namespaceURI:String;            public function AbstractMember(name:String, type:String, declaringType:String, isStatic:Boolean, applicationDomain:ApplicationDomain, metadata:HashArray = null) { super(null); }
            public static function newInstance(clazz:Class, name:String, type:String, declaringType:String, isStatic:Boolean, applicationDomain:ApplicationDomain, metadata:HashArray = null) : AbstractMember { return null; }
            public static function getCacheKey(clazz:Class, name:String, type:String, declaringType:String, isStatic:Boolean, applicationDomain:ApplicationDomain, metadata:HashArray = null) : String { return null; }
            protected function initAbstractType(name:String, isStatic:Boolean, type:String, declaringType:String, applicationDomain:ApplicationDomain) : void { }
            public function get declaringType() : Type { return null; }
            public function get isStatic() : Boolean { return false; }
            public function get name() : String { return null; }
            public function get qName() : QName { return null; }
            public function get namespaceURI() : String { return null; }
            public function get type() : Type { return null; }
            public function equals(other:Object) : Boolean { return false; }
            protected function compareMetadata(metadataArray:Array) : Boolean { return false; }
            as3commons_reflect function setDeclaringType(value:String) : void { }
            as3commons_reflect function setIsStatic(value:Boolean) : void { }
            as3commons_reflect function setName(value:String) : void { }
            as3commons_reflect function setNamespaceURI(value:String) : void { }
            as3commons_reflect function setType(value:String) : void { }
   }}