package consortion.guard
{
   import flash.events.Event;
   
   public class ConsortiaGuardEvent extends Event
   {
      
      public static const UPDATE_ACTIVITY:String = "updateActivity";
      
      public static const ADD_PLAYER:String = "addPlayer";
      
      public static const UPDATE_BOSS_STATE:String = "updateBossState";
      
      public static const UPDATE_PLAYER_STATE:String = "updatePlayerState";
      
      public static const UPDATE_RANK:String = "updateRank";
      
      public static const REMOVE_PLAYER:String = "removePlayer";
      
      public static const BUY_BUFF:String = "buyBuff";
      
      public static const UPDATE_GAME_STATE:String = "updateGameState";
      
      public static const UPDATE_PLAYER_VIEW:String = "updatePlayerView";
      
      public static const SHOW_BOSS_RANK:String = "showBossRank";
      
      public static const CLICK_BOSS_ICON:String = "clickBossIcon";
      
      public static const HIDE_BOSS_RANK:String = "hideBossRank";
       
      
      private var _data:Object;
      
      public function ConsortiaGuardEvent(type:String, data:Object = null)
      {
         _data = data;
         super(type,false,false);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}
