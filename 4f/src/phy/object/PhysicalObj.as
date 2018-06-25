package phy.object{   import flash.display.Sprite;   import flash.geom.Point;   import flash.geom.Rectangle;   import road7th.utils.MathUtils;      public class PhysicalObj extends Physics   {                   protected var _id:int;            protected var _testRect:Rectangle;            protected var _canCollided:Boolean;            protected var _isLiving:Boolean;            protected var _layerType:int;            private var _name:String;            public var IsCollide:Boolean;            private var _drawPointContainer:Sprite;            public function PhysicalObj(id:int, layerType:int = 1, mass:Number = 1, gravityFactor:Number = 1, windFactor:Number = 1, airResitFactor:Number = 1) { super(null,null,null,null); }
            public function get Id() : int { return 0; }
            public function get layerType() : int { return 0; }
            public function get Name() : String { return null; }
            public function set Name(value:String) : void { }
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
            public function collidedByObject(obj:PhysicalObj) : void { }
            public function setActionMapping(source:String, target:String) : void { }
            public function die() : void { }
            public function getTestRect() : Rectangle { return null; }
            public function isBox() : Boolean { return false; }
   }}