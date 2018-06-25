package catchInsect.event
{
   import flash.events.Event;
   
   public class CatchInsectRoomEvent extends Event
   {
      
      public static const CATCHINSECT_CREATROOMVIEW:String = "catchInsectCreatRoomView";
      
      public static const CATCHINSECT_SETVIEWAGAIN:String = "catchInsectSetViewAgain";
      
      public static const CATCHINSECT_UPDATEPLAYERSTATE:String = "catchInsectUpdatePlayerState";
      
      public static const CATCHINSECT_UPDATESELFSTATE:String = "catchInsectUpdateSelfState";
      
      public static const CATCHINSECT_MOVEPLAYER:String = "catchInsectMovePlayer";
      
      public static const PLAYER_NAME_VISIBLE:String = "playerNameVisible";
      
      public static const PLAYER_CHATBALL_VISIBLE:String = "playerChatBallVisible";
      
      public static const ENTER_GAME_TIME_OUT:String = "enterGameTimeOut";
      
      public static const READYFIGHT:String = "readyFight";
      
      public static const PLAYER_POS_CHANGE:String = "playerPosChange";
      
      public static const PLAYER_MOVE_SPEED_CHANGE:String = "playerMoveSpeedChange";
      
      public static const UPDATE_FIGHTMONSTER:String = "updatefightMonster";
       
      
      public var data:Object;
      
      public var playerid:int;
      
      public function CatchInsectRoomEvent(type:String, data:Object = null, playerid:int = 0)
      {
         this.data = data;
         this.playerid = playerid;
         super(type,bubbles,cancelable);
      }
   }
}
