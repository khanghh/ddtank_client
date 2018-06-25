package game.objects{   import ddt.events.LivingEvent;   import game.actions.MonsterShootBombAction;   import gameCommon.model.SmallEnemy;   import phy.maps.Map;   import phy.object.PhysicalObj;   import road7th.data.StringObject;      public class GameSmallEnemy extends GameLiving   {                   private var _bombEvent:LivingEvent;            private var _noDispose:Boolean = false;            private var _disposedOverTurns:Boolean = true;            public function GameSmallEnemy(info:SmallEnemy) { super(null); }
            override protected function initView() : void { }
            override public function setMap(map:Map) : void { }
            public function get smallEnemy() : SmallEnemy { return null; }
            override protected function __bloodChanged(event:LivingEvent) : void { }
            override protected function __die(event:LivingEvent) : void { }
            override public function collidedByObject(obj:PhysicalObj) : void { }
            override protected function fitChatBallPos() : void { }
            private function clearEnemy() : void { }
            private function removeEvents(flag:Boolean = false) : void { }
            override protected function __shoot(event:LivingEvent) : void { }
            override protected function __beginNewTurn(event:LivingEvent) : void { }
            override public function dispose() : void { }
            override public function setProperty(property:String, value:String) : void { }
   }}