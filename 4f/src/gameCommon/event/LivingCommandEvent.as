package gameCommon.event
{
   import flash.events.Event;
   
   public class LivingCommandEvent extends Event
   {
      
      public static const COMMAND:String = "livingCommand";
       
      
      private var _cmdType:String;
      
      private var _cmdObj:Object;
      
      public function LivingCommandEvent(param1:String, param2:Object = null, param3:String = "livingCommand", param4:Boolean = false, param5:Boolean = false){super(null,null,null);}
      
      public function get commandType() : String{return null;}
      
      public function get object() : Object{return null;}
   }
}
