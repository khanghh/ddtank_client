package org.as3commons.lang{   import flash.events.TimerEvent;   import flash.system.ApplicationDomain;   import flash.utils.Proxy;   import flash.utils.Timer;   import flash.utils.describeType;   import flash.utils.getQualifiedClassName;   import flash.utils.getQualifiedSuperclassName;      public final class ClassUtils   {            public static const CLEAR_CACHE_INTERVAL:uint = 60000;            private static const AS3VEC_SUFFIX:String = "__AS3__.vec";            private static const LESS_THAN:String = "<";            private static const CONSTRUCTOR_FIELD_NAME:String = "constructor";            private static const PACKAGE_CLASS_SEPARATOR:String = "::";            public static var clearCacheInterval:uint = CLEAR_CACHE_INTERVAL;            private static var _describeTypeCache:Object = {};            private static var _timer:Timer;                   public function ClassUtils() { super(); }
            public static function forInstance(instance:*, applicationDomain:ApplicationDomain = null) : Class { return null; }
            public static function forName(name:String, applicationDomain:ApplicationDomain = null) : Class { return null; }
            public static function getName(clazz:Class) : String { return null; }
            public static function getNameFromFullyQualifiedName(fullyQualifiedName:String) : String { return null; }
            public static function getFullyQualifiedName(clazz:Class, replaceColons:Boolean = false) : String { return null; }
            public static function isAssignableFrom(clazz1:Class, clazz2:Class, applicationDomain:ApplicationDomain = null) : Boolean { return false; }
            public static function isPrivateClass(object:*) : Boolean { return false; }
            public static function getProperties(clazz:*, statik:Boolean = false, readable:Boolean = true, writable:Boolean = true, applicationDomain:ApplicationDomain = null) : Object { return null; }
            public static function isSubclassOf(clazz:Class, parentClass:Class, applicationDomain:ApplicationDomain = null) : Boolean { return false; }
            public static function getSuperClass(clazz:Class, applicationDomain:ApplicationDomain = null) : Class { return null; }
            public static function getSuperClassName(clazz:Class) : String { return null; }
            public static function getFullyQualifiedSuperClassName(clazz:Class, replaceColons:Boolean = false) : String { return null; }
            public static function isImplementationOf(clazz:Class, interfaze:Class, applicationDomain:ApplicationDomain = null) : Boolean { return false; }
            public static function isInformalImplementationOf(clazz:Class, interfaze:Class, applicationDomain:ApplicationDomain = null) : Boolean { return false; }
            public static function isInterface(clazz:Class) : Boolean { return false; }
            public static function getImplementedInterfaceNames(clazz:Class) : Array { return null; }
            public static function getFullyQualifiedImplementedInterfaceNames(clazz:Class, replaceColons:Boolean = false, applicationDomain:ApplicationDomain = null) : Array { return null; }
            public static function getImplementedInterfaces(clazz:Class, applicationDomain:ApplicationDomain = null) : Array { return null; }
            public static function newInstance(clazz:Class, args:Array = null) : * { return null; }
            public static function convertFullyQualifiedName(className:String) : String { return null; }
            public static function clearDescribeTypeCache() : void { }
            public static function getClassParameterFromFullyQualifiedName(fullName:String, applicationDomain:ApplicationDomain = null) : Class { return null; }
            private static function timerHandler(e:TimerEvent) : void { }
            private static function getFromObject(object:Object, applicationDomain:ApplicationDomain) : XML { return null; }
   }}