package ringStation
{
   import ddt.CoreManager;
   import flash.events.Event;
   
   public class RingStationManager extends CoreManager
   {
      
      public static const RINGSTATION_VIEWOPEN:String = "ringStationViewOpen";
      
      private static var _instance:RingStationManager;
       
      
      public var RoomType:int = 0;
      
      public function RingStationManager(){super();}
      
      public static function get instance() : RingStationManager{return null;}
      
      override protected function start() : void{}
   }
}
