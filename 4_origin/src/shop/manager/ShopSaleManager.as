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
      
      public function ShopSaleManager()
      {
         super();
         _shopSaleList = ShopManager.Instance.getValidGoodByType(110);
         _oldGoodsList = ShopManager.Instance.getValidGoodByType(280);
      }
      
      public static function get Instance() : ShopSaleManager
      {
         if(_instance == null)
         {
            _instance = new ShopSaleManager();
         }
         return _instance;
      }
      
      public function checkOpenShopSale() : void
      {
         if(isOpenIcon)
         {
            if(!isOpen)
            {
               removeEnterIcon();
            }
            else
            {
               checkStaleDatedShop();
            }
         }
         else if(isOpen)
         {
            addEnterIcon();
         }
      }
      
      public function get isOpen() : Boolean
      {
         if(_shopSaleList.length > 0)
         {
            return _shopSaleList[0].isValid;
         }
         return false;
      }
      
      public function addEnterIcon() : void
      {
         isOpenIcon = true;
         HallIconManager.instance.updateSwitchHandler("saleshop",isOpenIcon);
      }
      
      public function removeEnterIcon() : void
      {
         isOpenIcon = false;
         HallIconManager.instance.updateSwitchHandler("saleshop",isOpenIcon);
         if(_view)
         {
            _view.dispose();
            _view = null;
         }
      }
      
      public function get shopSaleList() : Vector.<ShopItemInfo>
      {
         return _shopSaleList;
      }
      
      public function getGoodsOldPriceByID(value:int) : int
      {
         var _loc4_:int = 0;
         var _loc3_:* = _oldGoodsList;
         for each(var i in _oldGoodsList)
         {
            if(i.TemplateID == value)
            {
               return i.getItemPrice(1).bothMoneyValue;
            }
         }
         return 0;
      }
      
      public function set goodsBuyMaxNum(value:int) : void
      {
         _goodsBuyMaxNum = value;
      }
      
      public function get goodsBuyMaxNum() : int
      {
         return _goodsBuyMaxNum;
      }
      
      private function createSaleFrame() : void
      {
         _view = ComponentFactory.Instance.creat("ddtshop.view.ShopSaleFrame");
         _view.addEventListener("response",__onFrameClose);
         LayerManager.Instance.addToLayer(_view,3,true,1);
      }
      
      private function __onFrameClose(e:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(e.responseCode == 0 || e.responseCode == 1)
         {
            _view.removeEventListener("response",__onFrameClose);
            _view.dispose();
            _view = null;
         }
      }
      
      private function checkStaleDatedShop() : void
      {
         var copyShopSaleList:* = undefined;
         if(_view)
         {
            copyShopSaleList = new Vector.<ShopItemInfo>();
            var _loc4_:int = 0;
            var _loc3_:* = _shopSaleList;
            for each(var item in _shopSaleList)
            {
               if(item.isValid)
               {
                  copyShopSaleList.push(item);
               }
            }
            if(_shopSaleList.length == copyShopSaleList.length)
            {
               return;
            }
            _shopSaleList = copyShopSaleList;
            _view.updateSaleGoods();
         }
      }
      
      public function show() : void
      {
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",_onLoadingCloseHandle);
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onLoadComplete);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onProgress);
         UIModuleLoader.Instance.addUIModuleImp("ddtshop");
      }
      
      private function _onLoadingCloseHandle(e:Event) : void
      {
         UIModuleSmallLoading.Instance.removeEventListener("close",_onLoadingCloseHandle);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onLoadComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onProgress);
         UIModuleSmallLoading.Instance.hide();
      }
      
      private function __onLoadComplete(e:UIModuleEvent) : void
      {
         if(e.module == "ddtshop")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleSmallLoading.Instance.removeEventListener("close",_onLoadingCloseHandle);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onLoadComplete);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onProgress);
            createSaleFrame();
         }
      }
      
      private function __onProgress(e:UIModuleEvent) : void
      {
         if(e.module == "ddtshop")
         {
            UIModuleSmallLoading.Instance.progress = e.loader.progress * 100;
         }
      }
   }
}
