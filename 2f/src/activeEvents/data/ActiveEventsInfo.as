package activeEvents.data{   import ddt.manager.LanguageMgr;   import ddt.manager.TimeManager;   import road7th.utils.DateUtils;      public class ActiveEventsInfo   {            public static const COMMON:int = 0;            public static const GOODS_EXCHANGE:int = 1;            public static const PICC:int = 2;            public static const SENIOR_PLAYER:int = 5;            public static const SCAN_CODE:int = 6;                   public var ActiveID:int;            public var Title:String;            public var isAttend:Boolean = false;            public var Description:String;            private var _StartDate:String;            public var IsShow:Boolean;            public var viewId:int;            private var _start:Date;            private var _EndDate:String;            private var _end:Date;            public var Content:String;            public var AwardContent:String;            public var IsAdvance:Boolean;            public var Type:int;            public var IsOnly:int;            public var HasKey:int;            public var ActiveType:int;            public var IconID:int = 1;            public var GoodsExchangeTypes:String;            public var limitType:String;            public var limitValue:String;            public var GoodsExchangeNum:String;            public var ActionTimeContent:String;            public function ActiveEventsInfo() { super(); }
            public function get StartDate() : String { return null; }
            public function set StartDate(val:String) : void { }
            public function get start() : Date { return null; }
            public function get EndDate() : String { return null; }
            public function set EndDate(val:String) : void { }
            public function get end() : Date { return null; }
            public function activeTime() : String { return null; }
            private function getActiveString(date:Date) : String { return null; }
            private function addZero(value:Number) : String { return null; }
            public function overdue() : Boolean { return false; }
   }}