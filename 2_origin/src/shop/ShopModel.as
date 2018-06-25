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
         var arr:* = null;
         var i:int = 0;
         var arr1:* = null;
         var index:int = 0;
         var list:Array = !!_sex?_manTempList:_womanTempList;
         if(currentHistoryList.length > 0)
         {
            arr = currentHistoryList.pop();
            var _loc10_:int = 0;
            var _loc9_:* = arr;
            for each(var item in arr)
            {
               removeTempEquip(item);
            }
         }
         var result:Array = [];
         for(i = currentHistoryList.length - 1; i > -1; )
         {
            arr1 = currentHistoryList[i];
            var _loc12_:int = 0;
            var _loc11_:* = arr1;
            for each(var shopitem in arr1)
            {
               index = currentTempListHasItem(shopitem.TemplateInfo.CategoryID);
               if(index <= -1)
               {
                  currentTempList.push(shopitem);
                  dispatchEvent(new ShopEvent("addTempEquip",shopitem));
                  shopitem.addEventListener("change",__onItemChange);
               }
            }
            i--;
         }
         updateCost();
      }
      
      private function currentTempListHasItem(categoryID:int) : int
      {
         var items:Array = currentTempList;
         var _loc5_:int = 0;
         var _loc4_:* = items;
         for each(var item in items)
         {
            if(item.TemplateInfo.CategoryID == categoryID)
            {
               return items.indexOf(item);
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
         var index:int = 0;
         var list:Array = !!_sex?maleCollocation:femaleCollocation;
         var result:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = list;
         for each(var vect in list)
         {
            index = Math.floor(Math.random() * vect.length);
            result.push(fillToShopCarInfo(vect[index]));
         }
         addTempEquip(result);
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
      
      public function addTempEquip(item:*) : Boolean
      {
         var items:* = null;
         var history:* = null;
         var index:int = 0;
         var t:* = null;
         var index1:int = 0;
         var tt:* = null;
         var cantAdd:Boolean = isCarListMax();
         if(cantAdd)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.car"));
            return cantAdd;
         }
         if(item is Array)
         {
            items = item as Array;
            history = [];
            var _loc11_:int = 0;
            var _loc10_:* = items;
            for each(var shopitem in items)
            {
               index = currentTempListHasItem(shopitem.TemplateInfo.CategoryID);
               if(index > -1)
               {
                  currentTempList.splice(index,1);
               }
               t = fillToShopCarInfo(shopitem);
               t.dressing = true;
               t.ModelSex = currentModel.Sex;
               currentTempList.push(t);
               dispatchEvent(new ShopEvent("addTempEquip",t));
               updateCost();
               t.addEventListener("change",__onItemChange);
               history.push(t);
            }
            currentHistoryList.push(history);
         }
         else
         {
            index1 = currentTempListHasItem(item.TemplateInfo.CategoryID);
            if(index1 > -1)
            {
               currentTempList.splice(index1,1);
            }
            tt = fillToShopCarInfo(item);
            tt.dressing = true;
            tt.ModelSex = currentModel.Sex;
            currentTempList.push(tt);
            dispatchEvent(new ShopEvent("addTempEquip",tt));
            updateCost();
            tt.addEventListener("change",__onItemChange);
            currentHistoryList.push([tt]);
         }
         return !cantAdd;
      }
      
      public function addToShoppingCar(item:ShopCarItemInfo) : void
      {
         if(isCarListMax())
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.car"));
            return;
         }
         if(isOverCount(item))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.GoodsNumberLimit"));
            return;
         }
         _carList.push(item);
         updateCost();
         item.addEventListener("change",__onItemChange);
         dispatchEvent(new ShopEvent("addcarequip",item));
      }
      
      private function __onItemChange(evt:Event) : void
      {
         updateCost();
      }
      
      public function isOverCount(info:ShopItemInfo) : Boolean
      {
         var i:int = 0;
         var item:* = null;
         var count:uint = 0;
         var arr:Array = allItems;
         for(i = 0; i < arr.length; )
         {
            item = arr[i] as ShopCarItemInfo;
            if(info.TemplateID == item.TemplateID)
            {
               count++;
            }
            i++;
         }
         return count >= info.LimitCount && info.LimitCount != -1?true:false;
      }
      
      public function get allItems() : Array
      {
         return _carList.concat(_manTempList).concat(_womanTempList);
      }
      
      public function get allItemsCount() : int
      {
         return _carList.length + _manTempList.length + _womanTempList.length;
      }
      
      public function calcPrices(list:Array, list2:Array = null) : Array
      {
         var i:int = 0;
         var totalPrice:ItemPrice = new ItemPrice(null,null,null);
         var g:int = 0;
         var m:int = 0;
         var l:int = 0;
         var b:int = 0;
         for(i = 0; i < list.length; )
         {
            if(list2)
            {
               if(list2[i])
               {
                  totalPrice.addItemPrice(list[i].getCurrentPrice(),list2[i]);
               }
               else
               {
                  totalPrice.addItemPrice(list[i].getCurrentPrice());
               }
            }
            else
            {
               totalPrice.addItemPrice(list[i].getCurrentPrice());
            }
            i++;
         }
         g = totalPrice.goldValue;
         m = totalPrice.bothMoneyValue;
         l = totalPrice.ddtMoneyValue;
         b = totalPrice.bandDdtMoneyValue;
         return [g,m,l,b];
      }
      
      public function canBuyLeastOneGood(array:Array) : Boolean
      {
         return ShopManager.Instance.buyLeastGood(array,_self);
      }
      
      public function canChangSkin() : Boolean
      {
         var i:int = 0;
         var list:Array = currentTempList;
         for(i = 0; i < list.length; )
         {
            if(list[i].CategoryID == 6)
            {
               return true;
            }
            i++;
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
      
      public function clearCurrentTempList(sex:int = 0) : void
      {
         var list:* = null;
         if(sex == 0)
         {
            list = !!_sex?_manTempList:_womanTempList;
            list.splice(0,list.length);
         }
         else if(sex == 1)
         {
            _manTempList.splice(0,_manTempList.length);
         }
         else if(sex == 2)
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
         var temp:Array = calcPrices(currentTempList);
         _currentGift = temp[2];
         return _currentGift;
      }
      
      public function get currentGold() : int
      {
         var temp:Array = calcPrices(currentTempList);
         _currentGold = temp[0];
         return _currentGold;
      }
      
      public function get currentLeftList() : Array
      {
         return !!_sex?leftManList:leftWomanList;
      }
      
      public function get currentMedal() : int
      {
         var temp:Array = calcPrices(currentTempList);
         _currentMedal = temp[3];
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
         var temp:Array = calcPrices(currentTempList);
         _currentMoney = temp[1];
         return _currentMoney;
      }
      
      public function get currentSkin() : String
      {
         var i:int = 0;
         var list:Array = currentTempList;
         for(i = 0; i < list.length; )
         {
            if(list[i].CategoryID == 6)
            {
               return list[i].skin;
            }
            i++;
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
      
      public function set fittingSex(value:Boolean) : void
      {
         var shopEvt:* = null;
         if(_sex != value)
         {
            _sex = value;
            shopEvt = new ShopEvent("fittingmodelchange","sexChange");
            dispatchEvent(shopEvt);
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
      
      public function removeFromShoppingCar(item:ShopCarItemInfo) : void
      {
         removeTempEquip(item);
         var index:int = _carList.indexOf(item);
         if(index != -1)
         {
            _carList.splice(index,1);
            updateCost();
            item.removeEventListener("change",__onItemChange);
            dispatchEvent(new ShopEvent("removecarequip",item));
         }
      }
      
      public function checkPoint() : Boolean
      {
         var item:* = null;
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         for(var len:int = _carList.length; i < len; )
         {
            item = _carList[i] as ShopCarItemInfo;
            if(item.getCurrentPrice().ddtMoneyValue > 0 || isBandList[i])
            {
               return true;
            }
            i++;
         }
         for(j = 0; j < _manTempList.length; )
         {
            item = _manTempList[j] as ShopCarItemInfo;
            if(item.getCurrentPrice().ddtMoneyValue > 0 || isBandList[j])
            {
               return true;
            }
            j++;
         }
         for(k = 0; k < _womanTempList.length; )
         {
            item = _womanTempList[k] as ShopCarItemInfo;
            if(item.getCurrentPrice().ddtMoneyValue > 0 || isBandList[j])
            {
               return true;
            }
            k++;
         }
         return false;
      }
      
      public function checkDiscount() : Boolean
      {
         var item:* = null;
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         for(var len:int = _carList.length; i < len; )
         {
            item = _carList[i] as ShopCarItemInfo;
            if(item.isDiscount == 2)
            {
               return true;
            }
            i++;
         }
         for(j = 0; j < _manTempList.length; )
         {
            item = _manTempList[j] as ShopCarItemInfo;
            if(item.isDiscount == 2)
            {
               return true;
            }
            j++;
         }
         for(k = 0; k < _womanTempList.length; )
         {
            item = _womanTempList[k] as ShopCarItemInfo;
            if(item.isDiscount == 2)
            {
               return true;
            }
            k++;
         }
         return false;
      }
      
      public function removeItem(item:ShopCarItemInfo) : void
      {
         if(_carList.indexOf(item) != -1)
         {
            _carList.splice(_carList.indexOf(item),1);
            return;
         }
         var _loc5_:int = 0;
         var _loc4_:* = _manTempList;
         for each(var arr in _manTempList)
         {
            if(arr.indexOf(item) > -1)
            {
               if(arr.length > 1)
               {
                  arr.splice(arr.indexOf(item),1);
               }
               else
               {
                  _manTempList.splice(_manTempList.indexOf(arr),1);
               }
            }
         }
         var _loc7_:int = 0;
         var _loc6_:* = _womanTempList;
         for each(var arr1 in _womanTempList)
         {
            if(arr1.indexOf(item) > -1)
            {
               if(arr1.length > 1)
               {
                  arr1.splice(arr1.indexOf(item),1);
               }
               else
               {
                  _womanTempList.splice(_womanTempList.indexOf(arr1),1);
               }
            }
         }
      }
      
      public function removeTempEquip(item:ShopCarItemInfo) : void
      {
         var model:* = null;
         var oldItem:* = null;
         var index:int = _manTempList.indexOf(item);
         if(index != -1)
         {
            _manTempList.splice(index,1);
            model = _manModel;
         }
         else
         {
            index = _womanTempList.indexOf(item);
            if(index != -1)
            {
               _womanTempList.splice(index,1);
               model = _womanModel;
            }
         }
         if(model)
         {
            oldItem = model.Bag.items[item.place];
            if(oldItem)
            {
               if(oldItem.CategoryID >= 1 && oldItem.CategoryID <= 6 || item.CategoryID == 13 || item.CategoryID == 15)
               {
                  model.setPartStyle(item.CategoryID,item.TemplateInfo.NeedSex,oldItem.TemplateID,oldItem.Color);
               }
               if(item.CategoryID == 6)
               {
                  model.Skin = _self.Skin;
               }
            }
            else if(EquipType.dressAble(item.TemplateInfo))
            {
               model.setPartStyle(item.CategoryID,item.TemplateInfo.NeedSex);
               if(item.CategoryID == 6)
               {
                  model.Skin = "";
               }
            }
            dispatchEvent(new ShopEvent("removetempequip",item,model));
         }
         updateCost();
         item.removeEventListener("change",__onItemChange);
         if(currentTempList.length > 0)
         {
            setSelectedEquip(currentTempList[currentTempList.length - 1]);
         }
      }
      
      public function restoreAllItemsOnBody() : void
      {
         var list:* = null;
         if(currentModel.Sex == _self.Sex && currentTempList.length > 0 || currentModel.Bag.items != _bodyThings)
         {
            list = !!_sex?_manTempList:_womanTempList;
            list.splice(0,list.length);
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
      
      public function setSelectedEquip(item:ShopCarItemInfo) : void
      {
         var list:* = null;
         if(item is ShopCarItemInfo)
         {
            list = currentTempList;
            if(list.indexOf(item) > -1)
            {
               list.splice(list.indexOf(item),1);
               list.push(item);
            }
            dispatchEvent(new ShopEvent("selectedequipchange",item));
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
         var temp:Array = calcPrices(_carList);
         _totalGold = _totalGold + temp[0];
         _totalMoney = _totalMoney + temp[1];
         _totalGift = _totalGift + temp[2];
         _totalMedal = _totalMedal + temp[3];
         temp = calcPrices(_womanTempList);
         _totalGold = _totalGold + temp[0];
         _totalMoney = _totalMoney + temp[1];
         _totalGift = _totalGift + temp[2];
         _totalMedal = _totalMedal + temp[3];
         temp = calcPrices(_manTempList);
         _totalGold = _totalGold + temp[0];
         _totalMoney = _totalMoney + temp[1];
         _totalGift = _totalGift + temp[2];
         _totalMedal = _totalMedal + temp[3];
         dispatchEvent(new ShopEvent("costChange"));
      }
      
      public function get womanModelInfo() : PlayerInfo
      {
         return _womanModel;
      }
      
      private function __bagChange(evt:BagEvent) : void
      {
         var shouldUpdate:Boolean = false;
         var items:Dictionary = evt.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = items;
         for each(var item in items)
         {
            if(item.Place <= 30)
            {
               shouldUpdate = true;
               break;
            }
         }
         if(!shouldUpdate)
         {
            return;
         }
         var model:PlayerInfo = !!_self.Sex?_manModel:_womanModel;
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
      
      private function __styleChange(evt:PlayerPropertyEvent) : void
      {
         var model:* = null;
         if(currentModel && evt.changedProperties["Style"])
         {
            _defaultModel = 1;
            model = !!_self.Sex?_manModel:_womanModel;
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
         var list:Array = !!_sex?_manTempList:_womanTempList;
         list.splice(0,list.length);
         if(currentModel.Sex)
         {
            currentModel.updateStyle(true,2222222222,DEFAULT_MAN_STYLE,",,,,,,","");
         }
         else
         {
            currentModel.updateStyle(false,2222222222,DEFAULT_WOMAN_STYLE,",,,,,,","");
         }
      }
      
      private function fillToShopCarInfo(item:ShopItemInfo) : ShopCarItemInfo
      {
         var t:ShopCarItemInfo = new ShopCarItemInfo(item.GoodsID,item.TemplateID);
         ObjectUtils.copyProperties(t,item);
         return t;
      }
      
      private function findEquip(id:Number, list:Array) : int
      {
         var i:int = 0;
         for(i = 0; i < list.length; )
         {
            if(list[i].TemplateID == id)
            {
               return i;
            }
            i++;
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
         for each(var item in _self.Bag.items)
         {
            if(item.Place <= 30)
            {
               _bodyThings.add(item.Place,item);
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
      
      public function getBagItems($id:int, $isIndex:Boolean = false) : int
      {
         var numArr:Array = [0,2,4,11,1,3,5,13];
         if(!$isIndex)
         {
            return numArr[$id] != null?numArr[$id]:-1;
         }
         return numArr.indexOf($id);
      }
   }
}
