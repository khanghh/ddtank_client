package flowerGiving.events
{
   import flash.events.Event;
   
   public class FlowerGiveEvent extends Event
   {
      
      public static const SHOW:String = "fg_show";
      
      public static const CHECK_OPEN:String = "fg_checkopen";
      
      public static const FLOWER_FALL:String = "fg_flower_fall";
       
      
      public function FlowerGiveEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
