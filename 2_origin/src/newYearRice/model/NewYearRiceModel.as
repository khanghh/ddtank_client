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
      
      public function set isOpen(param1:Boolean) : void
      {
         _isOpen = param1;
      }
      
      public function get currentNum() : Array
      {
         return _currentNum;
      }
      
      public function set currentNum(param1:Array) : void
      {
         _currentNum = param1;
      }
      
      public function get maxNum() : Array
      {
         return _maxNum;
      }
      
      public function set maxNum(param1:Array) : void
      {
         _maxNum = param1;
      }
      
      public function get itemInfoList() : Array
      {
         return _itemInfoList;
      }
      
      public function set itemInfoList(param1:Array) : void
      {
         _itemInfoList = param1;
      }
      
      public function get yearFoodInfo() : int
      {
         return _yearFoodInfo;
      }
      
      public function set yearFoodInfo(param1:int) : void
      {
         _yearFoodInfo = param1;
      }
      
      public function get playerNum() : int
      {
         return _playerNum;
      }
      
      public function set playerNum(param1:int) : void
      {
         _playerNum = param1;
      }
      
      public function get playersLength() : int
      {
         return _playersLength;
      }
      
      public function get playersArray() : Array
      {
         return _playersArray;
      }
      
      public function set playersArray(param1:Array) : void
      {
         _playersArray = param1;
      }
      
      public function set playersLength(param1:int) : void
      {
         _playersLength = param1;
      }
      
      public function get roomType() : int
      {
         return _roomType;
      }
      
      public function set roomType(param1:int) : void
      {
         _roomType = param1;
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
   }
}
