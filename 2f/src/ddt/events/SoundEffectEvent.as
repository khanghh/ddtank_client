package ddt.events
{
   import flash.events.Event;
   
   public class SoundEffectEvent extends Event
   {
       
      
      public var soundInfo:Object;
      
      public function SoundEffectEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
   }
}
