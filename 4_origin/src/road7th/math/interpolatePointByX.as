package road7th.math
{
   import flash.geom.Point;
   
   public function interpolatePointByX(p1:Point, p2:Point, x:Number) : Number
   {
      return (x - p1.x) * (p2.y - p1.y) / (p2.x - p1.x) + p1.y;
   }
}
