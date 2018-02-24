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
      
      public function ShopItemInfo(param1:int, param2:int){super();}
      
      public function get LimitGrade() : int{return 0;}
      
      public function set LimitGrade(param1:int) : void{}
      
      public function get isValid() : Boolean{return false;}
      
      public function set TemplateInfo(param1:ItemTemplateInfo) : void{}
      
      public function get TemplateInfo() : ItemTemplateInfo{return null;}
      
      public function getItemPrice(param1:int) : ItemPrice{return null;}
      
      public function getTimeToString(param1:int) : String{return null;}
      
      public function get buyTypeToString() : String{return null;}
      
      public function get LimitCount() : int{return 0;}
      
      public function set LimitCount(param1:int) : void{}
      
      public function get LimitPersonalCount() : int{return 0;}
      
      public function set LimitPersonalCount(param1:int) : void{}
      
      public function set LimitAreaCount(param1:int) : void{}
      
      public function get LimitAreaCount() : int{return 0;}
      
      public function get StartDate() : String{return null;}
      
      public function set StartDate(param1:String) : void{}
      
      public function get EndDate() : String{return null;}
      
      public function set EndDate(param1:String) : void{}
      
      private function analysisDate() : void{}
   }
}
