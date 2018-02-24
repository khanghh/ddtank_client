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
      
      public function ShopManager(param1:SingletonEnfocer)
      {
         super();
      }
      
      public static function get Instance() : ShopManager
      {
         if(_instance == null)
         {
            _instance = new ShopManager(new SingletonEnfocer());
         }
         return _instance;
      }
      
      public function setup(param1:ShopItemAnalyzer) : void
      {
         _shopGoods = param1.shopinfolist;
         initialized = true;
         SocketManager.Instance.addEventListener(PkgEvent.format(168),__updateGoodsCount);
         SocketManager.Instance.addEventListener(PkgEvent.format(109),__updateGoodsDisCount);
         SocketManager.Instance.addEventListener(PkgEvent.format(288),__shopBuyLimitedCountHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(528),__syncLimitShopList);
      }
      
      private function __syncLimitShopList(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = param1.pkg.readInt();
         var _loc6_:int = param1.pkg.readInt();
         var _loc4_:int = 0;
         var _loc3_:ShopItemInfo = null;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc4_ = param1.pkg.readInt();
            _loc3_ = getShopItemByGoodsID(_loc4_);
            if(_loc3_)
            {
               _loc3_.personalBuyCnt = Math.max(0,_loc3_.LimitPersonalCount - param1.pkg.readInt());
            }
            else
            {
               param1.pkg.readInt();
            }
            _loc5_++;
         }
         dispatchEvent(new CEvent("updatePersonalLimitShop",_loc2_));
      }
      
      public function updateShopGoods(param1:ShopItemAnalyzer) : void
      {
         _shopGoods = param1.shopinfolist;
      }
      
      public function sortShopItems(param1:ShopItemSortAnalyzer) : void
      {
         _shopSortList = param1.shopSortedGoods;
      }
      
      private function __shopBuyLimitedCountHandler(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:PackageIn = param1.pkg;
         var _loc4_:int = _loc5_.readInt();
         if(_loc4_ > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc2_ = _loc5_.readInt();
               _loc3_ = _loc5_.readInt();
               if(_shopGoods[_loc2_])
               {
                  ShopItemInfo(_shopGoods[_loc2_]).LimitAreaCount = _loc3_;
               }
               _loc6_++;
            }
            dispatchEvent(new ShopEvent("updataLimitAreaCount"));
         }
      }
      
      public function getResultPages(param1:int, param2:int = 8) : int
      {
         var _loc3_:Vector.<ShopItemInfo> = getValidGoodByType(param1);
         var _loc4_:int = Math.ceil(_loc3_.length / param2);
         return _loc4_;
      }
      
      public function buyIt(param1:Array) : Array
      {
         var _loc6_:SelfInfo = PlayerManager.Instance.Self;
         var _loc7_:Array = [];
         var _loc3_:int = _loc6_.Gold;
         var _loc2_:int = _loc6_.Money;
         var _loc4_:int = _loc6_.BandMoney;
         var _loc9_:int = 0;
         var _loc8_:* = param1;
         for each(var _loc5_ in param1)
         {
            _loc7_.push(_loc5_);
         }
         return _loc7_;
      }
      
      public function giveGift(param1:Array, param2:SelfInfo) : Array
      {
         var _loc6_:* = null;
         var _loc3_:Array = [];
         var _loc5_:int = param2.Money;
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for each(var _loc4_ in param1)
         {
            _loc6_ = _loc4_.getItemPrice(_loc4_.currentBuyType);
            if(_loc5_ >= _loc6_.bothMoneyValue && _loc6_.bandDdtMoneyValue == 0 && _loc6_.goldValue == 0)
            {
               _loc5_ = _loc5_ - _loc6_.bothMoneyValue;
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      private function __updateGoodsCount(param1:PkgEvent) : void
      {
         var _loc10_:int = 0;
         var _loc15_:int = 0;
         var _loc3_:int = 0;
         var _loc12_:* = null;
         var _loc9_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc2_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc7_:int = StateManager.currentStateType == "consortia"?2:1;
         var _loc6_:int = _loc4_.readInt();
         _loc10_ = 0;
         while(_loc10_ < _loc6_)
         {
            _loc15_ = _loc4_.readInt();
            _loc3_ = _loc4_.readInt();
            _loc12_ = getShopItemByGoodsID(_loc15_);
            if(_loc12_ && _loc7_ == 1)
            {
               _loc12_.LimitCount = _loc3_;
            }
            _loc10_++;
         }
         var _loc8_:int = _loc4_.readInt();
         var _loc5_:int = _loc4_.readInt();
         _loc9_ = 0;
         while(_loc9_ < _loc5_)
         {
            _loc13_ = _loc4_.readInt();
            _loc14_ = _loc4_.readInt();
            _loc2_ = getShopItemByGoodsID(_loc13_);
            if(_loc2_ && _loc7_ == 2 && _loc8_ == PlayerManager.Instance.Self.ConsortiaID)
            {
               _loc2_.LimitCount = _loc14_;
            }
            _loc9_++;
         }
         var _loc11_:int = _loc4_.readInt();
         GemstoneManager.Instance.upDataFitCount();
      }
      
      public function getShopItemByGoodsID(param1:int) : ShopItemInfo
      {
         var _loc4_:* = null;
         var _loc3_:ShopItemInfo = _shopGoods[param1];
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         var _loc6_:int = 0;
         var _loc5_:* = _shopRealTimesDisCountGoods;
         for each(var _loc2_ in _shopRealTimesDisCountGoods)
         {
            _loc4_ = _loc2_[param1];
            if(_loc4_ != null && _loc4_.isValid)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function getValidSortedGoodsByType(param1:int, param2:int, param3:int = 8) : Vector.<ShopItemInfo>
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         var _loc6_:Vector.<ShopItemInfo> = getValidGoodByType(param1);
         var _loc8_:int = Math.ceil(_loc6_.length / param3);
         if(param2 > 0 && param2 <= _loc8_)
         {
            _loc5_ = 0 + param3 * (param2 - 1);
            _loc7_ = Math.min(_loc6_.length - _loc5_,param3);
            _loc9_ = 0;
            while(_loc9_ < _loc7_)
            {
               _loc4_.push(_loc6_[_loc5_ + _loc9_]);
               _loc9_++;
            }
         }
         return _loc4_;
      }
      
      public function getValidSortedGoodsByList(param1:Vector.<ShopItemInfo>, param2:int, param3:int = 8) : Vector.<ShopItemInfo>
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         var _loc7_:int = Math.ceil(param1.length / param3);
         if(param2 > 0 && param2 <= _loc7_)
         {
            _loc5_ = 0 + param3 * (param2 - 1);
            _loc6_ = Math.min(param1.length - _loc5_,param3);
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               _loc4_.push(param1[_loc5_ + _loc8_]);
               _loc8_++;
            }
         }
         return _loc4_;
      }
      
      public function getGoodsByType(param1:int) : Vector.<ShopItemInfo>
      {
         return _shopSortList[param1] as Vector.<ShopItemInfo>;
      }
      
      public function getValidGoodByType(param1:int) : Vector.<ShopItemInfo>
      {
         var _loc2_:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         var _loc4_:Vector.<ShopItemInfo> = _shopSortList[param1];
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for each(var _loc3_ in _loc4_)
         {
            if(_loc3_.isValid)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getValidGoodsArrayByType(param1:int) : Array
      {
         var _loc2_:Array = [];
         var _loc4_:Vector.<ShopItemInfo> = _shopSortList[param1];
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for each(var _loc3_ in _loc4_)
         {
            if(_loc3_.isValid)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function consortiaShopLevelTemplates(param1:int) : Vector.<ShopItemInfo>
      {
         return _shopSortList[80 + param1 - 1] as Vector.<ShopItemInfo>;
      }
      
      public function canAddPrice(param1:int) : Boolean
      {
         if(!getGoodsByTemplateIDOnlyUseXuFei(param1) || !getGoodsByTemplateIDOnlyUseXuFei(param1).IsContinue)
         {
            return false;
         }
         if(getShopRechargeItemByTemplateId(param1).length <= 0)
         {
            return false;
         }
         return true;
      }
      
      public function getShopRechargeItemByTemplateId(param1:int) : Array
      {
         var _loc6_:Array = [];
         var _loc11_:int = 0;
         var _loc10_:* = _shopGoods;
         for each(var _loc9_ in _shopGoods)
         {
            if(_loc9_.TemplateID == param1 && _loc9_.getItemPrice(1).armShellClipValue > 0 && _loc9_.IsContinue)
            {
               _loc6_.push(_loc9_);
            }
         }
         var _loc13_:int = 0;
         var _loc12_:* = _shopGoods;
         for each(var _loc8_ in _shopGoods)
         {
            if(_loc8_.TemplateID == param1 && _loc8_.getItemPrice(1).bothMoneyValue > 0 && _loc8_.IsContinue)
            {
               _loc6_.push(_loc8_);
            }
         }
         var _loc15_:int = 0;
         var _loc14_:* = _shopGoods;
         for each(var _loc5_ in _shopGoods)
         {
            if(_loc5_.TemplateID == param1 && _loc5_.getItemPrice(1).moneyValue > 0 && _loc5_.IsContinue)
            {
               _loc6_.push(_loc5_);
            }
         }
         var _loc17_:int = 0;
         var _loc16_:* = _shopGoods;
         for each(var _loc3_ in _shopGoods)
         {
            if(_loc3_.TemplateID == param1 && _loc3_.getItemPrice(1).bandDdtMoneyValue > 0 && _loc3_.IsContinue)
            {
               _loc6_.push(_loc3_);
            }
         }
         var _loc19_:int = 0;
         var _loc18_:* = _shopGoods;
         for each(var _loc4_ in _shopGoods)
         {
            if(_loc4_.TemplateID == param1 && _loc4_.getItemPrice(1).lightStoneValue > 0 && _loc4_.IsContinue)
            {
               _loc6_.push(_loc4_);
            }
         }
         var _loc21_:int = 0;
         var _loc20_:* = _shopGoods;
         for each(var _loc2_ in _shopGoods)
         {
            if(_loc2_.TemplateID == param1 && _loc2_.getItemPrice(1).leagueValue > 0 && _loc2_.IsContinue)
            {
               _loc6_.push(_loc2_);
            }
         }
         var _loc23_:int = 0;
         var _loc22_:* = _shopGoods;
         for each(var _loc7_ in _shopGoods)
         {
            if(_loc7_.TemplateID == param1 && _loc7_.getItemPrice(1).ddtMoneyValue > 0 && _loc7_.IsContinue)
            {
               _loc6_.push(_loc7_);
            }
         }
         return _loc6_;
      }
      
      public function getShopItemByTemplateID(param1:int, param2:int) : ShopItemInfo
      {
         var _loc3_:* = null;
         switch(int(param2) - 1)
         {
            case 0:
               var _loc5_:int = 0;
               var _loc4_:* = _shopGoods;
               for each(_loc3_ in _shopGoods)
               {
                  if(_loc3_.TemplateID == param1 && _loc3_.getItemPrice(1).hardCurrencyValue > 0)
                  {
                     if(_loc3_.isValid)
                     {
                        return _loc3_;
                     }
                  }
               }
            case 1:
               var _loc7_:int = 0;
               var _loc6_:* = _shopGoods;
               for each(_loc3_ in _shopGoods)
               {
                  if(_loc3_.TemplateID == param1 && _loc3_.getItemPrice(1).gesteValue > 0)
                  {
                     if(_loc3_.isValid)
                     {
                        return _loc3_;
                     }
                  }
               }
            case 2:
               return getMoneyShopItemByTemplateID(param1);
            case 3:
               var _loc9_:int = 0;
               var _loc8_:* = _shopGoods;
               for each(_loc3_ in _shopGoods)
               {
                  if(_loc3_.TemplateID == param1 && _loc3_.getItemPrice(1).leagueValue > 0)
                  {
                     if(_loc3_.isValid)
                     {
                        return _loc3_;
                     }
                  }
               }
            case 4:
               var _loc11_:int = 0;
               var _loc10_:* = _shopGoods;
               for each(_loc3_ in _shopGoods)
               {
                  if(_loc3_.TemplateID == param1 && _loc3_.getItemPrice(1).scoreValue > 0)
                  {
                     if(_loc3_.isValid)
                     {
                        return _loc3_;
                     }
                  }
               }
            case 5:
               var _loc13_:int = 0;
               var _loc12_:* = _shopGoods;
               for each(_loc3_ in _shopGoods)
               {
                  if(_loc3_.TemplateID == param1)
                  {
                     if(_loc3_.getItemPrice(1).badgeValue > 0 && _loc3_.isValid)
                     {
                        return _loc3_;
                     }
                  }
               }
         }
      }
      
      public function getMoneyShopItemByTemplateID(param1:int, param2:Boolean = false) : ShopItemInfo
      {
         var _loc8_:* = null;
         var _loc4_:* = undefined;
         var _loc6_:* = undefined;
         if(param2)
         {
            _loc8_ = getType(ShopType.MALE_MONEY_TYPE).concat(getType(ShopType.FEMALE_MONEY_TYPE)).concat(getType(ShopType.FEMALE_DDTMONEY_TYPE)).concat(getType(ShopType.MALE_DDTMONEY_TYPE));
            var _loc12_:int = 0;
            var _loc11_:* = _loc8_;
            for each(var _loc7_ in _loc8_)
            {
               _loc4_ = getValidGoodByType(_loc7_);
               var _loc10_:int = 0;
               var _loc9_:* = _loc4_;
               for each(var _loc5_ in _loc4_)
               {
                  if(_loc5_.TemplateID == param1 && _loc5_.getItemPrice(1).bothMoneyValue > 0)
                  {
                     return _loc5_;
                  }
               }
            }
         }
         else
         {
            _loc6_ = new Vector.<ShopItemInfo>();
            var _loc14_:int = 0;
            var _loc13_:* = _shopGoods;
            for each(var _loc3_ in _shopGoods)
            {
               if(_loc3_.TemplateID == param1 && _loc3_.getItemPrice(1).bothMoneyValue > 0 && _loc3_.isValid)
               {
                  _loc6_.push(_loc3_);
               }
            }
            if(_loc6_.length > 0)
            {
               return getInfoByBuyType(_loc6_);
            }
         }
         return null;
      }
      
      private function getInfoByBuyType(param1:Vector.<ShopItemInfo>) : ShopItemInfo
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:ShopItemInfo = null;
         _loc3_ = 0;
         _loc2_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = _loc3_ - 1;
            _loc4_ = param1[_loc3_];
            while(_loc2_ >= 0 && _loc4_.ShopID < param1[_loc2_].ShopID)
            {
               param1[_loc2_ + 1] = param1[_loc2_];
               _loc2_--;
            }
            param1[_loc2_ + 1] = _loc4_;
            _loc3_++;
         }
         return param1[0];
      }
      
      public function getMoneyShopItemByTemplateIDForGiftSystem(param1:int) : ShopItemInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _shopGoods;
         for each(var _loc2_ in _shopGoods)
         {
            if(_loc2_.TemplateID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getBuriedGoodsList() : Vector.<ShopItemInfo>
      {
         var _loc2_:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         var _loc4_:int = 0;
         var _loc3_:* = _shopGoods;
         for each(var _loc1_ in _shopGoods)
         {
            if(_loc1_.ShopID == 94)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      private function getGoodsByTemplateIDOnlyUseXuFei(param1:int) : ShopItemInfo
      {
         var _loc3_:int = 0;
         var _loc4_:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         var _loc6_:int = 0;
         var _loc5_:* = _shopGoods;
         for each(var _loc2_ in _shopGoods)
         {
            if(_loc2_.TemplateID == param1)
            {
               _loc4_.push(_loc2_);
            }
         }
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if(_loc4_[_loc3_].IsContinue)
            {
               return _loc4_[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getGoodsByTemplateID(param1:int, param2:int = -1) : ShopItemInfo
      {
         var _loc5_:int = 0;
         var _loc4_:* = _shopGoods;
         for each(var _loc3_ in _shopGoods)
         {
            if(_loc3_.TemplateID == param1)
            {
               if(param2 == -1 || _loc3_.ShopID == param2)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      public function getShopItemByTemplateIdAndType(param1:int, param2:int) : ShopItemInfo
      {
         var _loc5_:int = 0;
         var _loc4_:* = _shopSortList[param2];
         for each(var _loc3_ in _shopSortList[param2])
         {
            if(_loc3_.TemplateID == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getGiftShopItemByTemplateID(param1:int, param2:Boolean = false) : ShopItemInfo
      {
         var _loc7_:* = null;
         var _loc4_:* = undefined;
         if(param2)
         {
            _loc7_ = getType(ShopType.MALE_MONEY_TYPE).concat(getType(ShopType.FEMALE_MONEY_TYPE)).concat(getType(ShopType.FEMALE_DDTMONEY_TYPE)).concat(getType(ShopType.MALE_DDTMONEY_TYPE));
            var _loc11_:int = 0;
            var _loc10_:* = _loc7_;
            for each(var _loc6_ in _loc7_)
            {
               _loc4_ = getValidGoodByType(_loc6_);
               var _loc9_:int = 0;
               var _loc8_:* = _loc4_;
               for each(var _loc5_ in _loc4_)
               {
                  if(_loc5_.TemplateID == param1)
                  {
                     if(_loc5_.getItemPrice(1).ddtMoneyValue > 0)
                     {
                        return _loc5_;
                     }
                  }
               }
            }
         }
         else
         {
            var _loc13_:int = 0;
            var _loc12_:* = _shopGoods;
            for each(var _loc3_ in _shopGoods)
            {
               if(_loc3_.TemplateID == param1 && _loc3_.getItemPrice(1).ddtMoneyValue > 0)
               {
                  if(_loc3_.isValid)
                  {
                     return _loc3_;
                  }
               }
            }
         }
         return null;
      }
      
      private function getType(param1:*) : Array
      {
         var _loc2_:Array = [];
         if(param1 is Array)
         {
            var _loc5_:int = 0;
            var _loc4_:* = param1;
            for each(var _loc3_ in param1)
            {
               _loc2_ = _loc2_.concat(getType(_loc3_));
            }
         }
         else
         {
            _loc2_.push(param1);
         }
         return _loc2_;
      }
      
      public function getGoldShopItemByTemplateID(param1:int) : ShopItemInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _shopSortList[90];
         for each(var _loc2_ in _shopSortList[90])
         {
            if(_loc2_.TemplateID == param1)
            {
               if(_loc2_.isValid)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function moneyGoods(param1:Array, param2:SelfInfo) : Array
      {
         var _loc5_:* = null;
         var _loc4_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc5_ = _loc3_.getItemPrice(_loc3_.currentBuyType);
            if(_loc5_.bothMoneyValue > 0)
            {
               _loc4_.push(_loc3_);
            }
         }
         return _loc4_;
      }
      
      public function buyLeastGood(param1:Array, param2:SelfInfo) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            if(param2.Gold >= _loc3_.getItemPrice(_loc3_.currentBuyType).goldValue && param2.Money >= _loc3_.getItemPrice(_loc3_.currentBuyType).bothMoneyValue && param2.BandMoney >= _loc3_.getItemPrice(_loc3_.currentBuyType).bothMoneyValue && param2.Money >= _loc3_.getItemPrice(_loc3_.currentBuyType).moneyValue && param2.BandMoney >= _loc3_.getItemPrice(_loc3_.currentBuyType).bandDdtMoneyValue && param2.DDTMoney >= _loc3_.getItemPrice(_loc3_.currentBuyType).ddtMoneyValue)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getDesignatedAllShopItem() : Vector.<ShopItemInfo>
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         _loc3_ = 0;
         while(_loc3_ < ShopType.CAN_SHOW_IN_SHOP.length)
         {
            _loc2_ = ShopType.CAN_SHOW_IN_SHOP[_loc3_];
            if(_shopSortList[_loc2_])
            {
               _loc1_ = _loc1_.concat(_shopSortList[_loc2_]);
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function fuzzySearch(param1:Vector.<ShopItemInfo>, param2:String) : Vector.<ShopItemInfo>
      {
         var _loc5_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         var _loc11_:int = 0;
         var _loc10_:* = param1;
         for each(var _loc6_ in param1)
         {
            if(_loc6_.isValid && _loc6_.TemplateInfo)
            {
               _loc5_ = _loc6_.TemplateInfo.Name.indexOf(param2);
               if(_loc5_ > -1)
               {
                  _loc3_ = true;
                  var _loc9_:int = 0;
                  var _loc8_:* = _loc4_;
                  for each(var _loc7_ in _loc4_)
                  {
                     if(_loc7_.GoodsID == _loc6_.GoodsID)
                     {
                        _loc3_ = false;
                     }
                  }
                  if(_loc3_)
                  {
                     _loc4_.push(_loc6_);
                  }
               }
            }
         }
         return _loc4_;
      }
      
      public function getDisCountValidGoodByType(param1:int) : Vector.<ShopItemInfo>
      {
         var _loc7_:* = null;
         var _loc5_:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         if(param1 != 1)
         {
            _loc7_ = _shopRealTimesDisCountGoods[param1];
            if(_loc7_)
            {
               var _loc9_:int = 0;
               var _loc8_:* = _loc7_.list;
               for each(var _loc6_ in _loc7_.list)
               {
                  if(_loc6_.isValid && _loc6_.TemplateInfo.CategoryID != 25)
                  {
                     _loc5_.push(_loc6_);
                  }
               }
            }
            return _loc5_;
         }
         if(param1 == 1)
         {
            _loc7_ = _shopRealTimesDisCountGoods[param1];
            if(_loc7_)
            {
               var _loc11_:int = 0;
               var _loc10_:* = _loc7_.list;
               for each(var _loc4_ in _loc7_.list)
               {
                  if(_loc4_.isValid && _loc4_.TemplateInfo.CategoryID != 25)
                  {
                     _loc5_.push(_loc4_);
                  }
               }
            }
            _loc7_ = _shopRealTimesDisCountGoods[8];
            if(_loc7_)
            {
               var _loc13_:int = 0;
               var _loc12_:* = _loc7_.list;
               for each(var _loc2_ in _loc7_.list)
               {
                  if(_loc2_.isValid && _loc2_.TemplateInfo.CategoryID != 25)
                  {
                     _loc5_.push(_loc2_);
                  }
               }
            }
            _loc7_ = _shopRealTimesDisCountGoods[9];
            if(_loc7_)
            {
               var _loc15_:int = 0;
               var _loc14_:* = _loc7_.list;
               for each(var _loc3_ in _loc7_.list)
               {
                  if(_loc3_.isValid && _loc3_.TemplateInfo.CategoryID != 25)
                  {
                     _loc5_.push(_loc3_);
                  }
               }
            }
            return _loc5_;
         }
         return _loc5_;
      }
      
      public function getDisCountResultPages(param1:int, param2:int = 8) : int
      {
         var _loc4_:int = 0;
         var _loc3_:Vector.<ShopItemInfo> = getDisCountValidGoodByType(param1);
         if(_loc3_)
         {
            _loc4_ = Math.ceil(_loc3_.length / param2);
         }
         return _loc4_;
      }
      
      public function getDisCountShopItemByGoodsID(param1:int) : ShopItemInfo
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _shopRealTimesDisCountGoods;
         for each(var _loc2_ in _shopRealTimesDisCountGoods)
         {
            _loc3_ = _loc2_[param1];
            if(_loc3_ != null && _loc3_.isValid)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getMoneySaleShopItemByTemplateID(param1:int) : ShopItemInfo
      {
         var _loc3_:Vector.<ShopItemInfo> = _shopSortList[110];
         if(_loc3_)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _loc3_;
            for each(var _loc2_ in _loc3_)
            {
               if(_loc2_.GoodsID == param1 && _loc2_.getItemPrice(1).bothMoneyValue > 0)
               {
                  return _loc2_;
               }
               if(_loc2_.GoodsID == param1 && _loc2_.getItemPrice(1).moneyValue > 0)
               {
                  return _loc2_;
               }
               if(_loc2_.GoodsID == param1 && _loc2_.getItemPrice(1).bandDdtMoneyValue > 0)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function getDisCountGoods(param1:int = 1, param2:int = 1, param3:int = 8) : Vector.<ShopItemInfo>
      {
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         var _loc6_:Vector.<ShopItemInfo> = getDisCountValidGoodByType(param1);
         if(_loc6_)
         {
            _loc8_ = Math.ceil(_loc6_.length / param3);
            if(param2 > 0 && param2 <= _loc8_)
            {
               _loc5_ = 0 + param3 * (param2 - 1);
               _loc7_ = Math.min(_loc6_.length - _loc5_,param3);
               _loc9_ = 0;
               while(_loc9_ < _loc7_)
               {
                  _loc4_.push(_loc6_[_loc5_ + _loc9_]);
                  _loc9_++;
               }
            }
         }
         return _loc4_;
      }
      
      public function getGoodsByTempId(param1:int) : ShopItemInfo
      {
         var _loc3_:int = 0;
         var _loc4_:ShopItemInfo = null;
         var _loc2_:Vector.<ShopItemInfo> = getDisCountGoods();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(param1 == _loc2_[_loc3_].TemplateID)
            {
               _loc4_ = _loc2_[_loc3_];
               break;
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      public function isHasDisCountGoods(param1:int) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:DictionaryData = _shopRealTimesDisCountGoods[param1];
         if(param1 == 1)
         {
            _loc2_ = _shopRealTimesDisCountGoods[8];
            _loc3_ = _shopRealTimesDisCountGoods[9];
            if(checkIsHasDisCount(_loc4_) || checkIsHasDisCount(_loc2_) || checkIsHasDisCount(_loc3_))
            {
               return true;
            }
         }
         else if(checkIsHasDisCount(_loc4_))
         {
            return true;
         }
         return false;
      }
      
      private function checkIsHasDisCount(param1:DictionaryData) : Boolean
      {
         if(param1 && param1.length > 0)
         {
            var _loc4_:int = 0;
            var _loc3_:* = param1.list;
            for each(var _loc2_ in param1.list)
            {
               if(_loc2_ && _loc2_.isValid)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function __updateGoodsDisCount(param1:PkgEvent) : void
      {
         loadDisCounts();
      }
      
      private function loadDisCounts() : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["rnd"] = Math.random();
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ShopCheapItemList.ashx"),6,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.ShopDisCountRealTimesFailure");
         _loc1_.analyzer = new ShopItemDisCountAnalyzer(ShopManager.Instance.updateRealTimesItemsByDisCount);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      public function updateRealTimesItemsByDisCount(param1:ShopItemDisCountAnalyzer) : void
      {
         _shopRealTimesDisCountGoods = param1.shopDisCountGoods;
         dispatchEvent(new ShopEvent("discountIsChange"));
      }
      
      public function get shopGoods() : DictionaryData
      {
         return _shopGoods;
      }
      
      public function set shopGoods(param1:DictionaryData) : void
      {
         _shopGoods = param1;
      }
   }
}

class SingletonEnfocer
{
    
   
   function SingletonEnfocer()
   {
      super();
   }
}
