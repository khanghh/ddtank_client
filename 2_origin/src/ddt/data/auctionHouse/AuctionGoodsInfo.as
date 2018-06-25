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
      
      public function set BeginDate(value:String) : void
      {
         _BeginDate = value;
      }
      
      public function get BeginDate() : String
      {
         return _BeginDate;
      }
      
      public function get beginDateObj() : Date
      {
         return _beginDateObj == null?DateUtils.getDateByStr(BeginDate):_beginDateObj;
      }
      
      public function set beginDateObj(date:Date) : void
      {
         _beginDateObj = date;
      }
      
      public function getTimeDescription() : String
      {
         var result:String = "";
         var offDate:Date = new Date();
         offDate.setTime(beginDateObj.getTime());
         offDate.hours = ValidDate + offDate.hours;
         var diff:int = Math.abs(TimeManager.Instance.TotalHoursToNow(offDate));
         if(diff <= 1.5)
         {
            result = LanguageMgr.GetTranslation("tank.data.auctionHouse.AuctionGoodsInfo.short");
         }
         else if(diff <= 3)
         {
            result = LanguageMgr.GetTranslation("tank.data.auctionHouse.AuctionGoodsInfo.middle");
         }
         else if(diff <= 13)
         {
            result = LanguageMgr.GetTranslation("tank.data.auctionHouse.AuctionGoodsInfo.long");
         }
         else
         {
            result = LanguageMgr.GetTranslation("tank.data.auctionHouse.AuctionGoodsInfo.very");
         }
         offDate = null;
         return result;
      }
      
      public function getSithTimeDescription() : String
      {
         var result:String = "";
         var offDate:Date = new Date();
         offDate.setTime(beginDateObj.getTime());
         offDate.hours = ValidDate + offDate.hours;
         var diff:int = Math.abs(TimeManager.Instance.TotalHoursToNow(offDate));
         if(diff <= 1.5)
         {
            result = LanguageMgr.GetTranslation("tank.data.auctionHouse.AuctionGoodsInfo.tshort");
         }
         else if(diff <= 3)
         {
            result = LanguageMgr.GetTranslation("tank.data.auctionHouse.AuctionGoodsInfo.tmiddle");
         }
         else if(diff <= 13)
         {
            result = LanguageMgr.GetTranslation("tank.data.auctionHouse.AuctionGoodsInfo.tlong");
         }
         else
         {
            result = LanguageMgr.GetTranslation("tank.data.auctionHouse.AuctionGoodsInfo.tvery");
         }
         offDate = null;
         return result;
      }
   }
}
