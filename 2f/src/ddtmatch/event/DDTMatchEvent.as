package ddtmatch.event
{
   import flash.events.Event;
   
   public class DDTMatchEvent extends Event
   {
      
      public static const EXPERT_SELECT:String = "expertSelect";
      
      public static const UPDATA_REDPACKTE_LIST:String = "updataRedPacketList";
      
      public static const CHECK_VIEW_CLOSE:String = "checkViewClose";
       
      
      public var resultData:Object;
      
      public var flag:Boolean;
      
      public function DDTMatchEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
   }
}
