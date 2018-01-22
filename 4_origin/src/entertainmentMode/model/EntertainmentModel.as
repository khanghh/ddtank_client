package entertainmentMode.model
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import room.model.RoomInfo;
   
   public class EntertainmentModel extends EventDispatcher
   {
      
      public static const ROOMLIST_CHANGE:String = "roomlistchange";
      
      public static const SCORE_CHANGE:String = "scoreChange";
      
      private static var _instance:EntertainmentModel = null;
       
      
      private var _roomList:Object;
      
      private var _score:int;
      
      private var _roomTotal:int;
      
      private var _scoreArr:Array;
      
      private var _selfScore:int;
      
      public function EntertainmentModel()
      {
         _roomList = {};
         super();
      }
      
      public static function get instance() : EntertainmentModel
      {
         if(_instance == null)
         {
            _instance = new EntertainmentModel();
         }
         return _instance;
      }
      
      public function get roomList() : Object
      {
         return _roomList;
      }
      
      public function updateRoom(param1:Array) : void
      {
         var _loc2_:int = 0;
         _roomList = {};
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _roomList[param1[_loc2_].ID] = param1[_loc2_];
            _loc2_++;
         }
         dispatchEvent(new Event("roomlistchange"));
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function set score(param1:int) : void
      {
         _score = param1;
         dispatchEvent(new Event("scoreChange"));
      }
      
      public function set roomTotal(param1:int) : void
      {
         _roomTotal = param1;
      }
      
      public function get roomTotal() : int
      {
         return _roomTotal;
      }
      
      public function getRoomById(param1:int) : RoomInfo
      {
         return _roomList[param1];
      }
      
      public function get scoreArr() : Array
      {
         return _scoreArr;
      }
      
      public function set scoreArr(param1:Array) : void
      {
         _scoreArr = param1;
      }
      
      public function get selfScore() : int
      {
         return _selfScore;
      }
      
      public function set selfScore(param1:int) : void
      {
         _selfScore = param1;
      }
   }
}
