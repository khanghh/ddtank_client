package times.utils.timerManager
{
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class TManagerJuggler extends EventDispatcher implements ITimerManager
   {
       
      
      protected var _sTimer:Timer;
      
      protected var _timerDic:Dictionary;
      
      protected var _curID:uint;
      
      private var _duration:int;
      
      private var _date:Date;
      
      private var _preTime:Number;
      
      private var _internalFlag:InternalFlag;
      
      public function TManagerJuggler(single:InternalFlag, IDLevel:int)
      {
         super();
         _curID = IDLevel;
      }
      
      function addTimer(delay:Number, repeatCount:int, revise:Boolean, type:String) : TimerJuggler
      {
         _curID = Number(_curID) + 1;
         var tj:TimerJuggler = new TimerJuggler(_internalFlag,delay,repeatCount,_curID,revise,type);
         _timerDic[_curID] = tj;
         return tj;
      }
      
      function removeTimer(id:uint) : void
      {
      }
      
      function getTimerDataByID(id:int) : TimerJuggler
      {
         return _timerDic[id];
      }
      
      function init(delay:Number) : void
      {
         _duration = delay;
         _timerDic = new Dictionary();
         _sTimer = new Timer(delay,0);
         _sTimer.addEventListener("timer",onTimer);
         _sTimer.start();
         _date = new Date();
         _preTime = _date.time;
      }
      
      function dispose() : void
      {
         if(_sTimer != null)
         {
            _sTimer.stop();
            _sTimer.removeEventListener("timer",onTimer);
            _sTimer = null;
         }
         _timerDic = null;
      }
      
      protected function onTimer(te:TimerEvent) : void
      {
         _date = new Date();
         var curTime:Number = _date.time;
         var curDuration:Number = curTime - _preTime;
         _preTime = curTime;
         var _loc6_:int = 0;
         var _loc5_:* = _timerDic;
         for each(var value in _timerDic)
         {
            if(value.revise)
            {
               value.advance(curDuration);
            }
            else
            {
               value.advance(_duration);
            }
         }
      }
   }
}
