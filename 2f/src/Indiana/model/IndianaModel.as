package Indiana.model
{
   import Indiana.analyzer.IndianaGoodsItemInfo;
   import Indiana.analyzer.IndianaShopItemInfo;
   import ddt.manager.TimeManager;
   import road7th.utils.DateUtils;
   
   public class IndianaModel
   {
      
      public static var INDIANA_COUNTDOWN:int = 1;
      
      public static var INDIANA_SHOWING:int = 2;
      
      public static var INDIANA_DOING:int = 0;
      
      public static var INDIANA_START:int = 5;
      
      public static var INDIANA_END:int = 6;
       
      
      private var _items:Vector.<IndianaGoodsItemInfo>;
      
      private var _shopItems:Vector.<IndianaShopItemInfo>;
      
      private var _startTime:Date;
      
      private var _endTime:Date;
      
      public function IndianaModel(){super();}
      
      public function set Items(param1:Vector.<IndianaGoodsItemInfo>) : void{}
      
      public function get Items() : Vector.<IndianaGoodsItemInfo>{return null;}
      
      public function set ShopItems(param1:Vector.<IndianaShopItemInfo>) : void{}
      
      public function calculationIsNeedCheck() : Boolean{return false;}
      
      public function get ShopItems() : Vector.<IndianaShopItemInfo>{return null;}
      
      public function getShopItemByid(param1:int) : IndianaShopItemInfo{return null;}
      
      private function calculationEndTime() : void{}
      
      private function calculationStartTime() : void{}
      
      public function getActivateState() : int{return 0;}
   }
}
