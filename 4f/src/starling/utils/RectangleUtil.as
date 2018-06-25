package starling.utils{   import flash.geom.Matrix;   import flash.geom.Point;   import flash.geom.Rectangle;   import starling.errors.AbstractClassError;      public class RectangleUtil   {            private static const sHelperPoint:Point = new Point();            private static const sPositions:Vector.<Point> = new <Point>[new Point(0,0),new Point(1,0),new Point(0,1),new Point(1,1)];                   public function RectangleUtil() { super(); }
            public static function intersect(rect1:Rectangle, rect2:Rectangle, resultRect:Rectangle = null) : Rectangle { return null; }
            public static function fit(rectangle:Rectangle, into:Rectangle, scaleMode:String = "showAll", pixelPerfect:Boolean = false, resultRect:Rectangle = null) : Rectangle { return null; }
            private static function nextSuitableScaleFactor(factor:Number, up:Boolean) : Number { return 0; }
            public static function normalize(rect:Rectangle) : void { }
            public static function getBounds(rectangle:Rectangle, transformationMatrix:Matrix, resultRect:Rectangle = null) : Rectangle { return null; }
   }}