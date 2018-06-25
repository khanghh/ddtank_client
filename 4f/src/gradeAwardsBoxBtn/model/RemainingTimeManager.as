package gradeAwardsBoxBtn.model{   import flash.events.TimerEvent;   import flash.utils.Timer;      public class RemainingTimeManager   {            private static var instance:RemainingTimeManager;                   public var funOnTimer:Function = null;            private var _timer:Timer;            public function RemainingTimeManager(single:inner) { super(); }
            public static function getInstance() : RemainingTimeManager { return null; }
            public function start() : void { }
            protected function onTimer(te:TimerEvent) : void { }
            public function stop() : void { }
            public function isRuning() : Boolean { return false; }
            public function dispose() : void { }
   }}class inner{          function inner() { super(); }
}