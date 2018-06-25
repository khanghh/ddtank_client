package littleGame.model{   import ddt.data.player.PlayerInfo;   import littleGame.events.LittleLivingEvent;      public class LittlePlayer extends LittleLiving   {                   private var _playerInfo:PlayerInfo;            public function LittlePlayer(playerInfo:PlayerInfo, id:int, x:int, y:int, type:int) { super(null,null,null,null); }
            public function get playerInfo() : PlayerInfo { return null; }
            override public function get isPlayer() : Boolean { return false; }
            override public function toString() : String { return null; }
            public function set headType($type:int) : void { }
   }}