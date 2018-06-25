package newYearRice.model
{
   public class NewYearRiceModel
   {
       
      
      private var _isOpen:Boolean;
      
      private var _playerNum:int;
      
      private var _currentNum:Array;
      
      private var _maxNum:Array;
      
      private var _itemInfoList:Array;
      
      private var _yearFoodInfo:int;
      
      private var _playersLength:int;
      
      private var _playersArray:Array;
      
      private var _roomType:int;
      
      private var _playerID:int;
      
      private var _playerName:String;
      
      public function NewYearRiceModel()
      {
         _currentNum = [10,20,30,40];
         _maxNum = [40,40,40,40];
         super();
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set isOpen(value:Boolean) : void
      {
         _isOpen = value;
      }
      
      public function get currentNum() : Array
      {
         return _currentNum;
      }
      
      public function set currentNum(value:Array) : void
      {
         _currentNum = value;
      }
      
      public function get maxNum() : Array
      {
         return _maxNum;
      }
      
      public function set maxNum(value:Array) : void
      {
         _maxNum = value;
      }
      
      public function get itemInfoList() : Array
      {
         return _itemInfoList;
      }
      
      public function set itemInfoList(value:Array) : void
      {
         _itemInfoList = value;
      }
      
      public function get yearFoodInfo() : int
      {
         return _yearFoodInfo;
      }
      
      public function set yearFoodInfo(value:int) : void
      {
         _yearFoodInfo = value;
      }
      
      public function get playerNum() : int
      {
         return _playerNum;
      }
      
      public function set playerNum(value:int) : void
      {
         _playerNum = value;
      }
      
      public function get playersLength() : int
      {
         return _playersLength;
      }
      
      public function get playersArray() : Array
      {
         return _playersArray;
      }
      
      public function set playersArray(value:Array) : void
      {
         _playersArray = value;
      }
      
      public function set playersLength(value:int) : void
      {
         _playersLength = value;
      }
      
      public function get roomType() : int
      {
         return _roomType;
      }
      
      public function set roomType(value:int) : void
      {
         _roomType = value;
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
   }
}
