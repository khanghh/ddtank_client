package devilTurn.model{   import ddt.manager.ServerConfigManager;   import road7th.data.DictionaryData;      public class DevilTurnModel   {            public static const DEVUIL_TURN_TYPE:int = 19;                   private var _goodsItemList:Vector.<DevilTurnGoodsItem>;            private var _boxConverList:Array;            private var _pointsShopList:Array;            private var _rankAwardList:Array;            private var _rankList:Array;            private var _lotteryCount:int;            private var _myRank:int;            private var _myRankScore:int;            public var beadCount1:int;            public var beadCount2:int;            public var beadCount3:int;            public var beadCount4:int;            public var beadCount5:int;            public var getGiftProgress:int;            private var _jackpot:Number;            public var freeTimes:int;            public var freeDate:int;            public var totalJackpot:int;            public var activityDate:String;            private var _boxInfoData:DictionaryData;            public function DevilTurnModel() { super(); }
            public function getGiftIsGetByID(id:int) : Boolean { return false; }
            public function get myRankScore() : int { return 0; }
            public function set myRankScore(value:int) : void { }
            public function get myRank() : int { return 0; }
            public function set myRank(value:int) : void { }
            public function get lotteryCount() : int { return 0; }
            public function set lotteryCount(value:int) : void { }
            public function get jackpot() : Number { return 0; }
            public function set jackpot(value:Number) : void { }
            public function set goodsItemList(value:Vector.<DevilTurnGoodsItem>) : void { }
            public function get goodsItemList() : Vector.<DevilTurnGoodsItem> { return null; }
            public function getGoodsItemByID(id:int) : DevilTurnGoodsItem { return null; }
            public function set boxConverList(value:Array) : void { }
            public function get boxConverList() : Array { return null; }
            public function set pointsShopList(value:Array) : void { }
            public function get pointsShopList() : Array { return null; }
            public function set rankAwardList(value:Array) : void { }
            public function get rankAwardList() : Array { return null; }
            public function set rankList(value:Array) : void { }
            public function get rankList() : Array { return null; }
            public function addBoxInfo(info:DevilTurnBoxInfo) : void { }
            public function getBoxInfoByID(id:int) : DevilTurnBoxInfo { return null; }
            public function clearBoxInfoList() : void { }
            public function getBoxListByID(id:int) : Array { return null; }
   }}