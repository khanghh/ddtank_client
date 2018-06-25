package yzhkof.logicdata{   import flash.display.Loader;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.net.URLLoader;   import flash.utils.ByteArray;   import yzhkof.debug.ScriptEvent;   import yzhkof.debug.ScriptRuner;      [Event(name="complete",type="flash.events.Event")]   [Event(name="result",type="yzhkof.debug.ScriptEvent")]   public class ScriptRun extends EventDispatcher   {                   public var data:Object;            public var urlLoader:URLLoader;            private var _loader:Loader;            public var script:String;            public var bytes:ByteArray;            public var param;            public function ScriptRun() { super(); }
            public function get loader() : Loader { return null; }
            public function set loader(value:Loader) : void { }
            public function set result(value:*) : void { }
            private function __loaderComplete(e:Event) : void { }
   }}