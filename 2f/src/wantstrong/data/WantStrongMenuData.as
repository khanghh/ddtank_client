package wantstrong.data{   public class WantStrongMenuData   {                   private var _id:int;            private var _type:int;            private var _freeBackBtnEnable:Boolean = true;            private var _allBackBtnEnable:Boolean = true;            private var _bossType:int;            private var _title:String;            private var _starNum:int;            private var _description:String;            private var _needLevel:int;            private var _iconUrl:String;            private var _awardType:int;            private var _awardNum:int;            private var _moneyNum:int;            public function WantStrongMenuData() { super(); }
            public function get iconUrl() : String { return null; }
            public function set iconUrl(value:String) : void { }
            public function get moneyNum() : int { return 0; }
            public function set moneyNum(value:int) : void { }
            public function get awardType() : int { return 0; }
            public function set awardType(value:int) : void { }
            public function get awardNum() : int { return 0; }
            public function set awardNum(value:int) : void { }
            public function get allBackBtnEnable() : Boolean { return false; }
            public function set allBackBtnEnable(value:Boolean) : void { }
            public function get freeBackBtnEnable() : Boolean { return false; }
            public function set freeBackBtnEnable(value:Boolean) : void { }
            public function get bossType() : int { return 0; }
            public function set bossType(value:int) : void { }
            public function get type() : int { return 0; }
            public function set type(value:int) : void { }
            public function get needLevel() : int { return 0; }
            public function set needLevel(value:int) : void { }
            public function get description() : String { return null; }
            public function set description(value:String) : void { }
            public function get starNum() : int { return 0; }
            public function set starNum(value:int) : void { }
            public function get title() : String { return null; }
            public function set title(value:String) : void { }
            public function get id() : int { return 0; }
            public function set id(value:int) : void { }
   }}