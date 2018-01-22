package treasureHunting.event
{
   import flash.events.Event;
   
   public class TreasureEvent extends Event
   {
      
      public static const TREASURE_OPENVIEW:String = "teasureOpenView";
      
      public static const TREASURE_REMOVEMASK:String = "teasureRemoveMask";
      
      public static const MOVIE_START:String = "movieStart";
      
      public static const MOVIE_COMPLETE:String = "movieComplete";
       
      
      public var data;
      
      public function TreasureEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
