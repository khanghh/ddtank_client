package shop.manager
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import hallIcon.HallIconManager;
   import shop.view.ShopSaleFrame;
   
   public class ShopSaleManager
   {
      
      private static var _instance:ShopSaleManager;
       
      
      private var _shopSaleList:Vector.<ShopItemInfo>;
      
      private var _oldGoodsList:Vector.<ShopItemInfo>;
      
      private var _goodsBuyMaxNum:int = 0;
      
      private var _view:ShopSaleFrame;
      
      public var isOpenIcon:Boolean;
      
      public function ShopSaleManager(){super();}
      
      public static function get Instance() : ShopSaleManager{return null;}
      
      public function checkOpenShopSale() : void{}
      
      public function get isOpen() : Boolean{return false;}
      
      public function addEnterIcon() : void{}
      
      public function removeEnterIcon() : void{}
      
      public function get shopSaleList() : Vector.<ShopItemInfo>{return null;}
      
      public function getGoodsOldPriceByID(param1:int) : int{return 0;}
      
      public function set goodsBuyMaxNum(param1:int) : void{}
      
      public function get goodsBuyMaxNum() : int{return 0;}
      
      private function createSaleFrame() : void{}
      
      private function __onFrameClose(param1:FrameEvent) : void{}
      
      private function checkStaleDatedShop() : void{}
      
      public function show() : void{}
      
      private function _onLoadingCloseHandle(param1:Event) : void{}
      
      private function __onLoadComplete(param1:UIModuleEvent) : void{}
      
      private function __onProgress(param1:UIModuleEvent) : void{}
   }
}
