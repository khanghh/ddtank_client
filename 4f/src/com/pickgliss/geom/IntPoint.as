package com.pickgliss.geom
{
   import flash.geom.Point;
   
   public class IntPoint
   {
       
      
      public var x:int = 0;
      
      public var y:int = 0;
      
      public function IntPoint(param1:int = 0, param2:int = 0){super();}
      
      public static function creatWithPoint(param1:Point) : IntPoint{return null;}
      
      public function toPoint() : Point{return null;}
      
      public function setWithPoint(param1:Point) : void{}
      
      public function setLocation(param1:IntPoint) : void{}
      
      public function setLocationXY(param1:int = 0, param2:int = 0) : void{}
      
      public function move(param1:int, param2:int) : IntPoint{return null;}
      
      public function moveRadians(param1:int, param2:int) : IntPoint{return null;}
      
      public function nextPoint(param1:Number, param2:Number) : IntPoint{return null;}
      
      public function distanceSq(param1:IntPoint) : int{return 0;}
      
      public function distance(param1:IntPoint) : int{return 0;}
      
      public function equals(param1:Object) : Boolean{return false;}
      
      public function clone() : IntPoint{return null;}
      
      public function toString() : String{return null;}
   }
}
