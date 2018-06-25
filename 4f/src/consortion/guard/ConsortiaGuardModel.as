package consortion.guard{   import road7th.data.DictionaryData;      public class ConsortiaGuardModel   {                   private var _playerList:DictionaryData;            private var _isOpen:Boolean;            private var _openTime:Date;            private var _bossHp:Array;            private var _bossMaxHp:Array;            private var _bossState:Array;            private var _statueHp:Number = 0;            private var _statueMaxHp:Number = 0;            private var _isFight:Boolean = true;            private var _isWin:Boolean;            private var _endTime:Number;            private var _openLevel:int;            private var _buffLevel:int;            private var _rankList:DictionaryData;            private var _rankBossList:DictionaryData;            public function ConsortiaGuardModel() { super(); }
            public function reset() : void { }
            public function setBossHp(index:int, hp:Number) : void { }
            public function setBossMaxHp(index:int, hp:Number) : void { }
            public function setBossState(index:int, state:int) : void { }
            public function getBossHp(index:int) : Number { return 0; }
            public function getBossMaxHp(index:int) : Number { return 0; }
            public function getBossState(index:int) : int { return 0; }
            public function get playerList() : DictionaryData { return null; }
            public function set isOpen(value:Boolean) : void { }
            public function get isOpen() : Boolean { return false; }
            public function set openTime(value:Date) : void { }
            public function get openTime() : Date { return null; }
            public function get rankList() : DictionaryData { return null; }
            public function get statueHp() : Number { return 0; }
            public function set statueHp(value:Number) : void { }
            public function get statueMaxHp() : Number { return 0; }
            public function set statueMaxHp(value:Number) : void { }
            public function get isFight() : Boolean { return false; }
            public function set isFight(value:Boolean) : void { }
            public function get isWin() : Boolean { return false; }
            public function set isWin(value:Boolean) : void { }
            public function get endTime() : Number { return 0; }
            public function set endTime(value:Number) : void { }
            public function get openLevel() : int { return 0; }
            public function set openLevel(value:int) : void { }
            public function get buffLevel() : int { return 0; }
            public function set buffLevel(value:int) : void { }
            public function get rankBossList() : DictionaryData { return null; }
   }}