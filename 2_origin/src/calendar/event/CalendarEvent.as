package calendar.event
{
   import flash.events.Event;
   
   public class CalendarEvent extends Event
   {
      
      public static const CALENDAR_OPENVIEW:String = "calendarOpenView";
      
      public static const CALENDAR_QQOPENVIEW:String = "calendarqqOpenView";
      
      public static const SignCountChanged:String = "SignCountChanged";
      
      public static const TodayChanged:String = "TodayChanged";
      
      public static const DayLogChanged:String = "DayLogChanged";
      
      public static const LuckyNumChanged:String = "LuckyNumChanged";
      
      public static const ExchangeGoodsChange:String = "ExchangeGoodsChange";
       
      
      private var _enable:Boolean;
      
      public function CalendarEvent(type:String, enable:Boolean = true)
      {
         super(type,bubbles,cancelable);
         _enable = enable;
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
   }
}
