package game.objects{   import com.greensock.TweenLite;   import flash.events.Event;   import flash.geom.Point;   import flash.geom.Rectangle;   import gameCommon.GameControl;   import gameCommon.model.Bomb;   import gameCommon.model.Living;   import phy.object.PhysicalObj;   import road.game.resource.ActionMovie;   import road7th.utils.MathUtils;      public class SpiderBomb2 extends SimpleBomb   {                   private var _isWalk:Boolean = false;            private var _path:Array;            private var _currentPathIndex:int = 0;            public function SpiderBomb2(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false) { super(null,null,null,null); }
            private function initData(info:Bomb) : void { }
            override protected function initMovie() : void { }
            override public function moveTo(p:Point) : void { }
            override protected function computeFallNextXY(dt:Number) : Point { return null; }
            override protected function updatePosition(dt:Number) : void { }
            override public function get motionAngle() : Number { return 0; }
            private function checkWalkBall() : void { }
            public function doAction(type:String, backFun:Function = null) : void { }
            public function doDefaultAction() : void { }
            override protected function isPillarCollide() : Boolean { return false; }
            override public function dispose() : void { }
   }}