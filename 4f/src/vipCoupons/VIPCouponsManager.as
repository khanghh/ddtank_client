package vipCoupons
{
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import flash.events.IEventDispatcher;
   
   public class VIPCouponsManager extends CoreManager
   {
      
      public static const OPENVIEW:String = "vipCouponesOpenView";
      
      public static const USE_VIPCOUPONS:String = "useVipCoupons";
      
      private static var _instance:VIPCouponsManager;
       
      
      private var _curCoupons:int = 0;
      
      private var _place:int;
      
      private var _bagType:int;
      
      private var _vipDiscountUseDate:Date = null;
      
      private var _vipDiscountValidity:Date = null;
      
      public function VIPCouponsManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : VIPCouponsManager{return null;}
      
      override protected function start() : void{}
      
      public function get curCoupons() : int{return 0;}
      
      public function set curCoupons(param1:int) : void{}
      
      public function useVipCoupons(param1:int, param2:int) : void{}
      
      public function openShow(param1:int, param2:int) : void{}
   }
}
