package hall.player.aStar
{
   import flash.geom.Point;
   
   public class MathUtil
   {
       
      
      public function MathUtil()
      {
         super();
      }
      
      public static function getLineFunc(param1:Point, param2:Point, param3:int = 0) : Function
      {
         ponit1 = param1;
         point2 = param2;
         type = param3;
         if(ponit1.x == point2.x)
         {
            if(type == 0)
            {
               throw new Error("两点所确定直线垂直于y轴，不能根据x值得到y值");
            }
            if(type == 1)
            {
               var resultFuc:Function = function(param1:Number):Number
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
               resultFuc = function(param1:Number):Number
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
            resultFuc = function(param1:Number):Number
            {
               return a * param1 + b;
            };
         }
         else if(type == 1)
         {
            resultFuc = function(param1:Number):Number
            {
               return (param1 - b) / a;
            };
         }
         return resultFuc;
      }
      
      public static function getSlope(param1:Point, param2:Point) : Number
      {
         return (param2.y - param1.y) / (param2.x - param1.x);
      }
   }
}
