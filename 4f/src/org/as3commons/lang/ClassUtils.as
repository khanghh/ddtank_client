package org.as3commons.lang
{
   import flash.events.TimerEvent;
   import flash.system.ApplicationDomain;
   import flash.utils.Proxy;
   import flash.utils.Timer;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getQualifiedSuperclassName;
   
   public final class ClassUtils
   {
      
      public static const CLEAR_CACHE_INTERVAL:uint = 60000;
      
      private static const AS3VEC_SUFFIX:String = "__AS3__.vec";
      
      private static const LESS_THAN:String = "<";
      
      private static const CONSTRUCTOR_FIELD_NAME:String = "constructor";
      
      private static const PACKAGE_CLASS_SEPARATOR:String = "::";
      
      public static var clearCacheInterval:uint = CLEAR_CACHE_INTERVAL;
      
      private static var _describeTypeCache:Object = {};
      
      private static var _timer:Timer;
       
      
      public function ClassUtils(){super();}
      
      public static function forInstance(param1:*, param2:ApplicationDomain = null) : Class{return null;}
      
      public static function forName(param1:String, param2:ApplicationDomain = null) : Class{return null;}
      
      public static function getName(param1:Class) : String{return null;}
      
      public static function getNameFromFullyQualifiedName(param1:String) : String{return null;}
      
      public static function getFullyQualifiedName(param1:Class, param2:Boolean = false) : String{return null;}
      
      public static function isAssignableFrom(param1:Class, param2:Class, param3:ApplicationDomain = null) : Boolean{return false;}
      
      public static function isPrivateClass(param1:*) : Boolean{return false;}
      
      public static function getProperties(param1:*, param2:Boolean = false, param3:Boolean = true, param4:Boolean = true, param5:ApplicationDomain = null) : Object{return null;}
      
      public static function isSubclassOf(param1:Class, param2:Class, param3:ApplicationDomain = null) : Boolean{return false;}
      
      public static function getSuperClass(param1:Class, param2:ApplicationDomain = null) : Class{return null;}
      
      public static function getSuperClassName(param1:Class) : String{return null;}
      
      public static function getFullyQualifiedSuperClassName(param1:Class, param2:Boolean = false) : String{return null;}
      
      public static function isImplementationOf(param1:Class, param2:Class, param3:ApplicationDomain = null) : Boolean{return false;}
      
      public static function isInformalImplementationOf(param1:Class, param2:Class, param3:ApplicationDomain = null) : Boolean{return false;}
      
      public static function isInterface(param1:Class) : Boolean{return false;}
      
      public static function getImplementedInterfaceNames(param1:Class) : Array{return null;}
      
      public static function getFullyQualifiedImplementedInterfaceNames(param1:Class, param2:Boolean = false, param3:ApplicationDomain = null) : Array{return null;}
      
      public static function getImplementedInterfaces(param1:Class, param2:ApplicationDomain = null) : Array{return null;}
      
      public static function newInstance(param1:Class, param2:Array = null) : *{return null;}
      
      public static function convertFullyQualifiedName(param1:String) : String{return null;}
      
      public static function clearDescribeTypeCache() : void{}
      
      public static function getClassParameterFromFullyQualifiedName(param1:String, param2:ApplicationDomain = null) : Class{return null;}
      
      private static function timerHandler(param1:TimerEvent) : void{}
      
      private static function getFromObject(param1:Object, param2:ApplicationDomain) : XML{return null;}
   }
}
