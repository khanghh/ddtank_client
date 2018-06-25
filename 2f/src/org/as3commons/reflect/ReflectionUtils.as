package org.as3commons.reflect{   import flash.system.Capabilities;   import flash.utils.describeType;   import org.as3commons.lang.ClassUtils;      public final class ReflectionUtils   {            private static var _version:String;            private static var _isOldPlayer:Boolean = true;                   public function ReflectionUtils() { super(); }
            public static function concatTypeMetadata(type:Type, metadataContainers:Array, propertyName:String) : void { }
            public static function getTypeDescription(clazz:Class) : XML { return null; }
            public static function playerHasConstructorBug() : Boolean { return false; }
   }}