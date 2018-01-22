package prayIndiana.model
{
   public class PrayIndianaModel
   {
       
      
      private var _isOpen:Boolean = false;
      
      private var _goodsAll:Array;
      
      private var _position:int;
      
      private var _templateID:int;
      
      private var _getGoods:Array;
      
      private var _PrayGoodsCount:int;
      
      private var _UpdateRateCount:int;
      
      private var _PrayLotteryGoodsCount:int;
      
      private var _prayInfo:Array;
      
      private var _IsPray:Boolean;
      
      private var _type:int;
      
      private var _probabilityNum:int;
      
      private var _gameTimes:String;
      
      public function PrayIndianaModel()
      {
         _getGoods = [];
         super();
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         _isOpen = param1;
      }
      
      public function get goodsAll() : Array
      {
         return _goodsAll;
      }
      
      public function set goodsAll(param1:Array) : void
      {
         _goodsAll = param1;
      }
      
      public function get position() : int
      {
         return _position;
      }
      
      public function set position(param1:int) : void
      {
         _position = param1;
      }
      
      public function get templateID() : int
      {
         return _templateID;
      }
      
      public function set templateID(param1:int) : void
      {
         _templateID = param1;
      }
      
      public function get getGoods() : Array
      {
         return _getGoods;
      }
      
      public function set getGoods(param1:Array) : void
      {
         _getGoods = param1;
      }
      
      public function get prayInfo() : Array
      {
         return _prayInfo;
      }
      
      public function get PrayGoodsCount() : int
      {
         return _PrayGoodsCount;
      }
      
      public function set PrayGoodsCount(param1:int) : void
      {
         _PrayGoodsCount = param1;
      }
      
      public function get UpdateRateCount() : int
      {
         return _UpdateRateCount;
      }
      
      public function set UpdateRateCount(param1:int) : void
      {
         _UpdateRateCount = param1;
      }
      
      public function get PrayLotteryGoodsCount() : int
      {
         return _PrayLotteryGoodsCount;
      }
      
      public function set PrayLotteryGoodsCount(param1:int) : void
      {
         _PrayLotteryGoodsCount = param1;
      }
      
      public function set prayInfo(param1:Array) : void
      {
         _prayInfo = param1;
      }
      
      public function get IsPray() : Boolean
      {
         return _IsPray;
      }
      
      public function set IsPray(param1:Boolean) : void
      {
         _IsPray = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get probabilityNum() : int
      {
         return _probabilityNum;
      }
      
      public function set probabilityNum(param1:int) : void
      {
         _probabilityNum = param1;
      }
      
      public function get gameTimes() : String
      {
         return _gameTimes;
      }
      
      public function set gameTimes(param1:String) : void
      {
         _gameTimes = param1;
      }
   }
}
