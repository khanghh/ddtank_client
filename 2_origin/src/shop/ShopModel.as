package shop
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemPrice;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.BagEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   
   public class ShopModel extends EventDispatcher
   {
      
      private static var DEFAULT_MAN_STYLE:String = "1101,2101,3101,4101,5101,6101,7001,13101,15001";
      
      private static var DEFAULT_WOMAN_STYLE:String = "1201,2201,3201,4201,5201,6201,7002,13201,15001";
      
      public static const SHOP_CART_MAX_LENGTH:uint = 20;
       
      
      public var leftCarList:Array;
      
      public var leftManList:Array;
      
      public var isBandList:Array;
      
      public var leftWomanList:Array;
      
      private var _bodyThings:DictionaryData;
      
      private var _carList:Array;
      
      private var _currentGift:int;
      
      private var _currentGold:int;
      
      private var _currentMedal:int;
      
      private var _currentMoney:int;
      
      private var _totalGold:int;
      
      private var _totalMedal:int;
      
      private var _totalMoney:int;
      
      private var _defaultModel:int;
      
      private var _manMemoryList:Array;
      
      private var _manModel:PlayerInfo;
      
      private var _manTempList:Array;
      
      private var _womanMemoryList:Array;
      
      private var _womanModel:PlayerInfo;
      
      private var _womanTempList:Array;
      
      private var _manHistoryList:Array;
      
      private var _womanHistoryList:Array;
      
      private var _self:SelfInfo;
      
      private var _sex:Boolean;
      
      private var _totalGift:int;
      
      private var maleCollocation:Array;
      
      private var femaleCollocation:Array;
      
      public function ShopModel()
      {
         leftCarList = [];
         leftManList = [];
         isBandList = [];
         leftWomanList = [];
         super();
         _self = PlayerManager.Instance.Self;
         _womanModel = new PlayerInfo();
         _manModel = new PlayerInfo();
         _womanTempList = [];
         _manTempList = [];
         _carList = [];
         _manMemoryList = [];
         _womanMemoryList = [];
         _manHistoryList = [];
         _womanHistoryList = [];
         _totalGold = 0;
         _totalMoney = 0;
         _totalGift = 0;
         _totalMedal = 0;
         _defaultModel = 1;
         init();
         fittingSex = _self.Sex;
         _self.addEventListener("propertychange",__styleChange);
         _self.Bag.addEventListener("update",__bagChange);
         initRandom();
      }
      
      public function removeLatestItem() : void
      {
         var _loc3_:* = null;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc2_:int = 0;
         var _loc6_:Array = !!_sex?_manTempList:_womanTempList;
         if(currentHistoryList.length > 0)
         {
            _loc3_ = currentHistoryList.pop();
            var _loc10_:int = 0;
            var _loc9_:* = _loc3_;
            for each(var _loc4_ in _loc3_)
            {
               removeTempEquip(_loc4_);
            }
         }
         var _loc1_:Array = [];
         _loc8_ = currentHistoryList.length - 1;
         while(_loc8_ > -1)
         {
            _loc7_ = currentHistoryList[_loc8_];
            var _loc12_:int = 0;
            var _loc11_:* = _loc7_;
            for each(var _loc5_ in _loc7_)
            {
               _loc2_ = currentTempListHasItem(_loc5_.TemplateInfo.CategoryID);
               if(_loc2_ <= -1)
               {
                  currentTempList.push(_loc5_);
                  dispatchEvent(new ShopEvent("addTempEquip",_loc5_));
                  _loc5_.addEventListener("change",__onItemChange);
               }
            }
            _loc8_--;
         }
         updateCost();
      }
      
      private function currentTempListHasItem(param1:int) : int
      {
         var _loc2_:Array = currentTempList;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.TemplateInfo.CategoryID == param1)
            {
               return _loc2_.indexOf(_loc3_);
            }
         }
         return -1;
      }
      
      public function get currentHistoryList() : Array
      {
         return !!_sex?_manHistoryList:_womanHistoryList;
      }
      
      private function initRandom() : void
      {
         maleCollocation = [];
         femaleCollocation = [];
         maleCollocation.push(ShopManager.Instance.getValidGoodByType(9));
         maleCollocation.push(ShopManager.Instance.getValidGoodByType(11));
         maleCollocation.push(ShopManager.Instance.getValidGoodByType(13));
         maleCollocation.push(ShopManager.Instance.getValidGoodByType(17));
         maleCollocation.push(ShopManager.Instance.getValidGoodByType(19));
         maleCollocation.push(ShopManager.Instance.getValidGoodByType(25));
         maleCollocation.push(ShopManager.Instance.getValidGoodByType(21));
         femaleCollocation.push(ShopManager.Instance.getValidGoodByType(10));
         femaleCollocation.push(ShopManager.Instance.getValidGoodByType(12));
         femaleCollocation.push(ShopManager.Instance.getValidGoodByType(14));
         femaleCollocation.push(ShopManager.Instance.getValidGoodByType(18));
         femaleCollocation.push(ShopManager.Instance.getValidGoodByType(20));
         femaleCollocation.push(ShopManager.Instance.getValidGoodByType(26));
         femaleCollocation.push(ShopManager.Instance.getValidGoodByType(22));
      }
      
      public function random() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Array = !!_sex?maleCollocation:femaleCollocation;
         var _loc2_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for each(var _loc1_ in _loc4_)
         {
            _loc3_ = Math.floor(Math.random() * _loc1_.length);
            _loc2_.push(fillToShopCarInfo(_loc1_[_loc3_]));
         }
         addTempEquip(_loc2_);
         updateCost();
      }
      
      public function get Self() : SelfInfo
      {
         return _self;
      }
      
      public function isCarListMax() : Boolean
      {
         return _carList.length + _manTempList.length + _womanTempList.length >= 20;
      }
      
      public function addTempEquip(param1:*) : Boolean
      {
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc4_:Boolean = isCarListMax();
         if(_loc4_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.car"));
            return _loc4_;
         }
         if(param1 is Array)
         {
            _loc7_ = param1 as Array;
            _loc2_ = [];
            var _loc11_:int = 0;
            var _loc10_:* = _loc7_;
            for each(var _loc9_ in _loc7_)
            {
               _loc3_ = currentTempListHasItem(_loc9_.TemplateInfo.CategoryID);
               if(_loc3_ > -1)
               {
                  currentTempList.splice(_loc3_,1);
               }
               _loc5_ = fillToShopCarInfo(_loc9_);
               _loc5_.dressing = true;
               _loc5_.ModelSex = currentModel.Sex;
               currentTempList.push(_loc5_);
               dispatchEvent(new ShopEvent("addTempEquip",_loc5_));
               updateCost();
               _loc5_.addEventListener("change",__onItemChange);
               _loc2_.push(_loc5_);
            }
            currentHistoryList.push(_loc2_);
         }
         else
         {
            _loc8_ = currentTempListHasItem(param1.TemplateInfo.CategoryID);
            if(_loc8_ > -1)
            {
               currentTempList.splice(_loc8_,1);
            }
            _loc6_ = fillToShopCarInfo(param1);
            _loc6_.dressing = true;
            _loc6_.ModelSex = currentModel.Sex;
            currentTempList.push(_loc6_);
            dispatchEvent(new ShopEvent("addTempEquip",_loc6_));
            updateCost();
            _loc6_.addEventListener("change",__onItemChange);
            currentHistoryList.push([_loc6_]);
         }
         return !_loc4_;
      }
      
      public function addToShoppingCar(param1:ShopCarItemInfo) : void
      {
         if(isCarListMax())
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.car"));
            return;
         }
         if(isOverCount(param1))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.GoodsNumberLimit"));
            return;
         }
         _carList.push(param1);
         updateCost();
         param1.addEventListener("change",__onItemChange);
         dispatchEvent(new ShopEvent("addcarequip",param1));
      }
      
      private function __onItemChange(param1:Event) : void
      {
         updateCost();
      }
      
      public function isOverCount(param1:ShopItemInfo) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:uint = 0;
         var _loc3_:Array = allItems;
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc5_] as ShopCarItemInfo;
            if(param1.TemplateID == _loc4_.TemplateID)
            {
               _loc2_++;
            }
            _loc5_++;
         }
         return _loc2_ >= param1.LimitCount && param1.LimitCount != -1?true:false;
      }
      
      public function get allItems() : Array
      {
         return _carList.concat(_manTempList).concat(_womanTempList);
      }
      
      public function get allItemsCount() : int
      {
         return _carList.length + _manTempList.length + _womanTempList.length;
      }
      
      public function calcPrices(param1:Array, param2:Array = null) : Array
      {
         var _loc7_:int = 0;
         var _loc8_:ItemPrice = new ItemPrice(null,null,null);
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            if(param2)
            {
               if(param2[_loc7_])
               {
                  _loc8_.addItemPrice(param1[_loc7_].getCurrentPrice(),param2[_loc7_]);
               }
               else
               {
                  _loc8_.addItemPrice(param1[_loc7_].getCurrentPrice());
               }
            }
            else
            {
               _loc8_.addItemPrice(param1[_loc7_].getCurrentPrice());
            }
            _loc7_++;
         }
         _loc3_ = _loc8_.goldValue;
         _loc6_ = _loc8_.bothMoneyValue;
         _loc5_ = _loc8_.ddtMoneyValue;
         _loc4_ = _loc8_.bandDdtMoneyValue;
         return [_loc3_,_loc6_,_loc5_,_loc4_];
      }
      
      public function canBuyLeastOneGood(param1:Array) : Boolean
      {
         return ShopManager.Instance.buyLeastGood(param1,_self);
      }
      
      public function canChangSkin() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:Array = currentTempList;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_loc1_[_loc2_].CategoryID == 6)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function clearAllitems() : void
      {
         _carList = [];
         _defaultModel = 1;
         _manTempList = [];
         _womanTempList = [];
         updateCost();
         dispatchEvent(new ShopEvent("updateCar"));
         init();
      }
      
      public function clearCurrentTempList(param1:int = 0) : void
      {
         var _loc2_:* = null;
         if(param1 == 0)
         {
            _loc2_ = !!_sex?_manTempList:_womanTempList;
            _loc2_.splice(0,_loc2_.length);
         }
         else if(param1 == 1)
         {
            _manTempList.splice(0,_manTempList.length);
         }
         else if(param1 == 2)
         {
            _womanTempList.splice(0,_womanTempList.length);
         }
         updateCost();
         dispatchEvent(new ShopEvent("updateCar"));
         init();
      }
      
      public function clearLeftList() : void
      {
         leftCarList = [];
         leftManList = [];
         leftWomanList = [];
      }
      
      public function get currentGift() : int
      {
         var _loc1_:Array = calcPrices(currentTempList);
         _currentGift = _loc1_[2];
         return _currentGift;
      }
      
      public function get currentGold() : int
      {
         var _loc1_:Array = calcPrices(currentTempList);
         _currentGold = _loc1_[0];
         return _currentGold;
      }
      
      public function get currentLeftList() : Array
      {
         return !!_sex?leftManList:leftWomanList;
      }
      
      public function get currentMedal() : int
      {
         var _loc1_:Array = calcPrices(currentTempList);
         _currentMedal = _loc1_[3];
         return _currentMedal;
      }
      
      public function get currentMemoryList() : Array
      {
         return !!currentModel.Sex?_manMemoryList:_womanMemoryList;
      }
      
      public function get currentModel() : PlayerInfo
      {
         return !!_sex?_manModel:_womanModel;
      }
      
      public function get currentMoney() : int
      {
         var _loc1_:Array = calcPrices(currentTempList);
         _currentMoney = _loc1_[1];
         return _currentMoney;
      }
      
      public function get currentSkin() : String
      {
         var _loc2_:int = 0;
         var _loc1_:Array = currentTempList;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_loc1_[_loc2_].CategoryID == 6)
            {
               return _loc1_[_loc2_].skin;
            }
            _loc2_++;
         }
         return "";
      }
      
      public function get currentTempList() : Array
      {
         return !!_sex?_manTempList:_womanTempList;
      }
      
      public function dispose() : void
      {
         _self.removeEventListener("propertychange",__styleChange);
         _self.Bag.removeEventListener("update",__bagChange);
         _womanModel = null;
         _manModel = null;
         _carList = null;
         leftCarList = null;
         leftManList = null;
         leftWomanList = null;
         maleCollocation = null;
         femaleCollocation = null;
      }
      
      public function get fittingSex() : Boolean
      {
         return _sex;
      }
      
      public function set fittingSex(param1:Boolean) : void
      {
         var _loc2_:* = null;
         if(_sex != param1)
         {
            _sex = param1;
            _loc2_ = new ShopEvent("fittingmodelchange","sexChange");
            dispatchEvent(_loc2_);
         }
      }
      
      public function get isSelfModel() : Boolean
      {
         return _sex == _self.Sex;
      }
      
      public function get manModelInfo() : PlayerInfo
      {
         return _manModel;
      }
      
      public function removeFromShoppingCar(param1:ShopCarItemInfo) : void
      {
         removeTempEquip(param1);
         var _loc2_:int = _carList.indexOf(param1);
         if(_loc2_ != -1)
         {
            _carList.splice(_loc2_,1);
            updateCost();
            param1.removeEventListener("change",__onItemChange);
            dispatchEvent(new ShopEvent("removecarequip",param1));
         }
      }
      
      public function checkPoint() : Boolean
      {
         var _loc1_:* = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = _carList.length;
         while(_loc5_ < _loc2_)
         {
            _loc1_ = _carList[_loc5_] as ShopCarItemInfo;
            if(_loc1_.getCurrentPrice().ddtMoneyValue > 0 || isBandList[_loc5_])
            {
               return true;
            }
            _loc5_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _manTempList.length)
         {
            _loc1_ = _manTempList[_loc3_] as ShopCarItemInfo;
            if(_loc1_.getCurrentPrice().ddtMoneyValue > 0 || isBandList[_loc3_])
            {
               return true;
            }
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _womanTempList.length)
         {
            _loc1_ = _womanTempList[_loc4_] as ShopCarItemInfo;
            if(_loc1_.getCurrentPrice().ddtMoneyValue > 0 || isBandList[_loc3_])
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function checkDiscount() : Boolean
      {
         var _loc1_:* = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = _carList.length;
         while(_loc5_ < _loc2_)
         {
            _loc1_ = _carList[_loc5_] as ShopCarItemInfo;
            if(_loc1_.isDiscount == 2)
            {
               return true;
            }
            _loc5_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _manTempList.length)
         {
            _loc1_ = _manTempList[_loc3_] as ShopCarItemInfo;
            if(_loc1_.isDiscount == 2)
            {
               return true;
            }
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _womanTempList.length)
         {
            _loc1_ = _womanTempList[_loc4_] as ShopCarItemInfo;
            if(_loc1_.isDiscount == 2)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function removeItem(param1:ShopCarItemInfo) : void
      {
         if(_carList.indexOf(param1) != -1)
         {
            _carList.splice(_carList.indexOf(param1),1);
            return;
         }
         var _loc5_:int = 0;
         var _loc4_:* = _manTempList;
         for each(var _loc2_ in _manTempList)
         {
            if(_loc2_.indexOf(param1) > -1)
            {
               if(_loc2_.length > 1)
               {
                  _loc2_.splice(_loc2_.indexOf(param1),1);
               }
               else
               {
                  _manTempList.splice(_manTempList.indexOf(_loc2_),1);
               }
            }
         }
         var _loc7_:int = 0;
         var _loc6_:* = _womanTempList;
         for each(var _loc3_ in _womanTempList)
         {
            if(_loc3_.indexOf(param1) > -1)
            {
               if(_loc3_.length > 1)
               {
                  _loc3_.splice(_loc3_.indexOf(param1),1);
               }
               else
               {
                  _womanTempList.splice(_womanTempList.indexOf(_loc3_),1);
               }
            }
         }
      }
      
      public function removeTempEquip(param1:ShopCarItemInfo) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:int = _manTempList.indexOf(param1);
         if(_loc3_ != -1)
         {
            _manTempList.splice(_loc3_,1);
            _loc2_ = _manModel;
         }
         else
         {
            _loc3_ = _womanTempList.indexOf(param1);
            if(_loc3_ != -1)
            {
               _womanTempList.splice(_loc3_,1);
               _loc2_ = _womanModel;
            }
         }
         if(_loc2_)
         {
            _loc4_ = _loc2_.Bag.items[param1.place];
            if(_loc4_)
            {
               if(_loc4_.CategoryID >= 1 && _loc4_.CategoryID <= 6 || param1.CategoryID == 13 || param1.CategoryID == 15)
               {
                  _loc2_.setPartStyle(param1.CategoryID,param1.TemplateInfo.NeedSex,_loc4_.TemplateID,_loc4_.Color);
               }
               if(param1.CategoryID == 6)
               {
                  _loc2_.Skin = _self.Skin;
               }
            }
            else if(EquipType.dressAble(param1.TemplateInfo))
            {
               _loc2_.setPartStyle(param1.CategoryID,param1.TemplateInfo.NeedSex);
               if(param1.CategoryID == 6)
               {
                  _loc2_.Skin = "";
               }
            }
            dispatchEvent(new ShopEvent("removetempequip",param1,_loc2_));
         }
         updateCost();
         param1.removeEventListener("change",__onItemChange);
         if(currentTempList.length > 0)
         {
            setSelectedEquip(currentTempList[currentTempList.length - 1]);
         }
      }
      
      public function restoreAllItemsOnBody() : void
      {
         var _loc1_:* = null;
         if(currentModel.Sex == _self.Sex && currentTempList.length > 0 || currentModel.Bag.items != _bodyThings)
         {
            _loc1_ = !!_sex?_manTempList:_womanTempList;
            _loc1_.splice(0,_loc1_.length);
            init();
            dispatchEvent(new ShopEvent("fittingmodelchange"));
            updateCost();
            dispatchEvent(new ShopEvent("updateCar"));
         }
      }
      
      public function revertToDefalt() : void
      {
         clearAllItemsOnBody();
         dispatchEvent(new ShopEvent("fittingmodelchange"));
         updateCost();
         dispatchEvent(new ShopEvent("updateCar"));
      }
      
      public function setSelectedEquip(param1:ShopCarItemInfo) : void
      {
         var _loc2_:* = null;
         if(param1 is ShopCarItemInfo)
         {
            _loc2_ = currentTempList;
            if(_loc2_.indexOf(param1) > -1)
            {
               _loc2_.splice(_loc2_.indexOf(param1),1);
               _loc2_.push(param1);
            }
            dispatchEvent(new ShopEvent("selectedequipchange",param1));
         }
      }
      
      public function get totalGift() : int
      {
         return _totalGift;
      }
      
      public function get totalGold() : int
      {
         return _totalGold;
      }
      
      public function get totalMedal() : int
      {
         return _totalMedal;
      }
      
      public function get totalMoney() : int
      {
         return _totalMoney;
      }
      
      public function updateCost() : void
      {
         _totalGold = 0;
         _totalMoney = 0;
         _totalGift = 0;
         _totalMedal = 0;
         var _loc1_:Array = calcPrices(_carList);
         _totalGold = _totalGold + _loc1_[0];
         _totalMoney = _totalMoney + _loc1_[1];
         _totalGift = _totalGift + _loc1_[2];
         _totalMedal = _totalMedal + _loc1_[3];
         _loc1_ = calcPrices(_womanTempList);
         _totalGold = _totalGold + _loc1_[0];
         _totalMoney = _totalMoney + _loc1_[1];
         _totalGift = _totalGift + _loc1_[2];
         _totalMedal = _totalMedal + _loc1_[3];
         _loc1_ = calcPrices(_manTempList);
         _totalGold = _totalGold + _loc1_[0];
         _totalMoney = _totalMoney + _loc1_[1];
         _totalGift = _totalGift + _loc1_[2];
         _totalMedal = _totalMedal + _loc1_[3];
         dispatchEvent(new ShopEvent("costChange"));
      }
      
      public function get womanModelInfo() : PlayerInfo
      {
         return _womanModel;
      }
      
      private function __bagChange(param1:BagEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc3_:Dictionary = param1.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = _loc3_;
         for each(var _loc5_ in _loc3_)
         {
            if(_loc5_.Place <= 30)
            {
               _loc4_ = true;
               break;
            }
         }
         if(!_loc4_)
         {
            return;
         }
         var _loc2_:PlayerInfo = !!_self.Sex?_manModel:_womanModel;
         if(_self.Sex)
         {
            _manModel.Bag.items = _self.Bag.items;
         }
         else
         {
            _womanModel.Bag.items = _self.Bag.items;
         }
         dispatchEvent(new ShopEvent("fittingmodelchange"));
      }
      
      private function __styleChange(param1:PlayerPropertyEvent) : void
      {
         var _loc2_:* = null;
         if(currentModel && param1.changedProperties["Style"])
         {
            _defaultModel = 1;
            _loc2_ = !!_self.Sex?_manModel:_womanModel;
            if(_self.Sex)
            {
               _manModel.updateStyle(_self.Sex,_self.Hide,_self.getPrivateStyle(),_self.Colors,_self.getSkinColor());
               _womanModel.updateStyle(false,2222222222,DEFAULT_WOMAN_STYLE,",,,,,,","");
               _manModel.Bag.items = _self.Bag.items;
            }
            else
            {
               _manModel.updateStyle(true,2222222222,DEFAULT_MAN_STYLE,",,,,,,","");
               _womanModel.updateStyle(_self.Sex,_self.Hide,_self.getPrivateStyle(),_self.Colors,_self.getSkinColor());
               _womanModel.Bag.items = _self.Bag.items;
            }
            dispatchEvent(new ShopEvent("fittingmodelchange"));
         }
      }
      
      private function clearAllItemsOnBody() : void
      {
         saveTriedList();
         currentModel.Bag.items = new DictionaryData();
         var _loc1_:Array = !!_sex?_manTempList:_womanTempList;
         _loc1_.splice(0,_loc1_.length);
         if(currentModel.Sex)
         {
            currentModel.updateStyle(true,2222222222,DEFAULT_MAN_STYLE,",,,,,,","");
         }
         else
         {
            currentModel.updateStyle(false,2222222222,DEFAULT_WOMAN_STYLE,",,,,,,","");
         }
      }
      
      private function fillToShopCarInfo(param1:ShopItemInfo) : ShopCarItemInfo
      {
         var _loc2_:ShopCarItemInfo = new ShopCarItemInfo(param1.GoodsID,param1.TemplateID);
         ObjectUtils.copyProperties(_loc2_,param1);
         return _loc2_;
      }
      
      private function findEquip(param1:Number, param2:Array) : int
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param2.length)
         {
            if(param2[_loc3_].TemplateID == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function init() : void
      {
         initBodyThing();
         if(_self.Sex)
         {
            if(_defaultModel == 1)
            {
               _manModel.updateStyle(_self.Sex,_self.Hide,_self.getPrivateStyle(),_self.Colors,_self.getSkinColor());
               _manModel.Bag.items = _bodyThings;
            }
            else
            {
               _manModel.updateStyle(true,2222222222,DEFAULT_MAN_STYLE,",,,,,,","");
               _manModel.Bag.items = new DictionaryData();
            }
            _womanModel.updateStyle(false,2222222222,DEFAULT_WOMAN_STYLE,",,,,,,","");
         }
         else
         {
            _manModel.updateStyle(true,2222222222,DEFAULT_MAN_STYLE,",,,,,,","");
            if(_defaultModel == 1)
            {
               _womanModel.updateStyle(_self.Sex,_self.Hide,_self.getPrivateStyle(),_self.Colors,_self.getSkinColor());
               _womanModel.Bag.items = _bodyThings;
            }
            else
            {
               _womanModel.updateStyle(false,2222222222,DEFAULT_WOMAN_STYLE,",,,,,,","");
               _womanModel.Bag.items = new DictionaryData();
            }
         }
         dispatchEvent(new ShopEvent("fittingmodelchange"));
      }
      
      private function initBodyThing() : void
      {
         _bodyThings = new DictionaryData();
         var _loc3_:int = 0;
         var _loc2_:* = _self.Bag.items;
         for each(var _loc1_ in _self.Bag.items)
         {
            if(_loc1_.Place <= 30)
            {
               _bodyThings.add(_loc1_.Place,_loc1_);
            }
         }
      }
      
      private function saveTriedList() : void
      {
         if(currentModel.Sex)
         {
            _manMemoryList = currentTempList.concat();
         }
         else
         {
            _womanMemoryList = currentTempList.concat();
         }
      }
      
      public function getBagItems(param1:int, param2:Boolean = false) : int
      {
         var _loc3_:Array = [0,2,4,11,1,3,5,13];
         if(!param2)
         {
            return _loc3_[param1] != null?_loc3_[param1]:-1;
         }
         return _loc3_.indexOf(param1);
      }
   }
}
