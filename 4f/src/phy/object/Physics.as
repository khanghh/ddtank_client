package phy.object{   import com.pickgliss.ui.core.Disposeable;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;   import phy.maps.Map;   import phy.math.EulerVector;      public class Physics extends Sprite implements Disposeable   {                   protected var _mass:Number;            protected var _gravityFactor:Number;            protected var _windFactor:Number;            protected var _airResitFactor:Number;            protected var _vx:EulerVector;            protected var _vy:EulerVector;            protected var _ef:Point;            protected var _isMoving:Boolean;            protected var _map:Map;            protected var _layer:int = -1;            protected var _arf:Number = 0;            protected var _gf:Number = 0;            protected var _wf:Number = 0;            public function Physics(mass:Number = 1, gravityFactor:Number = 1, windFactor:Number = 1, airResitFactor:Number = 1) { super(); }
            public function get layer() : int { return 0; }
            public function set layer(value:int) : void { }
            public function addExternForce(force:Point) : void { }
            public function addSpeedXY(vector:Point) : void { }
            public function setSpeedXY(vector:Point) : void { }
            public function changeSpeedXY($x:Number, $y:Number) : void { }
            public function changeAccelerateXY($x:Number, $y:Number) : void { }
            public function get Vx() : Number { return 0; }
            public function get Vy() : Number { return 0; }
            public function get motionAngle() : Number { return 0; }
            public function isMoving() : Boolean { return false; }
            public function startMoving() : void { }
            public function stopMoving() : void { }
            public function setMap(map:Map) : void { }
            protected function computeFallNextXY(dt:Number) : Point { return null; }
            public function get pos() : Point { return null; }
            public function set pos(value:Point) : void { }
            public function update(dt:Number) : void { }
            protected function updatePosition(dt:Number) : void { }
            public function moveTo(p:Point) : void { }
            override public function set x(value:Number) : void { }
            override public function set y(value:Number) : void { }
            public function dispose() : void { }
   }}