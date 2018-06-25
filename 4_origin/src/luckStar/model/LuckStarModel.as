package luckStar.model
{
   import ddt.data.goods.InventoryItemInfo;
   import flash.events.EventDispatcher;
   import luckStar.event.LuckStarEvent;
   
   public class LuckStarModel extends EventDispatcher
   {
       
      
      private var _rank:Array;
      
      private var _reward:Vector.<InventoryItemInfo>;
      
      private var _goods:Vector.<InventoryItemInfo>;
      
      private var _newRewardList:Vector.<Array>;
      
      private var _coins:int = 0;
      
      private var _activityDate:Array;
      
      private var _selfInfo:LuckStarPlayerInfo;
      
      private var _lastDate:String;
      
      private var _minUseNum:int;
      
      public function LuckStarModel()
      {
         super();
         _goods = new Vector.<InventoryItemInfo>();
      }
      
      public function set reward(value:Vector.<InventoryItemInfo>) : void
      {
         _reward = value;
      }
      
      public function set rank(value:Array) : void
      {
         _rank = value;
      }
      
      public function set newRewardList(value:Vector.<Array>) : void
      {
         _newRewardList = value;
         dispatchEvent(new LuckStarEvent(2));
      }
      
      public function set goods(value:Vector.<InventoryItemInfo>) : void
      {
         _goods = value;
         dispatchEvent(new LuckStarEvent(0));
      }
      
      public function set coins(value:int) : void
      {
         if(_coins == value)
         {
            return;
         }
         _coins = value;
         dispatchEvent(new LuckStarEvent(1));
      }
      
      public function setActivityDate(startDate:Date, endDate:Date) : void
      {
         if(_activityDate == null)
         {
            _activityDate = new Array(2);
         }
         _activityDate[0] = startDate;
         _activityDate[1] = endDate;
      }
      
      public function set selfInfo(value:LuckStarPlayerInfo) : void
      {
         _selfInfo = value;
      }
      
      public function set lastDate(value:String) : void
      {
         _lastDate = value;
      }
      
      public function get lastDate() : String
      {
         return _lastDate;
      }
      
      public function get selfInfo() : LuckStarPlayerInfo
      {
         return _selfInfo;
      }
      
      public function get activityDate() : Array
      {
         return _activityDate;
      }
      
      public function get rank() : Array
      {
         return _rank;
      }
      
      public function get goods() : Vector.<InventoryItemInfo>
      {
         return _goods;
      }
      
      public function get reward() : Vector.<InventoryItemInfo>
      {
         return _reward;
      }
      
      public function get newRewardList() : Vector.<Array>
      {
         return _newRewardList;
      }
      
      public function get coins() : int
      {
         return _coins;
      }
      
      public function set minUseNum(value:int) : void
      {
         _minUseNum = value;
      }
      
      public function get minUseNum() : int
      {
         return _minUseNum;
      }
   }
}
