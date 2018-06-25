package ddt.data.player{   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;      public class PlayerState   {            public static const OFFLINE:int = 0;            public static const ONLINE:int = 1;            public static const AWAY:int = 2;            public static const BUSY:int = 3;            public static const SHOPPING:int = 4;            public static const NO_DISTRUB:int = 5;            public static const CLEAN_OUT:int = 6;            public static const AUTO:int = 0;            public static const MANUAL:int = 1;                   private var _stateID:int;            private var _autoReply:String;            private var _priority:int;            public function PlayerState(stateID:int, priority:int = 0) { super(); }
            public function get StateID() : int { return 0; }
            public function get Priority() : int { return 0; }
            public function get AutoReply() : String { return null; }
            public function set AutoReply(value:String) : void { }
            public function convertToString() : String { return null; }
   }}