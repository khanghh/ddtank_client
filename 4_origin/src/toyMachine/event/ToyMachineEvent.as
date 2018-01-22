package toyMachine.event
{
   import flash.events.Event;
   
   public class ToyMachineEvent extends Event
   {
       
      
      public function ToyMachineEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
