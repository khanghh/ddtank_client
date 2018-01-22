package farm
{
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.PlayerManager;
   import ddt.manager.TimeManager;
   import farm.modelx.FieldVO;
   import farm.modelx.SuperPetFoodPriceInfo;
   import farm.view.compose.vo.FoodComposeListTemplateInfo;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   
   public class FarmModel extends EventDispatcher
   {
       
      
      public var FarmTreeLevel:int;
      
      public var farmPoultryInfo:Dictionary;
      
      public var PoultryState:int;
      
      public var SelectIndex:int;
      
      private var _prosperityCostList:Dictionary;
      
      public var payFieldMoney:String;
      
      public var payAutoMoney:String;
      
      public var autoPayTime:Date;
      
      public var autoValidDate:int;
      
      public var vipLimitLevel:int;
      
      private var _stopTime:Date;
      
      private var _isArrange:Boolean;
      
      public var helperArray:Array;
      
      private var _currentFarmerId:int;
      
      public var currentFarmerName:String;
      
      public var fieldsInfo:Vector.<FieldVO>;
      
      public var seedingFieldInfo:FieldVO;
      
      public var selfFieldsInfo:Vector.<FieldVO>;
      
      public var gainFieldId:int;
      
      public var payFieldIDs:Array;
      
      public var matureId:int;
      
      public var killCropId:int;
      
      public var isAutoId:int;
      
      public var batchFieldIDArray:Array;
      
      public var foodComposeList:Vector.<FoodComposeListTemplateInfo>;
      
      private var _friendStateList:DictionaryData;
      
      private var _friendStateListStolenInfo:DictionaryData;
      
      private var _buyExpRemainNum:int;
      
      private var _priceList:Vector.<SuperPetFoodPriceInfo>;
      
      public function FarmModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get prosperityCostList() : Dictionary
      {
         return _prosperityCostList;
      }
      
      public function set prosperityCostList(param1:Dictionary) : void
      {
         _prosperityCostList = param1;
      }
      
      public function get payFieldDiscount() : int
      {
         if(payFieldMoney.split("|")[2])
         {
            return parseInt(payFieldMoney.split("|")[2]);
         }
         return 100;
      }
      
      public function get payAutoMoneyToWeek() : int
      {
         return parseInt(payAutoMoney.split("|")[0].split(",")[1]);
      }
      
      public function get payAutoTimeToWeek() : int
      {
         return parseInt(payAutoMoney.split("|")[0].split(",")[0]);
      }
      
      public function get payAutoMoneyToMonth() : int
      {
         return parseInt(payAutoMoney.split("|")[1].split(",")[1]);
      }
      
      public function get payAutoTimeToMonth() : int
      {
         return parseInt(payAutoMoney.split("|")[1].split(",")[0]);
      }
      
      public function get payFieldMoneyToWeek() : int
      {
         return parseInt(payFieldMoney.split("|")[0].split(",")[1]);
      }
      
      public function get payFieldMoneyToMonth() : int
      {
         return parseInt(payFieldMoney.split("|")[1].split(",")[1]);
      }
      
      public function get payFieldTimeToWeek() : int
      {
         return parseInt(payFieldMoney.split("|")[0].split(",")[0]);
      }
      
      public function get payFieldTimeToMonth() : int
      {
         return parseInt(payFieldMoney.split("|")[1].split(",")[0]);
      }
      
      public function get isArrange() : Boolean
      {
         return _isArrange;
      }
      
      public function set isArrange(param1:Boolean) : void
      {
         _isArrange = param1;
      }
      
      public function get isHelperMay() : Boolean
      {
         return (TimeManager.Instance.Now().time - autoPayTime.time) / 3600000 <= autoValidDate;
      }
      
      public function get stopTime() : Date
      {
         _stopTime = new Date();
         var _loc1_:Number = autoPayTime.time + autoValidDate * 60 * 60 * 1000;
         _stopTime.setTime(_loc1_);
         return _stopTime;
      }
      
      public function get currentFarmerId() : int
      {
         return _currentFarmerId;
      }
      
      public function set currentFarmerId(param1:int) : void
      {
         _currentFarmerId = param1;
      }
      
      public function getfieldInfoById(param1:int) : FieldVO
      {
         var _loc4_:int = 0;
         var _loc3_:* = fieldsInfo;
         for each(var _loc2_ in fieldsInfo)
         {
            if(_loc2_.fieldID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get friendStateList() : DictionaryData
      {
         if(_friendStateList == null)
         {
            _friendStateList = new DictionaryData();
         }
         return _friendStateList;
      }
      
      public function set friendStateList(param1:DictionaryData) : void
      {
         _friendStateList = param1;
      }
      
      public function get friendStateListStolenInfo() : DictionaryData
      {
         if(_friendStateListStolenInfo == null)
         {
            _friendStateListStolenInfo = new DictionaryData();
         }
         return _friendStateListStolenInfo;
      }
      
      public function set friendStateListStolenInfo(param1:DictionaryData) : void
      {
         _friendStateListStolenInfo = param1;
      }
      
      public function findItemInfo(param1:int, param2:int) : InventoryItemInfo
      {
         var _loc5_:* = null;
         var _loc3_:Array = PlayerManager.Instance.Self.getBag(13).findItems(param1);
         var _loc7_:int = 0;
         var _loc6_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            if(_loc4_.TemplateID == param2)
            {
               _loc5_ = _loc4_;
               break;
            }
         }
         return _loc5_;
      }
      
      public function getSeedCountByID(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:Array = PlayerManager.Instance.Self.getBag(13).findItems(32);
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            if(_loc4_.TemplateID == param1)
            {
               _loc2_ = _loc2_ + _loc4_.Count;
            }
         }
         return _loc2_;
      }
      
      public function get buyExpRemainNum() : int
      {
         return _buyExpRemainNum;
      }
      
      public function set buyExpRemainNum(param1:int) : void
      {
         _buyExpRemainNum = param1;
      }
      
      public function get priceList() : Vector.<SuperPetFoodPriceInfo>
      {
         return _priceList;
      }
      
      public function set priceList(param1:Vector.<SuperPetFoodPriceInfo>) : void
      {
         _priceList = param1;
      }
   }
}
