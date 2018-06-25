package starling.display.util{   public class CurveUtil   {            private static const STEPS:int = 8;            public static const BEZIER_ERROR:Number = 0.75;            private static var _subSteps:int = 0;            private static var _bezierError:Number = 0.75;            private static var _terms:Vector.<Number> = new Vector.<Number>(8,true);                   public function CurveUtil() { super(); }
            public static function quadraticCurve(a1x:Number, a1y:Number, cx:Number, cy:Number, a2x:Number, a2y:Number, error:Number = 0.75) : Vector.<Number> { return null; }
            public static function cubicCurve(a1x:Number, a1y:Number, c1x:Number, c1y:Number, c2x:Number, c2y:Number, a2x:Number, a2y:Number, error:Number = 0.75) : Vector.<Number> { return null; }
            private static function quadratic(t:Number, axis:int) : Number { return 0; }
            private static function cubic(t:Number, axis:int) : Number { return 0; }
            private static function subdivide(t0:Number, t1:Number, depth:int, equation:Function, output:Vector.<Number>) : void { }
            private static function subdivideQuadratic(t0:Number, t1:Number, depth:int, output:Vector.<Number>) : void { }
            private static function subdivideCubic(t0:Number, t1:Number, depth:int, output:Vector.<Number>) : void { }
   }}