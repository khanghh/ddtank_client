package phy.object
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import road7th.utils.MathUtils;
   
   public class PhysicalObj extends Physics
   {
       
      
      protected var _id:int;
      
      protected var _testRect:Rectangle;
      
      protected var _canCollided:Boolean;
      
      protected var _isLiving:Boolean;
      
      protected var _layerType:int;
      
      public var IsCollide:Boolean;
      
      private var _drawPointContainer:Sprite;
      
      public function PhysicalObj(param1:int, param2:int = 1, param3:Number = 1, param4:Number = 1, param5:Number = 1, param6:Number = 1){super(null,null,null,null);}
      
      public function get Id() : int{return 0;}
      
      public function get layerType() : int{return 0;}
      
      public function setCollideRect(param1:int, param2:int, param3:int, param4:int) : void{}
      
      public function getCollideRect() : Rectangle{return null;}
      
      public function get canCollided() : Boolean{return false;}
      
      public function set canCollided(param1:Boolean) : void{}
      
      public function get smallView() : SmallObject{return null;}
      
      public function get isLiving() : Boolean{return false;}
      
      override public function moveTo(param1:Point) : void{}
      
      public function calcObjectAngle(param1:Number = 16) : Number{return 0;}
      
      public function calcObjectAngle2(param1:Number = 16, param2:int = 10) : Number{return 0;}
      
      public function calcObjectAngleDebug(param1:Number = 16) : Number{return 0;}
      
      public function calcObjectAngleDebug2(param1:Number = 16, param2:int = 10) : Number{return 0;}
      
      private function drawPoint(param1:Array, param2:Boolean) : void{}
      
      protected function flyOutMap() : void{}
      
      protected function collideObject(param1:Array) : void{}
      
      protected function collideGround() : void{}
      
      public function collidedByObject(param1:PhysicalObj) : void{}
      
      public function setActionMapping(param1:String, param2:String) : void{}
      
      public function die() : void{}
      
      public function getTestRect() : Rectangle{return null;}
      
      public function isBox() : Boolean{return false;}
   }
}
