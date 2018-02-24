package prayIndiana.events
{
   import flash.events.Event;
   
   public class PrayIndianaEvent extends Event
   {
      
      public static const PRAY_OPEN:int = 170;
      
      public static const PRAYGOODSACTIVITYENTER:int = 171;
      
      public static const PRAYGOODSACTIVITYREFRESH:int = 172;
      
      public static const PRAYGOODSACTIVITYEXTRACT:int = 173;
      
      public static const PROBABILITY:int = 174;
       
      
      public function PrayIndianaEvent(param1:String){super(null,null,null);}
   }
}
