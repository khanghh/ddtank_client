package campbattle.event
{
   import flash.events.Event;
   
   public class MapEvent extends Event
   {
      
      public static const RES_LOADER_OVER:String = "res_loader_over";
      
      public static const CAPTURE_STATUE:String = "capture_statue";
      
      public static const CAPTURE_START:String = "capture_start";
      
      public static const CAPTURE_OVER:String = "capture_over";
      
      public static const LOSE_CAPTURE:String = "capture_lose";
      
      public static const DROP_CAPTURE:String = "drop_capture";
      
      public static const TO_OTHER_MAP:String = "to_other_map";
      
      public static const ENTER_FIGHT:String = "enter_fight";
      
      public static const PLAYER_STATE_CHANGE:String = "player_state_change";
      
      public static const ADD_ROLE:String = "add_role";
      
      public static const REMOVE_ROLE:String = "remove_role";
      
      public static const RE_LIFE:String = "re_life";
      
      public static const GOTO_FIGHT:String = "goto_fight";
      
      public static const STATUE_GOTO_FIGHT:String = "statue_goto_fight";
      
      public static const WIN_COUNT_PVP:String = "win_count_pvp";
      
      public static const PVE_COUNT:String = "pve_count";
      
      public static const UPDATE_SCORE:String = "update_score";
      
      public static const PER_SCORE_RANK:String = "per_score_rank";
      
      public static const CAMP_SOCER_RANK:String = "camp_score_rank";
      
      public static const UPDATE_ROLES:String = "update_roles";
       
      
      public var data;
      
      public function MapEvent(type:String, $data:* = null)
      {
         super(type);
         data = $data;
      }
   }
}
