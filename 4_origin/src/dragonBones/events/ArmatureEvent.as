package dragonBones.events
{
   import flash.events.Event;
   
   public class ArmatureEvent extends Event
   {
      
      public static const Z_ORDER_UPDATED:String = "zOrderUpdated";
       
      
      public function ArmatureEvent(param1:String)
      {
         super(param1,false,false);
      }
      
      override public function clone() : Event
      {
         return new ArmatureEvent(type);
      }
   }
}
