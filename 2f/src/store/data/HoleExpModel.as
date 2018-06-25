package store.data{   public class HoleExpModel   {                   private var _expList:Array;            private var _maxLv:int;            private var _maxOpLv:int;            public function HoleExpModel() { super(); }
            public function set explist(val:String) : void { }
            public function set maxLv(lv:String) : void { }
            public function set oprationLv(lv:String) : void { }
            public function getMaxLv() : int { return 0; }
            public function getMaxOpLv() : int { return 0; }
            public function getExpByLevel(lv:int) : int { return 0; }
   }}