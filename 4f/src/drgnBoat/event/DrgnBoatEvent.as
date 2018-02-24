package drgnBoat.event
{
   import flash.events.Event;
   
   public class DrgnBoatEvent extends Event
   {
      
      public static const DRGNBOAT_OPENVIEW:String = "drgnBoatOpenView";
       
      
      public var data:Object;
      
      public function DrgnBoatEvent(param1:String, param2:Boolean = false, param3:Boolean = false){super(null,null,null);}
   }
}
