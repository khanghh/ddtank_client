package mx.utils
{
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.xml.XMLNode;
   import mx.collections.IList;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class ObjectUtil
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      private static var defaultToStringExcludes:Array = ["password","credentials"];
      
      private static var refCount:int = 0;
      
      private static var CLASS_INFO_CACHE:Object = {};
       
      
      public function ObjectUtil(){super();}
      
      public static function compare(param1:Object, param2:Object, param3:int = -1) : int{return 0;}
      
      public static function copy(param1:Object) : Object{return null;}
      
      public static function clone(param1:Object) : Object{return null;}
      
      private static function cloneInternal(param1:Object, param2:Object) : void{}
      
      public static function isSimple(param1:Object) : Boolean{return false;}
      
      public static function numericCompare(param1:Number, param2:Number) : int{return 0;}
      
      public static function stringCompare(param1:String, param2:String, param3:Boolean = false) : int{return 0;}
      
      public static function dateCompare(param1:Date, param2:Date) : int{return 0;}
      
      public static function toString(param1:Object, param2:Array = null, param3:Array = null) : String{return null;}
      
      private static function internalToString(param1:Object, param2:int = 0, param3:Dictionary = null, param4:Array = null, param5:Array = null) : String{return null;}
      
      private static function newline(param1:String, param2:int = 0) : String{return null;}
      
      private static function internalCompare(param1:Object, param2:Object, param3:int, param4:int, param5:Dictionary) : int{return 0;}
      
      public static function getClassInfo(param1:Object, param2:Array = null, param3:Object = null) : Object{return null;}
      
      public static function hasMetadata(param1:Object, param2:String, param3:String, param4:Array = null, param5:Object = null) : Boolean{return false;}
      
      public static function isDynamicObject(param1:Object) : Boolean{return false;}
      
      private static function internalHasMetadata(param1:Object, param2:String, param3:String) : Boolean{return false;}
      
      private static function recordMetadata(param1:XMLList) : Object{return null;}
      
      private static function getCacheKey(param1:Object, param2:Array = null, param3:Object = null) : String{return null;}
      
      private static function arrayCompare(param1:Array, param2:Array, param3:int, param4:int, param5:Dictionary) : int{return 0;}
      
      private static function byteArrayCompare(param1:ByteArray, param2:ByteArray) : int{return 0;}
      
      private static function listCompare(param1:IList, param2:IList, param3:int, param4:int, param5:Dictionary) : int{return 0;}
      
      private static function getRef(param1:Object, param2:Dictionary) : Object{return null;}
   }
}
