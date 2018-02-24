package devilTurn.model
{
   import ddt.manager.ServerConfigManager;
   import road7th.data.DictionaryData;
   
   public class DevilTurnModel
   {
      
      public static const DEVUIL_TURN_TYPE:int = 19;
       
      
      private var _goodsItemList:Vector.<DevilTurnGoodsItem>;
      
      private var _boxConverList:Array;
      
      private var _pointsShopList:Array;
      
      private var _rankAwardList:Array;
      
      private var _rankList:Array;
      
      private var _lotteryCount:int;
      
      private var _myRank:int;
      
      private var _myRankScore:int;
      
      public var beadCount1:int;
      
      public var beadCount2:int;
      
      public var beadCount3:int;
      
      public var beadCount4:int;
      
      public var beadCount5:int;
      
      public var getGiftProgress:int;
      
      private var _jackpot:Number;
      
      public var freeTimes:int;
      
      public var freeDate:int;
      
      public var totalJackpot:int;
      
      public var activityDate:String;
      
      private var _boxInfoData:DictionaryData;
      
      public function DevilTurnModel()
      {
         super();
         _boxInfoData = new DictionaryData();
      }
      
      public function getGiftIsGetByID(param1:int) : Boolean
      {
         if(getGiftProgress >> param1 & 1)
         {
            return true;
         }
         return false;
      }
      
      public function get myRankScore() : int
      {
         return _myRankScore;
      }
      
      public function set myRankScore(param1:int) : void
      {
         _myRankScore = param1;
      }
      
      public function get myRank() : int
      {
         return _myRank;
      }
      
      public function set myRank(param1:int) : void
      {
         _myRank = param1;
      }
      
      public function get lotteryCount() : int
      {
         return _lotteryCount;
      }
      
      public function set lotteryCount(param1:int) : void
      {
         _lotteryCount = param1;
      }
      
      public function get jackpot() : Number
      {
         return _jackpot;
      }
      
      public function set jackpot(param1:Number) : void
      {
         _jackpot = param1;
      }
      
      public function set goodsItemList(param1:Vector.<DevilTurnGoodsItem>) : void
      {
         _goodsItemList = param1;
      }
      
      public function get goodsItemList() : Vector.<DevilTurnGoodsItem>
      {
         return _goodsItemList;
      }
      
      public function getGoodsItemByID(param1:int) : DevilTurnGoodsItem
      {
         var _loc4_:int = 0;
         var _loc3_:* = _goodsItemList;
         for each(var _loc2_ in _goodsItemList)
         {
            if(_loc2_.ID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function set boxConverList(param1:Array) : void
      {
         _boxConverList = param1;
      }
      
      public function get boxConverList() : Array
      {
         return _boxConverList;
      }
      
      public function set pointsShopList(param1:Array) : void
      {
         _pointsShopList = param1;
      }
      
      public function get pointsShopList() : Array
      {
         return _pointsShopList;
      }
      
      public function set rankAwardList(param1:Array) : void
      {
         _rankAwardList = param1;
      }
      
      public function get rankAwardList() : Array
      {
         return _rankAwardList;
      }
      
      public function set rankList(param1:Array) : void
      {
         if(_rankList)
         {
            _rankList.splice(0,_rankList.length);
         }
         _rankList = param1;
      }
      
      public function get rankList() : Array
      {
         return _rankList;
      }
      
      public function addBoxInfo(param1:DevilTurnBoxInfo) : void
      {
         _boxInfoData.add(param1.id,param1);
      }
      
      public function getBoxInfoByID(param1:int) : DevilTurnBoxInfo
      {
         return _boxInfoData[param1];
      }
      
      public function clearBoxInfoList() : void
      {
         _boxInfoData.clear();
      }
      
      public function getBoxListByID(param1:int) : Array
      {
         var _loc4_:* = null;
         var _loc2_:Array = ServerConfigManager.instance.devilTurnCfgBox;
         var _loc6_:int = 0;
         var _loc5_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            _loc4_ = _loc3_.split(",");
            if(param1 == int(_loc4_[0]))
            {
               return _loc4_;
            }
         }
         return [];
      }
   }
}
