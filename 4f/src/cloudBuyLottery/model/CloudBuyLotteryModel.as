package cloudBuyLottery.model{   import cloudBuyLottery.view.WinningLogItemInfo;      public class CloudBuyLotteryModel   {                   private var _isOpen:Boolean;            private var _luckTime:Date;            public var myGiftData:Vector.<WinningLogItemInfo>;            public var packsLen:int = 15;            private var _moneyNum:int = 200;            private var _templateId:int;            private var _templatedIdCount:int;            private var _validDate:int;            private var _property:Array;            private var _count:int;            private var _buyGoodsIDArray:Array;            private var _buyGoodsCountArray:Array;            private var _buyMoney:int;            private var _maxNum:int;            private var _currentNum:int;            private var _totalSeconds:int;            private var _luckCount:int;            private var _remainTimes:int;            private var _luckDrawId:int;            private var _isGame:Boolean;            private var _isGetReward:Boolean;            public function CloudBuyLotteryModel() { super(); }
            public function get isOpen() : Boolean { return false; }
            public function set isOpen(value:Boolean) : void { }
            public function get luckTime() : Date { return null; }
            public function set luckTime(value:Date) : void { }
            public function get moneyNum() : int { return 0; }
            public function set moneyNum(value:int) : void { }
            public function get templateId() : int { return 0; }
            public function set templateId(value:int) : void { }
            public function get validDate() : int { return 0; }
            public function set validDate(value:int) : void { }
            public function get count() : int { return 0; }
            public function set count(value:int) : void { }
            public function get buyGoodsIDArray() : Array { return null; }
            public function set buyGoodsIDArray(value:Array) : void { }
            public function get buyGoodsCountArray() : Array { return null; }
            public function set buyGoodsCountArray(value:Array) : void { }
            public function get buyMoney() : int { return 0; }
            public function set buyMoney(value:int) : void { }
            public function get maxNum() : int { return 0; }
            public function set maxNum(value:int) : void { }
            public function get currentNum() : int { return 0; }
            public function set currentNum(value:int) : void { }
            public function get totalSeconds() : int { return 0; }
            public function set totalSeconds(value:int) : void { }
            public function get luckCount() : int { return 0; }
            public function set luckCount(value:int) : void { }
            public function get remainTimes() : int { return 0; }
            public function set remainTimes(value:int) : void { }
            public function get property() : Array { return null; }
            public function set property(value:Array) : void { }
            public function get luckDrawId() : int { return 0; }
            public function set luckDrawId(value:int) : void { }
            public function get isGame() : Boolean { return false; }
            public function set isGame(value:Boolean) : void { }
            public function get isGetReward() : Boolean { return false; }
            public function set isGetReward(value:Boolean) : void { }
            public function get templatedIdCount() : int { return 0; }
            public function set templatedIdCount(value:int) : void { }
   }}