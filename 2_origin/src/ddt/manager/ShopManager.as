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
      
      public function ShopManager(singleton:SingletonEnfocer)
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
      
      public function setup(analyzer:ShopItemAnalyzer) : void
      {
         _shopGoods = analyzer.shopinfolist;
         initialized = true;
         SocketManager.Instance.addEventListener(PkgEvent.format(168),__updateGoodsCount);
         SocketManager.Instance.addEventListener(PkgEvent.format(109),__updateGoodsDisCount);
         SocketManager.Instance.addEventListener(PkgEvent.format(288),__shopBuyLimitedCountHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(528),__syncLimitShopList);
      }
      
      private function __syncLimitShopList(evt:PkgEvent) : void
      {
         var i:int = 0;
         var shopType:int = evt.pkg.readInt();
         var size:int = evt.pkg.readInt();
         var goodId:int = 0;
         var goodInfo:ShopItemInfo = null;
         for(i = 0; i < size; )
         {
            goodId = evt.pkg.readInt();
            goodInfo = getShopItemByGoodsID(goodId);
            if(goodInfo)
            {
               goodInfo.personalBuyCnt = Math.max(0,goodInfo.LimitPersonalCount - evt.pkg.readInt());
            }
            else
            {
               evt.pkg.readInt();
            }
            i++;
         }
         dispatchEvent(new CEvent("updatePersonalLimitShop",shopType));
      }
      
      public function updateShopGoods(analyzer:ShopItemAnalyzer) : void
      {
         _shopGoods = analyzer.shopinfolist;
      }
      
      public function sortShopItems(analyzer:ShopItemSortAnalyzer) : void
      {
         _shopSortList = analyzer.shopSortedGoods;
      }
      
      private function __shopBuyLimitedCountHandler(evt:PkgEvent) : void
      {
         var i:int = 0;
         var id:int = 0;
         var count:int = 0;
         var pkg:PackageIn = evt.pkg;
         var length:int = pkg.readInt();
         if(length > 0)
         {
            for(i = 0; i < length; )
            {
               id = pkg.readInt();
               count = pkg.readInt();
               if(_shopGoods[id])
               {
                  ShopItemInfo(_shopGoods[id]).LimitAreaCount = count;
               }
               i++;
            }
            dispatchEvent(new ShopEvent("updataLimitAreaCount"));
         }
      }
      
      public function getResultPages(type:int, count:int = 8) : int
      {
         var list:Vector.<ShopItemInfo> = getValidGoodByType(type);
         var totlaPage:int = Math.ceil(list.length / count);
         return totlaPage;
      }
      
      public function buyIt(list:Array) : Array
      {
         var self:SelfInfo = PlayerManager.Instance.Self;
         var buyedArr:Array = [];
         var selfGold:int = self.Gold;
         var selfMoney:int = self.Money;
         var selfDDTMoney:int = self.BandMoney;
         var _loc9_:int = 0;
         var _loc8_:* = list;
         for each(var item in list)
         {
            buyedArr.push(item);
         }
         return buyedArr;
      }
      
      public function giveGift(list:Array, self:SelfInfo) : Array
      {
         var itemPrice:* = null;
         var giftArray:Array = [];
         var money:int = self.Money;
         var _loc8_:int = 0;
         var _loc7_:* = list;
         for each(var item in list)
         {
            itemPrice = item.getItemPrice(item.currentBuyType);
            if(money >= itemPrice.bothMoneyValue && itemPrice.bandDdtMoneyValue == 0 && itemPrice.goldValue == 0)
            {
               money = money - itemPrice.bothMoneyValue;
               giftArray.push(item);
            }
         }
         return giftArray;
      }
      
      private function __updateGoodsCount(evt:PkgEvent) : void
      {
         var i:int = 0;
         var goodsID:int = 0;
         var count:int = 0;
         var item:* = null;
         var j:int = 0;
         var goodsID2:int = 0;
         var count2:int = 0;
         var item2:* = null;
         var pkg:PackageIn = evt.pkg;
         var type:int = StateManager.currentStateType == "consortia"?2:1;
         var len:int = pkg.readInt();
         for(i = 0; i < len; )
         {
            goodsID = pkg.readInt();
            count = pkg.readInt();
            item = getShopItemByGoodsID(goodsID);
            if(item && type == 1)
            {
               item.LimitCount = count;
            }
            i++;
         }
         var consortiaID:int = pkg.readInt();
         var len2:int = pkg.readInt();
         for(j = 0; j < len2; )
         {
            goodsID2 = pkg.readInt();
            count2 = pkg.readInt();
            item2 = getShopItemByGoodsID(goodsID2);
            if(item2 && type == 2 && consortiaID == PlayerManager.Instance.Self.ConsortiaID)
            {
               item2.LimitCount = count2;
            }
            j++;
         }
         var playerId:int = pkg.readInt();
         GemstoneManager.Instance.upDataFitCount();
      }
      
      public function getShopItemByGoodsID(id:int) : ShopItemInfo
      {
         var info:* = null;
         var item:ShopItemInfo = _shopGoods[id];
         if(item != null)
         {
            return item;
         }
         var _loc6_:int = 0;
         var _loc5_:* = _shopRealTimesDisCountGoods;
         for each(var result in _shopRealTimesDisCountGoods)
         {
            info = result[id];
            if(info != null && info.isValid)
            {
               return info;
            }
         }
         return null;
      }
      
      public function getValidSortedGoodsByType(type:int, page:int, count:int = 8) : Vector.<ShopItemInfo>
      {
         var startIndex:int = 0;
         var len:int = 0;
         var i:int = 0;
         var result:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         var list:Vector.<ShopItemInfo> = getValidGoodByType(type);
         var totlaPage:int = Math.ceil(list.length / count);
         if(page > 0 && page <= totlaPage)
         {
            startIndex = 0 + count * (page - 1);
            len = Math.min(list.length - startIndex,count);
            for(i = 0; i < len; )
            {
               result.push(list[startIndex + i]);
               i++;
            }
         }
         return result;
      }
      
      public function getValidSortedGoodsByList(list:Vector.<ShopItemInfo>, page:int, count:int = 8) : Vector.<ShopItemInfo>
      {
         var startIndex:int = 0;
         var len:int = 0;
         var i:int = 0;
         var result:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         var totlaPage:int = Math.ceil(list.length / count);
         if(page > 0 && page <= totlaPage)
         {
            startIndex = 0 + count * (page - 1);
            len = Math.min(list.length - startIndex,count);
            for(i = 0; i < len; )
            {
               result.push(list[startIndex + i]);
               i++;
            }
         }
         return result;
      }
      
      public function getGoodsByType(type:int) : Vector.<ShopItemInfo>
      {
         return _shopSortList[type] as Vector.<ShopItemInfo>;
      }
      
      public function getValidGoodByType(type:int) : Vector.<ShopItemInfo>
      {
         var result:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         var list:Vector.<ShopItemInfo> = _shopSortList[type];
         var _loc6_:int = 0;
         var _loc5_:* = list;
         for each(var item in list)
         {
            if(item.isValid)
            {
               result.push(item);
            }
         }
         return result;
      }
      
      public function getValidGoodsArrayByType(type:int) : Array
      {
         var result:Array = [];
         var list:Vector.<ShopItemInfo> = _shopSortList[type];
         var _loc6_:int = 0;
         var _loc5_:* = list;
         for each(var item in list)
         {
            if(item.isValid)
            {
               result.push(item);
            }
         }
         return result;
      }
      
      public function consortiaShopLevelTemplates(level:int) : Vector.<ShopItemInfo>
      {
         return _shopSortList[80 + level - 1] as Vector.<ShopItemInfo>;
      }
      
      public function canAddPrice(templateID:int) : Boolean
      {
         if(!getGoodsByTemplateIDOnlyUseXuFei(templateID) || !getGoodsByTemplateIDOnlyUseXuFei(templateID).IsContinue)
         {
            return false;
         }
         if(getShopRechargeItemByTemplateId(templateID).length <= 0)
         {
            return false;
         }
         return true;
      }
      
      public function getShopRechargeItemByTemplateId(id:int) : Array
      {
         var result:Array = [];
         var _loc11_:int = 0;
         var _loc10_:* = _shopGoods;
         for each(var item5 in _shopGoods)
         {
            if(item5.TemplateID == id && item5.getItemPrice(1).armShellClipValue > 0 && item5.IsContinue)
            {
               result.push(item5);
            }
         }
         var _loc13_:int = 0;
         var _loc12_:* = _shopGoods;
         for each(var item0 in _shopGoods)
         {
            if(item0.TemplateID == id && item0.getItemPrice(1).bothMoneyValue > 0 && item0.IsContinue)
            {
               result.push(item0);
            }
         }
         var _loc15_:int = 0;
         var _loc14_:* = _shopGoods;
         for each(var item1 in _shopGoods)
         {
            if(item1.TemplateID == id && item1.getItemPrice(1).moneyValue > 0 && item1.IsContinue)
            {
               result.push(item1);
            }
         }
         var _loc17_:int = 0;
         var _loc16_:* = _shopGoods;
         for each(var item2 in _shopGoods)
         {
            if(item2.TemplateID == id && item2.getItemPrice(1).bandDdtMoneyValue > 0 && item2.IsContinue)
            {
               result.push(item2);
            }
         }
         var _loc19_:int = 0;
         var _loc18_:* = _shopGoods;
         for each(var item3 in _shopGoods)
         {
            if(item3.TemplateID == id && item3.getItemPrice(1).lightStoneValue > 0 && item3.IsContinue)
            {
               result.push(item3);
            }
         }
         var _loc21_:int = 0;
         var _loc20_:* = _shopGoods;
         for each(var item4 in _shopGoods)
         {
            if(item4.TemplateID == id && item4.getItemPrice(1).leagueValue > 0 && item4.IsContinue)
            {
               result.push(item4);
            }
         }
         var _loc23_:int = 0;
         var _loc22_:* = _shopGoods;
         for each(var item6 in _shopGoods)
         {
            if(item6.TemplateID == id && item6.getItemPrice(1).ddtMoneyValue > 0 && item6.IsContinue)
            {
               result.push(item6);
            }
         }
         return result;
      }
      
      public function getShopItemByTemplateID(id:int, type:int) : ShopItemInfo
      {
         var item:* = null;
         switch(int(type) - 1)
         {
            case 0:
               var _loc5_:int = 0;
               var _loc4_:* = _shopGoods;
               for each(item in _shopGoods)
               {
                  if(item.TemplateID == id && item.getItemPrice(1).hardCurrencyValue > 0)
                  {
                     if(item.isValid)
                     {
                        return item;
                     }
                  }
               }
            case 1:
               var _loc7_:int = 0;
               var _loc6_:* = _shopGoods;
               for each(item in _shopGoods)
               {
                  if(item.TemplateID == id && item.getItemPrice(1).gesteValue > 0)
                  {
                     if(item.isValid)
                     {
                        return item;
                     }
                  }
               }
            case 2:
               return getMoneyShopItemByTemplateID(id);
            case 3:
               var _loc9_:int = 0;
               var _loc8_:* = _shopGoods;
               for each(item in _shopGoods)
               {
                  if(item.TemplateID == id && item.getItemPrice(1).leagueValue > 0)
                  {
                     if(item.isValid)
                     {
                        return item;
                     }
                  }
               }
            case 4:
               var _loc11_:int = 0;
               var _loc10_:* = _shopGoods;
               for each(item in _shopGoods)
               {
                  if(item.TemplateID == id && item.getItemPrice(1).scoreValue > 0)
                  {
                     if(item.isValid)
                     {
                        return item;
                     }
                  }
               }
            case 5:
               var _loc13_:int = 0;
               var _loc12_:* = _shopGoods;
               for each(item in _shopGoods)
               {
                  if(item.TemplateID == id)
                  {
                     if(item.getItemPrice(1).badgeValue > 0 && item.isValid)
                     {
                        return item;
                     }
                  }
               }
         }
      }
      
      public function getMoneyShopItemByTemplateID(id:int, shouldInShop:Boolean = false) : ShopItemInfo
      {
         var types:* = null;
         var shopitems:* = undefined;
         var list:* = undefined;
         if(shouldInShop)
         {
            types = getType(ShopType.MALE_MONEY_TYPE).concat(getType(ShopType.FEMALE_MONEY_TYPE)).concat(getType(ShopType.FEMALE_DDTMONEY_TYPE)).concat(getType(ShopType.MALE_DDTMONEY_TYPE));
            var _loc12_:int = 0;
            var _loc11_:* = types;
            for each(var type in types)
            {
               shopitems = getValidGoodByType(type);
               var _loc10_:int = 0;
               var _loc9_:* = shopitems;
               for each(var item in shopitems)
               {
                  if(item.TemplateID == id && item.getItemPrice(1).bothMoneyValue > 0)
                  {
                     return item;
                  }
               }
            }
         }
         else
         {
            list = new Vector.<ShopItemInfo>();
            var _loc14_:int = 0;
            var _loc13_:* = _shopGoods;
            for each(var item1 in _shopGoods)
            {
               if(item1.TemplateID == id && item1.getItemPrice(1).bothMoneyValue > 0 && item1.isValid)
               {
                  list.push(item1);
               }
            }
            if(list.length > 0)
            {
               return getInfoByBuyType(list);
            }
         }
         return null;
      }
      
      private function getInfoByBuyType(list:Vector.<ShopItemInfo>) : ShopItemInfo
      {
         var i:int = 0;
         var j:int = 0;
         var info:ShopItemInfo = null;
         for(i = 0,j = 0; i < list.length; )
         {
            j = i - 1;
            info = list[i];
            while(j >= 0 && info.ShopID < list[j].ShopID)
            {
               list[j + 1] = list[j];
               j--;
            }
            list[j + 1] = info;
            i++;
         }
         return list[0];
      }
      
      public function getMoneyShopItemByTemplateIDForGiftSystem(id:int) : ShopItemInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _shopGoods;
         for each(var item in _shopGoods)
         {
            if(item.TemplateID == id)
            {
               return item;
            }
         }
         return null;
      }
      
      public function getBuriedGoodsList() : Vector.<ShopItemInfo>
      {
         var list:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         var _loc4_:int = 0;
         var _loc3_:* = _shopGoods;
         for each(var item in _shopGoods)
         {
            if(item.ShopID == 94)
            {
               list.push(item);
            }
         }
         return list;
      }
      
      private function getGoodsByTemplateIDOnlyUseXuFei(id:int) : ShopItemInfo
      {
         var i:int = 0;
         var itemArr:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         var _loc6_:int = 0;
         var _loc5_:* = _shopGoods;
         for each(var item in _shopGoods)
         {
            if(item.TemplateID == id)
            {
               itemArr.push(item);
            }
         }
         for(i = 0; i < itemArr.length; )
         {
            if(itemArr[i].IsContinue)
            {
               return itemArr[i];
            }
            i++;
         }
         return null;
      }
      
      public function getGoodsByTemplateID(id:int, shopID:int = -1) : ShopItemInfo
      {
         var _loc5_:int = 0;
         var _loc4_:* = _shopGoods;
         for each(var item in _shopGoods)
         {
            if(item.TemplateID == id)
            {
               if(shopID == -1 || item.ShopID == shopID)
               {
                  return item;
               }
            }
         }
         return null;
      }
      
      public function getShopItemByTemplateIdAndType(id:int, type:int) : ShopItemInfo
      {
         var _loc5_:int = 0;
         var _loc4_:* = _shopSortList[type];
         for each(var item in _shopSortList[type])
         {
            if(item.TemplateID == id)
            {
               return item;
            }
         }
         return null;
      }
      
      public function getGiftShopItemByTemplateID(id:int, shouldInShop:Boolean = false) : ShopItemInfo
      {
         var types:* = null;
         var shopitems:* = undefined;
         if(shouldInShop)
         {
            types = getType(ShopType.MALE_MONEY_TYPE).concat(getType(ShopType.FEMALE_MONEY_TYPE)).concat(getType(ShopType.FEMALE_DDTMONEY_TYPE)).concat(getType(ShopType.MALE_DDTMONEY_TYPE));
            var _loc11_:int = 0;
            var _loc10_:* = types;
            for each(var type in types)
            {
               shopitems = getValidGoodByType(type);
               var _loc9_:int = 0;
               var _loc8_:* = shopitems;
               for each(var item in shopitems)
               {
                  if(item.TemplateID == id)
                  {
                     if(item.getItemPrice(1).ddtMoneyValue > 0)
                     {
                        return item;
                     }
                  }
               }
            }
         }
         else
         {
            var _loc13_:int = 0;
            var _loc12_:* = _shopGoods;
            for each(var item1 in _shopGoods)
            {
               if(item1.TemplateID == id && item1.getItemPrice(1).ddtMoneyValue > 0)
               {
                  if(item1.isValid)
                  {
                     return item1;
                  }
               }
            }
         }
         return null;
      }
      
      private function getType(type:*) : Array
      {
         var result:Array = [];
         if(type is Array)
         {
            var _loc5_:int = 0;
            var _loc4_:* = type;
            for each(var t in type)
            {
               result = result.concat(getType(t));
            }
         }
         else
         {
            result.push(type);
         }
         return result;
      }
      
      public function getGoldShopItemByTemplateID(id:int) : ShopItemInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _shopSortList[90];
         for each(var item in _shopSortList[90])
         {
            if(item.TemplateID == id)
            {
               if(item.isValid)
               {
                  return item;
               }
            }
         }
         return null;
      }
      
      public function moneyGoods(list:Array, self:SelfInfo) : Array
      {
         var itemPrice:* = null;
         var moneyGoods:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = list;
         for each(var item in list)
         {
            itemPrice = item.getItemPrice(item.currentBuyType);
            if(itemPrice.bothMoneyValue > 0)
            {
               moneyGoods.push(item);
            }
         }
         return moneyGoods;
      }
      
      public function buyLeastGood(list:Array, self:SelfInfo) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var item in list)
         {
            if(self.Gold >= item.getItemPrice(item.currentBuyType).goldValue && self.Money >= item.getItemPrice(item.currentBuyType).bothMoneyValue && self.BandMoney >= item.getItemPrice(item.currentBuyType).bothMoneyValue && self.Money >= item.getItemPrice(item.currentBuyType).moneyValue && self.BandMoney >= item.getItemPrice(item.currentBuyType).bandDdtMoneyValue && self.DDTMoney >= item.getItemPrice(item.currentBuyType).ddtMoneyValue)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getDesignatedAllShopItem() : Vector.<ShopItemInfo>
      {
         var i:int = 0;
         var type:int = 0;
         var result:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         for(i = 0; i < ShopType.CAN_SHOW_IN_SHOP.length; )
         {
            type = ShopType.CAN_SHOW_IN_SHOP[i];
            if(_shopSortList[type])
            {
               result = result.concat(_shopSortList[type]);
            }
            i++;
         }
         return result;
      }
      
      public function fuzzySearch($ShopItemList:Vector.<ShopItemInfo>, $shopName:String) : Vector.<ShopItemInfo>
      {
         var indexId:int = 0;
         var boole:Boolean = false;
         var result:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         var _loc11_:int = 0;
         var _loc10_:* = $ShopItemList;
         for each(var item in $ShopItemList)
         {
            if(item.isValid && item.TemplateInfo)
            {
               indexId = item.TemplateInfo.Name.indexOf($shopName);
               if(indexId > -1)
               {
                  boole = true;
                  var _loc9_:int = 0;
                  var _loc8_:* = result;
                  for each(var info in result)
                  {
                     if(info.GoodsID == item.GoodsID)
                     {
                        boole = false;
                     }
                  }
                  if(boole)
                  {
                     result.push(item);
                  }
               }
            }
         }
         return result;
      }
      
      public function getDisCountValidGoodByType(type:int) : Vector.<ShopItemInfo>
      {
         var list:* = null;
         var result:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         if(type != 1)
         {
            list = _shopRealTimesDisCountGoods[type];
            if(list)
            {
               var _loc9_:int = 0;
               var _loc8_:* = list.list;
               for each(var item in list.list)
               {
                  if(item.isValid && item.TemplateInfo.CategoryID != 25)
                  {
                     result.push(item);
                  }
               }
            }
            return result;
         }
         if(type == 1)
         {
            list = _shopRealTimesDisCountGoods[type];
            if(list)
            {
               var _loc11_:int = 0;
               var _loc10_:* = list.list;
               for each(var item1 in list.list)
               {
                  if(item1.isValid && item1.TemplateInfo.CategoryID != 25)
                  {
                     result.push(item1);
                  }
               }
            }
            list = _shopRealTimesDisCountGoods[8];
            if(list)
            {
               var _loc13_:int = 0;
               var _loc12_:* = list.list;
               for each(var item2 in list.list)
               {
                  if(item2.isValid && item2.TemplateInfo.CategoryID != 25)
                  {
                     result.push(item2);
                  }
               }
            }
            list = _shopRealTimesDisCountGoods[9];
            if(list)
            {
               var _loc15_:int = 0;
               var _loc14_:* = list.list;
               for each(var item3 in list.list)
               {
                  if(item3.isValid && item3.TemplateInfo.CategoryID != 25)
                  {
                     result.push(item3);
                  }
               }
            }
            return result;
         }
         return result;
      }
      
      public function getDisCountResultPages(type:int, count:int = 8) : int
      {
         var totlaPage:int = 0;
         var list:Vector.<ShopItemInfo> = getDisCountValidGoodByType(type);
         if(list)
         {
            totlaPage = Math.ceil(list.length / count);
         }
         return totlaPage;
      }
      
      public function getDisCountShopItemByGoodsID(id:int) : ShopItemInfo
      {
         var item:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _shopRealTimesDisCountGoods;
         for each(var result in _shopRealTimesDisCountGoods)
         {
            item = result[id];
            if(item != null && item.isValid)
            {
               return item;
            }
         }
         return null;
      }
      
      public function getMoneySaleShopItemByTemplateID(id:int) : ShopItemInfo
      {
         var list:Vector.<ShopItemInfo> = _shopSortList[110];
         if(list)
         {
            var _loc5_:int = 0;
            var _loc4_:* = list;
            for each(var item in list)
            {
               if(item.GoodsID == id && item.getItemPrice(1).bothMoneyValue > 0)
               {
                  return item;
               }
               if(item.GoodsID == id && item.getItemPrice(1).moneyValue > 0)
               {
                  return item;
               }
               if(item.GoodsID == id && item.getItemPrice(1).bandDdtMoneyValue > 0)
               {
                  return item;
               }
            }
         }
         return null;
      }
      
      public function getDisCountGoods(type:int = 1, page:int = 1, count:int = 8) : Vector.<ShopItemInfo>
      {
         var totlaPage:int = 0;
         var startIndex:int = 0;
         var len:int = 0;
         var i:int = 0;
         var result:Vector.<ShopItemInfo> = new Vector.<ShopItemInfo>();
         var list:Vector.<ShopItemInfo> = getDisCountValidGoodByType(type);
         if(list)
         {
            totlaPage = Math.ceil(list.length / count);
            if(page > 0 && page <= totlaPage)
            {
               startIndex = 0 + count * (page - 1);
               len = Math.min(list.length - startIndex,count);
               for(i = 0; i < len; )
               {
                  result.push(list[startIndex + i]);
                  i++;
               }
            }
         }
         return result;
      }
      
      public function getGoodsByTempId(tempId:int) : ShopItemInfo
      {
         var i:int = 0;
         var info:ShopItemInfo = null;
         var itemList:Vector.<ShopItemInfo> = getDisCountGoods();
         for(i = 0; i < itemList.length; )
         {
            if(tempId == itemList[i].TemplateID)
            {
               info = itemList[i];
               break;
            }
            i++;
         }
         return info;
      }
      
      public function isHasDisCountGoods(type:int) : Boolean
      {
         var result_8:* = null;
         var result_9:* = null;
         var result:DictionaryData = _shopRealTimesDisCountGoods[type];
         if(type == 1)
         {
            result_8 = _shopRealTimesDisCountGoods[8];
            result_9 = _shopRealTimesDisCountGoods[9];
            if(checkIsHasDisCount(result) || checkIsHasDisCount(result_8) || checkIsHasDisCount(result_9))
            {
               return true;
            }
         }
         else if(checkIsHasDisCount(result))
         {
            return true;
         }
         return false;
      }
      
      private function checkIsHasDisCount(result:DictionaryData) : Boolean
      {
         if(result && result.length > 0)
         {
            var _loc4_:int = 0;
            var _loc3_:* = result.list;
            for each(var item in result.list)
            {
               if(item && item.isValid)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function __updateGoodsDisCount(evt:PkgEvent) : void
      {
         loadDisCounts();
      }
      
      private function loadDisCounts() : void
      {
         var args:URLVariables = new URLVariables();
         args["rnd"] = Math.random();
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ShopCheapItemList.ashx"),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.ShopDisCountRealTimesFailure");
         loader.analyzer = new ShopItemDisCountAnalyzer(ShopManager.Instance.updateRealTimesItemsByDisCount);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      public function updateRealTimesItemsByDisCount(analyzer:ShopItemDisCountAnalyzer) : void
      {
         _shopRealTimesDisCountGoods = analyzer.shopDisCountGoods;
         dispatchEvent(new ShopEvent("discountIsChange"));
      }
      
      public function get shopGoods() : DictionaryData
      {
         return _shopGoods;
      }
      
      public function set shopGoods(value:DictionaryData) : void
      {
         _shopGoods = value;
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
