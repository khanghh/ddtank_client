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
      
      public function LuckStarModel(){super();}
      
      public function set reward(param1:Vector.<InventoryItemInfo>) : void{}
      
      public function set rank(param1:Array) : void{}
      
      public function set newRewardList(param1:Vector.<Array>) : void{}
      
      public function set goods(param1:Vector.<InventoryItemInfo>) : void{}
      
      public function set coins(param1:int) : void{}
      
      public function setActivityDate(param1:Date, param2:Date) : void{}
      
      public function set selfInfo(param1:LuckStarPlayerInfo) : void{}
      
      public function set lastDate(param1:String) : void{}
      
      public function get lastDate() : String{return null;}
      
      public function get selfInfo() : LuckStarPlayerInfo{return null;}
      
      public function get activityDate() : Array{return null;}
      
      public function get rank() : Array{return null;}
      
      public function get goods() : Vector.<InventoryItemInfo>{return null;}
      
      public function get reward() : Vector.<InventoryItemInfo>{return null;}
      
      public function get newRewardList() : Vector.<Array>{return null;}
      
      public function get coins() : int{return 0;}
      
      public function set minUseNum(param1:int) : void{}
      
      public function get minUseNum() : int{return 0;}
   }
}
