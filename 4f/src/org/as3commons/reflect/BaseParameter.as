package org.as3commons.reflect{   import flash.system.ApplicationDomain;   import org.as3commons.lang.IEquals;   import org.as3commons.reflect.util.CacheUtil;      public class BaseParameter implements IEquals   {            private static const _cache:Object = {};                   private var _applicationDomain:ApplicationDomain;            private var _isOptional:Boolean;            protected var typeName:String;            public function BaseParameter(type:String, applicationDomain:ApplicationDomain, isOptional:Boolean = false) { super(); }
            public static function newInstance(type:String, applicationDomain:ApplicationDomain, isOptional:Boolean = false) : BaseParameter { return null; }
            private static function getCacheKey(type:String, applicationDomain:ApplicationDomain, isOptional:Boolean) : String { return null; }
            public function get isOptional() : Boolean { return false; }
            public function get type() : Type { return null; }
            as3commons_reflect function setIsOptional(value:Boolean) : void { }
            as3commons_reflect function setType(value:String) : void { }
            public function equals(other:Object) : Boolean { return false; }
            private function valuesAreEqual(typeName:String, appDomain:ApplicationDomain, isOptional:Boolean) : Boolean { return false; }
   }}