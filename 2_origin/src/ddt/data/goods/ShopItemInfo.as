package ddt.data.goods
{
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import road7th.utils.DateUtils;
   
   public class ShopItemInfo extends EventDispatcher
   {
      
      public static const DAY:String = LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.day");
      
      public static const AMOUNT:String = LanguageMgr.GetTranslation("ge");
      
      public static const FOREVER:String = LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.forever");
       
      
      public var ShopID:int;
      
      public var GoodsID:int;
      
      public var TemplateID:int;
      
      public var BuyType:int;
      
      public var Sort:int;
      
      public var IsBind:int;
      
      public var Label:int;
      
      public var IsCheap:Boolean;
      
      public var Beat:Number = 1;
      
      public var Position:int;
      
      public var AUnit:int;
      
      public var APrice1:int;
      
      public var AValue1:int;
      
      public var APrice2:int;
      
      public var AValue2:int;
      
      public var APrice3:int;
      
      public var AValue3:int;
      
      public var BUnit:int;
      
      public var BPrice1:int;
      
      public var BValue1:int;
      
      public var BPrice2:int;
      
      public var BValue2:int;
      
      public var BPrice3:int;
      
      public var BValue3:int;
      
      public var IsContinue:Boolean;
      
      public var CUnit:int;
      
      public var CPrice1:int;
      
      public var CValue1:int;
      
      public var CPrice2:int;
      
      public var CValue2:int;
      
      public var CPrice3:int;
      
      public var CValue3:int;
      
      private var startDate:String;
      
      private var endDate:String;
      
      private var startData_D:Date;
      
      private var endDate_D:Date;
      
      private var _templateInfo:ItemTemplateInfo;
      
      private var _itemPrice:ItemPrice;
      
      private var _count:int = -1;
      
      private var _limitPersonalCount:int = -1;
      
      private var _limitGrade:int;
      
      private var _limitAreaCount:int = -1;
      
      private var _isChangeDate:Boolean;
      
      public var isDiscount:int = 1;
      
      public var personalBuyCnt:int = -1;
      
      public function ShopItemInfo($GoodsID:int, $TemplateID:int)
      {
         super();
         GoodsID = $GoodsID;
         TemplateID = $TemplateID;
      }
      
      public function get LimitGrade() : int
      {
         return _limitGrade;
      }
      
      public function set LimitGrade(value:int) : void
      {
         _limitGrade = value;
      }
      
      public function get isValid() : Boolean
      {
         analysisDate();
         if(TimeManager.Instance.Now().time < endDate_D.time && TimeManager.Instance.Now().time >= startData_D.time)
         {
            return true;
         }
         return false;
      }
      
      public function set TemplateInfo(value:ItemTemplateInfo) : void
      {
         _templateInfo = value;
      }
      
      public function get TemplateInfo() : ItemTemplateInfo
      {
         if(_templateInfo == null)
         {
            return ItemManager.Instance.getTemplateById(this.TemplateID);
         }
         return _templateInfo;
      }
      
      public function getItemPrice(index:int) : ItemPrice
      {
         switch(int(index) - 1)
         {
            case 0:
               return new ItemPrice(AUnit == -1?null:new Price(AValue1 * Beat,APrice1),AUnit == -1?null:new Price(AValue2 * Beat,APrice2),AUnit == -1?null:new Price(AValue3 * Beat,APrice3));
            case 1:
               return new ItemPrice(BUnit == -1?null:new Price(BValue1 * Beat,BPrice1),BUnit == -1?null:new Price(BValue2 * Beat,BPrice2),BUnit == -1?null:new Price(BValue3 * Beat,BPrice3));
            case 2:
               return new ItemPrice(CUnit == -1?null:new Price(CValue1 * Beat,CPrice1),CUnit == -1?null:new Price(CValue2 * Beat,CPrice2),CUnit == -1?null:new Price(CValue3 * Beat,CPrice3));
         }
      }
      
      public function getTimeToString(type:int) : String
      {
         switch(int(type) - 1)
         {
            case 0:
               return AUnit == 0?FOREVER:AUnit.toString() + " " + buyTypeToString;
            case 1:
               return BUnit == 0?FOREVER:BUnit.toString() + " " + buyTypeToString;
            case 2:
               return CUnit == 0?FOREVER:CUnit.toString() + " " + buyTypeToString;
         }
      }
      
      public function get buyTypeToString() : String
      {
         if(BuyType == 0)
         {
            return DAY;
         }
         return AMOUNT;
      }
      
      public function get LimitCount() : int
      {
         return _count;
      }
      
      public function set LimitCount(value:int) : void
      {
         if(_count == value)
         {
            return;
         }
         _count = value;
         dispatchEvent(new Event("change"));
      }
      
      public function get LimitPersonalCount() : int
      {
         return _limitPersonalCount;
      }
      
      public function set LimitPersonalCount(value:int) : void
      {
         if(_limitPersonalCount == value)
         {
            return;
         }
         _limitPersonalCount = value;
         personalBuyCnt = value;
      }
      
      public function set LimitAreaCount(value:int) : void
      {
         if(_limitAreaCount == value)
         {
            return;
         }
         _limitAreaCount = value;
      }
      
      public function get LimitAreaCount() : int
      {
         return _limitAreaCount;
      }
      
      public function get StartDate() : String
      {
         return startDate;
      }
      
      public function set StartDate(value:String) : void
      {
         startDate = value;
         _isChangeDate = true;
      }
      
      public function get EndDate() : String
      {
         return endDate;
      }
      
      public function set EndDate(value:String) : void
      {
         endDate = value;
         _isChangeDate = true;
      }
      
      private function analysisDate() : void
      {
         if(_isChangeDate)
         {
            _isChangeDate = false;
            startData_D = DateUtils.decodeDated(startDate);
            endDate_D = DateUtils.decodeDated(endDate);
         }
      }
   }
}
