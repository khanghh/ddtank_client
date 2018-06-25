package LanternFestival2015.model{   import ddt.data.BagInfo;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;      public class LanternFestivalModel   {                   private var _isActivityOpen:Boolean = false;            private var _numSendRemain:int;            private var _numReceiveRemain:int;            public var tpIDFilling:int = 12504;            public var tpIDRice:int = 12505;            public var tpIDLantern:int = 12506;            public var tpIDCookedLantern:int = 1120321;            private var _maxVisitTimes:int;            private var _maxBeVisitedTimes:int;            private var _cookPrice:int;            private var _inited:Boolean = false;            public function LanternFestivalModel() { super(); }
            public function get isActivityOpen() : Boolean { return false; }
            public function set isActivityOpen(value:Boolean) : void { }
            public function set numSendRemain(value:int) : void { }
            public function get numSendRemain() : int { return 0; }
            public function set numReceiveRemain(value:int) : void { }
            public function get numReceiveRemain() : int { return 0; }
            public function maxLanternCanMake() : int { return 0; }
            public function get maxVisitTimes() : int { return 0; }
            public function get maxBeVisitedTimes() : int { return 0; }
            public function get cookPrice() : int { return 0; }
            public function initData() : void { }
   }}