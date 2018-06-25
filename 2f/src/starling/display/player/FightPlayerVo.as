package starling.display.player{   import flash.events.IEventDispatcher;   import hall.player.vo.PlayerVO;      public class FightPlayerVo extends PlayerVO   {                   private var _isFight:Boolean;            private var _isDie:Boolean;            private var _state:int;            private var _reviveTime:Date;            public var stateType:String;            public function FightPlayerVo(target:IEventDispatcher = null) { super(null); }
            public function get isFight() : Boolean { return false; }
            public function set isFight(value:Boolean) : void { }
            public function get isDie() : Boolean { return false; }
            public function set isDie(value:Boolean) : void { }
            public function get state() : int { return 0; }
            public function set state(value:int) : void { }
            public function get reviveTime() : Date { return null; }
            public function set reviveTime(value:Date) : void { }
   }}