package starling.display
{
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Vector3D;
   import starling.core.RenderSupport;
   import starling.events.Event;
   import starling.utils.MathUtil;
   import starling.utils.MatrixUtil;
   import starling.utils.rad2deg;
   
   public class Sprite3D extends DisplayObjectContainer
   {
      
      private static const E:Number = 1.0E-5;
      
      private static var sHelperPoint:Vector3D = new Vector3D();
      
      private static var sHelperPointAlt:Vector3D = new Vector3D();
      
      private static var sHelperMatrix:Matrix3D = new Matrix3D();
       
      
      private var mRotationX:Number;
      
      private var mRotationY:Number;
      
      private var mScaleZ:Number;
      
      private var mPivotZ:Number;
      
      private var mZ:Number;
      
      private var mTransformationMatrix:Matrix;
      
      private var mTransformationMatrix3D:Matrix3D;
      
      private var mTransformationChanged:Boolean;
      
      public function Sprite3D(){super();}
      
      override public function render(param1:RenderSupport, param2:Number) : void{}
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject{return null;}
      
      private function onAddedChild(param1:Event) : void{}
      
      private function onRemovedChild(param1:Event) : void{}
      
      private function recursivelySetIs3D(param1:DisplayObject, param2:Boolean) : void{}
      
      private function updateMatrices() : void{}
      
      [Inline]
      private final function get is2D() : Boolean{return false;}
      
      override public function get transformationMatrix() : Matrix{return null;}
      
      override public function set transformationMatrix(param1:Matrix) : void{}
      
      override public function get transformationMatrix3D() : Matrix3D{return null;}
      
      override public function set x(param1:Number) : void{}
      
      override public function set y(param1:Number) : void{}
      
      public function get z() : Number{return 0;}
      
      public function set z(param1:Number) : void{}
      
      override public function set pivotX(param1:Number) : void{}
      
      override public function set pivotY(param1:Number) : void{}
      
      public function get pivotZ() : Number{return 0;}
      
      public function set pivotZ(param1:Number) : void{}
      
      override public function set scaleX(param1:Number) : void{}
      
      override public function set scaleY(param1:Number) : void{}
      
      public function get scaleZ() : Number{return 0;}
      
      public function set scaleZ(param1:Number) : void{}
      
      override public function set skewX(param1:Number) : void{}
      
      override public function set skewY(param1:Number) : void{}
      
      override public function set rotation(param1:Number) : void{}
      
      public function get rotationX() : Number{return 0;}
      
      public function set rotationX(param1:Number) : void{}
      
      public function get rotationY() : Number{return 0;}
      
      public function set rotationY(param1:Number) : void{}
      
      public function get rotationZ() : Number{return 0;}
      
      public function set rotationZ(param1:Number) : void{}
   }
}
