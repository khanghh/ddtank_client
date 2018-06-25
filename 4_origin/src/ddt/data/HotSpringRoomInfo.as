package ddt.data
{
   public class HotSpringRoomInfo
   {
       
      
      private var _roomID:int;
      
      private var _roomNumber:int;
      
      private var _roomType:int;
      
      private var _roomName:String;
      
      private var _playerID:int;
      
      private var _playerName:String;
      
      private var _roomIsPassword:Boolean;
      
      private var _roomPassword:String;
      
      private var _effectiveTime:int;
      
      private var _maxCount:int;
      
      private var _curCount:int;
      
      private var _mapIndex:int;
      
      private var _startTime:Date;
      
      private var _breakTime:Date;
      
      private var _roomIntroduction:String;
      
      private var _serverID:int;
      
      public function HotSpringRoomInfo()
      {
         super();
      }
      
      public function get roomID() : int
      {
         return _roomID;
      }
      
      public function set roomID(value:int) : void
      {
         _roomID = value;
      }
      
      public function get roomType() : int
      {
         return _roomType;
      }
      
      public function set roomType(value:int) : void
      {
         _roomType = value;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function set roomName(value:String) : void
      {
         _roomName = value;
      }
      
      public function get playerID() : int
      {
         return _playerID;
      }
      
      public function set playerID(value:int) : void
      {
         _playerID = value;
      }
      
      public function get playerName() : String
      {
         return _playerName;
      }
      
      public function set playerName(value:String) : void
      {
         _playerName = value;
      }
      
      public function get roomIsPassword() : Boolean
      {
         return _roomIsPassword;
      }
      
      public function set roomIsPassword(value:Boolean) : void
      {
         _roomIsPassword = value;
      }
      
      public function get roomPassword() : String
      {
         return _roomPassword;
      }
      
      public function set roomPassword(value:String) : void
      {
         _roomPassword = value;
         _roomIsPassword = _roomPassword && _roomPassword != "" && _roomPassword.length > 0;
      }
      
      public function get effectiveTime() : int
      {
         return _effectiveTime;
      }
      
      public function set effectiveTime(value:int) : void
      {
         _effectiveTime = value;
      }
      
      public function get maxCount() : int
      {
         return _maxCount;
      }
      
      public function set maxCount(value:int) : void
      {
         _maxCount = value;
      }
      
      public function get curCount() : int
      {
         return _curCount;
      }
      
      public function set curCount(value:int) : void
      {
         _curCount = value;
      }
      
      public function get startTime() : Date
      {
         return _startTime;
      }
      
      public function set startTime(value:Date) : void
      {
         _startTime = value;
      }
      
      public function get breakTime() : Date
      {
         return _breakTime;
      }
      
      public function set breakTime(value:Date) : void
      {
         _breakTime = value;
      }
      
      public function get roomIntroduction() : String
      {
         return _roomIntroduction;
      }
      
      public function set roomIntroduction(value:String) : void
      {
         _roomIntroduction = value;
      }
      
      public function get serverID() : int
      {
         return _serverID;
      }
      
      public function set serverID(value:int) : void
      {
         _serverID = value;
      }
      
      public function get roomNumber() : int
      {
         return _roomNumber;
      }
      
      public function set roomNumber(value:int) : void
      {
         _roomNumber = value;
      }
   }
}
