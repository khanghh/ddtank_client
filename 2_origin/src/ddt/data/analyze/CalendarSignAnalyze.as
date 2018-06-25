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
      
      public function CalendarSignAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
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
      
      public function set isOK(value:String) : void
      {
         _isOK = value;
      }
      
      override public function analyze(data:*) : void
      {
         var xml:* = null;
         var date:* = null;
         try
         {
            xml = new XML(data);
            if(xml.@value == "true")
            {
               _date = DateUtils.dealWithStringDate(xml.@nowDate);
               _signCount = xml.DailyLogList.@UserAwardLog;
               _dayLog = xml.DailyLogList.@DayLog;
               _times = xml.DailyLogList.@Times;
               _luckyNum = xml.@luckyNum;
               _myLuckyNum = xml.@myLuckyNum;
               _price = xml.@Price;
               _isOK = xml.DailyLogList.@AwardMonth;
               onAnalyzeComplete();
            }
            else
            {
               message = xml.@message;
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
