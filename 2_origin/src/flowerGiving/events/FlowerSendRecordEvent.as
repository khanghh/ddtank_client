package flowerGiving.events
{
   import flash.events.Event;
   
   public class FlowerSendRecordEvent extends Event
   {
      
      public static const HUIKUI_FLOWER:String = "huiKuiFlower";
       
      
      private var _nickName:String;
      
      public function FlowerSendRecordEvent(param1:String, param2:String)
      {
         super(param1,bubbles,cancelable);
         _nickName = param2;
      }
      
      public function get nickName() : String
      {
         return _nickName;
      }
   }
}
