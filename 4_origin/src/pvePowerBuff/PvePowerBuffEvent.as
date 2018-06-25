package pvePowerBuff
{
   import flash.events.Event;
   
   public class PvePowerBuffEvent extends Event
   {
      
      public static const PVE_POWER_BUFF_OPENVIEW:String = "pvePowerBuffOpenView";
      
      public static const LOAD_COMPLETE:String = "pvePowerBuffLoadComplete";
      
      public static const PVE_POWER_BUFF_DISPOSE:String = "pvePowerBuffDispose";
       
      
      public var info;
      
      public function PvePowerBuffEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
