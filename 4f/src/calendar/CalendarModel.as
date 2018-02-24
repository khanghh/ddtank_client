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
      
      public function CalendarModel(param1:Date, param2:int, param3:Dictionary, param4:Array, param5:Array, param6:Array, param7:Array){super();}
      
      public static function getMonthMaxDay(param1:int, param2:int) : int{return 0;}
      
      public function get luckyNum() : int{return 0;}
      
      public function set luckyNum(param1:int) : void{}
      
      public function get myLuckyNum() : int{return 0;}
      
      public function set myLuckyNum(param1:int) : void{}
      
      public function get eventActives() : Array{return null;}
      
      public function get activeExchange() : Array{return null;}
      
      public function get signCount() : int{return 0;}
      
      public function set signCount(param1:int) : void{}
      
      public function get awardCounts() : Array{return null;}
      
      public function get awards() : Array{return null;}
      
      public function get today() : Date{return null;}
      
      public function set today(param1:Date) : void{}
      
      public function get dayLog() : Dictionary{return null;}
      
      public function set dayLog(param1:Dictionary) : void{}
      
      public function hasSigned(param1:Date) : Boolean{return false;}
      
      public function hasSignedNew(param1:Date) : Boolean{return false;}
      
      public function hasRestroSigned(param1:Date) : Boolean{return false;}
      
      public function get RestroactiveFlag() : Boolean{return false;}
      
      public function hasReceived(param1:int) : Boolean{return false;}
      
      public function dispose() : void{}
      
      public function set restroactiveNum(param1:int) : void{}
      
      public function get restroactiveNum() : int{return 0;}
   }
}
