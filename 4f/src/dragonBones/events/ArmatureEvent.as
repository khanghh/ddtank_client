package dragonBones.events
{
   import flash.events.Event;
   
   public class ArmatureEvent extends Event
   {
      
      public static const Z_ORDER_UPDATED:String = "zOrderUpdated";
       
      
      public function ArmatureEvent(param1:String){super(null,null,null);}
      
      override public function clone() : Event{return null;}
   }
}
