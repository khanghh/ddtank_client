package ddQiYuan.model
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class DDQiYuanModel extends EventDispatcher
   {
      
      public static const BAO_ZHU_TOTAL_NUM:int = 7;
      
      public static const OPEN_TREASURE_BOX_ADD_DEGREE:int = 5;
      
      public static const OFFER_1_TIME_ADD_DEGREE:int = 1;
      
      public static const OFFER_10_TIME_ADD_DEGREE:int = 10;
       
      
      public var isOpen:Boolean = false;
      
      public var endTime:Date;
      
      public var beliefConfigArr:Array;
      
      public var myAreaRankConfigArr:Array;
      
      public var allAreaRankConfigArr:Array;
      
      public var joinRewardLeastOfferTimes:int;
      
      public var rankRewardLeastOfferTimes:int;
      
      public var joinRewardGood:Object;
      
      public var joinRewardProbabilityGainGood:Object;
      
      public var offerTimesPerBaoZhu:int;
      
      public var offerTimesPerTreasureBox:int;
      
      public var myAreaOfferDegree:int;
      
      public var myAreaOfferTimes:int;
      
      public var myOfferTimes:int;
      
      public var hasGetGoodArr:Array;
      
      public var taskGroupArr:Array;
      
      public var towerTaskRewardArr:Array;
      
      public var myAreaRankArr:Array;
      
      public var allAreaRankArr:Array;
      
      public var offer1Or10TimesRewardBoxGoodArr:Array;
      
      public var openTreasureBoxGoodArr:Array;
      
      public var hasGainTreasureBoxNum:int;
      
      public var hasGainJoinRewardCount:int;
      
      public var OFFER_1_TIME_COST_MONEY:int = 100;
      
      public var OFFER_10_TIME_COST_MONEY:int = 900;
      
      public var OPEN_TREASUREBOX_COST_MONEY:int = 500;
      
      public function DDQiYuanModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
   }
}
