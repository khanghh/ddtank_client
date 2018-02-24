package hallIcon.event
{
   import flash.events.Event;
   
   public class HallIconEvent extends Event
   {
      
      public static const UPDATE_LEFTICON_VIEW:String = "updateLeftIconView";
      
      public static const UPDATE_RIGHTICON_VIEW:String = "updateRightIconView";
      
      public static const UPDATE_BATCH_RIGHTICON_VIEW:String = "updateBatchRightIconView";
      
      public static const CHECK_HALLICONEXPERIENCEOPEN:String = "checkHallIconExperienceOpen";
       
      
      public var data:Object;
      
      public function HallIconEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
   }
}
