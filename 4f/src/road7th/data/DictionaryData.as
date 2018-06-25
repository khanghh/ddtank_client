package road7th.data{   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.utils.Dictionary;      [Event(name="add",type="road7th.data.DictionaryEvent")]   [Event(name="update",type="road7th.data.DictionaryEvent")]   [Event(name="remove",type="road7th.data.DictionaryEvent")]   [Event(name="clear",type="road7th.data.DictionaryEvent")]   public dynamic class DictionaryData extends Dictionary implements IEventDispatcher   {                   private var _dispatcher:EventDispatcher;            private var _array:Array;            private var _fName:String;            private var _value:Object;            public function DictionaryData(weakKeys:Boolean = false) { super(null); }
            public function get length() : int { return 0; }
            public function get list() : Array { return null; }
            public function filter(field:String, value:Object) : Array { return null; }
            private function filterCallBack(item:*, index:int, array:Array) : Boolean { return false; }
            public function add(key:*, value:Object) : void { }
            public function hasKey(key:*) : Boolean { return false; }
            public function remove(key:*) : void { }
            public function setData(dic:DictionaryData) : void { }
            public function clear() : void { }
            public function slice(startIndex:int = 0, endIndex:int = 166777215) : Array { return null; }
            public function concat(arr:Array) : Array { return null; }
            private function cleardata() : void { }
            public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void { }
            public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void { }
            public function dispatchEvent(event:Event) : Boolean { return false; }
            public function hasEventListener(type:String) : Boolean { return false; }
            public function willTrigger(type:String) : Boolean { return false; }
   }}