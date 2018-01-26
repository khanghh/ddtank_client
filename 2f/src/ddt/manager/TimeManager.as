package ddt.manager
{
   import ddt.events.PkgEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.getTimer;
   import loginDevice.LoginDeviceEvent;
   import loginDevice.LoginDeviceManager;
   import wantstrong.WantStrongManager;
   import wantstrong.event.WantStrongEvent;
   
   public class TimeManager
   {
      
      public static const DAY_TICKS:Number = 8.64E7;
      
      public static const HOUR_TICKS:Number = 3600000.0;
      
      public static const Minute_TICKS:Number = 60000.0;
      
      public static const Second_TICKS:Number = 1000;
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      public static var CHANGE:String = "change";
      
      private static var _instance:TimeManager;
       
      
      private var _serverDate:Date;
      
      private var _serverTick:int;
      
      private var _enterFightTime:Number;
      
      private var _startGameTime:Date;
      
      private var _currentTime:Date;
      
      private var _totalGameTime:Number;
      
      public function TimeManager(){super();}
      
      public static function getHHMMSSArr(param1:int) : Array{return null;}
      
      public static function setTwoDigit(param1:int) : String{return null;}
      
      public static function addEventListener(param1:String, param2:Function) : void{}
      
      public static function removeEventListener(param1:String, param2:Function) : void{}
      
      public static function get Instance() : TimeManager{return null;}
      
      public function setup() : void{}
      
      private function __update(param1:PkgEvent) : void{}
      
      public function Now() : Date{return null;}
      
      public function NowTime() : Number{return 0;}
      
      public function get serverDate() : Date{return null;}
      
      public function get currentDay() : Number{return 0;}
      
      public function TimeSpanToNow(param1:Date) : Date{return null;}
      
      public function TotalDaysToNow(param1:Date) : Number{return 0;}
      
      public function TotalHoursToNow(param1:Date) : Number{return 0;}
      
      public function TotalMinuteToNow(param1:Date) : Number{return 0;}
      
      public function TotalSecondToNow(param1:Date) : Number{return 0;}
      
      public function TotalDaysToNow2(param1:Date) : Number{return 0;}
      
      public function getMaxRemainDateStr(param1:Date, param2:int = 1) : String{return null;}
      
      public function set totalGameTime(param1:int) : void{}
      
      public function get totalGameTime() : int{return 0;}
      
      public function get enterFightTime() : Number{return 0;}
      
      public function set enterFightTime(param1:Number) : void{}
   }
}
