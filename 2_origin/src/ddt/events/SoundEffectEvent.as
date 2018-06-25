package ddt.events
{
   import flash.events.Event;
   
   public class SoundEffectEvent extends Event
   {
       
      
      public var soundInfo:Object;
      
      public function SoundEffectEvent(type:String, $soundInfo:Object, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         soundInfo = $soundInfo;
         super(type,bubbles,cancelable);
      }
   }
}
