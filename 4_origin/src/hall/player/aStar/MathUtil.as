package hall.player.aStar
{
   import flash.geom.Point;
   
   public class MathUtil
   {
       
      
      public function MathUtil()
      {
         super();
      }
      
      public static function getLineFunc(ponit1:Point, point2:Point, type:int = 0) : Function
      {
         ponit1 = ponit1;
         point2 = point2;
         type = type;
         if(ponit1.x == point2.x)
         {
            if(type == 0)
            {
               throw new Error("两点所确定直线垂直于y轴，不能根据x值得到y值");
            }
            if(type == 1)
            {
               var resultFuc:Function = function(y:Number):Number
               {
                  return ponit1.x;
               };
            }
            return resultFuc;
         }
         if(ponit1.y == point2.y)
         {
            if(type == 0)
            {
               resultFuc = function(x:Number):Number
               {
                  return ponit1.y;
               };
            }
            else if(type == 1)
            {
               throw new Error("两点所确定直线垂直于y轴，不能根据x值得到y值");
            }
            return resultFuc;
         }
         var a:Number = (ponit1.y - point2.y) / (ponit1.x - point2.x);
         var b:Number = ponit1.y - a * ponit1.x;
         if(type == 0)
         {
            resultFuc = function(x:Number):Number
            {
               return a * x + b;
            };
         }
         else if(type == 1)
         {
            resultFuc = function(y:Number):Number
            {
               return (y - b) / a;
            };
         }
         return resultFuc;
      }
      
      public static function getSlope(ponit1:Point, point2:Point) : Number
      {
         return (point2.y - ponit1.y) / (point2.x - ponit1.x);
      }
   }
}
