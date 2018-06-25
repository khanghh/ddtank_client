package draft.data{   import ddt.data.player.PlayerInfo;      public class DraftModel   {            private static var _total:int = 1;            public static var UploadNum:int;                   public var id:int;            public var playerInfo:PlayerInfo;            public var rank:int;            public var ticketNum:int;            public function DraftModel() { super(); }
            public static function get Total() : int { return 0; }
            public static function set Total(value:int) : void { }
   }}