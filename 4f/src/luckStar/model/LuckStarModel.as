package luckStar.model{   import ddt.data.goods.InventoryItemInfo;   import flash.events.EventDispatcher;   import luckStar.event.LuckStarEvent;      public class LuckStarModel extends EventDispatcher   {                   private var _rank:Array;            private var _reward:Vector.<InventoryItemInfo>;            private var _goods:Vector.<InventoryItemInfo>;            private var _newRewardList:Vector.<Array>;            private var _coins:int = 0;            private var _activityDate:Array;            private var _selfInfo:LuckStarPlayerInfo;            private var _lastDate:String;            private var _minUseNum:int;            public function LuckStarModel() { super(); }
            public function set reward(value:Vector.<InventoryItemInfo>) : void { }
            public function set rank(value:Array) : void { }
            public function set newRewardList(value:Vector.<Array>) : void { }
            public function set goods(value:Vector.<InventoryItemInfo>) : void { }
            public function set coins(value:int) : void { }
            public function setActivityDate(startDate:Date, endDate:Date) : void { }
            public function set selfInfo(value:LuckStarPlayerInfo) : void { }
            public function set lastDate(value:String) : void { }
            public function get lastDate() : String { return null; }
            public function get selfInfo() : LuckStarPlayerInfo { return null; }
            public function get activityDate() : Array { return null; }
            public function get rank() : Array { return null; }
            public function get goods() : Vector.<InventoryItemInfo> { return null; }
            public function get reward() : Vector.<InventoryItemInfo> { return null; }
            public function get newRewardList() : Vector.<Array> { return null; }
            public function get coins() : int { return 0; }
            public function set minUseNum(value:int) : void { }
            public function get minUseNum() : int { return 0; }
   }}