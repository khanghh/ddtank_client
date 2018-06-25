package times.utils.timerManager{   import flash.events.EventDispatcher;   import flash.events.TimerEvent;   import flash.utils.Dictionary;   import flash.utils.Timer;      public class TManagerJuggler extends EventDispatcher implements ITimerManager   {                   protected var _sTimer:Timer;            protected var _timerDic:Dictionary;            protected var _curID:uint;            private var _duration:int;            private var _date:Date;            private var _preTime:Number;            private var _internalFlag:InternalFlag;            public function TManagerJuggler(single:InternalFlag, IDLevel:int) { super(); }
            protected function addTimer(delay:Number, repeatCount:int, revise:Boolean, type:String) : TimerJuggler { return null; }
            protected function removeTimer(id:uint) : void { }
            protected function getTimerDataByID(id:int) : TimerJuggler { return null; }
            protected function init(delay:Number) : void { }
            protected function dispose() : void { }
            protected function onTimer(te:TimerEvent) : void { }
   }}