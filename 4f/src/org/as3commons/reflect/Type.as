package org.as3commons.reflect{   import flash.system.ApplicationDomain;   import org.as3commons.lang.ClassNotFoundError;   import org.as3commons.lang.ClassUtils;   import org.as3commons.lang.HashArray;      public class Type extends MetadataContainer   {            public static const UNTYPED:Type = new Type(currentApplicationDomain);            public static const VOID:Type = new Type(currentApplicationDomain);            public static const PRIVATE:Type = new Type(currentApplicationDomain);            private static const MEMBER_PROPERTY_NAME:String = "name";            public static const VOID_NAME:String = "void";            private static const UNTYPED_NAME:String = "*";            private static const PRIVATE_NAME:String = "private";            public static var typeProviderKind:TypeProviderKind = TypeProviderKind.JSON;            private static var typeProvider:ITypeProvider;            private static var _currentApplicationDomain:ApplicationDomain;            {         UNTYPED.fullName = UNTYPED_NAME;         UNTYPED.name = UNTYPED_NAME;         VOID.fullName = VOID_NAME;         VOID.name = VOID_NAME;         PRIVATE.fullName = PRIVATE_NAME;         PRIVATE.name = PRIVATE_NAME;      }            private var _applicationDomain:ApplicationDomain;            private var _alias:String;            private var _name:String;            private var _fullName:String;            private var _class:Class;            private var _isDynamic:Boolean;            private var _isFinal:Boolean;            private var _isStatic:Boolean;            private var _isInterface:Boolean;            private var _parameters:Array;            private var _interfaces:Array;            private var _constructor:Constructor;            private var _accessors:Array;            private var _methods:HashArray;            private var _staticConstants:Array;            private var _constants:Array;            private var _staticVariables:Array;            private var _extendsClasses:Array;            private var _variables:Array;            private var _fields:HashArray;            private var _metadataLookup:Object;            public function Type(applicationDomain:ApplicationDomain) { super(); }
            public static function reset() : void { }
            public static function get currentApplicationDomain() : ApplicationDomain { return null; }
            public static function forInstance(instance:*, applicationDomain:ApplicationDomain = null) : Type { return null; }
            public static function forName(name:String, applicationDomain:ApplicationDomain = null) : Type { return null; }
            public static function forClass(clazz:Class, applicationDomain:ApplicationDomain = null) : Type { return null; }
            public static function getTypeProvider() : ITypeProvider { return null; }
            public function get applicationDomain() : ApplicationDomain { return null; }
            public function set applicationDomain(value:ApplicationDomain) : void { }
            public function get alias() : String { return null; }
            public function set alias(value:String) : void { }
            public function get name() : String { return null; }
            public function set name(value:String) : void { }
            public function get fullName() : String { return null; }
            public function set fullName(value:String) : void { }
            public function get clazz() : Class { return null; }
            public function set clazz(value:Class) : void { }
            public function get isDynamic() : Boolean { return false; }
            public function set isDynamic(value:Boolean) : void { }
            public function get isFinal() : Boolean { return false; }
            public function set isFinal(value:Boolean) : void { }
            public function get isStatic() : Boolean { return false; }
            public function set isStatic(value:Boolean) : void { }
            public function get isInterface() : Boolean { return false; }
            public function set isInterface(value:Boolean) : void { }
            public function get parameters() : Array { return null; }
            public function get interfaces() : Array { return null; }
            public function set interfaces(value:Array) : void { }
            public function get constructor() : Constructor { return null; }
            public function set constructor(constructor:Constructor) : void { }
            public function get accessors() : Array { return null; }
            public function set accessors(value:Array) : void { }
            public function get methods() : Array { return null; }
            public function set methods(value:Array) : void { }
            public function get staticConstants() : Array { return null; }
            public function set staticConstants(value:Array) : void { }
            public function get constants() : Array { return null; }
            public function set constants(value:Array) : void { }
            public function get staticVariables() : Array { return null; }
            public function set staticVariables(value:Array) : void { }
            public function get extendsClasses() : Array { return null; }
            public function set extendsClasses(value:Array) : void { }
            public function get variables() : Array { return null; }
            public function set variables(value:Array) : void { }
            public function get fields() : Array { return null; }
            private function createFieldsHashArray() : void { }
            public function get properties() : Array { return null; }
            public function getMethod(name:String, ns:String = null) : Method { return null; }
            public function getField(name:String, ns:String = null) : Field { return null; }
            public function createMetadataLookup() : void { }
            public function getMetadataContainers(name:String) : Array { return null; }
            private function addToMetadataLookup(containerList:Array) : void { }
            as3commons_reflect function setParameters(value:Array) : void { }
   }}