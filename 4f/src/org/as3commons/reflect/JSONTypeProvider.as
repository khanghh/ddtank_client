package org.as3commons.reflect{   import avmplus.DescribeType;   import flash.errors.IllegalOperationError;   import flash.system.ApplicationDomain;   import org.as3commons.lang.ClassUtils;      public class JSONTypeProvider extends AbstractTypeProvider   {            public static const ALIAS_NOT_AVAILABLE:String = "Alias not available when using JSONTypeProvider";                   private var _describeTypeJSON:Function;            private var _ignoredMetadata:Array;            public function JSONTypeProvider() { super(); }
            protected function initJSONTypeProvider() : void { }
            override public function getType(cls:Class, applicationDomain:ApplicationDomain) : Type { return null; }
            protected function parseConstructor(type:Type, constructor:Array, applicationDomain:ApplicationDomain) : Constructor { return null; }
            private function concatMetadata(type:Type, metadataContainers:Array, propertyName:String) : void { }
            private function parseImplementedInterfaces(interfacesDescription:Array) : Array { return null; }
            private function parseMethods(type:Type, methods:Array, applicationDomain:ApplicationDomain, isStatic:Boolean) : Array { return null; }
            private function parseParameters(params:Array, applicationDomain:ApplicationDomain) : Array { return null; }
            private function parseAccessors(type:Type, accessors:Array, applicationDomain:ApplicationDomain, isStatic:Boolean) : Array { return null; }
            private function parseMetadata(metadataNodes:Array, metadata:IMetadataContainer) : void { }
            private function isIgnoredMetadata(metadataName:String) : Boolean { return false; }
            private function parseMembers(type:Type, memberClass:Class, members:Array, declaringType:String, isStatic:Boolean, isConstant:Boolean, applicationDomain:ApplicationDomain) : Array { return null; }
   }}