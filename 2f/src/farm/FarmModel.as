package farm{   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.PlayerManager;   import ddt.manager.TimeManager;   import farm.modelx.FieldVO;   import farm.modelx.SuperPetFoodPriceInfo;   import farm.view.compose.vo.FoodComposeListTemplateInfo;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.utils.Dictionary;   import road7th.data.DictionaryData;      public class FarmModel extends EventDispatcher   {                   public var FarmTreeLevel:int;            public var farmPoultryInfo:Dictionary;            public var PoultryState:int;            public var SelectIndex:int;            private var _prosperityCostList:Dictionary;            public var payFieldMoney:String;            public var payAutoMoney:String;            public var autoPayTime:Date;            public var autoValidDate:int;            public var vipLimitLevel:int;            private var _stopTime:Date;            private var _isArrange:Boolean;            public var helperArray:Array;            private var _currentFarmerId:int;            public var currentFarmerName:String;            public var fieldsInfo:Vector.<FieldVO>;            public var seedingFieldInfo:FieldVO;            public var selfFieldsInfo:Vector.<FieldVO>;            public var gainFieldId:int;            public var payFieldIDs:Array;            public var matureId:int;            public var killCropId:int;            public var isAutoId:int;            public var batchFieldIDArray:Array;            public var foodComposeList:Vector.<FoodComposeListTemplateInfo>;            private var _friendStateList:DictionaryData;            private var _friendStateListStolenInfo:DictionaryData;            private var _buyExpRemainNum:int;            private var _priceList:Vector.<SuperPetFoodPriceInfo>;            public function FarmModel(target:IEventDispatcher = null) { super(null); }
            public function get prosperityCostList() : Dictionary { return null; }
            public function set prosperityCostList(value:Dictionary) : void { }
            public function get payFieldDiscount() : int { return 0; }
            public function get payAutoMoneyToWeek() : int { return 0; }
            public function get payAutoTimeToWeek() : int { return 0; }
            public function get payAutoMoneyToMonth() : int { return 0; }
            public function get payAutoTimeToMonth() : int { return 0; }
            public function get payFieldMoneyToWeek() : int { return 0; }
            public function get payFieldMoneyToMonth() : int { return 0; }
            public function get payFieldTimeToWeek() : int { return 0; }
            public function get payFieldTimeToMonth() : int { return 0; }
            public function get isArrange() : Boolean { return false; }
            public function set isArrange(value:Boolean) : void { }
            public function get isHelperMay() : Boolean { return false; }
            public function get stopTime() : Date { return null; }
            public function get currentFarmerId() : int { return 0; }
            public function set currentFarmerId(value:int) : void { }
            public function getfieldInfoById(fieldId:int) : FieldVO { return null; }
            public function get friendStateList() : DictionaryData { return null; }
            public function set friendStateList(value:DictionaryData) : void { }
            public function get friendStateListStolenInfo() : DictionaryData { return null; }
            public function set friendStateListStolenInfo(value:DictionaryData) : void { }
            public function findItemInfo(equipType:int, templateID:int) : InventoryItemInfo { return null; }
            public function getSeedCountByID(templateID:int) : int { return 0; }
            public function get buyExpRemainNum() : int { return 0; }
            public function set buyExpRemainNum(value:int) : void { }
            public function get priceList() : Vector.<SuperPetFoodPriceInfo> { return null; }
            public function set priceList(value:Vector.<SuperPetFoodPriceInfo>) : void { }
   }}