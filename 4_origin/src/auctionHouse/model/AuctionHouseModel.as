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
      
      public function AuctionHouseModel(target:IEventDispatcher = null)
      {
         _categorys = new Vector.<CateCoryInfo>();
         super(target);
         _state = "browse";
         _myAuctionData = new DictionaryData();
         _browseAuctionData = new DictionaryData();
         _buyAuctionData = new DictionaryData();
      }
      
      public function get state() : String
      {
         return _state;
      }
      
      public function set state(value:String) : void
      {
         _state = value;
         dispatchEvent(new AuctionHouseEvent("changeState"));
      }
      
      public function get category() : Vector.<CateCoryInfo>
      {
         return _categorys.slice(0);
      }
      
      public function set category(value:Vector.<CateCoryInfo>) : void
      {
         _categorys = value;
         if(value.length != 0)
         {
            dispatchEvent(new AuctionHouseEvent("getGoodCateGory"));
         }
      }
      
      public function getCatecoryById(id:int) : CateCoryInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _categorys;
         for each(var info in _categorys)
         {
            if(info.ID == id)
            {
               return info;
            }
         }
         return null;
      }
      
      public function get myAuctionData() : DictionaryData
      {
         return _myAuctionData;
      }
      
      public function addMyAuction(info:AuctionGoodsInfo) : void
      {
         if(_state == "sell")
         {
            _myAuctionData.add(info.AuctionID,info);
         }
         else if(_state == "browse")
         {
            _browseAuctionData.add(info.AuctionID,info);
         }
         else if(_state == "buy")
         {
            _buyAuctionData.add(info.AuctionID,info);
         }
      }
      
      public function clearMyAuction() : void
      {
         _myAuctionData.clear();
      }
      
      public function removeMyAuction(info:AuctionGoodsInfo) : void
      {
         if(_state == "sell")
         {
            _myAuctionData.remove(info.AuctionID);
         }
         else if(_state == "browse")
         {
            _browseAuctionData.remove(info.AuctionID);
         }
         else if(_state == "buy")
         {
            _buyAuctionData.remove(info.AuctionID);
         }
      }
      
      public function set sellTotal(value:int) : void
      {
         _sellTotal = value;
         dispatchEvent(new AuctionHouseEvent("updatePage"));
      }
      
      public function get sellTotal() : int
      {
         return _sellTotal;
      }
      
      public function get sellTotalPage() : int
      {
         return Math.ceil(_sellTotal / SINGLE_PAGE_NUM);
      }
      
      public function set sellCurrent(value:int) : void
      {
         _sellCurrent = value;
      }
      
      public function get sellCurrent() : int
      {
         return _sellCurrent;
      }
      
      public function get browseAuctionData() : DictionaryData
      {
         return _browseAuctionData;
      }
      
      public function addBrowseAuctionData(info:AuctionGoodsInfo) : void
      {
         _browseAuctionData.add(info.AuctionID,info);
      }
      
      public function clearBrowseAuctionData() : void
      {
         _browseAuctionData.clear();
      }
      
      public function removeBrowseAuctionData(info:AuctionGoodsInfo) : void
      {
         _browseAuctionData.remove(info.AuctionID);
      }
      
      public function set browseTotal(value:int) : void
      {
         _browseTotal = value;
         dispatchEvent(new AuctionHouseEvent("updatePage"));
      }
      
      public function get browseTotal() : int
      {
         return _browseTotal;
      }
      
      public function get browseTotalPage() : int
      {
         return Math.ceil(_browseTotal / SINGLE_PAGE_NUM);
      }
      
      public function set browseCurrent(value:int) : void
      {
         _browseCurrent = value;
      }
      
      public function get browseCurrent() : int
      {
         return _browseCurrent;
      }
      
      public function get currentBrowseGoodInfo() : CateCoryInfo
      {
         return _currentBrowseGoodInfo;
      }
      
      public function set currentBrowseGoodInfo(value:CateCoryInfo) : void
      {
         _currentBrowseGoodInfo = value;
         _browseCurrent = 1;
         dispatchEvent(new AuctionHouseEvent("browseTypeChange"));
      }
      
      public function get buyAuctionData() : DictionaryData
      {
         return _buyAuctionData;
      }
      
      public function addBuyAuctionData(info:AuctionGoodsInfo) : void
      {
         _buyAuctionData.add(info.AuctionID,info);
      }
      
      public function removeBuyAuctionData(info:AuctionGoodsInfo) : void
      {
         _buyAuctionData.remove(info);
      }
      
      public function clearBuyAuctionData() : void
      {
         _buyAuctionData.clear();
      }
      
      public function set buyTotal(value:int) : void
      {
         this._buyTotal = value;
         dispatchEvent(new AuctionHouseEvent("updatePage"));
      }
      
      public function get buyTotal() : int
      {
         return this._buyTotal;
      }
      
      public function get buyTotalPage() : int
      {
         return Math.ceil(_buyTotal / 50);
      }
      
      public function set buyCurrent(value:int) : void
      {
         _buyCurrent = value;
      }
      
      public function get buyCurrent() : int
      {
         return this._buyCurrent;
      }
      
      public function dispose() : void
      {
         _categorys = new Vector.<CateCoryInfo>();
         if(_myAuctionData)
         {
            _myAuctionData.clear();
         }
         _myAuctionData = null;
         if(_browseAuctionData)
         {
            _browseAuctionData.clear();
         }
         _browseAuctionData = null;
         if(_buyAuctionData)
         {
            _buyAuctionData.clear();
         }
         _buyAuctionData = null;
      }
   }
}
