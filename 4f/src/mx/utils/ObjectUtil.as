package mx.utils{   import flash.utils.ByteArray;   import flash.utils.Dictionary;   import flash.utils.getQualifiedClassName;   import flash.xml.XMLNode;   import mx.collections.IList;   import mx.core.mx_internal;      use namespace mx_internal;      public class ObjectUtil   {            mx_internal static const VERSION:String = "4.1.0.16076";            private static var defaultToStringExcludes:Array = ["password","credentials"];            private static var refCount:int = 0;            private static var CLASS_INFO_CACHE:Object = {};                   public function ObjectUtil() { super(); }
            public static function compare(a:Object, b:Object, depth:int = -1) : int { return 0; }
            public static function copy(value:Object) : Object { return null; }
            public static function clone(value:Object) : Object { return null; }
            private static function cloneInternal(result:Object, value:Object) : void { }
            public static function isSimple(value:Object) : Boolean { return false; }
            public static function numericCompare(a:Number, b:Number) : int { return 0; }
            public static function stringCompare(a:String, b:String, caseInsensitive:Boolean = false) : int { return 0; }
            public static function dateCompare(a:Date, b:Date) : int { return 0; }
            public static function toString(value:Object, namespaceURIs:Array = null, exclude:Array = null) : String { return null; }
            private static function internalToString(value:Object, indent:int = 0, refs:Dictionary = null, namespaceURIs:Array = null, exclude:Array = null) : String { return null; }
            private static function newline(str:String, n:int = 0) : String { return null; }
            private static function internalCompare(a:Object, b:Object, currentDepth:int, desiredDepth:int, refs:Dictionary) : int { return 0; }
            public static function getClassInfo(obj:Object, excludes:Array = null, options:Object = null) : Object { return null; }
            public static function hasMetadata(obj:Object, propName:String, metadataName:String, excludes:Array = null, options:Object = null) : Boolean { return false; }
            public static function isDynamicObject(obj:Object) : Boolean { return false; }
            private static function internalHasMetadata(metadataInfo:Object, propName:String, metadataName:String) : Boolean { return false; }
            private static function recordMetadata(properties:XMLList) : Object { return null; }
            private static function getCacheKey(o:Object, excludes:Array = null, options:Object = null) : String { return null; }
            private static function arrayCompare(a:Array, b:Array, currentDepth:int, desiredDepth:int, refs:Dictionary) : int { return 0; }
            private static function byteArrayCompare(a:ByteArray, b:ByteArray) : int { return 0; }
            private static function listCompare(a:IList, b:IList, currentDepth:int, desiredDepth:int, refs:Dictionary) : int { return 0; }
            private static function getRef(o:Object, refs:Dictionary) : Object { return null; }
   }}