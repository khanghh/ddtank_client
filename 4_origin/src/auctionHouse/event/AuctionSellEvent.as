package auctionHouse.event
{
   import flash.events.Event;
   
   public class AuctionSellEvent extends Event
   {
      
      public static const SELL:String = "sell";
      
      public static const NOTSELL:String = "notsell";
       
      
      private var _sellCount:int;
      
      public function AuctionSellEvent(type:String, sellCount:int = 0, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         _sellCount = sellCount;
         super(type,bubbles,cancelable);
      }
      
      public function get sellCount() : int
      {
         return _sellCount;
      }
   }
}
