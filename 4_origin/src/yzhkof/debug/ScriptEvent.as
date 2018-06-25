package yzhkof.debug
{
   import flash.events.Event;
   
   public class ScriptEvent extends Event
   {
      
      public static const RESULT:String = "RESULT";
       
      
      public var result;
      
      public function ScriptEvent(type:String, result:*, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this.result = result;
      }
   }
}
