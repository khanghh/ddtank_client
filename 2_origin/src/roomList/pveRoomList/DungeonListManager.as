package roomList.pveRoomList
{
   import ddt.CoreManager;
   import ddt.events.CEvent;
   
   public class DungeonListManager extends CoreManager
   {
      
      private static var _instance:DungeonListManager;
       
      
      public function DungeonListManager()
      {
         super();
      }
      
      public static function get instance() : DungeonListManager
      {
         if(!_instance)
         {
            _instance = new DungeonListManager();
         }
         return _instance;
      }
      
      public function enter() : void
      {
         show();
      }
      
      override protected function start() : void
      {
         dispatchEvent(new CEvent("openview"));
      }
   }
}
