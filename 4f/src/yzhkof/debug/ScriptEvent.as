package yzhkof.debug
{
   import flash.events.Event;
   
   public class ScriptEvent extends Event
   {
      
      public static const RESULT:String = "RESULT";
       
      
      public var result;
      
      public function ScriptEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
   }
}
