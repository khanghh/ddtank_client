package starlingPhy.object{   import com.pickgliss.utils.ObjectUtils;   import flash.geom.Point;   import flash.geom.Rectangle;   import phy.object.SmallObject;   import road7th.utils.MathUtils;   import starling.display.Sprite;      public class PhysicalObj3D extends Physics3D   {                   protected var _id:int;            protected var _testRect:Rectangle;            protected var _canCollided:Boolean;            protected var _isLiving:Boolean;            protected var _layerType:int;            protected var _smallBox:SmallObject;            private var _drawPointContainer:Sprite;            public function PhysicalObj3D(id:int, layerType:int = 1, mass:Number = 1, gravityFactor:Number = 1, windFactor:Number = 1, airResitFactor:Number = 1) { super(null,null,null,null); }
            public function get Id() : int { return 0; }
            public function get layerType() : int { return 0; }
            public function setCollideRect(left:int, top:int, right:int, buttom:int) : void { }
            public function getCollideRect() : Rectangle { return null; }
            public function get canCollided() : Boolean { return false; }
            public function set canCollided(value:Boolean) : void { }
            public function get smallView() : SmallObject { return null; }
            public function get isLiving() : Boolean { return false; }
            override public function moveTo(p:Point) : void { }
            public function calcObjectAngle(bounds:Number = 16) : Number { return 0; }
            public function calcObjectAngle2(bounds:Number = 16, dis:int = 10) : Number { return 0; }
            public function calcObjectAngleDebug(bounds:Number = 16) : Number { return 0; }
            public function calcObjectAngleDebug2(bounds:Number = 16, dis:int = 10) : Number { return 0; }
            private function drawPoint(data:Array, clear:Boolean) : void { }
            protected function flyOutMap() : void { }
            protected function collideObject(list:Array) : void { }
            protected function collideGround() : void { }
            public function collidedByObject(obj:PhysicalObj3D) : void { }
            public function setActionMapping(source:String, target:String) : void { }
            public function die() : void { }
            public function getTestRect() : Rectangle { return null; }
            public function isBox() : Boolean { return false; }
            override public function dispose() : void { }
   }}