package starling.display{   import flash.geom.Matrix;   import flash.geom.Matrix3D;   import flash.geom.Point;   import flash.geom.Vector3D;   import starling.core.RenderSupport;   import starling.events.Event;   import starling.utils.MathUtil;   import starling.utils.MatrixUtil;   import starling.utils.rad2deg;      public class Sprite3D extends DisplayObjectContainer   {            private static const E:Number = 1.0E-5;            private static var sHelperPoint:Vector3D = new Vector3D();            private static var sHelperPointAlt:Vector3D = new Vector3D();            private static var sHelperMatrix:Matrix3D = new Matrix3D();                   private var mRotationX:Number;            private var mRotationY:Number;            private var mScaleZ:Number;            private var mPivotZ:Number;            private var mZ:Number;            private var mTransformationMatrix:Matrix;            private var mTransformationMatrix3D:Matrix3D;            private var mTransformationChanged:Boolean;            public function Sprite3D() { super(); }
            override public function render(support:RenderSupport, parentAlpha:Number) : void { }
            override public function hitTest(localPoint:Point, forTouch:Boolean = false) : DisplayObject { return null; }
            private function onAddedChild(event:Event) : void { }
            private function onRemovedChild(event:Event) : void { }
            private function recursivelySetIs3D(object:DisplayObject, value:Boolean) : void { }
            private function updateMatrices() : void { }
            [Inline]      private final function get is2D() : Boolean { return false; }
            override public function get transformationMatrix() : Matrix { return null; }
            override public function set transformationMatrix(value:Matrix) : void { }
            override public function get transformationMatrix3D() : Matrix3D { return null; }
            override public function set x(value:Number) : void { }
            override public function set y(value:Number) : void { }
            public function get z() : Number { return 0; }
            public function set z(value:Number) : void { }
            override public function set pivotX(value:Number) : void { }
            override public function set pivotY(value:Number) : void { }
            public function get pivotZ() : Number { return 0; }
            public function set pivotZ(value:Number) : void { }
            override public function set scaleX(value:Number) : void { }
            override public function set scaleY(value:Number) : void { }
            public function get scaleZ() : Number { return 0; }
            public function set scaleZ(value:Number) : void { }
            override public function set skewX(value:Number) : void { }
            override public function set skewY(value:Number) : void { }
            override public function set rotation(value:Number) : void { }
            public function get rotationX() : Number { return 0; }
            public function set rotationX(value:Number) : void { }
            public function get rotationY() : Number { return 0; }
            public function set rotationY(value:Number) : void { }
            public function get rotationZ() : Number { return 0; }
            public function set rotationZ(value:Number) : void { }
   }}