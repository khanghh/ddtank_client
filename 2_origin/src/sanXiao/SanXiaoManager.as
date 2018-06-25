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
      
      public function SanXiaoManager(single:inner)
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
         var i:int = 0;
         var __min:Number = NaN;
         var __max:Number = NaN;
         var __cur:Number = NaN;
         var len:int = _scoreRewardList.length;
         for(i = 0; i < len; )
         {
            if((_scoreRewardList[i] as SXRewardItemData).point > _score)
            {
               __min = i > 0?_scoreRewardList[i - 1].point:0;
               __max = _scoreRewardList[i].point - __min;
               __cur = _score - __min;
               _progressTips = _score.toString() + "/" + (_scoreRewardList[i] as SXRewardItemData).point.toString();
               return Math.floor(__cur / __max * 10000) / 100;
            }
            i++;
         }
         _progressTips = _score.toString() + "/" + (_scoreRewardList[len - 1] as SXRewardItemData).point.toString();
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
         var i:int = 0;
         var len:int = _scoreRewardList.length;
         for(i = 0; i < len; )
         {
            if((_scoreRewardList[i] as SXRewardItemData).point > _score)
            {
               return _scoreRewardList[i].point;
            }
            i++;
         }
         return -1;
      }
      
      public function get nextRewardSXRewardItemData() : SXRewardItemData
      {
         var i:int = 0;
         var len:int = _scoreRewardList.length;
         for(i = 0; i < len; )
         {
            if((_scoreRewardList[i] as SXRewardItemData).point > _score)
            {
               return _scoreRewardList[i];
            }
            i++;
         }
         return _scoreRewardList[len - 1];
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
      
      protected function onBuyTimes(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         _stepRemain = pkg.readInt();
         dispatchEvent(new CEvent("sanxiao_update_data"));
      }
      
      protected function onGainedDropItem(e:PkgEvent) : void
      {
         var i:int = 0;
         var data:* = null;
         var pkg:PackageIn = e.pkg;
         if(_rewardItemList == null)
         {
            _rewardItemList = [];
         }
         _lengthAddedDropOutItem = pkg.readInt();
         for(i = 0; i < _lengthAddedDropOutItem; )
         {
            data = new SXGainedItemDATA(pkg.readInt(),pkg.readInt());
            _rewardItemList.push(data);
            i++;
         }
         dispatchEvent(new CEvent("sanxiao_drop_out_item_gained"));
      }
      
      protected function onGetStoreData(e:PkgEvent) : void
      {
         var i:int = 0;
         var id:int = 0;
         var boughtTimes:int = 0;
         var pkg:PackageIn = e.pkg;
         _crystalNum = pkg.readInt();
         var count:int = pkg.readInt();
         _storeRemainList = [];
         for(i = 0; i < count; )
         {
            id = pkg.readInt();
            boughtTimes = pkg.readInt();
            _storeRemainList.push(new SXStoreBoughtData(id,boughtTimes));
            i++;
         }
         dispatchEvent(new CEvent("sanxiao_update_data"));
      }
      
      protected function onGetRewardsData(e:PkgEvent) : void
      {
         var i:int = 0;
         var pkg:PackageIn = e.pkg;
         var count:int = pkg.readInt();
         _rewardGainedIDList = [];
         for(i = 0; i < count; )
         {
            _rewardGainedIDList.push(pkg.readInt());
            i++;
         }
         dispatchEvent(new CEvent("sanxiao_update_data"));
      }
      
      protected function onGetData(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         _score = pkg.readInt();
         _stepRemain = pkg.readInt();
         _crystalNum = pkg.readInt();
         _dateEnd = pkg.readDate();
         dispatchEvent(new CEvent("sanxiao_update_data"));
      }
      
      protected function onRequireMap(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var count:int = pkg.readInt();
         mapInfo = [];
         while(count > 0)
         {
            mapInfo.push(pkg.readInt());
            mapInfo.push(pkg.readInt());
            mapInfo.push(pkg.readInt());
            count = count - 1;
         }
         dispatchEvent(new CEvent("sanxiao_map_status"));
      }
      
      protected function onIsOpen(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var isOpen:Boolean = pkg.readBoolean();
         _dateEnd = pkg.readDate();
         _discounts = pkg.readInt();
         _discounts = _discounts >= 100?0:_discounts;
         _isOpen = isOpen;
         HallIconManager.instance.updateSwitchHandler("sanxiao",_isOpen);
      }
      
      override protected function start() : void
      {
         propPriceData();
         _rewardItemList = [];
         dispatchEvent(new CEvent("sanxiao_show_view"));
      }
      
      public function getPropPrice(index:int) : String
      {
         if(_propPriceList == null)
         {
            return "";
         }
         return _propPriceList[index * 2 - 1];
      }
      
      public function getPropCurPrice(index:int) : String
      {
         if(_propPriceList == null)
         {
            return "";
         }
         if(_discounts == 0)
         {
            return getPropPrice(index);
         }
         return (int(_propPriceList[index * 2 - 1] * _discounts / 100)).toString();
      }
      
      public function getPropScore(index:int) : String
      {
         if(_propPriceList == null)
         {
            return "";
         }
         return _propPriceList[index * 2 - 2];
      }
      
      public function propPriceData() : Array
      {
         var ins:ServerConfigManager = ServerConfigManager.instance;
         if(!_propPriceList)
         {
            _propPriceList = [ins.SanXiaoCrossBombScore(),ins.SanXiaoCrossBombPrice(),ins.SanXiaoSquareBombScore(),ins.SanXiaoSquareBombPrice(),ins.SanXiaoClearColorScore(),ins.SanXiaoClearColorPrice(),ins.SanXiaoChangeColorScore(),ins.SanXiaoChangeColorPrice()];
         }
         return _propPriceList;
      }
      
      public function get itemDataList() : Array
      {
         var i:int = 0;
         var data:* = null;
         if(_itemDataList == null)
         {
            return [];
         }
         var len:int = _itemDataList.length;
         for(i = 0; i < len; i++)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _storeRemainList;
            for each(var v in _storeRemainList)
            {
               data = _itemDataList[i];
               if(data.id == v.id)
               {
                  data.remain = data.total - v.boughtTimes;
               }
            }
         }
         return _itemDataList;
      }
      
      public function get scoreRewardList() : Array
      {
         var i:int = 0;
         var data:* = null;
         if(_scoreRewardList == null)
         {
            return [];
         }
         var len:int = _scoreRewardList.length;
         for(i = 0; i < len; i++)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _rewardGainedIDList;
            for each(var v in _rewardGainedIDList)
            {
               data = _scoreRewardList[i];
               if(data.id == v)
               {
                  data.gained = true;
               }
            }
         }
         return _scoreRewardList;
      }
      
      public function get endTime() : Date
      {
         return _dateEnd;
      }
      
      public function onSXScoreRewardData(analyzer:SanXiaoScoreRewardAnalyzer) : void
      {
         _scoreRewardList = analyzer.list;
      }
      
      public function onSXStoreItemData(analyzer:SanXiaoStoreItemAnalyzer) : void
      {
         _itemDataList = analyzer.list;
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
