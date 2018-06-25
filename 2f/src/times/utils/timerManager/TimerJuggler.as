package times.utils.timerManager{   import flash.events.Event;   import flash.events.EventDispatcher;      public final class TimerJuggler extends EventDispatcher   {                   private var _id:uint;            private var _delay:Number;            private var _repeatCount:int;            private var _running:Boolean;            private var _currentCount:int = 0;            private var _totalTime:Number;            private var _currentTime:int = 0;            private var _revise:Boolean;            private var _type:String;            public function TimerJuggler(internalFag:InternalFlag, $delay:Number, $repeatCount:int, $id:int, $revise:Boolean, type:String) { super(); }
            final function advance(duration:Number) : void { }
            public function reset() : void { }
            public function start() : void { }
            public function stop() : void { }
            public function get running() : Boolean { return false; }
            public function get currentCount() : int { return 0; }
            public function get id() : uint { return null; }
            public function get repeatCount() : int { return 0; }
            public function set repeatCount(value:int) : void { }
            public function get delay() : Number { return 0; }
            public function set delay(value:Number) : void { }
            public function get revise() : Boolean { return false; }
            public function get type() : String { return null; }
   }}