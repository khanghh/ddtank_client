package cloudBuyLottery.model
{
   import cloudBuyLottery.view.WinningLogItemInfo;
   
   public class CloudBuyLotteryModel
   {
       
      
      private var _isOpen:Boolean;
      
      private var _luckTime:Date;
      
      public var myGiftData:Vector.<WinningLogItemInfo>;
      
      public var packsLen:int = 15;
      
      private var _moneyNum:int = 200;
      
      private var _templateId:int;
      
      private var _templatedIdCount:int;
      
      private var _validDate:int;
      
      private var _property:Array;
      
      private var _count:int;
      
      private var _buyGoodsIDArray:Array;
      
      private var _buyGoodsCountArray:Array;
      
      private var _buyMoney:int;
      
      private var _maxNum:int;
      
      private var _currentNum:int;
      
      private var _totalSeconds:int;
      
      private var _luckCount:int;
      
      private var _remainTimes:int;
      
      private var _luckDrawId:int;
      
      private var _isGame:Boolean;
      
      private var _isGetReward:Boolean;
      
      public function CloudBuyLotteryModel()
      {
         super();
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set isOpen(value:Boolean) : void
      {
         _isOpen = value;
      }
      
      public function get luckTime() : Date
      {
         return _luckTime;
      }
      
      public function set luckTime(value:Date) : void
      {
         _luckTime = value;
      }
      
      public function get moneyNum() : int
      {
         return _moneyNum;
      }
      
      public function set moneyNum(value:int) : void
      {
         _moneyNum = value;
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(value:int) : void
      {
         _templateId = value;
      }
      
      public function get validDate() : int
      {
         return _validDate;
      }
      
      public function set validDate(value:int) : void
      {
         _validDate = value;
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set count(value:int) : void
      {
         _count = value;
      }
      
      public function get buyGoodsIDArray() : Array
      {
         return _buyGoodsIDArray;
      }
      
      public function set buyGoodsIDArray(value:Array) : void
      {
         _buyGoodsIDArray = value;
      }
      
      public function get buyGoodsCountArray() : Array
      {
         return _buyGoodsCountArray;
      }
      
      public function set buyGoodsCountArray(value:Array) : void
      {
         _buyGoodsCountArray = value;
      }
      
      public function get buyMoney() : int
      {
         return _buyMoney;
      }
      
      public function set buyMoney(value:int) : void
      {
         _buyMoney = value;
      }
      
      public function get maxNum() : int
      {
         return _maxNum;
      }
      
      public function set maxNum(value:int) : void
      {
         _maxNum = value;
      }
      
      public function get currentNum() : int
      {
         return _currentNum;
      }
      
      public function set currentNum(value:int) : void
      {
         _currentNum = value;
      }
      
      public function get totalSeconds() : int
      {
         return _totalSeconds;
      }
      
      public function set totalSeconds(value:int) : void
      {
         _totalSeconds = value;
      }
      
      public function get luckCount() : int
      {
         return _luckCount;
      }
      
      public function set luckCount(value:int) : void
      {
         _luckCount = value;
      }
      
      public function get remainTimes() : int
      {
         return _remainTimes;
      }
      
      public function set remainTimes(value:int) : void
      {
         _remainTimes = value;
      }
      
      public function get property() : Array
      {
         return _property;
      }
      
      public function set property(value:Array) : void
      {
         _property = value;
      }
      
      public function get luckDrawId() : int
      {
         return _luckDrawId;
      }
      
      public function set luckDrawId(value:int) : void
      {
         _luckDrawId = value;
      }
      
      public function get isGame() : Boolean
      {
         return _isGame;
      }
      
      public function set isGame(value:Boolean) : void
      {
         _isGame = value;
      }
      
      public function get isGetReward() : Boolean
      {
         return _isGetReward;
      }
      
      public function set isGetReward(value:Boolean) : void
      {
         _isGetReward = value;
      }
      
      public function get templatedIdCount() : int
      {
         return _templatedIdCount;
      }
      
      public function set templatedIdCount(value:int) : void
      {
         _templatedIdCount = value;
      }
   }
}
