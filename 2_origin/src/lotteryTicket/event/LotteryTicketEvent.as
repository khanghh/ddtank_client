package lotteryTicket.event
{
   import flash.events.Event;
   
   public class LotteryTicketEvent extends Event
   {
      
      public static const DELETE_CELL:String = "deleteCell";
       
      
      public var info;
      
      public function LotteryTicketEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
