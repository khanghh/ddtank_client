package AvatarCollection
{
   import AvatarCollection.data.AvatarCollectionItemDataAnalyzer;
   import AvatarCollection.data.AvatarCollectionItemVo;
   import AvatarCollection.data.AvatarCollectionUnitDataAnalyzer;
   import AvatarCollection.data.AvatarCollectionUnitVo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   
   public class AvatarCollectionManager extends EventDispatcher
   {
      
      public static const REFRESH_VIEW:String = "avatar_collection_refresh_view";
      
      public static const DATA_COMPLETE:String = "avatar_collection_data_complete";
      
      public static const SELECT_ALL:String = "avatar_collection_select_all";
      
      public static const VISIBLE:String = "visible";
      
      public static const RESET_LEFT:String = "reset_left";
      
      private static var _instance:AvatarCollectionManager;
       
      
      public var isDataComplete:Boolean;
      
      private var _realItemIdDic:DictionaryData;
      
      private var _maleItemDic:DictionaryData;
      
      private var _femaleItemDic:DictionaryData;
      
      private var _weaponItemDic:DictionaryData;
      
      private var _allGoodsTemplateIDlist:DictionaryData;
      
      private var _maleItemList:Vector.<AvatarCollectionItemVo>;
      
      private var _femaleItemList:Vector.<AvatarCollectionItemVo>;
      
      private var _weaponItemList:Vector.<AvatarCollectionItemVo>;
      
      private var _maleUnitList:Array;
      
      private var _femaleUnitList:Array;
      
      private var _weaponUnitList:Array;
      
      private var _maleUnitDic:DictionaryData;
      
      private var _femaleUnitDic:DictionaryData;
      
      private var _weaponUnitDic:DictionaryData;
      
      private var _maleShopItemInfoList:Vector.<ShopItemInfo>;
      
      private var _femaleShopItemInfoList:Vector.<ShopItemInfo>;
      
      private var _weaponShopItemInfoList:Vector.<ShopItemInfo>;
      
      private var _isHasCheckedBuy:Boolean = false;
      
      public var isCheckedAvatarTime:Boolean = false;
      
      public var isSkipFromHall:Boolean = false;
      
      public var skipId:int;
      
      private var _isSelectAll:Boolean = false;
      
      private var _pageType:int;
      
      private var _listState:String = "normal";
      
      private var _gotAllInfo:Boolean = false;
      
      private var cevent:CEvent;
      
      public function AvatarCollectionManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : AvatarCollectionManager
      {
         if(_instance == null)
         {
            _instance = new AvatarCollectionManager();
         }
         return _instance;
      }
      
      private function honourNeedPerPage(_data:AvatarCollectionUnitVo) : Number
      {
         var _needHonour:int = 0;
         if(!_data)
         {
            return 0;
         }
         var totalCount:int = _data.totalItemList.length;
         var activityCount:int = _data.totalActivityItemCount;
         if(activityCount < totalCount / 2)
         {
            return 0;
         }
         if(activityCount == totalCount)
         {
            return _data.needHonor * 2;
         }
         return _data.needHonor;
      }
      
      public function honourNeedTotalPerDay() : Number
      {
         var __honourNeed:* = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _maleUnitList;
         for each(var v in _maleUnitList)
         {
            if(v.selected)
            {
               __honourNeed = Number(__honourNeed + honourNeedPerPage(v));
            }
         }
         var _loc8_:int = 0;
         var _loc7_:* = _femaleUnitList;
         for each(var v1 in _femaleUnitList)
         {
            if(v1.selected)
            {
               __honourNeed = Number(__honourNeed + honourNeedPerPage(v1));
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = _weaponUnitList;
         for each(var v2 in _weaponUnitList)
         {
            if(v2.selected)
            {
               __honourNeed = Number(__honourNeed + honourNeedPerPage(v2));
            }
         }
         return __honourNeed;
      }
      
      public function onListCellClick($data:AvatarCollectionUnitVo, $selected:Boolean) : void
      {
         var list:* = undefined;
         var listUnit:* = null;
         if($data.Type == 1)
         {
            list = $data.sex == 1?_maleItemList:_femaleItemList;
         }
         else
         {
            list = _weaponItemList;
         }
         if($data.Type == 1)
         {
            listUnit = $data.sex == 1?_maleUnitList:_femaleUnitList;
         }
         else
         {
            listUnit = _weaponUnitList;
         }
         var _loc8_:int = 0;
         var _loc7_:* = list;
         for each(var v in list)
         {
            if(v.id == $data.id)
            {
               v.selected = $selected;
               break;
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = listUnit;
         for each(var vv in listUnit)
         {
            if(vv.id == $data.id)
            {
               vv.selected = $selected;
               break;
            }
         }
      }
      
      public function get isSelectAll() : Boolean
      {
         return _isSelectAll;
      }
      
      public function set isSelectAll(value:Boolean) : void
      {
         _isSelectAll = value;
         if(_pageType == 0)
         {
            var _loc9_:int = 0;
            var _loc8_:* = _maleItemList;
            for each(var v in _maleItemList)
            {
               v.selected = value;
            }
            var _loc11_:int = 0;
            var _loc10_:* = _femaleItemList;
            for each(var v1 in _femaleItemList)
            {
               v1.selected = value;
            }
            var _loc13_:int = 0;
            var _loc12_:* = _maleUnitList;
            for each(var v2 in _maleUnitList)
            {
               v2.selected = value;
            }
            var _loc15_:int = 0;
            var _loc14_:* = _femaleUnitList;
            for each(var v3 in _femaleUnitList)
            {
               v3.selected = value;
            }
         }
         else
         {
            var _loc17_:int = 0;
            var _loc16_:* = _weaponUnitList;
            for each(var v4 in _weaponUnitList)
            {
               v4.selected = value;
            }
            var _loc19_:int = 0;
            var _loc18_:* = _weaponItemList;
            for each(var v5 in _weaponItemList)
            {
               v5.selected = value;
            }
         }
      }
      
      public function getSelectState(data:AvatarCollectionUnitVo) : Boolean
      {
         var list:* = undefined;
         if(data.Type == 1)
         {
            list = data.sex == 1?_maleItemList:_femaleItemList;
         }
         else
         {
            list = _weaponItemList;
         }
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var v in list)
         {
            if(v.id == data.id)
            {
               return v.selected;
            }
         }
         return false;
      }
      
      public function get pageType() : int
      {
         return _pageType;
      }
      
      public function set pageType(value:int) : void
      {
         _pageType = value;
      }
      
      public function selectAllClicked(bool:Object = null) : void
      {
         if(bool != null)
         {
            isSelectAll = Boolean(bool);
         }
         else if(_listState != "normal")
         {
            dispatchEvent(new CEvent("reset_left"));
            isSelectAll = true;
            _listState = "normal";
         }
         else
         {
            isSelectAll = !isSelectAll;
         }
         dispatchEvent(new CEvent("avatar_collection_select_all",_isSelectAll));
      }
      
      public function getDelayTimeCollectionCount() : Number
      {
         var num:* = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _maleUnitList;
         for each(var v in _maleUnitList)
         {
            if(v.selected == true)
            {
               num++;
            }
         }
         var _loc8_:int = 0;
         var _loc7_:* = _femaleUnitList;
         for each(var v1 in _femaleUnitList)
         {
            if(v1.selected == true)
            {
               num++;
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = _weaponUnitList;
         for each(var v2 in _weaponUnitList)
         {
            if(v2.selected == true)
            {
               num++;
            }
         }
         return num;
      }
      
      public function delayTheTimeConfirmed(count:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = _maleUnitList;
         for each(var v in _maleUnitList)
         {
            if(v.selected)
            {
               SocketManager.Instance.out.sendAvatarCollectionDelayTime(v.id,count,1);
            }
         }
         var _loc8_:int = 0;
         var _loc7_:* = _femaleUnitList;
         for each(var v1 in _femaleUnitList)
         {
            if(v1.selected)
            {
               SocketManager.Instance.out.sendAvatarCollectionDelayTime(v1.id,count,1);
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = _weaponUnitList;
         for each(var v2 in _weaponUnitList)
         {
            if(v2.selected)
            {
               SocketManager.Instance.out.sendAvatarCollectionDelayTime(v2.id,count,2);
            }
         }
      }
      
      public function listState(state:String) : void
      {
         _isSelectAll = true;
         _listState = state;
         var _loc9_:int = 0;
         var _loc8_:* = _maleUnitList;
         for(var key in _maleUnitList)
         {
            _maleUnitList[key].selected = false;
         }
         var _loc11_:int = 0;
         var _loc10_:* = _femaleUnitList;
         for(var key1 in _femaleUnitList)
         {
            _femaleUnitList[key1].selected = false;
         }
         var _loc13_:int = 0;
         var _loc12_:* = _weaponUnitList;
         for(var key2 in _weaponUnitList)
         {
            _weaponUnitList[key2].selected = false;
         }
         var _loc15_:int = 0;
         var _loc14_:* = _maleItemList;
         for each(var v in _maleItemList)
         {
            v.selected = false;
         }
         var _loc17_:int = 0;
         var _loc16_:* = _femaleItemList;
         for each(var v1 in _femaleItemList)
         {
            v1.selected = false;
         }
         var _loc19_:int = 0;
         var _loc18_:* = _weaponItemList;
         for each(var v2 in _weaponItemList)
         {
            v2.selected = false;
         }
      }
      
      public function getListState() : String
      {
         return _listState;
      }
      
      public function resetListCellData() : void
      {
         _isSelectAll = false;
         _listState = "normal";
         var _loc8_:int = 0;
         var _loc7_:* = _maleUnitList;
         for(var key in _maleUnitList)
         {
            _maleUnitList[key].selected = false;
         }
         var _loc10_:int = 0;
         var _loc9_:* = _femaleUnitList;
         for(var key1 in _femaleUnitList)
         {
            _femaleUnitList[key1].selected = false;
         }
         var _loc12_:int = 0;
         var _loc11_:* = _weaponUnitList;
         for(var key2 in _weaponUnitList)
         {
            _weaponUnitList[key2].selected = false;
         }
         var _loc14_:int = 0;
         var _loc13_:* = _maleItemList;
         for each(var v in _maleItemList)
         {
            v.selected = false;
         }
         var _loc16_:int = 0;
         var _loc15_:* = _femaleItemList;
         for each(var v1 in _femaleItemList)
         {
            v1.selected = false;
         }
         var _loc18_:int = 0;
         var _loc17_:* = _weaponItemList;
         for each(var v2 in _weaponItemList)
         {
            v2.selected = false;
         }
      }
      
      public function get maleUnitList() : Array
      {
         return _maleUnitList;
      }
      
      public function get femaleUnitList() : Array
      {
         return _femaleUnitList;
      }
      
      public function get weaponUnitList() : Array
      {
         return _weaponUnitList;
      }
      
      public function getItemListById(sex:int, id:int, type:int = 1) : Array
      {
         if(type == 1)
         {
            if(sex == 1)
            {
               return _maleItemDic[id].list;
            }
            return _femaleItemDic[id].list;
         }
         if(type == 2)
         {
            return _weaponItemDic[id].list;
         }
         return null;
      }
      
      public function unitListDataSetup(analyzer:AvatarCollectionUnitDataAnalyzer) : void
      {
         if(_maleUnitDic)
         {
            unitDicDataConvert(_maleUnitDic,analyzer.maleUnitDic);
         }
         else
         {
            _maleUnitDic = analyzer.maleUnitDic;
         }
         if(_femaleUnitDic)
         {
            unitDicDataConvert(_femaleUnitDic,analyzer.femaleUnitDic);
         }
         else
         {
            _femaleUnitDic = analyzer.femaleUnitDic;
         }
         if(_weaponUnitDic)
         {
            unitDicDataConvert(_weaponUnitDic,analyzer.weaponUnitDic);
         }
         else
         {
            _weaponUnitDic = analyzer.weaponUnitDic;
         }
         _maleUnitList = _maleUnitDic.list;
         _femaleUnitList = _femaleUnitDic.list;
         _weaponUnitList = _weaponUnitDic.list;
      }
      
      private function unitDicDataConvert(dicDest:DictionaryData, dicOrig:DictionaryData) : void
      {
         var i:int = 0;
         var obj1:* = null;
         var obj2:* = null;
         for(i = 0; i < dicOrig.list.length; )
         {
            obj1 = dicOrig.list[i];
            obj2 = dicDest[obj1.id];
            if(obj2)
            {
               obj1.endTime = obj2.endTime;
            }
            dicDest.add(obj1.id,obj1);
            i++;
         }
      }
      
      public function itemListDataSetup(analyzer:AvatarCollectionItemDataAnalyzer) : void
      {
         if(_maleItemDic)
         {
            itemDicDataConvert(_maleItemDic,analyzer.maleItemDic);
         }
         else
         {
            _maleItemDic = analyzer.maleItemDic;
         }
         if(_femaleItemDic)
         {
            itemDicDataConvert(_femaleItemDic,analyzer.femaleItemDic);
         }
         else
         {
            _femaleItemDic = analyzer.femaleItemDic;
         }
         if(_weaponItemDic)
         {
            itemDicDataConvert(_weaponItemDic,analyzer.weaponItemDic);
         }
         else
         {
            _weaponItemDic = analyzer.weaponItemDic;
         }
         _maleItemList = analyzer.maleItemList;
         _femaleItemList = analyzer.femaleItemList;
         _weaponItemList = analyzer.weaponItemList;
         _allGoodsTemplateIDlist = analyzer.allGoodsTemplateIDlist;
         _realItemIdDic = analyzer.realItemIdDic;
      }
      
      private function itemDicDataConvert(dicDest:DictionaryData, dicOrig:DictionaryData) : void
      {
         var obj1:* = null;
         var obj2:* = null;
         var obj3:* = null;
         var obj4:* = null;
         var _loc12_:int = 0;
         var _loc11_:* = dicOrig;
         for(var key1 in dicOrig)
         {
            obj1 = dicOrig[key1];
            obj2 = dicDest[key1];
            if(obj2)
            {
               var _loc10_:int = 0;
               var _loc9_:* = obj1;
               for(var key2 in obj1)
               {
                  obj3 = obj1[key2];
                  obj4 = obj2[key2];
                  if(obj4)
                  {
                     obj3.isActivity = obj4.isActivity;
                  }
                  obj2.add(key2,obj3);
               }
            }
            dicDest.add(key1,obj1);
         }
      }
      
      public function initShopItemInfoList() : void
      {
         var maleTypeArray:* = null;
         var tmplen:int = 0;
         var i:int = 0;
         var femaleTypeArray:* = null;
         var tmplen2:int = 0;
         var k:int = 0;
         var weaponTypeArray:* = null;
         var tmplen3:int = 0;
         var j:int = 0;
         if(!_maleShopItemInfoList)
         {
            _maleShopItemInfoList = new Vector.<ShopItemInfo>();
            maleTypeArray = [9,11,13,17,19,21];
            tmplen = maleTypeArray.length;
            for(i = 0; i < tmplen; )
            {
               _maleShopItemInfoList = _maleShopItemInfoList.concat(ShopManager.Instance.getValidGoodByType(maleTypeArray[i]));
               i++;
            }
            _maleShopItemInfoList = _maleShopItemInfoList.concat(ShopManager.Instance.getDisCountValidGoodByType(1));
         }
         if(!_femaleShopItemInfoList)
         {
            _femaleShopItemInfoList = new Vector.<ShopItemInfo>();
            femaleTypeArray = [10,12,14,18,20,22];
            tmplen2 = femaleTypeArray.length;
            for(k = 0; k < tmplen2; )
            {
               _femaleShopItemInfoList = _femaleShopItemInfoList.concat(ShopManager.Instance.getValidGoodByType(femaleTypeArray[k]));
               k++;
            }
            _femaleShopItemInfoList = _femaleShopItemInfoList.concat(ShopManager.Instance.getDisCountValidGoodByType(1));
         }
         if(!_weaponShopItemInfoList)
         {
            _weaponShopItemInfoList = new Vector.<ShopItemInfo>();
            weaponTypeArray = [7,8];
            tmplen3 = weaponTypeArray.length;
            for(j = 0; j < tmplen3; )
            {
               _weaponShopItemInfoList = _weaponShopItemInfoList.concat(ShopManager.Instance.getValidGoodByType(weaponTypeArray[j]));
               j++;
            }
            _weaponShopItemInfoList = _weaponShopItemInfoList.concat(ShopManager.Instance.getDisCountValidGoodByType(1));
         }
      }
      
      public function checkItemCanBuy() : void
      {
         if(_isHasCheckedBuy)
         {
            return;
         }
         var _loc10_:int = 0;
         var _loc9_:* = _maleItemList;
         for each(var tmpItem in _maleItemList)
         {
            tmpItem.canBuyStatus = 0;
            var _loc8_:int = 0;
            var _loc7_:* = _maleShopItemInfoList;
            for each(var tmpShopItem in _maleShopItemInfoList)
            {
               if(tmpItem.itemId == tmpShopItem.TemplateID)
               {
                  tmpItem.canBuyStatus = 1;
                  tmpItem.buyPrice = tmpShopItem.getItemPrice(1).bothMoneyValue;
                  tmpItem.isDiscount = tmpShopItem.isDiscount;
                  tmpItem.goodsId = tmpShopItem.GoodsID;
                  break;
               }
            }
         }
         var _loc14_:int = 0;
         var _loc13_:* = _femaleItemList;
         for each(var tmpItem2 in _femaleItemList)
         {
            tmpItem2.canBuyStatus = 0;
            var _loc12_:int = 0;
            var _loc11_:* = _femaleShopItemInfoList;
            for each(var tmpShopItem2 in _femaleShopItemInfoList)
            {
               if(tmpItem2.itemId == tmpShopItem2.TemplateID)
               {
                  tmpItem2.canBuyStatus = 1;
                  tmpItem2.buyPrice = tmpShopItem2.getItemPrice(1).bothMoneyValue;
                  tmpItem2.isDiscount = tmpShopItem2.isDiscount;
                  tmpItem2.goodsId = tmpShopItem2.GoodsID;
                  break;
               }
            }
         }
         var _loc18_:int = 0;
         var _loc17_:* = _weaponItemList;
         for each(var tmpItem3 in _weaponItemList)
         {
            tmpItem3.canBuyStatus = 0;
            var _loc16_:int = 0;
            var _loc15_:* = _weaponShopItemInfoList;
            for each(var tmpShopItem3 in _weaponShopItemInfoList)
            {
               if(tmpItem3.itemId == tmpShopItem3.TemplateID)
               {
                  tmpItem3.canBuyStatus = 1;
                  tmpItem3.buyPrice = tmpShopItem3.getItemPrice(1).bothMoneyValue;
                  tmpItem3.isDiscount = tmpShopItem3.isDiscount;
                  tmpItem3.goodsId = tmpShopItem3.GoodsID;
                  break;
               }
            }
         }
         _isHasCheckedBuy = true;
      }
      
      public function getShopItemInfoByItemId(itemId:int, sex:int, type:int) : ShopItemInfo
      {
         var tmpItemList:* = undefined;
         if(type == 1)
         {
            if(sex == 1)
            {
               tmpItemList = _maleShopItemInfoList;
            }
            else
            {
               tmpItemList = _femaleShopItemInfoList;
            }
         }
         else
         {
            tmpItemList = _weaponShopItemInfoList;
         }
         var _loc7_:int = 0;
         var _loc6_:* = tmpItemList;
         for each(var tmp in tmpItemList)
         {
            if(itemId == tmp.TemplateID)
            {
               return tmp;
            }
         }
         return null;
      }
      
      public function setup() : void
      {
         _maleUnitDic = new DictionaryData();
         _maleItemDic = new DictionaryData();
         _femaleUnitDic = new DictionaryData();
         _femaleItemDic = new DictionaryData();
         _weaponUnitDic = new DictionaryData();
         _weaponItemDic = new DictionaryData();
         SocketManager.Instance.addEventListener(PkgEvent.format(402),pkgHandler);
      }
      
      private function pkgHandler(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = pkg.readByte();
         switch(int(cmd) - 3)
         {
            case 0:
               activeHandler(pkg);
               break;
            case 1:
               delayTimeHandler(pkg);
               break;
            case 2:
               getAllInfoHandler(pkg);
         }
      }
      
      private function getAllInfoHandler(pkg:PackageIn) : void
      {
         var i:int = 0;
         var type:int = 0;
         var count:int = 0;
         var j:int = 0;
         var id:int = 0;
         var sex:int = 0;
         var unitVo:* = null;
         var itemVoDic:* = null;
         var itemCount:int = 0;
         var k:int = 0;
         var itemId:int = 0;
         var realId:int = 0;
         var allCount:int = pkg.readInt();
         for(i = 0; i < allCount; )
         {
            type = pkg.readInt();
            count = pkg.readInt();
            for(j = 0; j < count; )
            {
               id = pkg.readInt();
               sex = pkg.readInt();
               unitVo = new AvatarCollectionUnitVo();
               if(type == 1)
               {
                  if(sex == 1)
                  {
                     _maleUnitDic.add(id,unitVo);
                     itemVoDic = _maleItemDic[id];
                  }
                  else
                  {
                     _femaleUnitDic.add(id,unitVo);
                     itemVoDic = _femaleItemDic[id];
                  }
               }
               else if(type == 2)
               {
                  _weaponUnitDic.add(id,unitVo);
                  itemVoDic = _weaponItemDic[id];
               }
               itemCount = pkg.readInt();
               for(k = 0; k < itemCount; )
               {
                  itemId = pkg.readInt();
                  realId = _realItemIdDic[itemId];
                  (itemVoDic[realId] as AvatarCollectionItemVo).isActivity = true;
                  k++;
               }
               unitVo.endTime = pkg.readDate();
               j++;
            }
            i++;
         }
         isDataComplete = true;
         dispatchEvent(new Event("avatar_collection_data_complete"));
      }
      
      private function activeHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var itemId:int = pkg.readInt();
         itemId = _realItemIdDic[itemId];
         var sex:int = pkg.readInt();
         var type:int = pkg.readInt();
         if(type == 1)
         {
            if(sex == 1)
            {
               (_maleItemDic[id][itemId] as AvatarCollectionItemVo).isActivity = true;
            }
            else
            {
               (_femaleItemDic[id][itemId] as AvatarCollectionItemVo).isActivity = true;
            }
         }
         else if(type == 2)
         {
            (_weaponItemDic[id][itemId] as AvatarCollectionItemVo).isActivity = true;
         }
         dispatchEvent(new Event("avatar_collection_refresh_view"));
      }
      
      private function delayTimeHandler(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         var sex:int = pkg.readInt();
         var type:int = pkg.readInt();
         if(type == 1)
         {
            if(sex == 1)
            {
               (_maleUnitDic[id] as AvatarCollectionUnitVo).endTime = pkg.readDate();
            }
            else
            {
               (_femaleUnitDic[id] as AvatarCollectionUnitVo).endTime = pkg.readDate();
            }
         }
         else if(type == 2)
         {
            (_weaponUnitDic[id] as AvatarCollectionUnitVo).endTime = pkg.readDate();
         }
         dispatchEvent(new Event("avatar_collection_refresh_view"));
      }
      
      public function isCollectionGoodsByTemplateID(id:int) : Boolean
      {
         return _allGoodsTemplateIDlist[id];
      }
      
      public function showFrame(value:Sprite) : void
      {
         cevent = new CEvent("openview",{"parent":value});
         AssetModuleLoader.addModelLoader("avatarcollection",6);
         AssetModuleLoader.startCodeLoader(show);
      }
      
      public function show() : void
      {
         dispatchEvent(cevent);
         cevent = null;
      }
      
      public function closeFrame() : void
      {
         resetListCellData();
         dispatchEvent(new CEvent("closeView"));
      }
      
      public function visible(value:Boolean) : void
      {
         dispatchEvent(new CEvent("visible",{"visible":value}));
      }
   }
}
