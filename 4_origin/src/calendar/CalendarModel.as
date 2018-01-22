package calendar
{
   import calendar.event.CalendarEvent;
   import com.pickgliss.ui.core.Disposeable;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   [Event(name="LuckyNumChanged",type="calendar.event.CalendarEvent")]
   [Event(name="SignCountChanged",type="calendar.event.CalendarEvent")]
   [Event(name="TodayChanged",type="calendar.event.CalendarEvent")]
   public class CalendarModel extends EventDispatcher implements Disposeable
   {
      
      public static const Current:int = 1;
      
      public static const NewAward:int = 2;
      
      public static const Received:int = 3;
      
      public static const Calendar:int = 1;
      
      public static const Activity:int = 2;
      
      public static const NOSIGN:String = "0";
      
      public static const SIGN:String = "1";
      
      public static const RESTROSIGN:String = "2";
      
      public static const MS_of_Day:int = 86400000;
       
      
      public var dailyRewardIndex:int;
      
      private var _restroactiveNum:int = 0;
      
      private var _luckyNum:int;
      
      private var _myLuckyNum:int;
      
      private var _eventActives:Array;
      
      private var _activeExchange:Array;
      
      private var _signCount:int = 0;
      
      private var _awardCounts:Array;
      
      private var _awards:Array;
      
      private var _today:Date;
      
      private var _dayLog:Dictionary;
      
      public function CalendarModel(param1:Date, param2:int, param3:Dictionary, param4:Array, param5:Array, param6:Array, param7:Array)
      {
         super();
         _today = param1;
         _signCount = param2;
         _dayLog = param3;
         _awards = param4;
         _awardCounts = param5;
         _eventActives = param6;
         param7 = param7;
      }
      
      public static function getMonthMaxDay(param1:int, param2:int) : int
      {
         switch(int(param1))
         {
            case 0:
               return 31;
            case 1:
               if(param2 % 4 == 0)
               {
                  return 29;
               }
               return 28;
            case 2:
               return 31;
            case 3:
               return 30;
            case 4:
               return 31;
            case 5:
               return 30;
            case 6:
               return 31;
            case 7:
               return 31;
            case 8:
               return 30;
            case 9:
               return 31;
            case 10:
               return 30;
            case 11:
               return 31;
         }
      }
      
      public function get luckyNum() : int
      {
         return _luckyNum;
      }
      
      public function set luckyNum(param1:int) : void
      {
         if(_luckyNum == param1)
         {
            return;
         }
         _luckyNum = param1;
         dispatchEvent(new CalendarEvent("LuckyNumChanged"));
      }
      
      public function get myLuckyNum() : int
      {
         return _myLuckyNum;
      }
      
      public function set myLuckyNum(param1:int) : void
      {
         if(_myLuckyNum == param1)
         {
            return;
         }
         _myLuckyNum = param1;
         dispatchEvent(new CalendarEvent("LuckyNumChanged"));
      }
      
      public function get eventActives() : Array
      {
         return _eventActives;
      }
      
      public function get activeExchange() : Array
      {
         return _activeExchange;
      }
      
      public function get signCount() : int
      {
         return _signCount;
      }
      
      public function set signCount(param1:int) : void
      {
         if(_signCount == param1)
         {
            return;
         }
         _signCount = param1;
         dispatchEvent(new CalendarEvent("SignCountChanged"));
      }
      
      public function get awardCounts() : Array
      {
         return _awardCounts;
      }
      
      public function get awards() : Array
      {
         return _awards;
      }
      
      public function get today() : Date
      {
         return _today;
      }
      
      public function set today(param1:Date) : void
      {
         if(_today == param1)
         {
            return;
         }
         _today = param1;
         dispatchEvent(new CalendarEvent("TodayChanged"));
      }
      
      public function get dayLog() : Dictionary
      {
         return _dayLog;
      }
      
      public function set dayLog(param1:Dictionary) : void
      {
         if(_dayLog == param1)
         {
            return;
         }
         _dayLog = param1;
         dispatchEvent(new CalendarEvent("DayLogChanged"));
      }
      
      public function hasSigned(param1:Date) : Boolean
      {
         return _dayLog && param1.fullYear == _today.fullYear && param1.month == _today.month && _dayLog[param1.date.toString()] == "True";
      }
      
      public function hasSignedNew(param1:Date) : Boolean
      {
         return _dayLog[param1.date.toString()] == "True";
      }
      
      public function hasRestroSigned(param1:Date) : Boolean
      {
         return _dayLog && param1.fullYear == _today.fullYear && param1.month == _today.month && param1.date < _today.date && _dayLog[param1.date.toString()] == "2";
      }
      
      public function get RestroactiveFlag() : Boolean
      {
         return _restroactiveNum > 5;
      }
      
      public function hasReceived(param1:int) : Boolean
      {
         if(param1 <= _signCount)
         {
            return true;
         }
         return false;
      }
      
      public function dispose() : void
      {
      }
      
      public function set restroactiveNum(param1:int) : void
      {
         _restroactiveNum = param1;
      }
      
      public function get restroactiveNum() : int
      {
         return _restroactiveNum;
      }
   }
}
