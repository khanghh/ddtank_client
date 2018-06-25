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
      
      public function DDTMatchEvent(type:String, _resultData:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         resultData = _resultData;
         super(type,bubbles,cancelable);
      }
   }
}
