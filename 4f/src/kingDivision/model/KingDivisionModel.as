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
      
      public function KingDivisionModel(){super();}
      
      public function getLevelGoodsItems(param1:int) : Array{return null;}
      
      public function get isOpen() : Boolean{return false;}
      
      public function set isOpen(param1:Boolean) : void{}
      
      public function get zoneIndex() : int{return 0;}
      
      public function set zoneIndex(param1:int) : void{}
      
      public function get dateArr() : Array{return null;}
      
      public function set dateArr(param1:Array) : void{}
      
      public function get allDateArr() : Array{return null;}
      
      public function set allDateArr(param1:Array) : void{}
      
      public function get thisZoneNickName() : String{return null;}
      
      public function set thisZoneNickName(param1:String) : void{}
      
      public function get allZoneNickName() : String{return null;}
      
      public function set allZoneNickName(param1:String) : void{}
      
      public function get points() : int{return 0;}
      
      public function set points(param1:int) : void{}
      
      public function get gameNum() : int{return 0;}
      
      public function set gameNum(param1:int) : void{}
      
      public function get states() : int{return 0;}
      
      public function set states(param1:int) : void{}
      
      public function get level() : int{return 0;}
      
      public function set level(param1:int) : void{}
   }
}
