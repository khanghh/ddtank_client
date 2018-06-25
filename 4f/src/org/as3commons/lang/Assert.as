package org.as3commons.lang{   import flash.utils.Dictionary;   import flash.utils.getQualifiedClassName;      public final class Assert   {                   public function Assert() { super(); }
            public static function isTrue(expression:Boolean, message:String = "") : void { }
            public static function notAbstract(instance:Object, abstractClass:Class, message:String = "") : void { }
            public static function notNull(object:Object, message:String = "") : void { }
            public static function instanceOf(object:*, type:Class, message:String = "") : void { }
            public static function subclassOf(clazz:Class, parentClass:Class, message:String = "") : void { }
            public static function implementationOf(object:*, interfaze:Class, message:String = "") : void { }
            public static function state(expression:Boolean, message:String = "") : void { }
            public static function hasText(string:String, message:String = "") : void { }
            public static function dictionaryKeysOfType(dictionary:Dictionary, type:Class, message:String = "") : void { }
            public static function arrayContains(array:Array, item:*, message:String = "") : void { }
            public static function arrayItemsOfType(array:Array, type:Class, message:String = "") : void { }
   }}