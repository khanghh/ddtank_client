package gameStarling.objects{   import flash.geom.Point;   import flash.geom.Rectangle;   import gameCommon.GameControl;   import gameCommon.model.Bomb;   import gameCommon.model.Living;   import starlingPhy.object.PhysicalObj3D;      public class BurrowBomb3D extends SimpleBomb3D   {                   public function BurrowBomb3D(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false) { super(null,null,null,null); }
            override protected function initMovie() : void { }
            override public function moveTo(p:Point) : void { }
            override public function get motionAngle() : Number { return 0; }
            public function doAction(type:String, backFun:Function = null) : void { }
            public function doDefaultAction() : void { }
            override protected function isPillarCollide() : Boolean { return false; }
            private function removeEmitters() : void { }
            override public function dispose() : void { }
   }}