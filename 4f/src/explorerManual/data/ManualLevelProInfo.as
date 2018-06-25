package explorerManual.data{   import explorerManual.data.model.ManualItemInfo;      public class ManualLevelProInfo   {                   public var name:String;            public var magicAttack:int;            public var magicResistance:int;            private var _boost:int;            public function ManualLevelProInfo() { super(); }
            public function get boost() : int { return 0; }
            public function set boost(value:int) : void { }
            public function update(info:ManualItemInfo) : void { }
   }}