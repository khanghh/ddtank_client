package prayIndiana.model{   public class PrayIndianaModel   {                   private var _isOpen:Boolean = false;            private var _goodsAll:Array;            private var _position:int;            private var _templateID:int;            private var _getGoods:Array;            private var _PrayGoodsCount:int;            private var _UpdateRateCount:int;            private var _PrayLotteryGoodsCount:int;            private var _prayInfo:Array;            private var _IsPray:Boolean;            private var _type:int;            private var _probabilityNum:int;            private var _gameTimes:String;            public function PrayIndianaModel() { super(); }
            public function get isOpen() : Boolean { return false; }
            public function set isOpen(value:Boolean) : void { }
            public function get goodsAll() : Array { return null; }
            public function set goodsAll(value:Array) : void { }
            public function get position() : int { return 0; }
            public function set position(value:int) : void { }
            public function get templateID() : int { return 0; }
            public function set templateID(value:int) : void { }
            public function get getGoods() : Array { return null; }
            public function set getGoods(value:Array) : void { }
            public function get prayInfo() : Array { return null; }
            public function get PrayGoodsCount() : int { return 0; }
            public function set PrayGoodsCount(value:int) : void { }
            public function get UpdateRateCount() : int { return 0; }
            public function set UpdateRateCount(value:int) : void { }
            public function get PrayLotteryGoodsCount() : int { return 0; }
            public function set PrayLotteryGoodsCount(value:int) : void { }
            public function set prayInfo(value:Array) : void { }
            public function get IsPray() : Boolean { return false; }
            public function set IsPray(value:Boolean) : void { }
            public function get type() : int { return 0; }
            public function set type(value:int) : void { }
            public function get probabilityNum() : int { return 0; }
            public function set probabilityNum(value:int) : void { }
            public function get gameTimes() : String { return null; }
            public function set gameTimes(value:String) : void { }
   }}