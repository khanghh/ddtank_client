package giftSystem
{
   import flash.events.Event;
   
   public class GiftEvent extends Event
   {
      
      public static const GIFTOPENVIEW:String = "giftOpenView";
      
      public static const LOAD_RECORD_COMPLETE:String = "loadRecordComplete";
      
      public static const SEND_GIFT_RETURN:String = "sendGiftReturn";
      
      public static const REBACK_GIFT:String = "rebackGift";
       
      
      public var str:String;
      
      public function GiftEvent(param1:String, param2:String = "")
      {
         super(param1);
         str = param2;
      }
   }
}
