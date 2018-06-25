package ddt.manager{   import ddt.interfaces.IProcessObject;   import flash.display.Shape;   import flash.events.Event;   import flash.utils.getTimer;      public class ProcessManager   {            private static var _ins:ProcessManager;                   private var _objects:Vector.<IProcessObject>;            private var _startup:Boolean = false;            private var _shape:Shape;            private var _elapsed:int;            private var _virtualTime:int;            public function ProcessManager() { super(); }
            public static function get Instance() : ProcessManager { return null; }
            public function addObject(object:IProcessObject) : IProcessObject { return null; }
            public function removeObject(object:IProcessObject) : IProcessObject { return null; }
            public function startup() : void { }
            private function __enterFrame(event:Event) : void { }
            public function shutdown() : void { }
            public function get running() : Boolean { return false; }
   }}