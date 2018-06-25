package com.pickgliss.loader{   import flash.events.Event;   import flash.events.EventDispatcher;      public class LoaderQueue extends EventDispatcher   {                   private var _loaders:Vector.<BaseLoader>;            public function LoaderQueue() { super(); }
            public function addLoader(loader:BaseLoader) : void { }
            public function start() : void { }
            public function dispose() : void { }
            public function removeEvent() : void { }
            public function get length() : int { return 0; }
            public function get loaders() : Vector.<BaseLoader> { return null; }
            private function __loadComplete(event:LoaderEvent) : void { }
            public function get isComplete() : Boolean { return false; }
   }}