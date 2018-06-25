package org.as3commons.reflect{   import org.as3commons.lang.IEquals;      public class MetadataArgument implements IEquals   {            private static const _cache:Object = {};                   private var _key:String;            private var _value:String;            public function MetadataArgument(key:String, value:String) { super(); }
            public static function newInstance(name:String, value:String) : MetadataArgument { return null; }
            public static function getCacheKey(arg:MetadataArgument) : String { return null; }
            public static function getCacheKeyByNameAndValue(key:String, value:String) : String { return null; }
            public function get key() : String { return null; }
            public function get value() : String { return null; }
            public function equals(other:Object) : Boolean { return false; }
   }}