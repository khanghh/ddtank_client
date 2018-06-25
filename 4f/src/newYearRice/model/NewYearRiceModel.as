package newYearRice.model{   public class NewYearRiceModel   {                   private var _isOpen:Boolean;            private var _playerNum:int;            private var _currentNum:Array;            private var _maxNum:Array;            private var _itemInfoList:Array;            private var _yearFoodInfo:int;            private var _playersLength:int;            private var _playersArray:Array;            private var _roomType:int;            private var _playerID:int;            private var _playerName:String;            public function NewYearRiceModel() { super(); }
            public function get isOpen() : Boolean { return false; }
            public function set isOpen(value:Boolean) : void { }
            public function get currentNum() : Array { return null; }
            public function set currentNum(value:Array) : void { }
            public function get maxNum() : Array { return null; }
            public function set maxNum(value:Array) : void { }
            public function get itemInfoList() : Array { return null; }
            public function set itemInfoList(value:Array) : void { }
            public function get yearFoodInfo() : int { return 0; }
            public function set yearFoodInfo(value:int) : void { }
            public function get playerNum() : int { return 0; }
            public function set playerNum(value:int) : void { }
            public function get playersLength() : int { return 0; }
            public function get playersArray() : Array { return null; }
            public function set playersArray(value:Array) : void { }
            public function set playersLength(value:int) : void { }
            public function get roomType() : int { return 0; }
            public function set roomType(value:int) : void { }
            public function get playerID() : int { return 0; }
            public function set playerID(value:int) : void { }
            public function get playerName() : String { return null; }
            public function set playerName(value:String) : void { }
   }}