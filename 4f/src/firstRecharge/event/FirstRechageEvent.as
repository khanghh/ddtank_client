package firstRecharge.event
{
   import flash.events.Event;
   
   public class FirstRechageEvent extends Event
   {
      
      public static const FIRSTRECHAGE_OPEN:String = "firstRechageOpen";
      
      public static const FIRSTRECHAGE_CLOSE:String = "firstRechageClose";
       
      
      public function FirstRechageEvent(param1:String, param2:Boolean = false, param3:Boolean = false){super(null,null,null);}
   }
}
