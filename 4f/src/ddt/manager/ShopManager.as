package ddt.manager
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import ddt.data.ShopType;
   import ddt.data.analyze.ShopItemAnalyzer;
   import ddt.data.analyze.ShopItemDisCountAnalyzer;
   import ddt.data.analyze.ShopItemSortAnalyzer;
   import ddt.data.goods.ItemPrice;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import flash.events.EventDispatcher;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   import gemstone.GemstoneManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import shop.ShopEvent;
   
   public class ShopManager extends EventDispatcher
   {
      
      private static var _instance:ShopManager;
       
      
      public var initialized:Boolean = false;
      
      private var _shopGoods:DictionaryData;
      
      private var _shopSortList:Dictionary;
      
      private var _shopRealTimesDisCountGoods:Dictionary;
      
      public function ShopManager(param1:SingletonEnfocer){super();}
      
      public static function get Instance() : ShopManager{return null;}
      
      public function setup(param1:ShopItemAnalyzer) : void{}
      
      private function __syncLimitShopList(param1:PkgEvent) : void{}
      
      public function updateShopGoods(param1:ShopItemAnalyzer) : void{}
      
      public function sortShopItems(param1:ShopItemSortAnalyzer) : void{}
      
      private function __shopBuyLimitedCountHandler(param1:PkgEvent) : void{}
      
      public function getResultPages(param1:int, param2:int = 8) : int{return 0;}
      
      public function buyIt(param1:Array) : Array{return null;}
      
      public function giveGift(param1:Array, param2:SelfInfo) : Array{return null;}
      
      private function __updateGoodsCount(param1:PkgEvent) : void{}
      
      public function getShopItemByGoodsID(param1:int) : ShopItemInfo{return null;}
      
      public function getValidSortedGoodsByType(param1:int, param2:int, param3:int = 8) : Vector.<ShopItemInfo>{return null;}
      
      public function getValidSortedGoodsByList(param1:Vector.<ShopItemInfo>, param2:int, param3:int = 8) : Vector.<ShopItemInfo>{return null;}
      
      public function getGoodsByType(param1:int) : Vector.<ShopItemInfo>{return null;}
      
      public function getValidGoodByType(param1:int) : Vector.<ShopItemInfo>{return null;}
      
      public function getValidGoodsArrayByType(param1:int) : Array{return null;}
      
      public function consortiaShopLevelTemplates(param1:int) : Vector.<ShopItemInfo>{return null;}
      
      public function canAddPrice(param1:int) : Boolean{return false;}
      
      public function getShopRechargeItemByTemplateId(param1:int) : Array{return null;}
      
      public function getShopItemByTemplateID(param1:int, param2:int) : ShopItemInfo{return null;}
      
      public function getMoneyShopItemByTemplateID(param1:int, param2:Boolean = false) : ShopItemInfo{return null;}
      
      private function getInfoByBuyType(param1:Vector.<ShopItemInfo>) : ShopItemInfo{return null;}
      
      public function getMoneyShopItemByTemplateIDForGiftSystem(param1:int) : ShopItemInfo{return null;}
      
      public function getBuriedGoodsList() : Vector.<ShopItemInfo>{return null;}
      
      private function getGoodsByTemplateIDOnlyUseXuFei(param1:int) : ShopItemInfo{return null;}
      
      public function getGoodsByTemplateID(param1:int, param2:int = -1) : ShopItemInfo{return null;}
      
      public function getShopItemByTemplateIdAndType(param1:int, param2:int) : ShopItemInfo{return null;}
      
      public function getGiftShopItemByTemplateID(param1:int, param2:Boolean = false) : ShopItemInfo{return null;}
      
      private function getType(param1:*) : Array{return null;}
      
      public function getGoldShopItemByTemplateID(param1:int) : ShopItemInfo{return null;}
      
      public function moneyGoods(param1:Array, param2:SelfInfo) : Array{return null;}
      
      public function buyLeastGood(param1:Array, param2:SelfInfo) : Boolean{return false;}
      
      public function getDesignatedAllShopItem() : Vector.<ShopItemInfo>{return null;}
      
      public function fuzzySearch(param1:Vector.<ShopItemInfo>, param2:String) : Vector.<ShopItemInfo>{return null;}
      
      public function getDisCountValidGoodByType(param1:int) : Vector.<ShopItemInfo>{return null;}
      
      public function getDisCountResultPages(param1:int, param2:int = 8) : int{return 0;}
      
      public function getDisCountShopItemByGoodsID(param1:int) : ShopItemInfo{return null;}
      
      public function getMoneySaleShopItemByTemplateID(param1:int) : ShopItemInfo{return null;}
      
      public function getDisCountGoods(param1:int = 1, param2:int = 1, param3:int = 8) : Vector.<ShopItemInfo>{return null;}
      
      public function getGoodsByTempId(param1:int) : ShopItemInfo{return null;}
      
      public function isHasDisCountGoods(param1:int) : Boolean{return false;}
      
      private function checkIsHasDisCount(param1:DictionaryData) : Boolean{return false;}
      
      private function __updateGoodsDisCount(param1:PkgEvent) : void{}
      
      private function loadDisCounts() : void{}
      
      public function updateRealTimesItemsByDisCount(param1:ShopItemDisCountAnalyzer) : void{}
      
      public function get shopGoods() : DictionaryData{return null;}
      
      public function set shopGoods(param1:DictionaryData) : void{}
   }
}

class SingletonEnfocer
{
    
   
   function SingletonEnfocer(){super();}
}
