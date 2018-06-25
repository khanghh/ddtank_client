package ddt.view.bossbox
{
   import flash.events.Event;
   
   public class TimeBoxEvent extends Event
   {
      
      public static const UPDATETIMECOUNT:String = "updateTimeCount";
      
      public static const UPDATESMALLBOXBUTTONSTATE:String = "update_smallBoxButton_state";
       
      
      public var delaySumTime:int = 0;
      
      public var boxButtonShowType:int = 0;
      
      public function TimeBoxEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
