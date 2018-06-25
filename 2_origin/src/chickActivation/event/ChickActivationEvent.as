package chickActivation.event
{
   import flash.events.Event;
   
   public class ChickActivationEvent extends Event
   {
      
      public static const UPDATE_DATA:String = "updateData";
      
      public static const CLICK_LEVELPACKS:String = "clickLevelPacks";
      
      public static const GET_REWARD:String = "getReward";
       
      
      public var resultData:Object;
      
      public function ChickActivationEvent(type:String, _resultData:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         resultData = _resultData;
         super(type,bubbles,cancelable);
      }
   }
}
