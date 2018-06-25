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
      
      public function CalendarModel(today:Date, signCount:int, dayLog:Dictionary, signAwards:Array, awardCounts:Array, eventActives:Array, _activeExchange:Array)
      {
         super();
         _today = today;
         _signCount = signCount;
         _dayLog = dayLog;
         _awards = signAwards;
         _awardCounts = awardCounts;
         _eventActives = eventActives;
         _activeExchange = _activeExchange;
      }
      
      public static function getMonthMaxDay(month:int, year:int) : int
      {
         switch(int(month))
         {
            case 0:
               return 31;
            case 1:
               if(year % 4 == 0)
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
      
      public function set luckyNum(value:int) : void
      {
         if(_luckyNum == value)
         {
            return;
         }
         _luckyNum = value;
         dispatchEvent(new CalendarEvent("LuckyNumChanged"));
      }
      
      public function get myLuckyNum() : int
      {
         return _myLuckyNum;
      }
      
      public function set myLuckyNum(value:int) : void
      {
         if(_myLuckyNum == value)
         {
            return;
         }
         _myLuckyNum = value;
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
      
      public function set signCount(value:int) : void
      {
         if(_signCount == value)
         {
            return;
         }
         _signCount = value;
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
      
      public function set today(value:Date) : void
      {
         if(_today == value)
         {
            return;
         }
         _today = value;
         dispatchEvent(new CalendarEvent("TodayChanged"));
      }
      
      public function get dayLog() : Dictionary
      {
         return _dayLog;
      }
      
      public function set dayLog(value:Dictionary) : void
      {
         if(_dayLog == value)
         {
            return;
         }
         _dayLog = value;
         dispatchEvent(new CalendarEvent("DayLogChanged"));
      }
      
      public function hasSigned(date:Date) : Boolean
      {
         return _dayLog && date.fullYear == _today.fullYear && date.month == _today.month && _dayLog[date.date.toString()] == "True";
      }
      
      public function hasSignedNew(date:Date) : Boolean
      {
         return _dayLog[date.date.toString()] == "True";
      }
      
      public function hasRestroSigned(date:Date) : Boolean
      {
         return _dayLog && date.fullYear == _today.fullYear && date.month == _today.month && date.date < _today.date && _dayLog[date.date.toString()] == "2";
      }
      
      public function get RestroactiveFlag() : Boolean
      {
         return _restroactiveNum > 5;
      }
      
      public function hasReceived(count:int) : Boolean
      {
         if(count <= _signCount)
         {
            return true;
         }
         return false;
      }
      
      public function dispose() : void
      {
      }
      
      public function set restroactiveNum(value:int) : void
      {
         _restroactiveNum = value;
      }
      
      public function get restroactiveNum() : int
      {
         return _restroactiveNum;
      }
   }
}
