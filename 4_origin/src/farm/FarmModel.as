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
      
      public function FarmModel(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public function get prosperityCostList() : Dictionary
      {
         return _prosperityCostList;
      }
      
      public function set prosperityCostList(value:Dictionary) : void
      {
         _prosperityCostList = value;
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
      
      public function set isArrange(value:Boolean) : void
      {
         _isArrange = value;
      }
      
      public function get isHelperMay() : Boolean
      {
         return (TimeManager.Instance.Now().time - autoPayTime.time) / 3600000 <= autoValidDate;
      }
      
      public function get stopTime() : Date
      {
         _stopTime = new Date();
         var time:Number = autoPayTime.time + autoValidDate * 60 * 60 * 1000;
         _stopTime.setTime(time);
         return _stopTime;
      }
      
      public function get currentFarmerId() : int
      {
         return _currentFarmerId;
      }
      
      public function set currentFarmerId(value:int) : void
      {
         _currentFarmerId = value;
      }
      
      public function getfieldInfoById(fieldId:int) : FieldVO
      {
         var _loc4_:int = 0;
         var _loc3_:* = fieldsInfo;
         for each(var field in fieldsInfo)
         {
            if(field.fieldID == fieldId)
            {
               return field;
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
      
      public function set friendStateList(value:DictionaryData) : void
      {
         _friendStateList = value;
      }
      
      public function get friendStateListStolenInfo() : DictionaryData
      {
         if(_friendStateListStolenInfo == null)
         {
            _friendStateListStolenInfo = new DictionaryData();
         }
         return _friendStateListStolenInfo;
      }
      
      public function set friendStateListStolenInfo(value:DictionaryData) : void
      {
         _friendStateListStolenInfo = value;
      }
      
      public function findItemInfo(equipType:int, templateID:int) : InventoryItemInfo
      {
         var itemInfo:* = null;
         var arr:Array = PlayerManager.Instance.Self.getBag(13).findItems(equipType);
         var _loc7_:int = 0;
         var _loc6_:* = arr;
         for each(var item in arr)
         {
            if(item.TemplateID == templateID)
            {
               itemInfo = item;
               break;
            }
         }
         return itemInfo;
      }
      
      public function getSeedCountByID(templateID:int) : int
      {
         var allCount:int = 0;
         var arr:Array = PlayerManager.Instance.Self.getBag(13).findItems(32);
         var _loc6_:int = 0;
         var _loc5_:* = arr;
         for each(var item in arr)
         {
            if(item.TemplateID == templateID)
            {
               allCount = allCount + item.Count;
            }
         }
         return allCount;
      }
      
      public function get buyExpRemainNum() : int
      {
         return _buyExpRemainNum;
      }
      
      public function set buyExpRemainNum(value:int) : void
      {
         _buyExpRemainNum = value;
      }
      
      public function get priceList() : Vector.<SuperPetFoodPriceInfo>
      {
         return _priceList;
      }
      
      public function set priceList(value:Vector.<SuperPetFoodPriceInfo>) : void
      {
         _priceList = value;
      }
   }
}
