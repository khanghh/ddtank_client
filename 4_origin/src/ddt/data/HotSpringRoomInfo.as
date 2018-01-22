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
      
      public function set roomID(param1:int) : void
      {
         _roomID = param1;
      }
      
      public function get roomType() : int
      {
         return _roomType;
      }
      
      public function set roomType(param1:int) : void
      {
         _roomType = param1;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function set roomName(param1:String) : void
      {
         _roomName = param1;
      }
      
      public function get playerID() : int
      {
         return _playerID;
      }
      
      public function set playerID(param1:int) : void
      {
         _playerID = param1;
      }
      
      public function get playerName() : String
      {
         return _playerName;
      }
      
      public function set playerName(param1:String) : void
      {
         _playerName = param1;
      }
      
      public function get roomIsPassword() : Boolean
      {
         return _roomIsPassword;
      }
      
      public function set roomIsPassword(param1:Boolean) : void
      {
         _roomIsPassword = param1;
      }
      
      public function get roomPassword() : String
      {
         return _roomPassword;
      }
      
      public function set roomPassword(param1:String) : void
      {
         _roomPassword = param1;
         _roomIsPassword = _roomPassword && _roomPassword != "" && _roomPassword.length > 0;
      }
      
      public function get effectiveTime() : int
      {
         return _effectiveTime;
      }
      
      public function set effectiveTime(param1:int) : void
      {
         _effectiveTime = param1;
      }
      
      public function get maxCount() : int
      {
         return _maxCount;
      }
      
      public function set maxCount(param1:int) : void
      {
         _maxCount = param1;
      }
      
      public function get curCount() : int
      {
         return _curCount;
      }
      
      public function set curCount(param1:int) : void
      {
         _curCount = param1;
      }
      
      public function get startTime() : Date
      {
         return _startTime;
      }
      
      public function set startTime(param1:Date) : void
      {
         _startTime = param1;
      }
      
      public function get breakTime() : Date
      {
         return _breakTime;
      }
      
      public function set breakTime(param1:Date) : void
      {
         _breakTime = param1;
      }
      
      public function get roomIntroduction() : String
      {
         return _roomIntroduction;
      }
      
      public function set roomIntroduction(param1:String) : void
      {
         _roomIntroduction = param1;
      }
      
      public function get serverID() : int
      {
         return _serverID;
      }
      
      public function set serverID(param1:int) : void
      {
         _serverID = param1;
      }
      
      public function get roomNumber() : int
      {
         return _roomNumber;
      }
      
      public function set roomNumber(param1:int) : void
      {
         _roomNumber = param1;
      }
   }
}
