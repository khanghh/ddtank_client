package starling.utils{   import flash.geom.Matrix;   import flash.geom.Matrix3D;   import flash.geom.Point;   import flash.geom.Vector3D;   import starling.errors.AbstractClassError;      public class MatrixUtil   {            private static var sRawData:Vector.<Number> = new <Number>[1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1];            private static var sRawData2:Vector.<Number> = new Vector.<Number>(16,true);                   public function MatrixUtil() { super(); }
            public static function convertTo3D(matrix:Matrix, resultMatrix:Matrix3D = null) : Matrix3D { return null; }
            public static function convertTo2D(matrix3D:Matrix3D, resultMatrix:Matrix = null) : Matrix { return null; }
            public static function transformPoint(matrix:Matrix, point:Point, resultPoint:Point = null) : Point { return null; }
            public static function transformPoint3D(matrix:Matrix3D, point:Vector3D, resultPoint:Vector3D = null) : Vector3D { return null; }
            public static function transformCoords(matrix:Matrix, x:Number, y:Number, resultPoint:Point = null) : Point { return null; }
            public static function transformCoords3D(matrix:Matrix3D, x:Number, y:Number, z:Number, resultPoint:Vector3D = null) : Vector3D { return null; }
            public static function skew(matrix:Matrix, skewX:Number, skewY:Number) : void { }
            public static function prependMatrix(base:Matrix, prep:Matrix) : void { }
            public static function prependTranslation(matrix:Matrix, tx:Number, ty:Number) : void { }
            public static function prependScale(matrix:Matrix, sx:Number, sy:Number) : void { }
            public static function prependRotation(matrix:Matrix, angle:Number) : void { }
            public static function prependSkew(matrix:Matrix, skewX:Number, skewY:Number) : void { }
   }}