package christmas.event
{
   import flash.events.Event;
   
   public class ChristmasRoomEvent extends Event
   {
      
      public static const PLAYER_NAME_VISIBLE:String = "playerNameVisible";
      
      public static const PLAYER_CHATBALL_VISIBLE:String = "playerChatBallVisible";
      
      public static const READYFIGHT:String = "readyFight";
      
      public static const ENTER_GAME_TIME_OUT:String = "enterGameTimeOut";
      
      public static const SCORE_CONVERT:String = "score_convert";
      
      public static const PLAYER_POS_CHANGE:String = "playerPosChange";
      
      public static const PLAYER_MOVE_SPEED_CHANGE:String = "playerMoveSpeedChange";
       
      
      public var data:Object;
      
      public var playerid:int;
      
      public function ChristmasRoomEvent(param1:String, param2:Object = null, param3:int = 0){super(null,null,null);}
   }
}
