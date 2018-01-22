package consortionBattle.event
{
   import flash.events.Event;
   
   public class ConsBatEvent extends Event
   {
       
      
      public var data:Object;
      
      public function ConsBatEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
