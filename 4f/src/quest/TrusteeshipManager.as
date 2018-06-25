package quest{   import ddt.data.quest.QuestInfo;   import ddt.events.PkgEvent;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.TimeManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import road7th.comm.PackageIn;      public class TrusteeshipManager extends EventDispatcher   {            public static const UPDATE_ALL_DATA:String = "update_all_data";            public static const UPDATE_SPIRIT_VALUE:String = "update_spirit_value";            private static var _instance:TrusteeshipManager;                   private var _spiritValue:int;            private var _list:Vector.<TrusteeshipDataVo>;            private var _maxCanStartCount:int = -1;            private var _maxSpiritValue:int = -1;            private var _buyOnceSpiritValue:int = -1;            private var _buyOnceNeedMoney:int = -1;            private var _speedUpOneMinNeedMoney:int = -1;            public function TrusteeshipManager() { super(null); }
            public static function get instance() : TrusteeshipManager { return null; }
            public function get list() : Vector.<TrusteeshipDataVo> { return null; }
            public function get spiritValue() : int { return 0; }
            public function get speedUpOneMinNeedMoney() : int { return 0; }
            public function get buyOnceNeedMoney() : int { return 0; }
            public function get buyOnceSpiritValue() : int { return 0; }
            public function get maxSpiritValue() : int { return 0; }
            public function isCanStart() : Boolean { return false; }
            public function setup() : void { }
            private function updateSpiritValue(event:PkgEvent) : void { }
            private function updateData(event:PkgEvent) : void { }
            public function isHasTrusteeshipQuestUnaviable() : Boolean { return false; }
            public function isTrusteeshipQuestEnd(questId:int) : Boolean { return false; }
            public function getTrusteeshipInfo(questId:int) : TrusteeshipDataVo { return null; }
   }}