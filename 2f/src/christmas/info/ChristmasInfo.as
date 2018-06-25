package christmas.info{   import christmas.player.PlayerVO;   import flash.events.EventDispatcher;   import flash.geom.Point;      public class ChristmasInfo extends EventDispatcher   {            public static const CHRISTMAS_MONSTER:int = 17;            public static const LIVIN:int = 0;                   private var _myPlayerVO:PlayerVO;            private var _playerDefaultPos:Point;            public function ChristmasInfo() { super(); }
            public function set myPlayerVO(value:PlayerVO) : void { }
            public function get myPlayerVO() : PlayerVO { return null; }
            public function set playerDefaultPos(value:Point) : void { }
            public function get playerDefaultPos() : Point { return null; }
   }}