package roomList.pvpRoomList
{
   import ddt.CoreManager;
   import ddt.events.CEvent;
   
   public class RoomListManager extends CoreManager
   {
      
      private static var _instance:RoomListManager;
       
      
      private var _openMatch:Boolean = false;
      
      public function RoomListManager()
      {
         super();
      }
      
      public static function get instance() : RoomListManager
      {
         if(!_instance)
         {
            _instance = new RoomListManager();
         }
         return _instance;
      }
      
      public function enter() : void
      {
         show();
      }
      
      public function get openMatch() : Boolean
      {
         return _openMatch;
      }
      
      public function set openMatch(value:Boolean) : void
      {
         _openMatch = value;
      }
      
      override protected function start() : void
      {
         dispatchEvent(new CEvent("openview"));
      }
   }
}
