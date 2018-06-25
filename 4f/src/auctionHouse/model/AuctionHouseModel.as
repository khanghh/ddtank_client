package auctionHouse.model{   import auctionHouse.event.AuctionHouseEvent;   import ddt.data.auctionHouse.AuctionGoodsInfo;   import ddt.data.goods.CateCoryInfo;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import road7th.data.DictionaryData;      [Event(name="changeState",type="auctionHouse.event.AuctionHouseEvent")]   [Event(name="getGoodCategory",type="auctionHouse.event.event.AuctionHouseEvent")]   [Event(name="deleteAuction",type="auctionHouse.event.AuctionHouseEvent")]   [Event(name="addAuction",type="auctionHouse.event.AuctionHouseEvent")]   [Event(name="updatePage",type="auctionHouse.event.AuctionHouseEvent")]   [Event(name="browseTypeChange",type="auctionHouse.event.AuctionHouseEvent")]   public class AuctionHouseModel extends EventDispatcher   {            public static var searchType:int;            public static var SINGLE_PAGE_NUM:int = 20;            public static var _dimBooble:Boolean;                   private var _state:String;            private var _categorys:Vector.<CateCoryInfo>;            private var _myAuctionData:DictionaryData;            private var _sellTotal:int;            private var _sellCurrent:int;            private var _browseAuctionData:DictionaryData;            private var _browseTotal:int;            private var _browseCurrent:int = 1;            private var _currentBrowseGoodInfo:CateCoryInfo;            private var _buyAuctionData:DictionaryData;            private var _buyTotal:int;            private var _buyCurrent:int = 1;            public function AuctionHouseModel(target:IEventDispatcher = null) { super(null); }
            public function get state() : String { return null; }
            public function set state(value:String) : void { }
            public function get category() : Vector.<CateCoryInfo> { return null; }
            public function set category(value:Vector.<CateCoryInfo>) : void { }
            public function getCatecoryById(id:int) : CateCoryInfo { return null; }
            public function get myAuctionData() : DictionaryData { return null; }
            public function addMyAuction(info:AuctionGoodsInfo) : void { }
            public function clearMyAuction() : void { }
            public function removeMyAuction(info:AuctionGoodsInfo) : void { }
            public function set sellTotal(value:int) : void { }
            public function get sellTotal() : int { return 0; }
            public function get sellTotalPage() : int { return 0; }
            public function set sellCurrent(value:int) : void { }
            public function get sellCurrent() : int { return 0; }
            public function get browseAuctionData() : DictionaryData { return null; }
            public function addBrowseAuctionData(info:AuctionGoodsInfo) : void { }
            public function clearBrowseAuctionData() : void { }
            public function removeBrowseAuctionData(info:AuctionGoodsInfo) : void { }
            public function set browseTotal(value:int) : void { }
            public function get browseTotal() : int { return 0; }
            public function get browseTotalPage() : int { return 0; }
            public function set browseCurrent(value:int) : void { }
            public function get browseCurrent() : int { return 0; }
            public function get currentBrowseGoodInfo() : CateCoryInfo { return null; }
            public function set currentBrowseGoodInfo(value:CateCoryInfo) : void { }
            public function get buyAuctionData() : DictionaryData { return null; }
            public function addBuyAuctionData(info:AuctionGoodsInfo) : void { }
            public function removeBuyAuctionData(info:AuctionGoodsInfo) : void { }
            public function clearBuyAuctionData() : void { }
            public function set buyTotal(value:int) : void { }
            public function get buyTotal() : int { return 0; }
            public function get buyTotalPage() : int { return 0; }
            public function set buyCurrent(value:int) : void { }
            public function get buyCurrent() : int { return 0; }
            public function dispose() : void { }
   }}