package starling.display.util
{
   public class CurveUtil
   {
      
      private static const STEPS:int = 8;
      
      public static const BEZIER_ERROR:Number = 0.75;
      
      private static var _subSteps:int = 0;
      
      private static var _bezierError:Number = 0.75;
      
      private static var _terms:Vector.<Number> = new Vector.<Number>(8,true);
       
      
      public function CurveUtil(){super();}
      
      public static function quadraticCurve(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number = 0.75) : Vector.<Number>{return null;}
      
      public static function cubicCurve(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number = 0.75) : Vector.<Number>{return null;}
      
      private static function quadratic(param1:Number, param2:int) : Number{return 0;}
      
      private static function cubic(param1:Number, param2:int) : Number{return 0;}
      
      private static function subdivide(param1:Number, param2:Number, param3:int, param4:Function, param5:Vector.<Number>) : void{}
      
      private static function subdivideQuadratic(param1:Number, param2:Number, param3:int, param4:Vector.<Number>) : void{}
      
      private static function subdivideCubic(param1:Number, param2:Number, param3:int, param4:Vector.<Number>) : void{}
   }
}
