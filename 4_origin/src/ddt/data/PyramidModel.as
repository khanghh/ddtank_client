package ddt.data
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PyramidEvent;
   import ddt.manager.ItemManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class PyramidModel extends EventDispatcher
   {
       
      
      public var isOpen:Boolean;
      
      public var isScoreExchange:Boolean;
      
      public var turnCardPrice:int;
      
      public var revivePrice:Array;
      
      public var freeCount:int;
      
      public var beginTime:Date;
      
      public var endTime:Date;
      
      public var currentLayer:int;
      
      public var position:int;
      
      public var maxLayer:int;
      
      private var _totalPoint:int;
      
      public var turnPoint:int;
      
      public var pointRatio:int;
      
      public var currentFreeCount:int;
      
      public var currentReviveCount:int;
      
      public var isPyramidStart:Boolean;
      
      public var selectLayerItems:Dictionary;
      
      public var templateID:int;
      
      public var isPyramidDie:Boolean;
      
      public var isUp:Boolean;
      
      public var items:Array;
      
      public function PyramidModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function getLevelCardItems(param1:int) : Array
      {
         return items[param1 - 1];
      }
      
      public function getLevelCardItem(param1:int, param2:int) : PyramidSystemItemsInfo
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         if(isUp)
         {
            _loc3_ = items[param1 - 2];
         }
         else
         {
            _loc3_ = items[param1 - 1];
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc6_];
            if(_loc5_.TemplateID == param2)
            {
               _loc4_ = _loc5_;
               break;
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public function getInventoryItemInfo(param1:PyramidSystemItemsInfo) : InventoryItemInfo
      {
         var _loc3_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param1.TemplateID);
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(_loc2_,_loc3_);
         _loc2_.LuckCompose = param1.TemplateID;
         _loc2_.ValidDate = param1.ValidDate;
         _loc2_.Count = param1.Count;
         _loc2_.IsBinds = param1.IsBind;
         _loc2_.StrengthenLevel = param1.StrengthLevel;
         _loc2_.AttackCompose = param1.AttackCompose;
         _loc2_.DefendCompose = param1.DefendCompose;
         _loc2_.AgilityCompose = param1.AgilityCompose;
         _loc2_.LuckCompose = param1.LuckCompose;
         _loc2_.isShowBind = false;
         return _loc2_;
      }
      
      public function get startActivityTime() : String
      {
         var _loc1_:* = null;
         var _loc2_:String = "";
         if(beginTime)
         {
            _loc1_ = beginTime.minutes > 9?beginTime.minutes + "":"0" + beginTime.minutes;
            _loc2_ = beginTime.fullYear + "." + (beginTime.month + 1) + "." + beginTime.date + " " + beginTime.hours + ":" + _loc1_;
         }
         return _loc2_;
      }
      
      public function get endActivityTime() : String
      {
         var _loc1_:* = null;
         var _loc2_:String = "";
         if(endTime)
         {
            _loc1_ = endTime.minutes > 9?endTime.minutes + "":"0" + endTime.minutes;
            _loc2_ = endTime.fullYear + "." + (endTime.month + 1) + "." + endTime.date + " " + endTime.hours + ":" + _loc1_;
         }
         return _loc2_;
      }
      
      public function get isShuffleMovie() : Boolean
      {
         if(currentLayer >= 8)
         {
            return false;
         }
         if(!isPyramidStart)
         {
            return false;
         }
         if(isUp)
         {
            return true;
         }
         var _loc2_:int = 0;
         var _loc1_:Dictionary = selectLayerItems[currentLayer];
         var _loc5_:int = 0;
         var _loc4_:* = _loc1_;
         for each(var _loc3_ in _loc1_)
         {
            _loc2_++;
         }
         if(_loc2_ > 0)
         {
            return false;
         }
         return true;
      }
      
      public function dataChange(param1:String, param2:Object = null) : void
      {
         dispatchEvent(new PyramidEvent(param1,param2));
      }
      
      public function set totalPoint(param1:int) : void
      {
         _totalPoint = param1;
         dispatchEvent(new PyramidEvent("dataChange"));
      }
      
      public function get totalPoint() : int
      {
         return this._totalPoint;
      }
   }
}
