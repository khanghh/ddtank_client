package roomList.pveRoomList
{
   import ddt.CoreManager;
   import ddt.events.CEvent;
   
   public class DungeonListManager extends CoreManager
   {
      
      private static var _instance:DungeonListManager;
       
      
      public function DungeonListManager(){super();}
      
      public static function get instance() : DungeonListManager{return null;}
      
      public function enter() : void{}
      
      override protected function start() : void{}
   }
}
