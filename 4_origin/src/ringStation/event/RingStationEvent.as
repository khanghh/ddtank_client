package ringStation.event
{
   import flash.events.Event;
   import road7th.comm.PackageIn;
   
   public class RingStationEvent extends Event
   {
      
      public static const RINGSTATION_VIEWINFO:String = "ringStation_viewInfo";
      
      public static const RINGSTATION_BUYCOUNTORTIME:String = "ringStation_buyCountOrTime";
      
      public static const RINGSTATION_ARMORY:String = "ringStation_armory";
      
      public static const RINGSTATION_NEWBATTLEFIELD:String = "ringStation_newBattleField";
      
      public static const RINGSTATION_CHALLENGE:String = "ringStation_challenge";
      
      public static const RINGSTATION_FIGHTFLAG:String = "ringStation_fightFlag";
      
      public static const RINGSTATION_SIGN:String = "ringStation_sign";
      
      public static const LANDERSAWARD_RECEIVE:String = "landersaward_receive";
      
      public static const LANDERSAWARD_GET:String = "landersaward_get";
      
      public static const DUNGEON_UPDATEEXP:String = "dungeon_updateexp";
      
      public static const RINGSTATION_GETREWARDSS:String = "ringstation_getrewardss";
       
      
      private var _pkg:PackageIn;
      
      private var _sign:String;
      
      public function RingStationEvent(param1:String, param2:PackageIn = null, param3:String = "")
      {
         super(param1,bubbles,cancelable);
         _pkg = param2;
         _sign = param3;
      }
      
      public function get pkg() : PackageIn
      {
         return _pkg;
      }
      
      public function get sign() : String
      {
         return _sign;
      }
   }
}
