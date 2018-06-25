package character.action{   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import mx.events.PropertyChangeEvent;      public class BaseAction implements IAction, IEventDispatcher   {            public static const BASE:int = -1;            public static const SIMPLE_ACTION:int = 0;            public static const COMPLEX_ACTION:int = 1;            public static const MOVIE_ACTION:int = 2;                   protected var _asset:DisplayObject;            protected var _nextAction:String;            protected var _name:String;            protected var _priority:uint;            protected var _len:int;            protected var _endStop:Boolean;            protected var _sound:String = "";            protected var _type:int;            private var _bindingEventDispatcher:EventDispatcher;            public function BaseAction(name:String = "", nextAction:String = "", priority:uint = 0, endStop:Boolean = false) { super(); }
            public function get len() : int { return 0; }
            public function get isEnd() : Boolean { return false; }
            private function set _3373707name(value:String) : void { }
            public function get name() : String { return null; }
            private function set _1794985207nextAction(value:String) : void { }
            public function get nextAction() : String { return null; }
            private function set _1165461084priority(value:uint) : void { }
            public function get priority() : uint { return null; }
            public function get asset() : DisplayObject { return null; }
            public function reset() : void { }
            public function dispose() : void { }
            public function toXml() : XML { return null; }
            public function get endStop() : Boolean { return false; }
            private function set _1607262339endStop(value:Boolean) : void { }
            public function get sound() : String { return null; }
            private function set _109627663sound(value:String) : void { }
            [Bindable(event="propertyChange")]      public function set nextAction(param1:String) : void { }
            [Bindable(event="propertyChange")]      public function set sound(param1:String) : void { }
            [Bindable(event="propertyChange")]      public function set priority(param1:uint) : void { }
            [Bindable(event="propertyChange")]      public function set endStop(param1:Boolean) : void { }
            [Bindable(event="propertyChange")]      public function set name(param1:String) : void { }
            public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void { }
            public function dispatchEvent(param1:Event) : Boolean { return false; }
            public function hasEventListener(param1:String) : Boolean { return false; }
            public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void { }
            public function willTrigger(param1:String) : Boolean { return false; }
   }}