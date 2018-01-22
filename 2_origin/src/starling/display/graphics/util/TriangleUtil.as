package starling.display.graphics.util
{
   import flash.geom.Point;
   
   public class TriangleUtil
   {
       
      
      public function TriangleUtil()
      {
         super();
      }
      
      public static function isLeft(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Boolean
      {
         return (param3 - param1) * (param6 - param2) - (param4 - param2) * (param5 - param1) < 0;
      }
      
      public static function isPointInTriangle(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : Boolean
      {
         if(isLeft(param5,param6,param1,param2,param7,param8))
         {
            return false;
         }
         if(isLeft(param1,param2,param3,param4,param7,param8))
         {
            return false;
         }
         if(isLeft(param3,param4,param5,param6,param7,param8))
         {
            return false;
         }
         return true;
      }
      
      public static function isPointInTriangleBarycentric(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : Boolean
      {
         var _loc10_:Number = ((param4 - param6) * (param7 - param5) + (param5 - param3) * (param8 - param6)) / ((param4 - param6) * (param1 - param5) + (param5 - param3) * (param2 - param6));
         var _loc11_:Number = ((param6 - param2) * (param7 - param5) + (param1 - param5) * (param8 - param6)) / ((param4 - param6) * (param1 - param5) + (param5 - param3) * (param2 - param6));
         var _loc9_:Number = 1 - _loc10_ - _loc11_;
         if(_loc10_ > 0 && _loc11_ > 0 && _loc9_ > 0)
         {
            return true;
         }
         return false;
      }
      
      public static function isPointOnLine(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Boolean
      {
         var _loc8_:Number = (param3 - param1) * (param3 - param1) + (param4 - param2) * (param4 - param2);
         var _loc11_:Number = ((param5 - param1) * (param3 - param1) + (param6 - param2) * (param4 - param2)) / _loc8_;
         if(_loc11_ < 0 || _loc11_ > 1)
         {
            return false;
         }
         var _loc9_:Number = param1 + _loc11_ * (param3 - param1);
         var _loc13_:Number = param2 + _loc11_ * (param4 - param2);
         var _loc10_:Number = (param5 - _loc9_) * (param5 - _loc9_) + (param6 - _loc13_) * (param6 - _loc13_);
         var _loc12_:Number = 1 + param7;
         if(_loc10_ <= _loc12_ * _loc12_)
         {
            return true;
         }
         return false;
      }
      
      public static function lineIntersectLine(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Point) : Boolean
      {
         var _loc17_:Number = param4 - param2;
         var _loc16_:Number = param1 - param3;
         var _loc14_:Number = param3 * param2 - param1 * param4;
         var _loc18_:Number = param8 - param6;
         var _loc13_:Number = param5 - param7;
         var _loc15_:Number = param7 * param6 - param5 * param8;
         var _loc10_:Number = _loc17_ * _loc13_ - _loc18_ * _loc16_;
         if(_loc10_ == 0)
         {
            return false;
         }
         var _loc19_:Number = 1 / _loc10_;
         var _loc11_:Number = (_loc16_ * _loc15_ - _loc13_ * _loc14_) * _loc19_;
         var _loc12_:Number = (_loc18_ * _loc14_ - _loc17_ * _loc15_) * _loc19_;
         if(isPointOnLine(param1,param2,param3,param4,_loc11_,_loc12_,0) && isPointOnLine(param5,param6,param7,param8,_loc11_,_loc12_,0))
         {
            param9.x = _loc11_;
            param9.y = _loc12_;
            return true;
         }
         return false;
      }
   }
}
