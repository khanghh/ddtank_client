package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import road7th.utils.DateUtils;
   
   public class CalendarSignAnalyze extends DataAnalyzer
   {
       
      
      private var _date:Date;
      
      private var _signCount:int;
      
      private var _dayLog:String;
      
      private var _luckyNum:int = -1;
      
      private var _myLuckyNum:int = -1;
      
      private var _times:int;
      
      private var _price:int;
      
      private var _isOK:String;
      
      public function CalendarSignAnalyze(param1:Function)
      {
         super(param1);
      }
      
      public function get date() : Date
      {
         return _date;
      }
      
      public function get signCount() : int
      {
         return _signCount;
      }
      
      public function get dayLog() : String
      {
         return _dayLog;
      }
      
      public function get luckyNum() : int
      {
         return _luckyNum;
      }
      
      public function get myLuckyNum() : int
      {
         return _myLuckyNum;
      }
      
      public function get times() : int
      {
         return _times;
      }
      
      public function get price() : int
      {
         return _price;
      }
      
      public function get isOK() : String
      {
         return _isOK;
      }
      
      public function set isOK(param1:String) : void
      {
         _isOK = param1;
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         try
         {
            _loc2_ = new XML(param1);
            if(_loc2_.@value == "true")
            {
               _date = DateUtils.dealWithStringDate(_loc2_.@nowDate);
               _signCount = _loc2_.DailyLogList.@UserAwardLog;
               _dayLog = _loc2_.DailyLogList.@DayLog;
               _times = _loc2_.DailyLogList.@Times;
               _luckyNum = _loc2_.@luckyNum;
               _myLuckyNum = _loc2_.@myLuckyNum;
               _price = _loc2_.@Price;
               _isOK = _loc2_.DailyLogList.@AwardMonth;
               onAnalyzeComplete();
            }
            else
            {
               message = _loc2_.@message;
               onAnalyzeError();
               onAnalyzeComplete();
            }
            return;
         }
         catch(e:Error)
         {
            onAnalyzeError();
            onAnalyzeComplete();
            return;
         }
      }
   }
}
