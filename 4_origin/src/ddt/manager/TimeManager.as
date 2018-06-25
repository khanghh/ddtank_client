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
      
      public function TimeManager()
      {
         super();
      }
      
      public static function getHHMMSSArr(sec:int) : Array
      {
         var arr:* = null;
         var hour:* = null;
         var minute:* = null;
         var second:* = null;
         if(sec > 0)
         {
            hour = setTwoDigit(sec / 3600);
            minute = setTwoDigit(sec % 3600 / 60);
            second = setTwoDigit(sec % 60);
            arr = [hour,minute,second];
         }
         return arr;
      }
      
      public static function setTwoDigit(digit:int) : String
      {
         if(digit < 10)
         {
            return "0" + digit;
         }
         return digit.toString();
      }
      
      public static function addEventListener(type:String, listener:Function) : void
      {
         _dispatcher.addEventListener(type,listener);
      }
      
      public static function removeEventListener(type:String, listener:Function) : void
      {
         _dispatcher.removeEventListener(type,listener);
      }
      
      public static function get Instance() : TimeManager
      {
         if(_instance == null)
         {
            _instance = new TimeManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _serverDate = new Date();
         _serverTick = getTimer();
         SocketManager.Instance.addEventListener(PkgEvent.format(5),__update);
      }
      
      private function __update(event:PkgEvent) : void
      {
         _serverTick = getTimer();
         _serverDate = event.pkg.readDate();
         if(StateManager.currentStateType == "main" || StateManager.currentStateType == "roomlist" || StateManager.currentStateType == "dungeon")
         {
            WantStrongManager.Instance.dispatchEvent(new WantStrongEvent("alreadyUpdateTime"));
         }
         if(StateManager.currentStateType == "main")
         {
            LoginDeviceManager.instance().dispatchEvent(new LoginDeviceEvent("check_ua"));
         }
      }
      
      public function Now() : Date
      {
         return new Date(_serverDate.getTime() + getTimer() - _serverTick);
      }
      
      public function NowTime() : Number
      {
         return _serverDate.getTime() + getTimer() - _serverTick;
      }
      
      public function get serverDate() : Date
      {
         return _serverDate;
      }
      
      public function get currentDay() : Number
      {
         return Now().getDay();
      }
      
      public function TimeSpanToNow(last:Date) : Date
      {
         return new Date(Math.abs(_serverDate.getTime() + getTimer() - _serverTick - last.time));
      }
      
      public function TotalDaysToNow(last:Date) : Number
      {
         return (_serverDate.getTime() + getTimer() - _serverTick - last.time) / 86400000;
      }
      
      public function TotalHoursToNow(last:Date) : Number
      {
         return (_serverDate.getTime() + getTimer() - _serverTick - last.time) / 3600000;
      }
      
      public function TotalMinuteToNow(last:Date) : Number
      {
         return (_serverDate.getTime() + getTimer() - _serverTick - last.time) / 60000;
      }
      
      public function TotalSecondToNow(last:Date) : Number
      {
         return (_serverDate.getTime() + getTimer() - _serverTick - last.time) / 1000;
      }
      
      public function TotalDaysToNow2(last:Date) : Number
      {
         var dt:Date = Now();
         dt.setHours(0,0,0,0);
         var lt:Date = new Date(last.time);
         lt.setHours(0,0,0,0);
         return (dt.time - lt.time) / 86400000;
      }
      
      public function getMaxRemainDateStr(endTime:Date, type:int = 1) : String
      {
         var timeTxtStr:* = null;
         if(!endTime)
         {
            return "0" + LanguageMgr.GetTranslation("second");
         }
         var endTimestamp:Number = endTime.getTime();
         var nowTimestamp:Number = Now().getTime();
         var differ:Number = endTimestamp - nowTimestamp;
         differ = differ - 10000 < 0?differ:Number(differ - 10000);
         differ = differ < 0?0:Number(differ);
         var count:int = 0;
         if(differ / 86400000 > 1)
         {
            if(type == 1)
            {
               count = Math.floor(differ / 86400000);
            }
            else
            {
               count = Math.ceil(differ / 86400000);
            }
            timeTxtStr = count + LanguageMgr.GetTranslation("day");
         }
         else if(differ / 3600000 > 1)
         {
            count = differ / 3600000;
            timeTxtStr = count + LanguageMgr.GetTranslation("hour");
         }
         else if(differ / 60000 > 1)
         {
            count = differ / 60000;
            timeTxtStr = count + LanguageMgr.GetTranslation("minute");
         }
         else
         {
            count = differ / 1000;
            timeTxtStr = count + LanguageMgr.GetTranslation("second");
         }
         return timeTxtStr;
      }
      
      public function set totalGameTime(time:int) : void
      {
         _totalGameTime = time;
         _dispatcher.dispatchEvent(new Event(TimeManager.CHANGE));
      }
      
      public function get totalGameTime() : int
      {
         return this._totalGameTime;
      }
      
      public function get enterFightTime() : Number
      {
         return _enterFightTime;
      }
      
      public function set enterFightTime(value:Number) : void
      {
         _enterFightTime = value;
      }
   }
}
