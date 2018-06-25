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
      
      public function start(start:int, pingDelay:int = -1, burst:Boolean = true) : void
      {
         if(running)
         {
            return;
         }
         if(pingDelay != -1)
         {
            _backgroundTimer = new Timer(pingDelay);
            _backgroundTimer.addEventListener("timer",__onTimer);
            _backgroundTimer.start();
         }
         _internalClock = start;
         _deltas = new Vector.<TimeDelta>();
         _lockedInServerTime = false;
         _responsePending = false;
         _bursting = burst;
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
      
      private function __pong(event:LittleGameSocketEvent) : void
      {
         var serverTimeStamp:int = event.pkg.readInt();
         addTimeDelta(_timeRequestSent,_internalClock,serverTimeStamp);
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
      
      private function addTimeDelta(clientSendTime:int, clientReceiveTime:int, serverTime:int) : void
      {
         var latency:Number = (clientReceiveTime - clientSendTime) / 2;
         var clientServerDelta:int = serverTime - clientReceiveTime;
         var timeSyncDelta:int = clientServerDelta + latency;
         var delta:TimeDelta = new TimeDelta(latency,timeSyncDelta);
         _deltas.push(delta);
         if(_deltas.length > _maxDeltas)
         {
            _deltas.shift();
         }
         recalculate();
      }
      
      private function recalculate() : void
      {
         var tmp_deltas:Vector.<TimeDelta> = _deltas.slice(0);
         tmp_deltas.sort(compare);
         var medianLatency:int = determineMedian(tmp_deltas);
         pruneOutliers(tmp_deltas,medianLatency,1.5);
         _latency = determineAverageLatency(tmp_deltas);
         if(!_lockedInServerTime)
         {
            _syncTimeDelta = determineAverage(tmp_deltas);
            _lockedInServerTime = _deltas.length == _maxDeltas;
         }
      }
      
      private function determineAverage(deltas:Vector.<TimeDelta>) : int
      {
         var i:* = NaN;
         var td:* = null;
         var total:* = 0;
         for(i = 0; i < deltas.length; )
         {
            td = deltas[i];
            total = Number(total + td.timeSyncDelta);
            i++;
         }
         return total / deltas.length;
      }
      
      private function determineAverageLatency(deltas:Vector.<TimeDelta>) : int
      {
         var i:int = 0;
         var td:* = null;
         var total:int = 0;
         for(i = 0; i < deltas.length; )
         {
            td = deltas[i];
            total = total + td.latency;
            i++;
         }
         var lat:int = total / deltas.length;
         _latencyError = Math.abs(TimeDelta(deltas[deltas.length - 1]).latency - lat);
         return lat;
      }
      
      private function pruneOutliers(deltas:Vector.<TimeDelta>, median:int, threshold:Number) : void
      {
         var i:Number = NaN;
         var td:* = null;
         var maxValue:Number = median * threshold;
         for(i = deltas.length - 1; i >= 0; )
         {
            td = deltas[i];
            if(td.latency > maxValue)
            {
               deltas.splice(i,1);
               i--;
               continue;
            }
            break;
         }
      }
      
      private function determineMedian(deltas:Vector.<TimeDelta>) : int
      {
         var ind:Number = NaN;
         if(deltas.length % 2 == 0)
         {
            ind = deltas.length / 2 - 1;
            return (deltas[ind].latency + deltas[ind + 1].latency) / 2;
         }
         ind = Math.floor(deltas.length / 2);
         return deltas[ind].latency;
      }
      
      private function compare(a:TimeDelta, b:TimeDelta) : Number
      {
         if(a.latency < b.latency)
         {
            return -1;
         }
         if(a.latency > b.latency)
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
      
      public function set onProcess(val:Boolean) : void
      {
         _onProcess = val;
      }
      
      public function get running() : Boolean
      {
         return _onProcess;
      }
      
      public function process(rate:Number) : void
      {
         _internalClock = _internalClock + rate;
      }
      
      private function __onTimer(event:TimerEvent) : void
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
      
      public function set maxDeltas(val:Number) : void
      {
         _maxDeltas = val;
      }
   }
}
