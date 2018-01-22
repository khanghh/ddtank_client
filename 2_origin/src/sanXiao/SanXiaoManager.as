package sanXiao
{
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import sanXiao.model.SXGainedItemDATA;
   import sanXiao.model.SXRewardItemData;
   import sanXiao.model.SXStoreBoughtData;
   import sanXiao.model.SXStoreItemData;
   import sanXiao.model.SanXiaoScoreRewardAnalyzer;
   import sanXiao.model.SanXiaoStoreItemAnalyzer;
   
   public class SanXiaoManager extends CoreManager
   {
      
      public static const SHOW_VIEW:String = "sanxiao_show_view";
      
      public static const UPDATE_DATA:String = "sanxiao_update_data";
      
      public static const MAP_STATUS:String = "sanxiao_map_status";
      
      public static const DROP_OUT_ITEM_GAINED:String = "sanxiao_drop_out_item_gained";
      
      private static var instance:SanXiaoManager;
       
      
      private var _score:int;
      
      private var _stepRemain:Number;
      
      public var propCrossBombCount:int;
      
      public var propSquareBombCount:int;
      
      public var propClearColorCount:int;
      
      public var propChangeColorCount:int;
      
      private var _rewardItemList:Array;
      
      private var _crystalNum:Number = 0;
      
      private var _progressTips:String;
      
      private var _dateEnd:Date;
      
      private var _rewardGainedIDList:Array;
      
      private var _storeRemainList:Array;
      
      public var mapInfo:Array;
      
      private var _isOpen:Boolean = false;
      
      private var _discounts:int = 0;
      
      private var _propPriceList:Array;
      
      private var _itemDataList:Array;
      
      private var _scoreRewardList:Array;
      
      private var _lengthAddedDropOutItem:int;
      
      public function SanXiaoManager(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : SanXiaoManager
      {
         if(!instance)
         {
            instance = new SanXiaoManager(new inner());
         }
         return instance;
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function get stepRemain() : Number
      {
         return _stepRemain;
      }
      
      public function get dropOutItemList() : Array
      {
         return _rewardItemList;
      }
      
      public function get crystalNum() : Number
      {
         return _crystalNum;
      }
      
      public function get nextPriseScoreProgress() : Number
      {
         var _loc5_:int = 0;
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc3_:int = _scoreRewardList.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            if((_scoreRewardList[_loc5_] as SXRewardItemData).point > _score)
            {
               _loc2_ = _loc5_ > 0?_scoreRewardList[_loc5_ - 1].point:0;
               _loc1_ = _scoreRewardList[_loc5_].point - _loc2_;
               _loc4_ = _score - _loc2_;
               _progressTips = _score.toString() + "/" + (_scoreRewardList[_loc5_] as SXRewardItemData).point.toString();
               return Math.floor(_loc4_ / _loc1_ * 10000) / 100;
            }
            _loc5_++;
         }
         _progressTips = _score.toString() + "/" + (_scoreRewardList[_loc3_ - 1] as SXRewardItemData).point.toString();
         return 100;
      }
      
      public function get progressTipsData() : String
      {
         if(_progressTips == null)
         {
            nextPriseScoreProgress;
         }
         return _progressTips;
      }
      
      public function get nextPriseScore() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = _scoreRewardList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if((_scoreRewardList[_loc2_] as SXRewardItemData).point > _score)
            {
               return _scoreRewardList[_loc2_].point;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function get nextRewardSXRewardItemData() : SXRewardItemData
      {
         var _loc2_:int = 0;
         var _loc1_:int = _scoreRewardList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if((_scoreRewardList[_loc2_] as SXRewardItemData).point > _score)
            {
               return _scoreRewardList[_loc2_];
            }
            _loc2_++;
         }
         return _scoreRewardList[_loc1_ - 1];
      }
      
      public function get dataEnd() : Date
      {
         return _dateEnd;
      }
      
      public function get isDiscounts() : Boolean
      {
         return _discounts > 0;
      }
      
      public function setUp() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(329,6),onIsOpen);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,2),onRequireMap);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,15),onBuyTimes);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,5),onGetData);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,17),onGetRewardsData);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,18),onGetStoreData);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,19),onGainedDropItem);
      }
      
      protected function onBuyTimes(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _stepRemain = _loc2_.readInt();
         dispatchEvent(new CEvent("sanxiao_update_data"));
      }
      
      protected function onGainedDropItem(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         if(_rewardItemList == null)
         {
            _rewardItemList = [];
         }
         _lengthAddedDropOutItem = _loc3_.readInt();
         _loc4_ = 0;
         while(_loc4_ < _lengthAddedDropOutItem)
         {
            _loc2_ = new SXGainedItemDATA(_loc3_.readInt(),_loc3_.readInt());
            _rewardItemList.push(_loc2_);
            _loc4_++;
         }
         dispatchEvent(new CEvent("sanxiao_drop_out_item_gained"));
      }
      
      protected function onGetStoreData(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.pkg;
         _crystalNum = _loc5_.readInt();
         var _loc3_:int = _loc5_.readInt();
         _storeRemainList = [];
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc2_ = _loc5_.readInt();
            _loc4_ = _loc5_.readInt();
            _storeRemainList.push(new SXStoreBoughtData(_loc2_,_loc4_));
            _loc6_++;
         }
         dispatchEvent(new CEvent("sanxiao_update_data"));
      }
      
      protected function onGetRewardsData(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         _rewardGainedIDList = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _rewardGainedIDList.push(_loc3_.readInt());
            _loc4_++;
         }
         dispatchEvent(new CEvent("sanxiao_update_data"));
      }
      
      protected function onGetData(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _score = _loc2_.readInt();
         _stepRemain = _loc2_.readInt();
         _crystalNum = _loc2_.readInt();
         _dateEnd = _loc2_.readDate();
         dispatchEvent(new CEvent("sanxiao_update_data"));
      }
      
      protected function onRequireMap(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         mapInfo = [];
         while(_loc2_ > 0)
         {
            mapInfo.push(_loc3_.readInt());
            mapInfo.push(_loc3_.readInt());
            mapInfo.push(_loc3_.readInt());
            _loc2_ = _loc2_ - 1;
         }
         dispatchEvent(new CEvent("sanxiao_map_status"));
      }
      
      protected function onIsOpen(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:Boolean = _loc2_.readBoolean();
         _dateEnd = _loc2_.readDate();
         _discounts = _loc2_.readInt();
         _discounts = _discounts >= 100?0:_discounts;
         _isOpen = _loc3_;
         HallIconManager.instance.updateSwitchHandler("sanxiao",_isOpen);
      }
      
      override protected function start() : void
      {
         propPriceData();
         _rewardItemList = [];
         dispatchEvent(new CEvent("sanxiao_show_view"));
      }
      
      public function getPropPrice(param1:int) : String
      {
         if(_propPriceList == null)
         {
            return "";
         }
         return _propPriceList[param1 * 2 - 1];
      }
      
      public function getPropCurPrice(param1:int) : String
      {
         if(_propPriceList == null)
         {
            return "";
         }
         if(_discounts == 0)
         {
            return getPropPrice(param1);
         }
         return (int(_propPriceList[param1 * 2 - 1] * _discounts / 100)).toString();
      }
      
      public function getPropScore(param1:int) : String
      {
         if(_propPriceList == null)
         {
            return "";
         }
         return _propPriceList[param1 * 2 - 2];
      }
      
      public function propPriceData() : Array
      {
         var _loc1_:ServerConfigManager = ServerConfigManager.instance;
         if(!_propPriceList)
         {
            _propPriceList = [_loc1_.SanXiaoCrossBombScore(),_loc1_.SanXiaoCrossBombPrice(),_loc1_.SanXiaoSquareBombScore(),_loc1_.SanXiaoSquareBombPrice(),_loc1_.SanXiaoClearColorScore(),_loc1_.SanXiaoClearColorPrice(),_loc1_.SanXiaoChangeColorScore(),_loc1_.SanXiaoChangeColorPrice()];
         }
         return _propPriceList;
      }
      
      public function get itemDataList() : Array
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         if(_itemDataList == null)
         {
            return [];
         }
         var _loc3_:int = _itemDataList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _storeRemainList;
            for each(var _loc1_ in _storeRemainList)
            {
               _loc2_ = _itemDataList[_loc4_];
               if(_loc2_.id == _loc1_.id)
               {
                  _loc2_.remain = _loc2_.total - _loc1_.boughtTimes;
               }
            }
            _loc4_++;
         }
         return _itemDataList;
      }
      
      public function get scoreRewardList() : Array
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         if(_scoreRewardList == null)
         {
            return [];
         }
         var _loc3_:int = _scoreRewardList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _rewardGainedIDList;
            for each(var _loc1_ in _rewardGainedIDList)
            {
               _loc2_ = _scoreRewardList[_loc4_];
               if(_loc2_.id == _loc1_)
               {
                  _loc2_.gained = true;
               }
            }
            _loc4_++;
         }
         return _scoreRewardList;
      }
      
      public function get endTime() : Date
      {
         return _dateEnd;
      }
      
      public function onSXScoreRewardData(param1:SanXiaoScoreRewardAnalyzer) : void
      {
         _scoreRewardList = param1.list;
      }
      
      public function onSXStoreItemData(param1:SanXiaoStoreItemAnalyzer) : void
      {
         _itemDataList = param1.list;
      }
      
      public function get lengthAddedDropOutItem() : int
      {
         return _lengthAddedDropOutItem;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
