package littleGame.clock
{
   import ddt.interfaces.IProcessObject;
   import ddt.manager.ProcessManager;
   import ddt.manager.SocketManager;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import littleGame.LittleGameManager;
   import littleGame.events.LittleGameSocketEvent;
   
   public class Clock extends EventDispatcher implements IProcessObject
   {
       
      
      private var _deltas:Vector.<TimeDelta>;
      
      private var _maxDeltas:Number;
      
      private var _syncTimeDelta:int;
      
      private var _responsePending:Boolean;
      
      private var _timeRequestSent:Number;
      
      private var _latency:int;
      
      private var _latencyError:int;
      
      private var _backgroundWaitTime:int;
      
      private var _backgroundTimer:Timer;
      
      private var _bursting:Boolean;
      
      private var _lockedInServerTime:Boolean;
      
      private var _onProcess:Boolean;
      
      private var _internalClock:int;
      
      public function Clock(){super();}
      
      public function start(param1:int, param2:int = -1, param3:Boolean = true) : void{}
      
      public function ping() : void{}
      
      private function addEvent() : void{}
      
      private function __pong(param1:LittleGameSocketEvent) : void{}
      
      private function addTimeDelta(param1:int, param2:int, param3:int) : void{}
      
      private function recalculate() : void{}
      
      private function determineAverage(param1:Vector.<TimeDelta>) : int{return 0;}
      
      private function determineAverageLatency(param1:Vector.<TimeDelta>) : int{return 0;}
      
      private function pruneOutliers(param1:Vector.<TimeDelta>, param2:int, param3:Number) : void{}
      
      private function determineMedian(param1:Vector.<TimeDelta>) : int{return 0;}
      
      private function compare(param1:TimeDelta, param2:TimeDelta) : Number{return 0;}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
      
      public function get onProcess() : Boolean{return false;}
      
      public function set onProcess(param1:Boolean) : void{}
      
      public function get running() : Boolean{return false;}
      
      public function process(param1:Number) : void{}
      
      private function __onTimer(param1:TimerEvent) : void{}
      
      public function get time() : Number{return 0;}
      
      public function get latency() : int{return 0;}
      
      public function get latencyError() : int{return 0;}
      
      public function get maxDeltas() : Number{return 0;}
      
      public function set maxDeltas(param1:Number) : void{}
   }
}
