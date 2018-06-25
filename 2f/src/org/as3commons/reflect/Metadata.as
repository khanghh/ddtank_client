package org.as3commons.reflect{   import org.as3commons.lang.IEquals;   import org.as3commons.reflect.util.CacheUtil;      public class Metadata implements IEquals   {            public static const TRANSIENT:String = "Transient";            public static const BINDABLE:String = "Bindable";            private static const _cache:Object = {};                   private var _name:String;            private var _arguments:Array;            public function Metadata(name:String, arguments:Array = null) { super(); }
            public static function newInstance(name:String, arguments:Array = null) : Metadata { return null; }
            public static function getCacheKey(metadata:Metadata) : String { return null; }
            private static function getCacheKeyByNameAndArgs(key:String, metadataArgs:Array) : String { return null; }
            public function get name() : String { return null; }
            public function get arguments() : Array { return null; }
            public function hasArgumentWithKey(key:String) : Boolean { return false; }
            public function getArgument(key:String) : MetadataArgument { return null; }
            public function equals(other:Object) : Boolean { return false; }
            public function toString() : String { return null; }
            private function argumentsAreEqual(metadataArgs:Array) : Boolean { return false; }
            as3commons_reflect function setName(value:String) : void { }
   }}