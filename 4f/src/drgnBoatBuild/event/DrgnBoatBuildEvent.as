package drgnBoatBuild.event
{
   import flash.events.Event;
   
   public class DrgnBoatBuildEvent extends Event
   {
      
      public static const DRGNBOAT_OPENVIEW:String = "drgnBoatOpenView";
      
      public static const UPDATE_VIEW:String = "updateView";
      
      public static const UPDATE_FRIEND_LIST:String = "updateFriendList";
       
      
      public var info;
      
      public function DrgnBoatBuildEvent(param1:String, param2:Boolean = false, param3:Boolean = false){super(null,null,null);}
   }
}
