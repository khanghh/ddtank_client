package org.as3commons.reflect{   import flash.utils.Proxy;   import flash.utils.flash_proxy;   import org.as3commons.lang.IEquals;      public class MethodInvoker implements INamespaceOwner, IEquals   {            private static const CONSTRUCTOR_FIELD_NAME:String = "constructor";                   private var _target;            private var _method:String = "";            private var _arguments:Array;            private var _namespaceURI:String;            public function MethodInvoker() { super(); }
            public function get target() : * { return null; }
            public function set target(value:*) : void { }
            public function get method() : String { return null; }
            public function set method(value:String) : void { }
            public function get arguments() : Array { return null; }
            public function set arguments(value:Array) : void { }
            public function get namespaceURI() : String { return null; }
            public function set namespaceURI(value:String) : void { }
            public function invoke() : * { return null; }
            public function equals(other:Object) : Boolean { return false; }
   }}