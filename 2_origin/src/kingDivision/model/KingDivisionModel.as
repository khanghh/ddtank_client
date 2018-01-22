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
      
      public function getLevelGoodsItems(param1:int) : Array
      {
         return goods[param1];
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         _isOpen = param1;
      }
      
      public function get zoneIndex() : int
      {
         return _zoneIndex;
      }
      
      public function set zoneIndex(param1:int) : void
      {
         _zoneIndex = param1;
      }
      
      public function get dateArr() : Array
      {
         return _dateArr;
      }
      
      public function set dateArr(param1:Array) : void
      {
         _dateArr = param1;
      }
      
      public function get allDateArr() : Array
      {
         return _allDateArr;
      }
      
      public function set allDateArr(param1:Array) : void
      {
         _allDateArr = param1;
      }
      
      public function get thisZoneNickName() : String
      {
         return _thisZoneNickName;
      }
      
      public function set thisZoneNickName(param1:String) : void
      {
         _thisZoneNickName = param1;
      }
      
      public function get allZoneNickName() : String
      {
         return _allZoneNickName;
      }
      
      public function set allZoneNickName(param1:String) : void
      {
         _allZoneNickName = param1;
      }
      
      public function get points() : int
      {
         return _points;
      }
      
      public function set points(param1:int) : void
      {
         _points = param1;
      }
      
      public function get gameNum() : int
      {
         return _gameNum;
      }
      
      public function set gameNum(param1:int) : void
      {
         _gameNum = param1;
      }
      
      public function get states() : int
      {
         return _states;
      }
      
      public function set states(param1:int) : void
      {
         _states = param1;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
      }
   }
}
