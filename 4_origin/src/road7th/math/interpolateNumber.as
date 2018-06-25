package road7th.math
{
   public function interpolateNumber(x1:Number, y1:Number, x2:Number, y2:Number, x:Number) : Number
   {
      return (x - x1) * (y2 - y1) / (x2 - x1) + y1;
   }
}
