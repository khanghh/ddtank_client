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
      
      public function Clock()
      {
         super();
         _maxDeltas = 10;
      }
      
      public function start(param1:int, param2:int = -1, param3:Boolean = true) : void
      {
         if(running)
         {
            return;
         }
         if(param2 != -1)
         {
            _backgroundTimer = new Timer(param2);
            _backgroundTimer.addEventListener("timer",__onTimer);
            _backgroundTimer.start();
         }
         _internalClock = param1;
         _deltas = new Vector.<TimeDelta>();
         _lockedInServerTime = false;
         _responsePending = false;
         _bursting = param3;
         addEvent();
         ProcessManager.Instance.addObject(this);
         ping();
      }
      
      public function ping() : void
      {
         _timeRequestSent = _internalClock;
         LittleGameManager.Instance.ping(_timeRequestSent);
      }
      
      private function addEvent() : void
      {
         SocketManager.Instance.addEventListener("pong",__pong);
      }
      
      private function __pong(param1:LittleGameSocketEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         addTimeDelta(_timeRequestSent,_internalClock,_loc2_);
         _responsePending = false;
         if(_bursting)
         {
            if(_deltas.length >= _maxDeltas)
            {
               _bursting = false;
            }
            ping();
         }
      }
      
      private function addTimeDelta(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:Number = (param2 - param1) / 2;
         var _loc7_:int = param3 - param2;
         var _loc4_:int = _loc7_ + _loc5_;
         var _loc6_:TimeDelta = new TimeDelta(_loc5_,_loc4_);
         _deltas.push(_loc6_);
         if(_deltas.length > _maxDeltas)
         {
            _deltas.shift();
         }
         recalculate();
      }
      
      private function recalculate() : void
      {
         var _loc2_:Vector.<TimeDelta> = _deltas.slice(0);
         _loc2_.sort(compare);
         var _loc1_:int = determineMedian(_loc2_);
         pruneOutliers(_loc2_,_loc1_,1.5);
         _latency = determineAverageLatency(_loc2_);
         if(!_lockedInServerTime)
         {
            _syncTimeDelta = determineAverage(_loc2_);
            _lockedInServerTime = _deltas.length == _maxDeltas;
         }
      }
      
      private function determineAverage(param1:Vector.<TimeDelta>) : int
      {
         var _loc4_:* = NaN;
         var _loc3_:* = null;
         var _loc2_:* = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_];
            _loc2_ = Number(_loc2_ + _loc3_.timeSyncDelta);
            _loc4_++;
         }
         return _loc2_ / param1.length;
      }
      
      private function determineAverageLatency(param1:Vector.<TimeDelta>) : int
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc3_ = param1[_loc5_];
            _loc2_ = _loc2_ + _loc3_.latency;
            _loc5_++;
         }
         var _loc4_:int = _loc2_ / param1.length;
         _latencyError = Math.abs(TimeDelta(param1[param1.length - 1]).latency - _loc4_);
         return _loc4_;
      }
      
      private function pruneOutliers(param1:Vector.<TimeDelta>, param2:int, param3:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc4_:* = null;
         var _loc6_:Number = param2 * param3;
         _loc5_ = param1.length - 1;
         while(_loc5_ >= 0)
         {
            _loc4_ = param1[_loc5_];
            if(_loc4_.latency > _loc6_)
            {
               param1.splice(_loc5_,1);
               _loc5_--;
               continue;
            }
            break;
         }
      }
      
      private function determineMedian(param1:Vector.<TimeDelta>) : int
      {
         var _loc2_:Number = NaN;
         if(param1.length % 2 == 0)
         {
            _loc2_ = param1.length / 2 - 1;
            return (param1[_loc2_].latency + param1[_loc2_ + 1].latency) / 2;
         }
         _loc2_ = Math.floor(param1.length / 2);
         return param1[_loc2_].latency;
      }
      
      private function compare(param1:TimeDelta, param2:TimeDelta) : Number
      {
         if(param1.latency < param2.latency)
         {
            return -1;
         }
         if(param1.latency > param2.latency)
         {
            return 1;
         }
         return 0;
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
      }
      
      public function get onProcess() : Boolean
      {
         return _onProcess;
      }
      
      public function set onProcess(param1:Boolean) : void
      {
         _onProcess = param1;
      }
      
      public function get running() : Boolean
      {
         return _onProcess;
      }
      
      public function process(param1:Number) : void
      {
         _internalClock = _internalClock + param1;
      }
      
      private function __onTimer(param1:TimerEvent) : void
      {
         if(!_responsePending && !_bursting)
         {
            ping();
         }
      }
      
      public function get time() : Number
      {
         return _internalClock + _syncTimeDelta;
      }
      
      public function get latency() : int
      {
         return _latency;
      }
      
      public function get latencyError() : int
      {
         return _latencyError;
      }
      
      public function get maxDeltas() : Number
      {
         return _maxDeltas;
      }
      
      public function set maxDeltas(param1:Number) : void
      {
         _maxDeltas = param1;
      }
   }
}
