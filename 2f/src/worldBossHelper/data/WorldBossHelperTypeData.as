package worldBossHelper.data{   public class WorldBossHelperTypeData   {                   private var _requestType:int;            private var _isOpen:Boolean;            private var _buffNum:int;            private var _type:int;            private var _openType:int = 1;            public function WorldBossHelperTypeData() { super(); }
            public function get isOpen() : Boolean { return false; }
            public function set isOpen(value:Boolean) : void { }
            public function get requestType() : int { return 0; }
            public function set requestType(value:int) : void { }
            public function get openType() : int { return 0; }
            public function set openType(value:int) : void { }
            public function get type() : int { return 0; }
            public function set type(value:int) : void { }
            public function get buffNum() : int { return 0; }
            public function set buffNum(value:int) : void { }
   }}