package lotteryTicket.event
{
   import flash.events.Event;
   
   public class LotteryTicketEvent extends Event
   {
      
      public static const DELETE_CELL:String = "deleteCell";
       
      
      public var info;
      
      public function LotteryTicketEvent(param1:String, param2:Boolean = false, param3:Boolean = false){super(null,null,null);}
   }
}
