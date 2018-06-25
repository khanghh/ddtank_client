package christmas.event
{
   import flash.events.Event;
   
   public class ChristmasMonsterEvent extends Event
   {
      
      public static const UPDATE_SELF_RANK_INFO:String = "update_self_rank_info";
      
      public static const UPDATE_MONSTER_STATE:String = "update_monster_state";
      
      public static const MONSTER_ACTIVE_START:String = "monster_active_start";
       
      
      public var data:Object;
      
      public function ChristmasMonsterEvent(type:String, dat:Object = null)
      {
         data = dat;
         super(type);
      }
   }
}
