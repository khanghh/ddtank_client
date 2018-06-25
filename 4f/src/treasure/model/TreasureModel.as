package treasure.model{   import flash.events.EventDispatcher;   import treasure.data.TreasureTempInfo;      public class TreasureModel extends EventDispatcher   {            private static var _instance:TreasureModel = null;                   private var _logoinDays:int;            private var _leftTimes:int;            private var _friendHelpTimes:int;            private var _itemList:Vector.<TreasureTempInfo>;            public var isClick:Boolean = true;            private var _isEndTreasure:Boolean;            private var _isBeginTreasure:Boolean;            public function TreasureModel() { super(); }
            public static function get instance() : TreasureModel { return null; }
            public function get logoinDays() : int { return 0; }
            public function set logoinDays(value:int) : void { }
            public function get leftTimes() : int { return 0; }
            public function set leftTimes(value:int) : void { }
            public function get friendHelpTimes() : int { return 0; }
            public function set friendHelpTimes(value:int) : void { }
            public function get itemList() : Vector.<TreasureTempInfo> { return null; }
            public function set itemList(value:Vector.<TreasureTempInfo>) : void { }
            public function get isEndTreasure() : Boolean { return false; }
            public function set isEndTreasure(value:Boolean) : void { }
            public function get isBeginTreasure() : Boolean { return false; }
            public function set isBeginTreasure(value:Boolean) : void { }
   }}