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
      
      public function set isOpen(value:Boolean) : void
      {
         _isOpen = value;
      }
      
      public function get goodsAll() : Array
      {
         return _goodsAll;
      }
      
      public function set goodsAll(value:Array) : void
      {
         _goodsAll = value;
      }
      
      public function get position() : int
      {
         return _position;
      }
      
      public function set position(value:int) : void
      {
         _position = value;
      }
      
      public function get templateID() : int
      {
         return _templateID;
      }
      
      public function set templateID(value:int) : void
      {
         _templateID = value;
      }
      
      public function get getGoods() : Array
      {
         return _getGoods;
      }
      
      public function set getGoods(value:Array) : void
      {
         _getGoods = value;
      }
      
      public function get prayInfo() : Array
      {
         return _prayInfo;
      }
      
      public function get PrayGoodsCount() : int
      {
         return _PrayGoodsCount;
      }
      
      public function set PrayGoodsCount(value:int) : void
      {
         _PrayGoodsCount = value;
      }
      
      public function get UpdateRateCount() : int
      {
         return _UpdateRateCount;
      }
      
      public function set UpdateRateCount(value:int) : void
      {
         _UpdateRateCount = value;
      }
      
      public function get PrayLotteryGoodsCount() : int
      {
         return _PrayLotteryGoodsCount;
      }
      
      public function set PrayLotteryGoodsCount(value:int) : void
      {
         _PrayLotteryGoodsCount = value;
      }
      
      public function set prayInfo(value:Array) : void
      {
         _prayInfo = value;
      }
      
      public function get IsPray() : Boolean
      {
         return _IsPray;
      }
      
      public function set IsPray(value:Boolean) : void
      {
         _IsPray = value;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(value:int) : void
      {
         _type = value;
      }
      
      public function get probabilityNum() : int
      {
         return _probabilityNum;
      }
      
      public function set probabilityNum(value:int) : void
      {
         _probabilityNum = value;
      }
      
      public function get gameTimes() : String
      {
         return _gameTimes;
      }
      
      public function set gameTimes(value:String) : void
      {
         _gameTimes = value;
      }
   }
}
