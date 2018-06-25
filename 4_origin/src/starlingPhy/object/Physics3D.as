package starlingPhy.object
{
   import flash.geom.Point;
   import phy.math.EulerVector;
   import starling.display.Sprite;
   import starling.events.Event;
   import starlingPhy.maps.Map3D;
   
   public class Physics3D extends Sprite
   {
       
      
      protected var _mass:Number;
      
      protected var _gravityFactor:Number;
      
      protected var _windFactor:Number;
      
      protected var _airResitFactor:Number;
      
      protected var _vx:EulerVector;
      
      protected var _vy:EulerVector;
      
      protected var _ef:Point;
      
      protected var _isMoving:Boolean;
      
      protected var _map:Map3D;
      
      protected var _layer:int = -1;
      
      protected var _arf:Number = 0;
      
      protected var _gf:Number = 0;
      
      protected var _wf:Number = 0;
      
      public function Physics3D(mass:Number = 1, gravityFactor:Number = 1, windFactor:Number = 1, airResitFactor:Number = 1)
      {
         super();
         _mass = mass;
         _gravityFactor = gravityFactor;
         _windFactor = windFactor;
         _airResitFactor = airResitFactor;
         _vx = new EulerVector(0,0,0);
         _vy = new EulerVector(0,0,0);
         _ef = new Point(0,0);
      }
      
      public function get layer() : int
      {
         if(_layer == -1)
         {
            return 0;
         }
         return _layer;
      }
      
      public function set layer(value:int) : void
      {
         _layer = value;
      }
      
      public function addExternForce(force:Point) : void
      {
         _ef.x = _ef.x + force.x;
         _ef.y = _ef.y + force.y;
         if(!_isMoving && _map)
         {
            startMoving();
         }
      }
      
      public function addSpeedXY(vector:Point) : void
      {
         _vx.x1 = _vx.x1 + vector.x;
         _vy.x1 = _vy.x1 + vector.y;
         if(!_isMoving && _map)
         {
            startMoving();
         }
      }
      
      public function setSpeedXY(vector:Point) : void
      {
         _vx.x1 = vector.x;
         _vy.x1 = vector.y;
         if(!_isMoving && _map)
         {
            startMoving();
         }
      }
      
      public function changeSpeedXY($x:Number, $y:Number) : void
      {
         _vx.x1 = $x;
         _vy.x1 = $y;
      }
      
      public function get Vx() : Number
      {
         return _vx.x1;
      }
      
      public function get Vy() : Number
      {
         return _vy.x2;
      }
      
      public function get motionAngle() : Number
      {
         return Math.atan2(_vy.x1,_vx.x1);
      }
      
      public function isMoving() : Boolean
      {
         return _isMoving;
      }
      
      public function startMoving() : void
      {
         _isMoving = true;
      }
      
      public function stopMoving() : void
      {
         _vx.clearMotion();
         _vy.clearMotion();
         _isMoving = false;
      }
      
      public function setMap(map:Map3D) : void
      {
         _map = map;
         if(_map)
         {
            _arf = _map.airResistance * _airResitFactor;
            _gf = _map.gravity * _gravityFactor * _mass;
            _wf = _map.wind * _windFactor * _map.windRate;
         }
      }
      
      protected function computeFallNextXY(dt:Number) : Point
      {
         _vx.ComputeOneEulerStep(_mass,_arf,_wf + _ef.x,dt);
         _vy.ComputeOneEulerStep(_mass,_arf,_gf + _ef.y,dt);
         return new Point(_vx.x0,_vy.x0);
      }
      
      public function get pos() : Point
      {
         return new Point(x,y);
      }
      
      public function set pos(value:Point) : void
      {
         x = value.x;
         y = value.y;
      }
      
      public function update(dt:Number) : void
      {
         if(_isMoving && _map)
         {
            updatePosition(dt);
         }
      }
      
      protected function updatePosition(dt:Number) : void
      {
         moveTo(computeFallNextXY(dt));
         dispatchEvent(new Event("updatenamepos"));
      }
      
      public function moveTo(p:Point) : void
      {
         if(p.x != x || p.y != y)
         {
            pos = p;
         }
      }
      
      override public function set x(value:Number) : void
      {
         .super.x = value;
         _vx.x0 = value;
      }
      
      override public function set y(value:Number) : void
      {
         .super.y = value;
         _vy.x0 = value;
      }
      
      override public function dispose() : void
      {
         if(_map)
         {
            _map.removePhysical(this);
         }
         _map = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
