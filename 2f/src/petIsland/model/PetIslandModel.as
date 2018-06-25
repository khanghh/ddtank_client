package petIsland.model{   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import petIsland.event.PetIslandEvent;      public class PetIslandModel extends EventDispatcher   {                   public var isOpen:Boolean;            private var _pList:Array;            public var infoStr:String = "";            private var _openType:int;            private var _playerBlood:int;            private var _npcBlood:int;            private var _playerScore:int;            private var _npcScore:int;            private var _round:int;            private var _step:int;            private var _currentLevel:int;            private var _rewardRecord:String;            private var _saveLifeCount:int;            private var _saveLife2Count:int;            public function PetIslandModel(target:IEventDispatcher = null) { super(); }
            public function get pList() : Array { return null; }
            public function set pList(value:Array) : void { }
            public function get openType() : int { return 0; }
            public function set openType(value:int) : void { }
            public function get playerBlood() : int { return 0; }
            public function set playerBlood(value:int) : void { }
            public function get npcBlood() : int { return 0; }
            public function set npcBlood(value:int) : void { }
            public function get playerScore() : int { return 0; }
            public function set playerScore(value:int) : void { }
            public function get npcScore() : int { return 0; }
            public function set npcScore(value:int) : void { }
            public function get round() : int { return 0; }
            public function set round(value:int) : void { }
            public function get step() : int { return 0; }
            public function set step(value:int) : void { }
            public function get currentLevel() : int { return 0; }
            public function set currentLevel(value:int) : void { }
            public function get rewardRecord() : String { return null; }
            public function set rewardRecord(value:String) : void { }
            public function get saveLifeCount() : int { return 0; }
            public function set saveLifeCount(value:int) : void { }
            public function get saveLife2Count() : int { return 0; }
            public function set saveLife2Count(value:int) : void { }
   }}