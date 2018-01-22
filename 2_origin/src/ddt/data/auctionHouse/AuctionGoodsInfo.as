package ddt.data.auctionHouse
{
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import road7th.utils.DateUtils;
   
   public class AuctionGoodsInfo
   {
       
      
      public var AuctionID:int;
      
      public var AuctioneerID:int;
      
      public var AuctioneerName:String;
      
      public var ItemID:int;
      
      public var BagItemInfo:InventoryItemInfo;
      
      public var PayType:int;
      
      public var Price:int;
      
      public var Rise:int;
      
      public var Mouthful:int;
      
      private var _BeginDate:String;
      
      private var _beginDateObj:Date;
      
      public var ValidDate:int;
      
      public var count:int;
      
      public var BuyerID:int;
      
      public var BuyerName:String;
      
      public function AuctionGoodsInfo()
      {
         super();
      }
      
      public function set BeginDate(param1:String) : void
      {
         _BeginDate = param1;
      }
      
      public function get BeginDate() : String
      {
         return _BeginDate;
      }
      
      public function get beginDateObj() : Date
      {
         return _beginDateObj == null?DateUtils.getDateByStr(BeginDate):_beginDateObj;
      }
      
      public function set beginDateObj(param1:Date) : void
      {
         _beginDateObj = param1;
      }
      
      public function getTimeDescription() : String
      {
         var _loc1_:String = "";
         var _loc3_:Date = new Date();
         _loc3_.setTime(beginDateObj.getTime());
         _loc3_.hours = ValidDate + _loc3_.hours;
         var _loc2_:int = Math.abs(TimeManager.Instance.TotalHoursToNow(_loc3_));
         if(_loc2_ <= 1.5)
         {
            _loc1_ = LanguageMgr.GetTranslation("tank.data.auctionHouse.AuctionGoodsInfo.short");
         }
         else if(_loc2_ <= 3)
         {
            _loc1_ = LanguageMgr.GetTranslation("tank.data.auctionHouse.AuctionGoodsInfo.middle");
         }
         else if(_loc2_ <= 13)
         {
            _loc1_ = LanguageMgr.GetTranslation("tank.data.auctionHouse.AuctionGoodsInfo.long");
         }
         else
         {
            _loc1_ = LanguageMgr.GetTranslation("tank.data.auctionHouse.AuctionGoodsInfo.very");
         }
         _loc3_ = null;
         return _loc1_;
      }
      
      public function getSithTimeDescription() : String
      {
         var _loc1_:String = "";
         var _loc3_:Date = new Date();
         _loc3_.setTime(beginDateObj.getTime());
         _loc3_.hours = ValidDate + _loc3_.hours;
         var _loc2_:int = Math.abs(TimeManager.Instance.TotalHoursToNow(_loc3_));
         if(_loc2_ <= 1.5)
         {
            _loc1_ = LanguageMgr.GetTranslation("tank.data.auctionHouse.AuctionGoodsInfo.tshort");
         }
         else if(_loc2_ <= 3)
         {
            _loc1_ = LanguageMgr.GetTranslation("tank.data.auctionHouse.AuctionGoodsInfo.tmiddle");
         }
         else if(_loc2_ <= 13)
         {
            _loc1_ = LanguageMgr.GetTranslation("tank.data.auctionHouse.AuctionGoodsInfo.tlong");
         }
         else
         {
            _loc1_ = LanguageMgr.GetTranslation("tank.data.auctionHouse.AuctionGoodsInfo.tvery");
         }
         _loc3_ = null;
         return _loc1_;
      }
   }
}
