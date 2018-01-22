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
      
      public function AvatarCollectionManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : AvatarCollectionManager
      {
         if(_instance == null)
         {
            _instance = new AvatarCollectionManager();
         }
         return _instance;
      }
      
      private function honourNeedPerPage(param1:AvatarCollectionUnitVo) : Number
      {
         var _loc4_:int = 0;
         if(!param1)
         {
            return 0;
         }
         var _loc3_:int = param1.totalItemList.length;
         var _loc2_:int = param1.totalActivityItemCount;
         if(_loc2_ < _loc3_ / 2)
         {
            return 0;
         }
         if(_loc2_ == _loc3_)
         {
            return param1.needHonor * 2;
         }
         return param1.needHonor;
      }
      
      public function honourNeedTotalPerDay() : Number
      {
         var _loc4_:* = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _maleUnitList;
         for each(var _loc2_ in _maleUnitList)
         {
            if(_loc2_.selected)
            {
               _loc4_ = Number(_loc4_ + honourNeedPerPage(_loc2_));
            }
         }
         var _loc8_:int = 0;
         var _loc7_:* = _femaleUnitList;
         for each(var _loc1_ in _femaleUnitList)
         {
            if(_loc1_.selected)
            {
               _loc4_ = Number(_loc4_ + honourNeedPerPage(_loc1_));
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = _weaponUnitList;
         for each(var _loc3_ in _weaponUnitList)
         {
            if(_loc3_.selected)
            {
               _loc4_ = Number(_loc4_ + honourNeedPerPage(_loc3_));
            }
         }
         return _loc4_;
      }
      
      public function onListCellClick(param1:AvatarCollectionUnitVo, param2:Boolean) : void
      {
         var _loc6_:* = undefined;
         var _loc5_:* = null;
         if(param1.Type == 1)
         {
            _loc6_ = param1.sex == 1?_maleItemList:_femaleItemList;
         }
         else
         {
            _loc6_ = _weaponItemList;
         }
         if(param1.Type == 1)
         {
            _loc5_ = param1.sex == 1?_maleUnitList:_femaleUnitList;
         }
         else
         {
            _loc5_ = _weaponUnitList;
         }
         var _loc8_:int = 0;
         var _loc7_:* = _loc6_;
         for each(var _loc4_ in _loc6_)
         {
            if(_loc4_.id == param1.id)
            {
               _loc4_.selected = param2;
               break;
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = _loc5_;
         for each(var _loc3_ in _loc5_)
         {
            if(_loc3_.id == param1.id)
            {
               _loc3_.selected = param2;
               break;
            }
         }
      }
      
      public function get isSelectAll() : Boolean
      {
         return _isSelectAll;
      }
      
      public function set isSelectAll(param1:Boolean) : void
      {
         _isSelectAll = param1;
         if(_pageType == 0)
         {
            var _loc9_:int = 0;
            var _loc8_:* = _maleItemList;
            for each(var _loc3_ in _maleItemList)
            {
               _loc3_.selected = param1;
            }
            var _loc11_:int = 0;
            var _loc10_:* = _femaleItemList;
            for each(var _loc2_ in _femaleItemList)
            {
               _loc2_.selected = param1;
            }
            var _loc13_:int = 0;
            var _loc12_:* = _maleUnitList;
            for each(var _loc7_ in _maleUnitList)
            {
               _loc7_.selected = param1;
            }
            var _loc15_:int = 0;
            var _loc14_:* = _femaleUnitList;
            for each(var _loc6_ in _femaleUnitList)
            {
               _loc6_.selected = param1;
            }
         }
         else
         {
            var _loc17_:int = 0;
            var _loc16_:* = _weaponUnitList;
            for each(var _loc5_ in _weaponUnitList)
            {
               _loc5_.selected = param1;
            }
            var _loc19_:int = 0;
            var _loc18_:* = _weaponItemList;
            for each(var _loc4_ in _weaponItemList)
            {
               _loc4_.selected = param1;
            }
         }
      }
      
      public function getSelectState(param1:AvatarCollectionUnitVo) : Boolean
      {
         var _loc3_:* = undefined;
         if(param1.Type == 1)
         {
            _loc3_ = param1.sex == 1?_maleItemList:_femaleItemList;
         }
         else
         {
            _loc3_ = _weaponItemList;
         }
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            if(_loc2_.id == param1.id)
            {
               return _loc2_.selected;
            }
         }
         return false;
      }
      
      public function get pageType() : int
      {
         return _pageType;
      }
      
      public function set pageType(param1:int) : void
      {
         _pageType = param1;
      }
      
      public function selectAllClicked(param1:Object = null) : void
      {
         if(param1 != null)
         {
            isSelectAll = Boolean(param1);
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
         var _loc3_:* = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _maleUnitList;
         for each(var _loc2_ in _maleUnitList)
         {
            if(_loc2_.selected == true)
            {
               _loc3_++;
            }
         }
         var _loc8_:int = 0;
         var _loc7_:* = _femaleUnitList;
         for each(var _loc1_ in _femaleUnitList)
         {
            if(_loc1_.selected == true)
            {
               _loc3_++;
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = _weaponUnitList;
         for each(var _loc4_ in _weaponUnitList)
         {
            if(_loc4_.selected == true)
            {
               _loc3_++;
            }
         }
         return _loc3_;
      }
      
      public function delayTheTimeConfirmed(param1:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = _maleUnitList;
         for each(var _loc3_ in _maleUnitList)
         {
            if(_loc3_.selected)
            {
               SocketManager.Instance.out.sendAvatarCollectionDelayTime(_loc3_.id,param1,1);
            }
         }
         var _loc8_:int = 0;
         var _loc7_:* = _femaleUnitList;
         for each(var _loc2_ in _femaleUnitList)
         {
            if(_loc2_.selected)
            {
               SocketManager.Instance.out.sendAvatarCollectionDelayTime(_loc2_.id,param1,1);
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = _weaponUnitList;
         for each(var _loc4_ in _weaponUnitList)
         {
            if(_loc4_.selected)
            {
               SocketManager.Instance.out.sendAvatarCollectionDelayTime(_loc4_.id,param1,2);
            }
         }
      }
      
      public function listState(param1:String) : void
      {
         _isSelectAll = true;
         _listState = param1;
         var _loc9_:int = 0;
         var _loc8_:* = _maleUnitList;
         for(var _loc7_ in _maleUnitList)
         {
            _maleUnitList[_loc7_].selected = false;
         }
         var _loc11_:int = 0;
         var _loc10_:* = _femaleUnitList;
         for(var _loc6_ in _femaleUnitList)
         {
            _femaleUnitList[_loc6_].selected = false;
         }
         var _loc13_:int = 0;
         var _loc12_:* = _weaponUnitList;
         for(var _loc4_ in _weaponUnitList)
         {
            _weaponUnitList[_loc4_].selected = false;
         }
         var _loc15_:int = 0;
         var _loc14_:* = _maleItemList;
         for each(var _loc3_ in _maleItemList)
         {
            _loc3_.selected = false;
         }
         var _loc17_:int = 0;
         var _loc16_:* = _femaleItemList;
         for each(var _loc2_ in _femaleItemList)
         {
            _loc2_.selected = false;
         }
         var _loc19_:int = 0;
         var _loc18_:* = _weaponItemList;
         for each(var _loc5_ in _weaponItemList)
         {
            _loc5_.selected = false;
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
         for(var _loc6_ in _maleUnitList)
         {
            _maleUnitList[_loc6_].selected = false;
         }
         var _loc10_:int = 0;
         var _loc9_:* = _femaleUnitList;
         for(var _loc5_ in _femaleUnitList)
         {
            _femaleUnitList[_loc5_].selected = false;
         }
         var _loc12_:int = 0;
         var _loc11_:* = _weaponUnitList;
         for(var _loc3_ in _weaponUnitList)
         {
            _weaponUnitList[_loc3_].selected = false;
         }
         var _loc14_:int = 0;
         var _loc13_:* = _maleItemList;
         for each(var _loc2_ in _maleItemList)
         {
            _loc2_.selected = false;
         }
         var _loc16_:int = 0;
         var _loc15_:* = _femaleItemList;
         for each(var _loc1_ in _femaleItemList)
         {
            _loc1_.selected = false;
         }
         var _loc18_:int = 0;
         var _loc17_:* = _weaponItemList;
         for each(var _loc4_ in _weaponItemList)
         {
            _loc4_.selected = false;
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
      
      public function getItemListById(param1:int, param2:int, param3:int = 1) : Array
      {
         if(param3 == 1)
         {
            if(param1 == 1)
            {
               return _maleItemDic[param2].list;
            }
            return _femaleItemDic[param2].list;
         }
         if(param3 == 2)
         {
            return _weaponItemDic[param2].list;
         }
         return null;
      }
      
      public function unitListDataSetup(param1:AvatarCollectionUnitDataAnalyzer) : void
      {
         if(_maleUnitDic)
         {
            unitDicDataConvert(_maleUnitDic,param1.maleUnitDic);
         }
         else
         {
            _maleUnitDic = param1.maleUnitDic;
         }
         if(_femaleUnitDic)
         {
            unitDicDataConvert(_femaleUnitDic,param1.femaleUnitDic);
         }
         else
         {
            _femaleUnitDic = param1.femaleUnitDic;
         }
         if(_weaponUnitDic)
         {
            unitDicDataConvert(_weaponUnitDic,param1.weaponUnitDic);
         }
         else
         {
            _weaponUnitDic = param1.weaponUnitDic;
         }
         _maleUnitList = _maleUnitDic.list;
         _femaleUnitList = _femaleUnitDic.list;
         _weaponUnitList = _weaponUnitDic.list;
      }
      
      private function unitDicDataConvert(param1:DictionaryData, param2:DictionaryData) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         _loc5_ = 0;
         while(_loc5_ < param2.list.length)
         {
            _loc3_ = param2.list[_loc5_];
            _loc4_ = param1[_loc3_.id];
            if(_loc4_)
            {
               _loc3_.endTime = _loc4_.endTime;
            }
            param1.add(_loc3_.id,_loc3_);
            _loc5_++;
         }
      }
      
      public function itemListDataSetup(param1:AvatarCollectionItemDataAnalyzer) : void
      {
         if(_maleItemDic)
         {
            itemDicDataConvert(_maleItemDic,param1.maleItemDic);
         }
         else
         {
            _maleItemDic = param1.maleItemDic;
         }
         if(_femaleItemDic)
         {
            itemDicDataConvert(_femaleItemDic,param1.femaleItemDic);
         }
         else
         {
            _femaleItemDic = param1.femaleItemDic;
         }
         if(_weaponItemDic)
         {
            itemDicDataConvert(_weaponItemDic,param1.weaponItemDic);
         }
         else
         {
            _weaponItemDic = param1.weaponItemDic;
         }
         _maleItemList = param1.maleItemList;
         _femaleItemList = param1.femaleItemList;
         _weaponItemList = param1.weaponItemList;
         _allGoodsTemplateIDlist = param1.allGoodsTemplateIDlist;
         _realItemIdDic = param1.realItemIdDic;
      }
      
      private function itemDicDataConvert(param1:DictionaryData, param2:DictionaryData) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc12_:int = 0;
         var _loc11_:* = param2;
         for(var _loc8_ in param2)
         {
            _loc6_ = param2[_loc8_];
            _loc7_ = param1[_loc8_];
            if(_loc7_)
            {
               var _loc10_:int = 0;
               var _loc9_:* = _loc6_;
               for(var _loc5_ in _loc6_)
               {
                  _loc3_ = _loc6_[_loc5_];
                  _loc4_ = _loc7_[_loc5_];
                  if(_loc4_)
                  {
                     _loc3_.isActivity = _loc4_.isActivity;
                  }
                  _loc7_.add(_loc5_,_loc3_);
               }
            }
            param1.add(_loc8_,_loc6_);
         }
      }
      
      public function initShopItemInfoList() : void
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:* = null;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(!_maleShopItemInfoList)
         {
            _maleShopItemInfoList = new Vector.<ShopItemInfo>();
            _loc1_ = [9,11,13,17,19,21];
            _loc3_ = _loc1_.length;
            _loc9_ = 0;
            while(_loc9_ < _loc3_)
            {
               _maleShopItemInfoList = _maleShopItemInfoList.concat(ShopManager.Instance.getValidGoodByType(_loc1_[_loc9_]));
               _loc9_++;
            }
            _maleShopItemInfoList = _maleShopItemInfoList.concat(ShopManager.Instance.getDisCountValidGoodByType(1));
         }
         if(!_femaleShopItemInfoList)
         {
            _femaleShopItemInfoList = new Vector.<ShopItemInfo>();
            _loc4_ = [10,12,14,18,20,22];
            _loc8_ = _loc4_.length;
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               _femaleShopItemInfoList = _femaleShopItemInfoList.concat(ShopManager.Instance.getValidGoodByType(_loc4_[_loc7_]));
               _loc7_++;
            }
            _femaleShopItemInfoList = _femaleShopItemInfoList.concat(ShopManager.Instance.getDisCountValidGoodByType(1));
         }
         if(!_weaponShopItemInfoList)
         {
            _weaponShopItemInfoList = new Vector.<ShopItemInfo>();
            _loc2_ = [7,8];
            _loc6_ = _loc2_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _weaponShopItemInfoList = _weaponShopItemInfoList.concat(ShopManager.Instance.getValidGoodByType(_loc2_[_loc5_]));
               _loc5_++;
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
         for each(var _loc3_ in _maleItemList)
         {
            _loc3_.canBuyStatus = 0;
            var _loc8_:int = 0;
            var _loc7_:* = _maleShopItemInfoList;
            for each(var _loc6_ in _maleShopItemInfoList)
            {
               if(_loc3_.itemId == _loc6_.TemplateID)
               {
                  _loc3_.canBuyStatus = 1;
                  _loc3_.buyPrice = _loc6_.getItemPrice(1).bothMoneyValue;
                  _loc3_.isDiscount = _loc6_.isDiscount;
                  _loc3_.goodsId = _loc6_.GoodsID;
                  break;
               }
            }
         }
         var _loc14_:int = 0;
         var _loc13_:* = _femaleItemList;
         for each(var _loc5_ in _femaleItemList)
         {
            _loc5_.canBuyStatus = 0;
            var _loc12_:int = 0;
            var _loc11_:* = _femaleShopItemInfoList;
            for each(var _loc2_ in _femaleShopItemInfoList)
            {
               if(_loc5_.itemId == _loc2_.TemplateID)
               {
                  _loc5_.canBuyStatus = 1;
                  _loc5_.buyPrice = _loc2_.getItemPrice(1).bothMoneyValue;
                  _loc5_.isDiscount = _loc2_.isDiscount;
                  _loc5_.goodsId = _loc2_.GoodsID;
                  break;
               }
            }
         }
         var _loc18_:int = 0;
         var _loc17_:* = _weaponItemList;
         for each(var _loc4_ in _weaponItemList)
         {
            _loc4_.canBuyStatus = 0;
            var _loc16_:int = 0;
            var _loc15_:* = _weaponShopItemInfoList;
            for each(var _loc1_ in _weaponShopItemInfoList)
            {
               if(_loc4_.itemId == _loc1_.TemplateID)
               {
                  _loc4_.canBuyStatus = 1;
                  _loc4_.buyPrice = _loc1_.getItemPrice(1).bothMoneyValue;
                  _loc4_.isDiscount = _loc1_.isDiscount;
                  _loc4_.goodsId = _loc1_.GoodsID;
                  break;
               }
            }
         }
         _isHasCheckedBuy = true;
      }
      
      public function getShopItemInfoByItemId(param1:int, param2:int, param3:int) : ShopItemInfo
      {
         var _loc5_:* = undefined;
         if(param3 == 1)
         {
            if(param2 == 1)
            {
               _loc5_ = _maleShopItemInfoList;
            }
            else
            {
               _loc5_ = _femaleShopItemInfoList;
            }
         }
         else
         {
            _loc5_ = _weaponShopItemInfoList;
         }
         var _loc7_:int = 0;
         var _loc6_:* = _loc5_;
         for each(var _loc4_ in _loc5_)
         {
            if(param1 == _loc4_.TemplateID)
            {
               return _loc4_;
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
      
      private function pkgHandler(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readByte();
         switch(int(_loc2_) - 3)
         {
            case 0:
               activeHandler(_loc3_);
               break;
            case 1:
               delayTimeHandler(_loc3_);
               break;
            case 2:
               getAllInfoHandler(_loc3_);
         }
      }
      
      private function getAllInfoHandler(param1:PackageIn) : void
      {
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:int = 0;
         var _loc13_:* = null;
         var _loc12_:* = null;
         var _loc14_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc11_:int = param1.readInt();
         _loc9_ = 0;
         while(_loc9_ < _loc11_)
         {
            _loc5_ = param1.readInt();
            _loc3_ = param1.readInt();
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               _loc10_ = param1.readInt();
               _loc2_ = param1.readInt();
               _loc13_ = new AvatarCollectionUnitVo();
               if(_loc5_ == 1)
               {
                  if(_loc2_ == 1)
                  {
                     _maleUnitDic.add(_loc10_,_loc13_);
                     _loc12_ = _maleItemDic[_loc10_];
                  }
                  else
                  {
                     _femaleUnitDic.add(_loc10_,_loc13_);
                     _loc12_ = _femaleItemDic[_loc10_];
                  }
               }
               else if(_loc5_ == 2)
               {
                  _weaponUnitDic.add(_loc10_,_loc13_);
                  _loc12_ = _weaponItemDic[_loc10_];
               }
               _loc14_ = param1.readInt();
               _loc8_ = 0;
               while(_loc8_ < _loc14_)
               {
                  _loc7_ = param1.readInt();
                  _loc4_ = _realItemIdDic[_loc7_];
                  (_loc12_[_loc4_] as AvatarCollectionItemVo).isActivity = true;
                  _loc8_++;
               }
               _loc13_.endTime = param1.readDate();
               _loc6_++;
            }
            _loc9_++;
         }
         isDataComplete = true;
         dispatchEvent(new Event("avatar_collection_data_complete"));
      }
      
      private function activeHandler(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc5_:int = param1.readInt();
         _loc5_ = _realItemIdDic[_loc5_];
         var _loc3_:int = param1.readInt();
         var _loc4_:int = param1.readInt();
         if(_loc4_ == 1)
         {
            if(_loc3_ == 1)
            {
               (_maleItemDic[_loc2_][_loc5_] as AvatarCollectionItemVo).isActivity = true;
            }
            else
            {
               (_femaleItemDic[_loc2_][_loc5_] as AvatarCollectionItemVo).isActivity = true;
            }
         }
         else if(_loc4_ == 2)
         {
            (_weaponItemDic[_loc2_][_loc5_] as AvatarCollectionItemVo).isActivity = true;
         }
         dispatchEvent(new Event("avatar_collection_refresh_view"));
      }
      
      private function delayTimeHandler(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc3_:int = param1.readInt();
         var _loc4_:int = param1.readInt();
         if(_loc4_ == 1)
         {
            if(_loc3_ == 1)
            {
               (_maleUnitDic[_loc2_] as AvatarCollectionUnitVo).endTime = param1.readDate();
            }
            else
            {
               (_femaleUnitDic[_loc2_] as AvatarCollectionUnitVo).endTime = param1.readDate();
            }
         }
         else if(_loc4_ == 2)
         {
            (_weaponUnitDic[_loc2_] as AvatarCollectionUnitVo).endTime = param1.readDate();
         }
         dispatchEvent(new Event("avatar_collection_refresh_view"));
      }
      
      public function isCollectionGoodsByTemplateID(param1:int) : Boolean
      {
         return _allGoodsTemplateIDlist[param1];
      }
      
      public function showFrame(param1:Sprite) : void
      {
         cevent = new CEvent("openview",{"parent":param1});
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
      
      public function visible(param1:Boolean) : void
      {
         dispatchEvent(new CEvent("visible",{"visible":param1}));
      }
   }
}
