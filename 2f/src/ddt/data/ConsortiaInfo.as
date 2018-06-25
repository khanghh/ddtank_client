package ddt.data{   import ddt.events.PlayerPropertyEvent;   import flash.events.EventDispatcher;   import flash.utils.Dictionary;   import road7th.utils.DateUtils;      public class ConsortiaInfo extends EventDispatcher   {            public static const LEVEL:String = "level";            public static const STORE_LEVEL:String = "storeLevel";            public static const SHOP_LEVEL:String = "shopLevel";            public static const BANK_LEVEL:String = "bankLevel";            public static const RICHES:String = "riches";            public static const DESCRIPTION:String = "description";            public static const PLACARD:String = "placard";            public static const CHAIRMANNAME:String = "chairmanName";            public static const CONSORTIANAME:String = "consortiaName";            public static const BADGE_ID:String = "badgeID";            public static const BADGE_DATE:String = "badgedate";            public static const COUNT:String = "count";            public static const POLLOPEN:String = "pollOpen";            public static const SKILL_LEVEL:String = "skillLevel";            public static const IS_VOTING:String = "isVoting";                   public var ConsortiaID:int;            private var _consortiaName:String = "";            private var _badgeID:int = 0;            private var _badgeBuyTime:String;            private var _validDate:int;            private var _IsVoting:Boolean;            public var VoteRemainDay:int;            public var CreatorID:int;            public var CreatorName:String = "";            public var ChairmanID:int;            private var _chairmanName:String = "";            public var MaxCount:int;            public var CelebCount:int;            public var BuildDate:String = "";            public var IP:String;            public var Port:int;            private var _count:int;            public var Repute:int;            public var IsApply:Boolean;            public var State:int;            public var DeductDate:String;            public var Honor:int;            public var LastDayRiches:int;            public var OpenApply:Boolean;            public var FightPower:Number = 0;            public var ChairmanTypeVIP:int;            public var ChairmanVIPLevel:int;            private var _PollOpen:Boolean;            public var CharmGP:int;            private var _Level:int;            private var _storeLevel:int;            private var _SmithLevel:int;            private var _ShopLevel:int;            private var _bufferLevel:int;            private var _riches:int;            private var _description:String;            private var _placard:String = "";            public var BadgeType:int;            public var BadgeName:String;            protected var _changeCount:int = 0;            protected var _changedPropeties:Dictionary;            public function ConsortiaInfo() { super(); }
            public function get ValidDate() : int { return 0; }
            public function set ValidDate(value:int) : void { }
            public function get BadgeBuyTime() : String { return null; }
            public function set BadgeBuyTime(value:String) : void { }
            public function get BadgeID() : int { return 0; }
            public function set BadgeID(value:int) : void { }
            public function get ConsortiaName() : String { return null; }
            public function set ConsortiaName(value:String) : void { }
            public function get IsVoting() : Boolean { return false; }
            public function set IsVoting(value:Boolean) : void { }
            public function get ChairmanName() : String { return null; }
            public function set ChairmanName(value:String) : void { }
            public function get Count() : int { return 0; }
            public function set Count(value:int) : void { }
            public function get PollOpen() : Boolean { return false; }
            public function get ChairmanIsVIP() : Boolean { return false; }
            public function set PollOpen(value:Boolean) : void { }
            public function get Level() : int { return 0; }
            public function set Level(value:int) : void { }
            public function set StoreLevel($level:int) : void { }
            public function get StoreLevel() : int { return 0; }
            public function get SmithLevel() : int { return 0; }
            public function set SmithLevel(value:int) : void { }
            public function get ShopLevel() : int { return 0; }
            public function set ShopLevel(value:int) : void { }
            public function get BufferLevel() : int { return 0; }
            public function set BufferLevel(value:int) : void { }
            public function set Riches(i:int) : void { }
            public function get Riches() : int { return 0; }
            public function get Description() : String { return null; }
            public function set Description(value:String) : void { }
            public function get Placard() : String { return null; }
            public function set Placard(value:String) : void { }
            public function beginChanges() : void { }
            public function commitChanges() : void { }
            protected function onPropertiesChanged(propName:String = null) : void { }
            public function updateProperties() : void { }
   }}