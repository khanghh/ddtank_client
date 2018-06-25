package morn.core.managers{   import flash.display.Shape;   import flash.events.Event;   import flash.utils.Dictionary;   import flash.utils.getTimer;      public class TimerManager   {                   private var _shape:Shape;            private var _pool:Vector.<TimerHandler>;            private var _handlers:Dictionary;            private var _currTimer:int;            private var _currFrame:int = 0;            private var _count:int = 0;            private var _index:uint = 0;            public function TimerManager() { super(); }
            private function onEnterFrame(e:Event) : void { }
            private function create(useFrame:Boolean, repeat:Boolean, delay:int, method:Function, args:Array = null, cover:Boolean = true) : Object { return null; }
            public function doOnce(delay:int, method:Function, args:Array = null, cover:Boolean = true) : Object { return null; }
            public function doLoop(delay:int, method:Function, args:Array = null, cover:Boolean = true) : Object { return null; }
            public function doFrameOnce(delay:int, method:Function, args:Array = null, cover:Boolean = true) : Object { return null; }
            public function doFrameLoop(delay:int, method:Function, args:Array = null, cover:Boolean = true) : Object { return null; }
            public function get count() : int { return 0; }
            public function clearTimer(method:Object) : void { }
   }}class TimerHandler{          public var delay:int;      public var repeat:Boolean;      public var userFrame:Boolean;      public var exeTime:int;      public var method:Function;      public var args:Array;      function TimerHandler() { super(); }
      public function clear() : void { }
}