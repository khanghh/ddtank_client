package dragonBoat.event
{
   import flash.events.Event;
   
   public class DragonBoatEvent extends Event
   {
      
      public static const DRAGON_OPENVIEW:String = "dragonOpenView";
       
      
      public var tag:int;
      
      public var data:Object;
      
      public function DragonBoatEvent(param1:String, param2:Boolean = false, param3:Boolean = false){super(null,null,null);}
   }
}
