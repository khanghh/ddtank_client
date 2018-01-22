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
      
      public function set reward(param1:Vector.<InventoryItemInfo>) : void
      {
         _reward = param1;
      }
      
      public function set rank(param1:Array) : void
      {
         _rank = param1;
      }
      
      public function set newRewardList(param1:Vector.<Array>) : void
      {
         _newRewardList = param1;
         dispatchEvent(new LuckStarEvent(2));
      }
      
      public function set goods(param1:Vector.<InventoryItemInfo>) : void
      {
         _goods = param1;
         dispatchEvent(new LuckStarEvent(0));
      }
      
      public function set coins(param1:int) : void
      {
         if(_coins == param1)
         {
            return;
         }
         _coins = param1;
         dispatchEvent(new LuckStarEvent(1));
      }
      
      public function setActivityDate(param1:Date, param2:Date) : void
      {
         if(_activityDate == null)
         {
            _activityDate = new Array(2);
         }
         _activityDate[0] = param1;
         _activityDate[1] = param2;
      }
      
      public function set selfInfo(param1:LuckStarPlayerInfo) : void
      {
         _selfInfo = param1;
      }
      
      public function set lastDate(param1:String) : void
      {
         _lastDate = param1;
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
      
      public function set minUseNum(param1:int) : void
      {
         _minUseNum = param1;
      }
      
      public function get minUseNum() : int
      {
         return _minUseNum;
      }
   }
}
