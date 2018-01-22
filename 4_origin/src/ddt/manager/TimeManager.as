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
      
      public static function getHHMMSSArr(param1:int) : Array
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1 > 0)
         {
            _loc5_ = setTwoDigit(param1 / 3600);
            _loc2_ = setTwoDigit(param1 % 3600 / 60);
            _loc3_ = setTwoDigit(param1 % 60);
            _loc4_ = [_loc5_,_loc2_,_loc3_];
         }
         return _loc4_;
      }
      
      public static function setTwoDigit(param1:int) : String
      {
         if(param1 < 10)
         {
            return "0" + param1;
         }
         return param1.toString();
      }
      
      public static function addEventListener(param1:String, param2:Function) : void
      {
         _dispatcher.addEventListener(param1,param2);
      }
      
      public static function removeEventListener(param1:String, param2:Function) : void
      {
         _dispatcher.removeEventListener(param1,param2);
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
      
      private function __update(param1:PkgEvent) : void
      {
         _serverTick = getTimer();
         _serverDate = param1.pkg.readDate();
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
      
      public function TimeSpanToNow(param1:Date) : Date
      {
         return new Date(Math.abs(_serverDate.getTime() + getTimer() - _serverTick - param1.time));
      }
      
      public function TotalDaysToNow(param1:Date) : Number
      {
         return (_serverDate.getTime() + getTimer() - _serverTick - param1.time) / 86400000;
      }
      
      public function TotalHoursToNow(param1:Date) : Number
      {
         return (_serverDate.getTime() + getTimer() - _serverTick - param1.time) / 3600000;
      }
      
      public function TotalMinuteToNow(param1:Date) : Number
      {
         return (_serverDate.getTime() + getTimer() - _serverTick - param1.time) / 60000;
      }
      
      public function TotalSecondToNow(param1:Date) : Number
      {
         return (_serverDate.getTime() + getTimer() - _serverTick - param1.time) / 1000;
      }
      
      public function TotalDaysToNow2(param1:Date) : Number
      {
         var _loc2_:Date = Now();
         _loc2_.setHours(0,0,0,0);
         var _loc3_:Date = new Date(param1.time);
         _loc3_.setHours(0,0,0,0);
         return (_loc2_.time - _loc3_.time) / 86400000;
      }
      
      public function getMaxRemainDateStr(param1:Date, param2:int = 1) : String
      {
         var _loc7_:* = null;
         if(!param1)
         {
            return "0" + LanguageMgr.GetTranslation("second");
         }
         var _loc6_:Number = param1.getTime();
         var _loc5_:Number = Now().getTime();
         var _loc3_:Number = _loc6_ - _loc5_;
         _loc3_ = _loc3_ - 10000 < 0?_loc3_:Number(_loc3_ - 10000);
         _loc3_ = _loc3_ < 0?0:Number(_loc3_);
         var _loc4_:int = 0;
         if(_loc3_ / 86400000 > 1)
         {
            if(param2 == 1)
            {
               _loc4_ = Math.floor(_loc3_ / 86400000);
            }
            else
            {
               _loc4_ = Math.ceil(_loc3_ / 86400000);
            }
            _loc7_ = _loc4_ + LanguageMgr.GetTranslation("day");
         }
         else if(_loc3_ / 3600000 > 1)
         {
            _loc4_ = _loc3_ / 3600000;
            _loc7_ = _loc4_ + LanguageMgr.GetTranslation("hour");
         }
         else if(_loc3_ / 60000 > 1)
         {
            _loc4_ = _loc3_ / 60000;
            _loc7_ = _loc4_ + LanguageMgr.GetTranslation("minute");
         }
         else
         {
            _loc4_ = _loc3_ / 1000;
            _loc7_ = _loc4_ + LanguageMgr.GetTranslation("second");
         }
         return _loc7_;
      }
      
      public function set totalGameTime(param1:int) : void
      {
         _totalGameTime = param1;
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
      
      public function set enterFightTime(param1:Number) : void
      {
         _enterFightTime = param1;
      }
   }
}
