package collectionTask.event
{
   import flash.events.Event;
   
   public class CollectionTaskEvent extends Event
   {
      
      public static const PLAYER_NAME_VISIBLE:String = "playerNameVisible";
      
      public static const PLAYER_CHATBALL_VISIBLE:String = "playerChatBallVisible";
      
      public static const PLAYER_VISIBLE:String = "playerVisible";
      
      public static const REMOVE_ROBERT:String = "removeRobert";
      
      public static const COLLECT_COMPLETE:String = "collectComplete";
      
      public static const REFRESH_COMPLETE:String = "refreshProgress";
      
      public static const ADD_ONE_PLAYER:int = 1;
      
      public static const WALK:int = 2;
      
      public static const COLLECT:int = 3;
      
      public static const QUIT:int = 4;
      
      public static const INIT_PLAYERS:int = 5;
       
      
      public var robertNickName:String;
      
      public function CollectionTaskEvent(type:String, nickName:String = "")
      {
         super(type);
         robertNickName = nickName;
      }
   }
}
