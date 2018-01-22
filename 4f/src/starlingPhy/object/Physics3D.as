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
      
      public function Physics3D(param1:Number = 1, param2:Number = 1, param3:Number = 1, param4:Number = 1){super();}
      
      public function get layer() : int{return 0;}
      
      public function set layer(param1:int) : void{}
      
      public function addExternForce(param1:Point) : void{}
      
      public function addSpeedXY(param1:Point) : void{}
      
      public function setSpeedXY(param1:Point) : void{}
      
      public function changeSpeedXY(param1:Number, param2:Number) : void{}
      
      public function get Vx() : Number{return 0;}
      
      public function get Vy() : Number{return 0;}
      
      public function get motionAngle() : Number{return 0;}
      
      public function isMoving() : Boolean{return false;}
      
      public function startMoving() : void{}
      
      public function stopMoving() : void{}
      
      public function setMap(param1:Map3D) : void{}
      
      protected function computeFallNextXY(param1:Number) : Point{return null;}
      
      public function get pos() : Point{return null;}
      
      public function set pos(param1:Point) : void{}
      
      public function update(param1:Number) : void{}
      
      protected function updatePosition(param1:Number) : void{}
      
      public function moveTo(param1:Point) : void{}
      
      override public function set x(param1:Number) : void{}
      
      override public function set y(param1:Number) : void{}
      
      override public function dispose() : void{}
   }
}
