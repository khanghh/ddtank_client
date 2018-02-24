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
      
      public function TManagerJuggler(param1:InternalFlag, param2:int){super();}
      
      function addTimer(param1:Number, param2:int, param3:Boolean, param4:String) : TimerJuggler{return null;}
      
      function removeTimer(param1:uint) : void{}
      
      function getTimerDataByID(param1:int) : TimerJuggler{return null;}
      
      function init(param1:Number) : void{}
      
      function dispose() : void{}
      
      protected function onTimer(param1:TimerEvent) : void{}
   }
}
