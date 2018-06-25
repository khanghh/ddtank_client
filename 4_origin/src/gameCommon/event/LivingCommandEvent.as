package gameCommon.event
{
   import flash.events.Event;
   
   public class LivingCommandEvent extends Event
   {
      
      public static const COMMAND:String = "livingCommand";
       
      
      private var _cmdType:String;
      
      private var _cmdObj:Object;
      
      public function LivingCommandEvent(cmdType:String, cmdObj:Object = null, eventType:String = "livingCommand", bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(eventType,bubbles,cancelable);
         _cmdType = cmdType;
         _cmdObj = cmdObj;
      }
      
      public function get commandType() : String
      {
         return _cmdType;
      }
      
      public function get object() : Object
      {
         return _cmdObj;
      }
   }
}
