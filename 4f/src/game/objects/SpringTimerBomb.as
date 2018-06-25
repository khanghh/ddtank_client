package game.objects{   import flash.events.Event;   import flash.geom.Point;   import flash.geom.Rectangle;   import gameCommon.GameControl;   import gameCommon.model.Bomb;   import gameCommon.model.Living;   import par.emitters.Emitter;   import phy.object.PhysicalObj;      public class SpringTimerBomb extends SimpleBomb   {                   private var _currentBombTimer:int = -1;            public function SpringTimerBomb(info:Bomb, owner:Living, refineryLevel:int = 0) { super(null,null,null); }
            override protected function updatePosition(dt:Number) : void { }
            override public function moveTo(p:Point) : void { }
            override protected function isPillarCollide() : Boolean { return false; }
            protected function isLastPosSpring() : Boolean { return false; }
            private function removeEmitters() : void { }
            override public function dispose() : void { }
   }}