package church.events
{
   import flash.events.Event;
   
   public class ChurchScenePlayerEvent extends Event
   {
      
      public static const PLAYER_POS_CHANGE:String = "playerPosChange";
      
      public static const PLAYER_MOVE_SPEED_CHANGE:String = "playerMoveSpeedChange";
       
      
      public var playerid:int;
      
      public function ChurchScenePlayerEvent(type:String, playerid:int)
      {
         this.playerid = playerid;
         super(type);
      }
   }
}
