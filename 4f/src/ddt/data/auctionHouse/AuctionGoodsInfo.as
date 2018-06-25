package ddt.data.auctionHouse{   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.TimeManager;   import road7th.utils.DateUtils;      public class AuctionGoodsInfo   {                   public var AuctionID:int;            public var AuctioneerID:int;            public var AuctioneerName:String;            public var ItemID:int;            public var BagItemInfo:InventoryItemInfo;            public var PayType:int;            public var Price:int;            public var Rise:int;            public var Mouthful:int;            private var _BeginDate:String;            private var _beginDateObj:Date;            public var ValidDate:int;            public var count:int;            public var BuyerID:int;            public var BuyerName:String;            public function AuctionGoodsInfo() { super(); }
            public function set BeginDate(value:String) : void { }
            public function get BeginDate() : String { return null; }
            public function get beginDateObj() : Date { return null; }
            public function set beginDateObj(date:Date) : void { }
            public function getTimeDescription() : String { return null; }
            public function getSithTimeDescription() : String { return null; }
   }}