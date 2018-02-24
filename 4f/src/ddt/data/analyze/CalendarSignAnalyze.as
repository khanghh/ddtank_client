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
      
      public function CalendarSignAnalyze(param1:Function){super(null);}
      
      public function get date() : Date{return null;}
      
      public function get signCount() : int{return 0;}
      
      public function get dayLog() : String{return null;}
      
      public function get luckyNum() : int{return 0;}
      
      public function get myLuckyNum() : int{return 0;}
      
      public function get times() : int{return 0;}
      
      public function get price() : int{return 0;}
      
      public function get isOK() : String{return null;}
      
      public function set isOK(param1:String) : void{}
      
      override public function analyze(param1:*) : void{}
   }
}
