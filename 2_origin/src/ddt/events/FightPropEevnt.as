package ddt.events
{
   import flash.events.Event;
   
   public class FightPropEevnt extends Event
   {
      
      public static const MODECHANGED:String = "mode_Changed";
      
      public static const USEPROP:String = "use";
      
      public static const DELETEPROP:String = "delete";
      
      public static const ENABLEDCHANGED:String = "enabled_Changed";
       
      
      public function FightPropEevnt(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
