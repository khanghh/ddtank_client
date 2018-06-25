package road7th.math
{
   import flash.geom.Point;
   
   public class ColorLine extends XLine
   {
       
      
      public function ColorLine()
      {
         super();
      }
      
      override public function interpolate(x:Number) : Number
      {
         var p1:* = null;
         var p2:* = null;
         var i:int = 0;
         if(!fix)
         {
            for(i = 1; i < list.length; )
            {
               p2 = list[i];
               p1 = list[i - 1];
               if(p2.x <= x)
               {
                  i++;
                  continue;
               }
               break;
            }
            return interpolateColors(p1.y,p2.y,1 - (x - p1.x) / (p2.x - p1.x));
         }
         return fixValue;
      }
   }
}
