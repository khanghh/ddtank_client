package ddt.manager{   import ddt.events.PkgEvent;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.utils.getTimer;   import loginDevice.LoginDeviceEvent;   import loginDevice.LoginDeviceManager;   import wantstrong.WantStrongManager;   import wantstrong.event.WantStrongEvent;      public class TimeManager   {            public static const DAY_TICKS:Number = 8.64E7;            public static const HOUR_TICKS:Number = 3600000.0;            public static const Minute_TICKS:Number = 60000.0;            public static const Second_TICKS:Number = 1000;            private static var _dispatcher:EventDispatcher = new EventDispatcher();            public static var CHANGE:String = "change";            private static var _instance:TimeManager;                   private var _serverDate:Date;            private var _serverTick:int;            private var _enterFightTime:Number;            private var _startGameTime:Date;            private var _currentTime:Date;            private var _totalGameTime:Number;            public function TimeManager() { super(); }
            public static function getHHMMSSArr(sec:int) : Array { return null; }
            public static function setTwoDigit(digit:int) : String { return null; }
            public static function addEventListener(type:String, listener:Function) : void { }
            public static function removeEventListener(type:String, listener:Function) : void { }
            public static function get Instance() : TimeManager { return null; }
            public function setup() : void { }
            private function __update(event:PkgEvent) : void { }
            public function Now() : Date { return null; }
            public function NowTime() : Number { return 0; }
            public function get serverDate() : Date { return null; }
            public function get currentDay() : Number { return 0; }
            public function TimeSpanToNow(last:Date) : Date { return null; }
            public function TotalDaysToNow(last:Date) : Number { return 0; }
            public function TotalHoursToNow(last:Date) : Number { return 0; }
            public function TotalMinuteToNow(last:Date) : Number { return 0; }
            public function TotalSecondToNow(last:Date) : Number { return 0; }
            public function TotalDaysToNow2(last:Date) : Number { return 0; }
            public function getMaxRemainDateStr(endTime:Date, type:int = 1) : String { return null; }
            public function set totalGameTime(time:int) : void { }
            public function get totalGameTime() : int { return 0; }
            public function get enterFightTime() : Number { return 0; }
            public function set enterFightTime(value:Number) : void { }
   }}