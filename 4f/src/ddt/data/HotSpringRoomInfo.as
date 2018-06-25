package ddt.data{   public class HotSpringRoomInfo   {                   private var _roomID:int;            private var _roomNumber:int;            private var _roomType:int;            private var _roomName:String;            private var _playerID:int;            private var _playerName:String;            private var _roomIsPassword:Boolean;            private var _roomPassword:String;            private var _effectiveTime:int;            private var _maxCount:int;            private var _curCount:int;            private var _mapIndex:int;            private var _startTime:Date;            private var _breakTime:Date;            private var _roomIntroduction:String;            private var _serverID:int;            public function HotSpringRoomInfo() { super(); }
            public function get roomID() : int { return 0; }
            public function set roomID(value:int) : void { }
            public function get roomType() : int { return 0; }
            public function set roomType(value:int) : void { }
            public function get roomName() : String { return null; }
            public function set roomName(value:String) : void { }
            public function get playerID() : int { return 0; }
            public function set playerID(value:int) : void { }
            public function get playerName() : String { return null; }
            public function set playerName(value:String) : void { }
            public function get roomIsPassword() : Boolean { return false; }
            public function set roomIsPassword(value:Boolean) : void { }
            public function get roomPassword() : String { return null; }
            public function set roomPassword(value:String) : void { }
            public function get effectiveTime() : int { return 0; }
            public function set effectiveTime(value:int) : void { }
            public function get maxCount() : int { return 0; }
            public function set maxCount(value:int) : void { }
            public function get curCount() : int { return 0; }
            public function set curCount(value:int) : void { }
            public function get startTime() : Date { return null; }
            public function set startTime(value:Date) : void { }
            public function get breakTime() : Date { return null; }
            public function set breakTime(value:Date) : void { }
            public function get roomIntroduction() : String { return null; }
            public function set roomIntroduction(value:String) : void { }
            public function get serverID() : int { return 0; }
            public function set serverID(value:int) : void { }
            public function get roomNumber() : int { return 0; }
            public function set roomNumber(value:int) : void { }
   }}