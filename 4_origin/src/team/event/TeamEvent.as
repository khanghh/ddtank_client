package team.event
{
   import flash.events.Event;
   
   public class TeamEvent extends Event
   {
      
      public static const UPDATE_TEAM_INFO:String = "updateteaminfo";
      
      public static const UPDATE_TEAM_RANK:String = "updateteamrank";
      
      public static const UPDATE_TEAM_MEMBER:String = "updateteammember";
      
      public static const UPDATE_INVITE_LIST:String = "updateinvitelist";
      
      public static const UPDATE_ACTIVE_LIST:String = "updateactivelist";
      
      public static const UPDATE_RECORD_LIST:String = "updatercordlist";
      
      public static const UPDATE_SELF_INFO:String = "updateselfinfo";
      
      public static const UPDATE_SELF_ACTIVE:String = "updateselfactive";
       
      
      private var _data:Object;
      
      public function TeamEvent(param1:String, param2:Object = null)
      {
         _data = param2;
         super(param1);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}
