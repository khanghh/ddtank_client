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
      
      public function CloudBuyLotteryModel(){super();}
      
      public function get isOpen() : Boolean{return false;}
      
      public function set isOpen(param1:Boolean) : void{}
      
      public function get luckTime() : Date{return null;}
      
      public function set luckTime(param1:Date) : void{}
      
      public function get moneyNum() : int{return 0;}
      
      public function set moneyNum(param1:int) : void{}
      
      public function get templateId() : int{return 0;}
      
      public function set templateId(param1:int) : void{}
      
      public function get validDate() : int{return 0;}
      
      public function set validDate(param1:int) : void{}
      
      public function get count() : int{return 0;}
      
      public function set count(param1:int) : void{}
      
      public function get buyGoodsIDArray() : Array{return null;}
      
      public function set buyGoodsIDArray(param1:Array) : void{}
      
      public function get buyGoodsCountArray() : Array{return null;}
      
      public function set buyGoodsCountArray(param1:Array) : void{}
      
      public function get buyMoney() : int{return 0;}
      
      public function set buyMoney(param1:int) : void{}
      
      public function get maxNum() : int{return 0;}
      
      public function set maxNum(param1:int) : void{}
      
      public function get currentNum() : int{return 0;}
      
      public function set currentNum(param1:int) : void{}
      
      public function get totalSeconds() : int{return 0;}
      
      public function set totalSeconds(param1:int) : void{}
      
      public function get luckCount() : int{return 0;}
      
      public function set luckCount(param1:int) : void{}
      
      public function get remainTimes() : int{return 0;}
      
      public function set remainTimes(param1:int) : void{}
      
      public function get property() : Array{return null;}
      
      public function set property(param1:Array) : void{}
      
      public function get luckDrawId() : int{return 0;}
      
      public function set luckDrawId(param1:int) : void{}
      
      public function get isGame() : Boolean{return false;}
      
      public function set isGame(param1:Boolean) : void{}
      
      public function get isGetReward() : Boolean{return false;}
      
      public function set isGetReward(param1:Boolean) : void{}
      
      public function get templatedIdCount() : int{return 0;}
      
      public function set templatedIdCount(param1:int) : void{}
   }
}
