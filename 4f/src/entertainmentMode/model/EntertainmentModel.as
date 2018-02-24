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
      
      public function EntertainmentModel(){super();}
      
      public static function get instance() : EntertainmentModel{return null;}
      
      public function get roomList() : Object{return null;}
      
      public function updateRoom(param1:Array) : void{}
      
      public function get score() : int{return 0;}
      
      public function set score(param1:int) : void{}
      
      public function set roomTotal(param1:int) : void{}
      
      public function get roomTotal() : int{return 0;}
      
      public function getRoomById(param1:int) : RoomInfo{return null;}
      
      public function get scoreArr() : Array{return null;}
      
      public function set scoreArr(param1:Array) : void{}
      
      public function get selfScore() : int{return 0;}
      
      public function set selfScore(param1:int) : void{}
   }
}
