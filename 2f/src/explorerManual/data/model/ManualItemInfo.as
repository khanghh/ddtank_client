package explorerManual.data.model{   public class ManualItemInfo   {                   private var _level:int;            private var _name:String;            private var _describe:String;            private var _magicAttack:int;            private var _magicResistance:int;            private var _Boost:int;            public function ManualItemInfo() { super(); }
            public function get Boost() : int { return 0; }
            public function set Boost(value:int) : void { }
            public function get MagicResistance() : int { return 0; }
            public function set MagicResistance(value:int) : void { }
            public function get MagicAttack() : int { return 0; }
            public function set MagicAttack(value:int) : void { }
            public function get Describe() : String { return null; }
            public function set Describe(value:String) : void { }
            public function get Name() : String { return null; }
            public function set Name(value:String) : void { }
            public function get Level() : int { return 0; }
            public function set Level(value:int) : void { }
   }}