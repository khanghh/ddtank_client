package ddt.data{   import ddt.events.CEvent;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.utils.Dictionary;      public class BaseEventDispatcherInfo extends EventDispatcher   {            public static const PROPERTY_CHANGE:String = "propertychange";                   protected var _changeCount:int = 0;            protected var _changedPropeties:Dictionary;            public function BaseEventDispatcherInfo(target:IEventDispatcher = null) { super(null); }
            public function beginChanges() : void { }
            public function commitChanges() : void { }
            protected function onPropertiesChanged(propName:String = null) : void { }
            public function updateProperties() : void { }
   }}