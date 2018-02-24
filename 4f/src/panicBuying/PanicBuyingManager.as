package panicBuying
{
   import ddt.CoreManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import flash.utils.Dictionary;
   import hallIcon.HallIconManager;
   import panicBuying.event.PanicBuyingEvent;
   import road7th.utils.DateUtils;
   import shop.ShopEvent;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class PanicBuyingManager extends CoreManager
   {
      
      private static var _instance:PanicBuyingManager;
       
      
      private var requestArr:Array;
      
      public var levelId:String;
      
      private var _vipId:String;
      
      public var indivId:String;
      
      public var entireId:String;
      
      public var newEntireId:String;
      
      public var showIconFlag:int;
      
      public function PanicBuyingManager(){super();}
      
      public static function get instance() : PanicBuyingManager{return null;}
      
      public function get vipId() : String{return null;}
      
      public function set vipId(param1:String) : void{}
      
      public function setup() : void{}
      
      protected function __discountChange(param1:ShopEvent) : void{}
      
      public function checkOpen() : void{}
      
      public function reCheck() : void{}
      
      private function showEnterIcon() : void{}
      
      private function hideEnterIcon() : void{}
      
      public function updateView() : void{}
      
      override protected function start() : void{}
   }
}
