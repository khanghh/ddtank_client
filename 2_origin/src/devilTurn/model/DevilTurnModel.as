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
      
      public function getGiftIsGetByID(id:int) : Boolean
      {
         if(getGiftProgress >> id & 1)
         {
            return true;
         }
         return false;
      }
      
      public function get myRankScore() : int
      {
         return _myRankScore;
      }
      
      public function set myRankScore(value:int) : void
      {
         _myRankScore = value;
      }
      
      public function get myRank() : int
      {
         return _myRank;
      }
      
      public function set myRank(value:int) : void
      {
         _myRank = value;
      }
      
      public function get lotteryCount() : int
      {
         return _lotteryCount;
      }
      
      public function set lotteryCount(value:int) : void
      {
         _lotteryCount = value;
      }
      
      public function get jackpot() : Number
      {
         return _jackpot;
      }
      
      public function set jackpot(value:Number) : void
      {
         _jackpot = value;
      }
      
      public function set goodsItemList(value:Vector.<DevilTurnGoodsItem>) : void
      {
         _goodsItemList = value;
      }
      
      public function get goodsItemList() : Vector.<DevilTurnGoodsItem>
      {
         return _goodsItemList;
      }
      
      public function getGoodsItemByID(id:int) : DevilTurnGoodsItem
      {
         var _loc4_:int = 0;
         var _loc3_:* = _goodsItemList;
         for each(var item in _goodsItemList)
         {
            if(item.ID == id)
            {
               return item;
            }
         }
         return null;
      }
      
      public function set boxConverList(value:Array) : void
      {
         _boxConverList = value;
      }
      
      public function get boxConverList() : Array
      {
         return _boxConverList;
      }
      
      public function set pointsShopList(value:Array) : void
      {
         _pointsShopList = value;
      }
      
      public function get pointsShopList() : Array
      {
         return _pointsShopList;
      }
      
      public function set rankAwardList(value:Array) : void
      {
         _rankAwardList = value;
      }
      
      public function get rankAwardList() : Array
      {
         return _rankAwardList;
      }
      
      public function set rankList(value:Array) : void
      {
         if(_rankList)
         {
            _rankList.splice(0,_rankList.length);
         }
         _rankList = value;
      }
      
      public function get rankList() : Array
      {
         return _rankList;
      }
      
      public function addBoxInfo(info:DevilTurnBoxInfo) : void
      {
         _boxInfoData.add(info.id,info);
      }
      
      public function getBoxInfoByID(id:int) : DevilTurnBoxInfo
      {
         return _boxInfoData[id];
      }
      
      public function clearBoxInfoList() : void
      {
         _boxInfoData.clear();
      }
      
      public function getBoxListByID(id:int) : Array
      {
         var boxList:* = null;
         var list:Array = ServerConfigManager.instance.devilTurnCfgBox;
         var _loc6_:int = 0;
         var _loc5_:* = list;
         for each(var idList in list)
         {
            boxList = idList.split(",");
            if(id == int(boxList[0]))
            {
               return boxList;
            }
         }
         return [];
      }
   }
}
