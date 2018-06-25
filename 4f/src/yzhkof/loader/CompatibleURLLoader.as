package yzhkof.loader{   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.HTTPStatusEvent;   import flash.events.IOErrorEvent;   import flash.events.ProgressEvent;   import flash.events.SecurityErrorEvent;   import flash.net.URLLoader;   import flash.net.URLRequest;   import flash.utils.getQualifiedClassName;   import yzhkof.util.EventProxy;   import yzhkof.util.delayCallNextFrame;      [Event(name="io_error",type="flash.events.IOErrorEvent")]   [Event(name="PROGRESS",type="flash.events.ProgressEvent")]   [Event(name="complete",type="flash.events.Event")]   public class CompatibleURLLoader extends EventDispatcher   {                   private var text_data:String;            private var _url_loader:URLLoader;            public function CompatibleURLLoader() { super(); }
            public function get dataFormat() : String { return null; }
            public function set dataFormat(value:String) : void { }
            public function load(request:Object) : void { }
            public function loadURL(url:Object) : void { }
            public function get data() : Object { return null; }
            public function getURLLoader() : URLLoader { return null; }
            private function dispatchManual() : void { }
            private function set url_loader(value:URLLoader) : void { }
            private function get url_loader() : URLLoader { return null; }
            private function reInit() : void { }
   }}