package oldPlayerComeBack.data{   import flash.events.EventDispatcher;      public class ComeBackAwardItemsInfo extends EventDispatcher   {                   private var _curPlace:int;            private var awardItems:Vector.<AwardItemInfo>;            public function ComeBackAwardItemsInfo() { super(); }
            public function addInfo(info:AwardItemInfo) : void { }
            public function get allAwardItems() : Vector.<AwardItemInfo> { return null; }
            public function get curPlace() : int { return 0; }
            public function set curPlace(value:int) : void { }
   }}