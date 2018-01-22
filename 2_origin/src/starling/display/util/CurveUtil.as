package starling.display.util
{
   public class CurveUtil
   {
      
      private static const STEPS:int = 8;
      
      public static const BEZIER_ERROR:Number = 0.75;
      
      private static var _subSteps:int = 0;
      
      private static var _bezierError:Number = 0.75;
      
      private static var _terms:Vector.<Number> = new Vector.<Number>(8,true);
       
      
      public function CurveUtil()
      {
         super();
      }
      
      public static function quadraticCurve(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number = 0.75) : Vector.<Number>
      {
         _subSteps = 0;
         _bezierError = param7;
         _terms[0] = param1;
         _terms[1] = param2;
         _terms[2] = param3;
         _terms[3] = param4;
         _terms[4] = param5;
         _terms[5] = param6;
         var _loc8_:Vector.<Number> = new Vector.<Number>();
         subdivideQuadratic(0,0.5,0,_loc8_);
         subdivideQuadratic(0.5,1,0,_loc8_);
         return _loc8_;
      }
      
      public static function cubicCurve(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number = 0.75) : Vector.<Number>
      {
         _subSteps = 0;
         _bezierError = param9;
         _terms[0] = param1;
         _terms[1] = param2;
         _terms[2] = param3;
         _terms[3] = param4;
         _terms[4] = param5;
         _terms[5] = param6;
         _terms[6] = param7;
         _terms[7] = param8;
         var _loc10_:Vector.<Number> = new Vector.<Number>();
         subdivideCubic(0,0.5,0,_loc10_);
         subdivideCubic(0.5,1,0,_loc10_);
         return _loc10_;
      }
      
      private static function quadratic(param1:Number, param2:int) : Number
      {
         var _loc4_:Number = 1 - param1;
         var _loc5_:Number = _terms[0 + param2];
         var _loc3_:Number = _terms[2 + param2];
         var _loc6_:Number = _terms[4 + param2];
         return _loc4_ * _loc4_ * _loc5_ + 2 * _loc4_ * param1 * _loc3_ + param1 * param1 * _loc6_;
      }
      
      private static function cubic(param1:Number, param2:int) : Number
      {
         var _loc5_:Number = 1 - param1;
         var _loc6_:Number = _terms[0 + param2];
         var _loc3_:Number = _terms[2 + param2];
         var _loc4_:Number = _terms[4 + param2];
         var _loc7_:Number = _terms[6 + param2];
         return _loc5_ * _loc5_ * _loc5_ * _loc6_ + 3 * _loc5_ * _loc5_ * param1 * _loc3_ + 3 * _loc5_ * param1 * param1 * _loc4_ + param1 * param1 * param1 * _loc7_;
      }
      
      private static function subdivide(param1:Number, param2:Number, param3:int, param4:Function, param5:Vector.<Number>) : void
      {
         var _loc15_:Number = param4((param1 + param2) * 0.5,0);
         var _loc14_:Number = param4((param1 + param2) * 0.5,1);
         var _loc12_:Number = param4(param1,0);
         var _loc10_:Number = param4(param1,1);
         var _loc13_:Number = param4(param2,0);
         var _loc11_:Number = param4(param2,1);
         var _loc7_:Number = (_loc12_ + _loc13_) * 0.5;
         var _loc6_:Number = (_loc10_ + _loc11_) * 0.5;
         var _loc8_:Number = _loc15_ - _loc7_;
         var _loc9_:Number = _loc14_ - _loc6_;
         var _loc16_:Number = _loc8_ * _loc8_ + _loc9_ * _loc9_;
         if(_loc16_ > _bezierError * _bezierError)
         {
            subdivide(param1,(param1 + param2) * 0.5,param3 + 1,param4,param5);
            subdivide((param1 + param2) * 0.5,param2,param3 + 1,param4,param5);
         }
         else
         {
            _subSteps = _subSteps + 1;
            param5.push(_loc13_,_loc11_);
         }
      }
      
      private static function subdivideQuadratic(param1:Number, param2:Number, param3:int, param4:Vector.<Number>) : void
      {
         var _loc14_:Number = quadratic((param1 + param2) * 0.5,0);
         var _loc13_:Number = quadratic((param1 + param2) * 0.5,1);
         var _loc11_:Number = quadratic(param1,0);
         var _loc9_:Number = quadratic(param1,1);
         var _loc12_:Number = quadratic(param2,0);
         var _loc10_:Number = quadratic(param2,1);
         var _loc6_:Number = (_loc11_ + _loc12_) * 0.5;
         var _loc5_:Number = (_loc9_ + _loc10_) * 0.5;
         var _loc7_:Number = _loc14_ - _loc6_;
         var _loc8_:Number = _loc13_ - _loc5_;
         var _loc15_:Number = _loc7_ * _loc7_ + _loc8_ * _loc8_;
         if(_loc15_ > _bezierError * _bezierError)
         {
            subdivideQuadratic(param1,(param1 + param2) * 0.5,param3 + 1,param4);
            subdivideQuadratic((param1 + param2) * 0.5,param2,param3 + 1,param4);
         }
         else
         {
            _subSteps = _subSteps + 1;
            param4.push(_loc12_,_loc10_);
         }
      }
      
      private static function subdivideCubic(param1:Number, param2:Number, param3:int, param4:Vector.<Number>) : void
      {
         var _loc14_:Number = cubic((param1 + param2) * 0.5,0);
         var _loc13_:Number = cubic((param1 + param2) * 0.5,1);
         var _loc11_:Number = cubic(param1,0);
         var _loc9_:Number = cubic(param1,1);
         var _loc12_:Number = cubic(param2,0);
         var _loc10_:Number = cubic(param2,1);
         var _loc6_:Number = (_loc11_ + _loc12_) * 0.5;
         var _loc5_:Number = (_loc9_ + _loc10_) * 0.5;
         var _loc7_:Number = _loc14_ - _loc6_;
         var _loc8_:Number = _loc13_ - _loc5_;
         var _loc15_:Number = _loc7_ * _loc7_ + _loc8_ * _loc8_;
         if(_loc15_ > _bezierError * _bezierError)
         {
            subdivideCubic(param1,(param1 + param2) * 0.5,param3 + 1,param4);
            subdivideCubic((param1 + param2) * 0.5,param2,param3 + 1,param4);
         }
         else
         {
            _subSteps = _subSteps + 1;
            param4.push(_loc12_,_loc10_);
         }
      }
   }
}
