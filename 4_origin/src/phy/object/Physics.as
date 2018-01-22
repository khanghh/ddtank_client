package phy.object
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import phy.maps.Map;
   import phy.math.EulerVector;
   
   public class Physics extends Sprite implements Disposeable
   {
       
      
      protected var _mass:Number;
      
      protected var _gravityFactor:Number;
      
      protected var _windFactor:Number;
      
      protected var _airResitFactor:Number;
      
      protected var _vx:EulerVector;
      
      protected var _vy:EulerVector;
      
      protected var _ef:Point;
      
      protected var _isMoving:Boolean;
      
      protected var _map:Map;
      
      protected var _layer:int = -1;
      
      protected var _arf:Number = 0;
      
      protected var _gf:Number = 0;
      
      protected var _wf:Number = 0;
      
      public function Physics(param1:Number = 1, param2:Number = 1, param3:Number = 1, param4:Number = 1)
      {
         super();
         _mass = param1;
         _gravityFactor = param2;
         _windFactor = param3;
         _airResitFactor = param4;
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
      
      public function set layer(param1:int) : void
      {
         _layer = param1;
      }
      
      public function addExternForce(param1:Point) : void
      {
         _ef.x = _ef.x + param1.x;
         _ef.y = _ef.y + param1.y;
         if(!_isMoving && _map)
         {
            startMoving();
         }
      }
      
      public function addSpeedXY(param1:Point) : void
      {
         _vx.x1 = _vx.x1 + param1.x;
         _vy.x1 = _vy.x1 + param1.y;
         if(!_isMoving && _map)
         {
            startMoving();
         }
      }
      
      public function setSpeedXY(param1:Point) : void
      {
         _vx.x1 = param1.x;
         _vy.x1 = param1.y;
         if(!_isMoving && _map)
         {
            startMoving();
         }
      }
      
      public function changeSpeedXY(param1:Number, param2:Number) : void
      {
         _vx.x1 = param1;
         _vy.x1 = param2;
      }
      
      public function changeAccelerateXY(param1:Number, param2:Number) : void
      {
         _vx.addx2 = param1;
         _vy.addx2 = param2;
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
      
      public function setMap(param1:Map) : void
      {
         _map = param1;
         if(_map)
         {
            _arf = _map.airResistance * _airResitFactor;
            _gf = _map.gravity * _gravityFactor * _mass;
            _wf = _map.wind * _windFactor * _map.windRate;
         }
      }
      
      protected function computeFallNextXY(param1:Number) : Point
      {
         _vx.ComputeOneEulerStep(_mass,_arf,_wf + _ef.x,param1);
         _vy.ComputeOneEulerStep(_mass,_arf,_gf + _ef.y,param1);
         return new Point(_vx.x0,_vy.x0);
      }
      
      public function get pos() : Point
      {
         return new Point(x,y);
      }
      
      public function set pos(param1:Point) : void
      {
         x = param1.x;
         y = param1.y;
      }
      
      public function update(param1:Number) : void
      {
         if(_isMoving && _map)
         {
            updatePosition(param1);
         }
      }
      
      protected function updatePosition(param1:Number) : void
      {
         moveTo(computeFallNextXY(param1));
         dispatchEvent(new Event("updatenamepos"));
      }
      
      public function moveTo(param1:Point) : void
      {
         if(param1.x != x || param1.y != y)
         {
            pos = param1;
         }
      }
      
      override public function set x(param1:Number) : void
      {
         .super.x = param1;
         _vx.x0 = param1;
      }
      
      override public function set y(param1:Number) : void
      {
         .super.y = param1;
         _vy.x0 = param1;
      }
      
      public function dispose() : void
      {
         if(_map)
         {
            _map.removePhysical(this);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
