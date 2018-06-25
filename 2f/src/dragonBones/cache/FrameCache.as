package dragonBones.cache{   import dragonBones.objects.DBTransform;   import flash.geom.Matrix;      public class FrameCache   {            private static const ORIGIN_TRAMSFORM:DBTransform = new DBTransform();            private static const ORIGIN_MATRIX:Matrix = new Matrix();                   public var globalTransform:DBTransform;            public var globalTransformMatrix:Matrix;            public function FrameCache() { super(); }
            public function copy(frameCache:FrameCache) : void { }
            public function clear() : void { }
   }}