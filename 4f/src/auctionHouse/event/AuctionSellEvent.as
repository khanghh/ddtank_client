package auctionHouse.event
{
   import flash.events.Event;
   
   public class AuctionSellEvent extends Event
   {
      
      public static const SELL:String = "sell";
      
      public static const NOTSELL:String = "notsell";
       
      
      private var _sellCount:int;
      
      public function AuctionSellEvent(param1:String, param2:int = 0, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
      
      public function get sellCount() : int{return 0;}
   }
}
