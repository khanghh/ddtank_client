package gameStarling.objects{   import ddt.events.LivingEvent;   import gameCommon.model.SmallEnemy;   import gameStarling.actions.MonsterShootBombAction;   import road7th.data.StringObject;   import starlingPhy.maps.Map3D;   import starlingPhy.object.PhysicalObj3D;      public class GameSmallEnemy3D extends GameLiving3D   {                   private var _bombEvent:LivingEvent;            private var _noDispose:Boolean = false;            private var _disposedOverTurns:Boolean = true;            public function GameSmallEnemy3D(info:SmallEnemy) { super(null); }
            override protected function initView() : void { }
            override public function setMap(map:Map3D) : void { }
            public function get smallEnemy() : SmallEnemy { return null; }
            override protected function __bloodChanged(event:LivingEvent) : void { }
            override protected function __die(event:LivingEvent) : void { }
            override public function collidedByObject(obj:PhysicalObj3D) : void { }
            private function clearEnemy() : void { }
            private function removeEvents(flag:Boolean = false) : void { }
            override protected function __shoot(event:LivingEvent) : void { }
            override protected function __beginNewTurn(event:LivingEvent) : void { }
            override public function dispose() : void { }
            override public function setProperty(property:String, value:String) : void { }
   }}