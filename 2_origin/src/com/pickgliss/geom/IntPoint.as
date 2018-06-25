package com.pickgliss.geom
{
   import flash.geom.Point;
   
   public class IntPoint
   {
       
      
      public var x:int = 0;
      
      public var y:int = 0;
      
      public function IntPoint(x:int = 0, y:int = 0)
      {
         super();
         this.x = x;
         this.y = y;
      }
      
      public static function creatWithPoint(p:Point) : IntPoint
      {
         return new IntPoint(p.x,p.y);
      }
      
      public function toPoint() : Point
      {
         return new Point(x,y);
      }
      
      public function setWithPoint(p:Point) : void
      {
         x = p.x;
         y = p.y;
      }
      
      public function setLocation(p:IntPoint) : void
      {
         this.x = p.x;
         this.y = p.y;
      }
      
      public function setLocationXY(x:int = 0, y:int = 0) : void
      {
         this.x = x;
         this.y = y;
      }
      
      public function move(dx:int, dy:int) : IntPoint
      {
         x = x + dx;
         y = y + dy;
         return this;
      }
      
      public function moveRadians(direction:int, distance:int) : IntPoint
      {
         x = x + Math.round(Math.cos(direction) * distance);
         y = y + Math.round(Math.sin(direction) * distance);
         return this;
      }
      
      public function nextPoint(direction:Number, distance:Number) : IntPoint
      {
         return new IntPoint(x + Math.cos(direction) * distance,y + Math.sin(direction) * distance);
      }
      
      public function distanceSq(p:IntPoint) : int
      {
         var xx:int = p.x;
         var yy:int = p.y;
         return (x - xx) * (x - xx) + (y - yy) * (y - yy);
      }
      
      public function distance(p:IntPoint) : int
      {
         return Math.sqrt(distanceSq(p));
      }
      
      public function equals(o:Object) : Boolean
      {
         var toCompare:IntPoint = o as IntPoint;
         if(toCompare == null)
         {
            return false;
         }
         return x === toCompare.x && y === toCompare.y;
      }
      
      public function clone() : IntPoint
      {
         return new IntPoint(x,y);
      }
      
      public function toString() : String
      {
         return "IntPoint[" + x + "," + y + "]";
      }
   }
}
