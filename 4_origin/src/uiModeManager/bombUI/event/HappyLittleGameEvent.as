package uiModeManager.bombUI.event
{
   import flash.events.Event;
   
   public class HappyLittleGameEvent extends Event
   {
      
      public static const SHOOT_Bullet:String = "shootbullet";
      
      public static const ENTER_GAME:String = "entergame";
      
      public static const COME_TO_BACK:String = "cometoback";
      
      public static const REFRESH_RANKING:String = "refreshranking";
      
      public static const REFRESH_DAYNEW:String = "refreshdaynew";
      
      public static const GAME_TIMER:String = "gametimer";
      
      public static const REFRESH_MYMAXSCORE:String = "refreshmymaxscore";
       
      
      private var gameType:int;
      
      public function HappyLittleGameEvent(param1:String, param2:int = 0, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         gameType = param2;
      }
      
      public function get CurrentType() : int
      {
         return gameType;
      }
   }
}
