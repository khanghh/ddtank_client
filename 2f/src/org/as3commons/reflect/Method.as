package org.as3commons.reflect{   import flash.system.ApplicationDomain;   import org.as3commons.lang.HashArray;      public class Method extends MetadataContainer implements INamespaceOwner   {                   protected var applicationDomain:ApplicationDomain;            private var updateFullName:Boolean = true;            protected var declaringTypeName:String;            private var _fullName:String;            private var _isStatic:Boolean;            private var _name:String;            private var _qName:QName;            private var _namespaceURI:String;            protected var _parameters:Array;            private var _returnTypeName:String;            public function Method(declaringType:String, name:String, isStatic:Boolean, parameters:Array, returnType:String, applicationDomain:ApplicationDomain, metadata:HashArray = null) { super(null); }
            public function get declaringType() : Type { return null; }
            public function get fullName() : String { return null; }
            public function get isStatic() : Boolean { return false; }
            public function get name() : String { return null; }
            public function get qName() : QName { return null; }
            public function get namespaceURI() : String { return null; }
            public function get parameters() : Array { return null; }
            public function get returnType() : Type { return null; }
            as3commons_reflect function get returnTypeName() : String { return null; }
            public function invoke(target:*, args:Array) : * { return null; }
            public function toString() : String { return null; }
            as3commons_reflect function setDeclaringType(value:String) : void { }
            as3commons_reflect function setFullName(value:String) : void { }
            as3commons_reflect function setIsStatic(value:Boolean) : void { }
            as3commons_reflect function setName(value:String) : void { }
            as3commons_reflect function setNamespaceURI(value:String) : void { }
            as3commons_reflect function setParameters(value:Array) : void { }
            as3commons_reflect function setReturnType(value:String) : void { }
   }}