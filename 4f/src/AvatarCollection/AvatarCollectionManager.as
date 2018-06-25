package AvatarCollection{   import AvatarCollection.data.AvatarCollectionItemDataAnalyzer;   import AvatarCollection.data.AvatarCollectionItemVo;   import AvatarCollection.data.AvatarCollectionUnitDataAnalyzer;   import AvatarCollection.data.AvatarCollectionUnitVo;   import ddt.data.goods.ShopItemInfo;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.utils.AssetModuleLoader;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;      public class AvatarCollectionManager extends EventDispatcher   {            public static const REFRESH_VIEW:String = "avatar_collection_refresh_view";            public static const DATA_COMPLETE:String = "avatar_collection_data_complete";            public static const SELECT_ALL:String = "avatar_collection_select_all";            public static const VISIBLE:String = "visible";            public static const RESET_LEFT:String = "reset_left";            private static var _instance:AvatarCollectionManager;                   public var isDataComplete:Boolean;            private var _realItemIdDic:DictionaryData;            private var _maleItemDic:DictionaryData;            private var _femaleItemDic:DictionaryData;            private var _weaponItemDic:DictionaryData;            private var _allGoodsTemplateIDlist:DictionaryData;            private var _maleItemList:Vector.<AvatarCollectionItemVo>;            private var _femaleItemList:Vector.<AvatarCollectionItemVo>;            private var _weaponItemList:Vector.<AvatarCollectionItemVo>;            private var _maleUnitList:Array;            private var _femaleUnitList:Array;            private var _weaponUnitList:Array;            private var _maleUnitDic:DictionaryData;            private var _femaleUnitDic:DictionaryData;            private var _weaponUnitDic:DictionaryData;            private var _maleShopItemInfoList:Vector.<ShopItemInfo>;            private var _femaleShopItemInfoList:Vector.<ShopItemInfo>;            private var _weaponShopItemInfoList:Vector.<ShopItemInfo>;            private var _isHasCheckedBuy:Boolean = false;            public var isCheckedAvatarTime:Boolean = false;            public var isSkipFromHall:Boolean = false;            public var skipId:int;            private var _isSelectAll:Boolean = false;            private var _pageType:int;            private var _listState:String = "normal";            private var _gotAllInfo:Boolean = false;            private var cevent:CEvent;            public function AvatarCollectionManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : AvatarCollectionManager { return null; }
            private function honourNeedPerPage(_data:AvatarCollectionUnitVo) : Number { return 0; }
            public function honourNeedTotalPerDay() : Number { return 0; }
            public function onListCellClick($data:AvatarCollectionUnitVo, $selected:Boolean) : void { }
            public function get isSelectAll() : Boolean { return false; }
            public function set isSelectAll(value:Boolean) : void { }
            public function getSelectState(data:AvatarCollectionUnitVo) : Boolean { return false; }
            public function get pageType() : int { return 0; }
            public function set pageType(value:int) : void { }
            public function selectAllClicked(bool:Object = null) : void { }
            public function getDelayTimeCollectionCount() : Number { return 0; }
            public function delayTheTimeConfirmed(count:int) : void { }
            public function listState(state:String) : void { }
            public function getListState() : String { return null; }
            public function resetListCellData() : void { }
            public function get maleUnitList() : Array { return null; }
            public function get femaleUnitList() : Array { return null; }
            public function get weaponUnitList() : Array { return null; }
            public function getItemListById(sex:int, id:int, type:int = 1) : Array { return null; }
            public function unitListDataSetup(analyzer:AvatarCollectionUnitDataAnalyzer) : void { }
            private function unitDicDataConvert(dicDest:DictionaryData, dicOrig:DictionaryData) : void { }
            public function itemListDataSetup(analyzer:AvatarCollectionItemDataAnalyzer) : void { }
            private function itemDicDataConvert(dicDest:DictionaryData, dicOrig:DictionaryData) : void { }
            public function initShopItemInfoList() : void { }
            public function checkItemCanBuy() : void { }
            public function getShopItemInfoByItemId(itemId:int, sex:int, type:int) : ShopItemInfo { return null; }
            public function setup() : void { }
            private function pkgHandler(event:PkgEvent) : void { }
            private function getAllInfoHandler(pkg:PackageIn) : void { }
            private function activeHandler(pkg:PackageIn) : void { }
            private function delayTimeHandler(pkg:PackageIn) : void { }
            public function isCollectionGoodsByTemplateID(id:int) : Boolean { return false; }
            public function showFrame(value:Sprite) : void { }
            public function show() : void { }
            public function closeFrame() : void { }
            public function visible(value:Boolean) : void { }
   }}