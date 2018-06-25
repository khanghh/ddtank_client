package kingDivision.model
{
   import flash.events.EventDispatcher;
   import kingDivision.data.KingDivisionConsortionItemInfo;
   
   public class KingDivisionModel extends EventDispatcher
   {
       
      
      private var _isOpen:Boolean;
      
      private var _zoneIndex:int;
      
      private var _dateArr:Array;
      
      private var _allDateArr:Array;
      
      private var _thisZoneNickName:String = "";
      
      private var _allZoneNickName:String = "";
      
      private var _points:int;
      
      private var _gameNum:int;
      
      private var _states:int;
      
      private var _level:int;
      
      public var conItemInfo:Vector.<KingDivisionConsortionItemInfo>;
      
      public var conLen:int;
      
      public var goods:Array;
      
      public var goodsZone:int;
      
      public var eliminateInfo:Vector.<KingDivisionConsortionItemInfo>;
      
      public var eliminateAllZoneInfo:Vector.<KingDivisionConsortionItemInfo>;
      
      public var scoreArea:int;
      
      public var gameNumArea:int;
      
      public var consortiaMatchStartTime:Array;
      
      public var consortiaMatchEndTime:Array;
      
      public function KingDivisionModel()
      {
         super();
      }
      
      public function getLevelGoodsItems(level:int) : Array
      {
         return goods[level];
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set isOpen(value:Boolean) : void
      {
         _isOpen = value;
      }
      
      public function get zoneIndex() : int
      {
         return _zoneIndex;
      }
      
      public function set zoneIndex(value:int) : void
      {
         _zoneIndex = value;
      }
      
      public function get dateArr() : Array
      {
         return _dateArr;
      }
      
      public function set dateArr(value:Array) : void
      {
         _dateArr = value;
      }
      
      public function get allDateArr() : Array
      {
         return _allDateArr;
      }
      
      public function set allDateArr(value:Array) : void
      {
         _allDateArr = value;
      }
      
      public function get thisZoneNickName() : String
      {
         return _thisZoneNickName;
      }
      
      public function set thisZoneNickName(value:String) : void
      {
         _thisZoneNickName = value;
      }
      
      public function get allZoneNickName() : String
      {
         return _allZoneNickName;
      }
      
      public function set allZoneNickName(value:String) : void
      {
         _allZoneNickName = value;
      }
      
      public function get points() : int
      {
         return _points;
      }
      
      public function set points(value:int) : void
      {
         _points = value;
      }
      
      public function get gameNum() : int
      {
         return _gameNum;
      }
      
      public function set gameNum(value:int) : void
      {
         _gameNum = value;
      }
      
      public function get states() : int
      {
         return _states;
      }
      
      public function set states(value:int) : void
      {
         _states = value;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(value:int) : void
      {
         _level = value;
      }
   }
}
