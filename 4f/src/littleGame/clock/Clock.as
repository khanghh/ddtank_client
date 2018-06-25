package littleGame.clock{   import ddt.interfaces.IProcessObject;   import ddt.manager.ProcessManager;   import ddt.manager.SocketManager;   import flash.events.EventDispatcher;   import flash.events.TimerEvent;   import flash.utils.Timer;   import littleGame.LittleGameManager;   import littleGame.events.LittleGameSocketEvent;      public class Clock extends EventDispatcher implements IProcessObject   {                   private var _deltas:Vector.<TimeDelta>;            private var _maxDeltas:Number;            private var _syncTimeDelta:int;            private var _responsePending:Boolean;            private var _timeRequestSent:Number;            private var _latency:int;            private var _latencyError:int;            private var _backgroundWaitTime:int;            private var _backgroundTimer:Timer;            private var _bursting:Boolean;            private var _lockedInServerTime:Boolean;            private var _onProcess:Boolean;            private var _internalClock:int;            public function Clock() { super(); }
            public function start(start:int, pingDelay:int = -1, burst:Boolean = true) : void { }
            public function ping() : void { }
            private function addEvent() : void { }
            private function __pong(event:LittleGameSocketEvent) : void { }
            private function addTimeDelta(clientSendTime:int, clientReceiveTime:int, serverTime:int) : void { }
            private function recalculate() : void { }
            private function determineAverage(deltas:Vector.<TimeDelta>) : int { return 0; }
            private function determineAverageLatency(deltas:Vector.<TimeDelta>) : int { return 0; }
            private function pruneOutliers(deltas:Vector.<TimeDelta>, median:int, threshold:Number) : void { }
            private function determineMedian(deltas:Vector.<TimeDelta>) : int { return 0; }
            private function compare(a:TimeDelta, b:TimeDelta) : Number { return 0; }
            private function removeEvent() : void { }
            public function dispose() : void { }
            public function get onProcess() : Boolean { return false; }
            public function set onProcess(val:Boolean) : void { }
            public function get running() : Boolean { return false; }
            public function process(rate:Number) : void { }
            private function __onTimer(event:TimerEvent) : void { }
            public function get time() : Number { return 0; }
            public function get latency() : int { return 0; }
            public function get latencyError() : int { return 0; }
            public function get maxDeltas() : Number { return 0; }
            public function set maxDeltas(val:Number) : void { }
   }}