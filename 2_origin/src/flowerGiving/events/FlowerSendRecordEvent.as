package flowerGiving.events
{
   import flash.events.Event;
   
   public class FlowerSendRecordEvent extends Event
   {
      
      public static const HUIKUI_FLOWER:String = "huiKuiFlower";
       
      
      private var _nickName:String;
      
      public function FlowerSendRecordEvent(type:String, nickName:String)
      {
         super(type,bubbles,cancelable);
         _nickName = nickName;
      }
      
      public function get nickName() : String
      {
         return _nickName;
      }
   }
}
