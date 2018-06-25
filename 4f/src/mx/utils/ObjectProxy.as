package mx.utils{   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.utils.IDataInput;   import flash.utils.IDataOutput;   import flash.utils.IExternalizable;   import flash.utils.Proxy;   import flash.utils.flash_proxy;   import flash.utils.getQualifiedClassName;   import mx.core.IPropertyChangeNotifier;   import mx.events.PropertyChangeEvent;   import mx.events.PropertyChangeEventKind;      use namespace object_proxy;   use namespace flash_proxy;      [RemoteClass(alias="flex.messaging.io.ObjectProxy")]   [Bindable("propertyChange")]   public dynamic class ObjectProxy extends Proxy implements IExternalizable, IPropertyChangeNotifier   {                   protected var dispatcher:EventDispatcher;            protected var notifiers:Object;            protected var proxyClass:Class;            protected var propertyList:Array;            private var _proxyLevel:int;            private var _item:Object;            private var _type:QName;            private var _id:String;            public function ObjectProxy(item:Object = null, uid:String = null, proxyDepth:int = -1) { super(); }
            object_proxy function get object() : Object { return null; }
            object_proxy function get type() : QName { return null; }
            object_proxy function set type(value:QName) : void { }
            public function get uid() : String { return null; }
            public function set uid(value:String) : void { }
            override flash_proxy function getProperty(name:*) : * { return null; }
            override flash_proxy function callProperty(name:*, ... rest) : * { return null; }
            override flash_proxy function deleteProperty(name:*) : Boolean { return false; }
            override flash_proxy function hasProperty(name:*) : Boolean { return false; }
            override flash_proxy function nextName(index:int) : String { return null; }
            override flash_proxy function nextNameIndex(index:int) : int { return 0; }
            override flash_proxy function nextValue(index:int) : * { return null; }
            override flash_proxy function setProperty(name:*, value:*) : void { }
            object_proxy function getComplexProperty(name:*, value:*) : * { return null; }
            public function readExternal(input:IDataInput) : void { }
            public function writeExternal(output:IDataOutput) : void { }
            public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void { }
            public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void { }
            public function dispatchEvent(event:Event) : Boolean { return false; }
            public function hasEventListener(type:String) : Boolean { return false; }
            public function willTrigger(type:String) : Boolean { return false; }
            public function propertyChangeHandler(event:PropertyChangeEvent) : void { }
            protected function setupPropertyList() : void { }
   }}