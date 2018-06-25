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
      
      public function updateRoom(arr:Array) : void
      {
         var i:int = 0;
         _roomList = {};
         for(i = 0; i < arr.length; )
         {
            _roomList[arr[i].ID] = arr[i];
            i++;
         }
         dispatchEvent(new Event("roomlistchange"));
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function set score(value:int) : void
      {
         _score = value;
         dispatchEvent(new Event("scoreChange"));
      }
      
      public function set roomTotal(value:int) : void
      {
         _roomTotal = value;
      }
      
      public function get roomTotal() : int
      {
         return _roomTotal;
      }
      
      public function getRoomById(id:int) : RoomInfo
      {
         return _roomList[id];
      }
      
      public function get scoreArr() : Array
      {
         return _scoreArr;
      }
      
      public function set scoreArr(value:Array) : void
      {
         _scoreArr = value;
      }
      
      public function get selfScore() : int
      {
         return _selfScore;
      }
      
      public function set selfScore(value:int) : void
      {
         _selfScore = value;
      }
   }
}
