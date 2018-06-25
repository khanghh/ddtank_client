package sanXiao{   import ddt.CoreManager;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;   import sanXiao.model.SXGainedItemDATA;   import sanXiao.model.SXRewardItemData;   import sanXiao.model.SXStoreBoughtData;   import sanXiao.model.SXStoreItemData;   import sanXiao.model.SanXiaoScoreRewardAnalyzer;   import sanXiao.model.SanXiaoStoreItemAnalyzer;      public class SanXiaoManager extends CoreManager   {            public static const SHOW_VIEW:String = "sanxiao_show_view";            public static const UPDATE_DATA:String = "sanxiao_update_data";            public static const MAP_STATUS:String = "sanxiao_map_status";            public static const DROP_OUT_ITEM_GAINED:String = "sanxiao_drop_out_item_gained";            private static var instance:SanXiaoManager;                   private var _score:int;            private var _stepRemain:Number;            public var propCrossBombCount:int;            public var propSquareBombCount:int;            public var propClearColorCount:int;            public var propChangeColorCount:int;            private var _rewardItemList:Array;            private var _crystalNum:Number = 0;            private var _progressTips:String;            private var _dateEnd:Date;            private var _rewardGainedIDList:Array;            private var _storeRemainList:Array;            public var mapInfo:Array;            private var _isOpen:Boolean = false;            private var _discounts:int = 0;            private var _propPriceList:Array;            private var _itemDataList:Array;            private var _scoreRewardList:Array;            private var _lengthAddedDropOutItem:int;            public function SanXiaoManager(single:inner) { super(); }
            public static function getInstance() : SanXiaoManager { return null; }
            public function get score() : int { return 0; }
            public function get stepRemain() : Number { return 0; }
            public function get dropOutItemList() : Array { return null; }
            public function get crystalNum() : Number { return 0; }
            public function get nextPriseScoreProgress() : Number { return 0; }
            public function get progressTipsData() : String { return null; }
            public function get nextPriseScore() : int { return 0; }
            public function get nextRewardSXRewardItemData() : SXRewardItemData { return null; }
            public function get dataEnd() : Date { return null; }
            public function get isDiscounts() : Boolean { return false; }
            public function setUp() : void { }
            protected function onBuyTimes(e:PkgEvent) : void { }
            protected function onGainedDropItem(e:PkgEvent) : void { }
            protected function onGetStoreData(e:PkgEvent) : void { }
            protected function onGetRewardsData(e:PkgEvent) : void { }
            protected function onGetData(e:PkgEvent) : void { }
            protected function onRequireMap(e:PkgEvent) : void { }
            protected function onIsOpen(e:PkgEvent) : void { }
            override protected function start() : void { }
            public function getPropPrice(index:int) : String { return null; }
            public function getPropCurPrice(index:int) : String { return null; }
            public function getPropScore(index:int) : String { return null; }
            public function propPriceData() : Array { return null; }
            public function get itemDataList() : Array { return null; }
            public function get scoreRewardList() : Array { return null; }
            public function get endTime() : Date { return null; }
            public function onSXScoreRewardData(analyzer:SanXiaoScoreRewardAnalyzer) : void { }
            public function onSXStoreItemData(analyzer:SanXiaoStoreItemAnalyzer) : void { }
            public function get lengthAddedDropOutItem() : int { return 0; }
   }}class inner{          function inner() { super(); }
}