package levelFund.event
{
   import flash.events.Event;
   
   public class LevelFundEvent extends Event
   {
      
      public static const LEVELFUND_OPENVIEW:String = "levelFundOpenView";
      
      public static const UPDATE_VIEW:String = "update_view";
       
      
      public function LevelFundEvent(param1:String, param2:Boolean = false, param3:Boolean = false){super(null,null,null);}
   }
}
