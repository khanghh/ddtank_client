package auctionHouse.model
{
   import auctionHouse.event.AuctionHouseEvent;
   import ddt.data.auctionHouse.AuctionGoodsInfo;
   import ddt.data.goods.CateCoryInfo;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.data.DictionaryData;
   
   [Event(name="changeState",type="auctionHouse.event.AuctionHouseEvent")]
   [Event(name="getGoodCategory",type="auctionHouse.event.event.AuctionHouseEvent")]
   [Event(name="deleteAuction",type="auctionHouse.event.AuctionHouseEvent")]
   [Event(name="addAuction",type="auctionHouse.event.AuctionHouseEvent")]
   [Event(name="updatePage",type="auctionHouse.event.AuctionHouseEvent")]
   [Event(name="browseTypeChange",type="auctionHouse.event.AuctionHouseEvent")]
   public class AuctionHouseModel extends EventDispatcher
   {
      
      public static var searchType:int;
      
      public static var SINGLE_PAGE_NUM:int = 20;
      
      public static var _dimBooble:Boolean;
       
      
      private var _state:String;
      
      private var _categorys:Vector.<CateCoryInfo>;
      
      private var _myAuctionData:DictionaryData;
      
      private var _sellTotal:int;
      
      private var _sellCurrent:int;
      
      private var _browseAuctionData:DictionaryData;
      
      private var _browseTotal:int;
      
      private var _browseCurrent:int = 1;
      
      private var _currentBrowseGoodInfo:CateCoryInfo;
      
      private var _buyAuctionData:DictionaryData;
      
      private var _buyTotal:int;
      
      private var _buyCurrent:int = 1;
      
      public function AuctionHouseModel(param1:IEventDispatcher = null){super(null);}
      
      public function get state() : String{return null;}
      
      public function set state(param1:String) : void{}
      
      public function get category() : Vector.<CateCoryInfo>{return null;}
      
      public function set category(param1:Vector.<CateCoryInfo>) : void{}
      
      public function getCatecoryById(param1:int) : CateCoryInfo{return null;}
      
      public function get myAuctionData() : DictionaryData{return null;}
      
      public function addMyAuction(param1:AuctionGoodsInfo) : void{}
      
      public function clearMyAuction() : void{}
      
      public function removeMyAuction(param1:AuctionGoodsInfo) : void{}
      
      public function set sellTotal(param1:int) : void{}
      
      public function get sellTotal() : int{return 0;}
      
      public function get sellTotalPage() : int{return 0;}
      
      public function set sellCurrent(param1:int) : void{}
      
      public function get sellCurrent() : int{return 0;}
      
      public function get browseAuctionData() : DictionaryData{return null;}
      
      public function addBrowseAuctionData(param1:AuctionGoodsInfo) : void{}
      
      public function clearBrowseAuctionData() : void{}
      
      public function removeBrowseAuctionData(param1:AuctionGoodsInfo) : void{}
      
      public function set browseTotal(param1:int) : void{}
      
      public function get browseTotal() : int{return 0;}
      
      public function get browseTotalPage() : int{return 0;}
      
      public function set browseCurrent(param1:int) : void{}
      
      public function get browseCurrent() : int{return 0;}
      
      public function get currentBrowseGoodInfo() : CateCoryInfo{return null;}
      
      public function set currentBrowseGoodInfo(param1:CateCoryInfo) : void{}
      
      public function get buyAuctionData() : DictionaryData{return null;}
      
      public function addBuyAuctionData(param1:AuctionGoodsInfo) : void{}
      
      public function removeBuyAuctionData(param1:AuctionGoodsInfo) : void{}
      
      public function clearBuyAuctionData() : void{}
      
      public function set buyTotal(param1:int) : void{}
      
      public function get buyTotal() : int{return 0;}
      
      public function get buyTotalPage() : int{return 0;}
      
      public function set buyCurrent(param1:int) : void{}
      
      public function get buyCurrent() : int{return 0;}
      
      public function dispose() : void{}
   }
}
