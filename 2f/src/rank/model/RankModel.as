package rank.model{   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import wonderfulActivity.data.GmActivityInfo;      public class RankModel extends EventDispatcher   {                   private var _beginTime:String;            private var _endTime:String;            public var currentInfo:GmActivityInfo;            public function RankModel(target:IEventDispatcher = null) { super(null); }
            public function get beginTime() : String { return null; }
            public function set beginTime(value:String) : void { }
            public function get endTime() : String { return null; }
            public function set endTime(value:String) : void { }
   }}