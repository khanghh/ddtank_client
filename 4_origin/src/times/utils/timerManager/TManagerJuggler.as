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
      
      public function TManagerJuggler(param1:InternalFlag, param2:int)
      {
         super();
         _curID = param2;
      }
      
      function addTimer(param1:Number, param2:int, param3:Boolean, param4:String) : TimerJuggler
      {
         _curID = Number(_curID) + 1;
         var _loc5_:TimerJuggler = new TimerJuggler(_internalFlag,param1,param2,_curID,param3,param4);
         _timerDic[_curID] = _loc5_;
         return _loc5_;
      }
      
      function removeTimer(param1:uint) : void
      {
      }
      
      function getTimerDataByID(param1:int) : TimerJuggler
      {
         return _timerDic[param1];
      }
      
      function init(param1:Number) : void
      {
         _duration = param1;
         _timerDic = new Dictionary();
         _sTimer = new Timer(param1,0);
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
      
      protected function onTimer(param1:TimerEvent) : void
      {
         _date = new Date();
         var _loc4_:Number = _date.time;
         var _loc2_:Number = _loc4_ - _preTime;
         _preTime = _loc4_;
         var _loc6_:int = 0;
         var _loc5_:* = _timerDic;
         for each(var _loc3_ in _timerDic)
         {
            if(_loc3_.revise)
            {
               _loc3_.advance(_loc2_);
            }
            else
            {
               _loc3_.advance(_duration);
            }
         }
      }
   }
}
