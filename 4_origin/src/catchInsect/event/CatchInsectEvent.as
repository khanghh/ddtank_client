package catchInsect.event
{
   import flash.events.Event;
   import road7th.comm.PackageIn;
   
   public class CatchInsectEvent extends Event
   {
      
      public static const CATCH_INSECT:String = "catchInsect";
      
      public static const MOVE:String = "move";
      
      public static const PLAYER_STATUE:String = "player_statue";
      
      public static const ADDPLAYER_ROOM:String = "addplayer_room";
      
      public static const REMOVE_PLAYER:String = "removePlayer";
      
      public static const MONSTER:String = "addMonster";
      
      public static const UPDATE_AREA_RANK:String = "updateAreaRank";
      
      public static const AREA_SELF_INFO:String = "areaSelfInfo";
      
      public static const UPDATE_LOCAL_RANK:String = "updateLocalRank";
      
      public static const LOCAL_SELF_INFO:String = "localSelfInfo";
      
      public static const CAKE_STATUS:String = "cakeStatus";
      
      public static const FIGHT_MONSTER:String = "fightMonster";
       
      
      private var _cmd:int;
      
      private var _pkg:PackageIn;
      
      public function CatchInsectEvent(param1:String, param2:PackageIn = null, param3:int = 0)
      {
         _pkg = param2;
         _cmd = param3;
         super(param1,bubbles,cancelable);
      }
      
      public function get cmd() : int
      {
         return _cmd;
      }
      
      public function get pkg() : PackageIn
      {
         return _pkg;
      }
   }
}
