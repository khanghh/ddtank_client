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
      
      public function Sprite3D()
      {
         super();
         mScaleZ = 1;
         mZ = 0;
         mPivotZ = 0;
         mRotationY = 0;
         mRotationX = 0;
         mTransformationMatrix = new Matrix();
         mTransformationMatrix3D = new Matrix3D();
         setIs3D(true);
         addEventListener("added",onAddedChild);
         addEventListener("removed",onRemovedChild);
      }
      
      override public function render(support:RenderSupport, parentAlpha:Number) : void
      {
         if(is2D)
         {
            super.render(support,parentAlpha);
         }
         else
         {
            support.finishQuadBatch();
            support.pushMatrix3D();
            support.transformMatrix3D(this);
            super.render(support,parentAlpha);
            support.finishQuadBatch();
            support.popMatrix3D();
         }
      }
      
      override public function hitTest(localPoint:Point, forTouch:Boolean = false) : DisplayObject
      {
         if(is2D)
         {
            return super.hitTest(localPoint,forTouch);
         }
         if(forTouch && (!visible || !touchable))
         {
            return null;
         }
         sHelperMatrix.copyFrom(transformationMatrix3D);
         sHelperMatrix.invert();
         stage.getCameraPosition(this,sHelperPoint);
         MatrixUtil.transformCoords3D(sHelperMatrix,localPoint.x,localPoint.y,0,sHelperPointAlt);
         MathUtil.intersectLineWithXYPlane(sHelperPoint,sHelperPointAlt,localPoint);
         return super.hitTest(localPoint,forTouch);
      }
      
      private function onAddedChild(event:Event) : void
      {
         recursivelySetIs3D(event.target as DisplayObject,true);
      }
      
      private function onRemovedChild(event:Event) : void
      {
         recursivelySetIs3D(event.target as DisplayObject,false);
      }
      
      private function recursivelySetIs3D(object:DisplayObject, value:Boolean) : void
      {
         var container:* = null;
         var numChildren:int = 0;
         var i:int = 0;
         if(object is Sprite3D)
         {
            return;
         }
         if(object is DisplayObjectContainer)
         {
            container = object as DisplayObjectContainer;
            numChildren = container.numChildren;
            for(i = 0; i < numChildren; )
            {
               recursivelySetIs3D(container.getChildAt(i),value);
               i++;
            }
         }
         object.setIs3D(value);
      }
      
      private function updateMatrices() : void
      {
         var x:Number = this.x;
         var y:Number = this.y;
         var scaleX:Number = this.scaleX;
         var scaleY:Number = this.scaleY;
         var pivotX:Number = this.pivotX;
         var pivotY:Number = this.pivotY;
         var rotationZ:Number = this.rotation;
         mTransformationMatrix3D.identity();
         if(scaleX != 1 || scaleY != 1 || mScaleZ != 1)
         {
            mTransformationMatrix3D.appendScale(scaleX || 0.00001,scaleY || 0.00001,mScaleZ || 0.00001);
         }
         if(mRotationX != 0)
         {
            mTransformationMatrix3D.appendRotation(rad2deg(mRotationX),Vector3D.X_AXIS);
         }
         if(mRotationY != 0)
         {
            mTransformationMatrix3D.appendRotation(rad2deg(mRotationY),Vector3D.Y_AXIS);
         }
         if(rotationZ != 0)
         {
            mTransformationMatrix3D.appendRotation(rad2deg(rotationZ),Vector3D.Z_AXIS);
         }
         if(x != 0 || y != 0 || mZ != 0)
         {
            mTransformationMatrix3D.appendTranslation(x,y,mZ);
         }
         if(pivotX != 0 || pivotY != 0 || mPivotZ != 0)
         {
            mTransformationMatrix3D.prependTranslation(-pivotX,-pivotY,-mPivotZ);
         }
         if(is2D)
         {
            MatrixUtil.convertTo2D(mTransformationMatrix3D,mTransformationMatrix);
         }
         else
         {
            mTransformationMatrix.identity();
         }
      }
      
      [Inline]
      private final function get is2D() : Boolean
      {
         return mZ > -0.00001 && mZ < 0.00001 && mRotationX > -0.00001 && mRotationX < 0.00001 && mRotationY > -0.00001 && mRotationY < 0.00001 && mPivotZ > -0.00001 && mPivotZ < 0.00001;
      }
      
      override public function get transformationMatrix() : Matrix
      {
         if(mTransformationChanged)
         {
            updateMatrices();
            mTransformationChanged = false;
         }
         return mTransformationMatrix;
      }
      
      override public function set transformationMatrix(value:Matrix) : void
      {
         .super.transformationMatrix = value;
         mZ = 0;
         mPivotZ = 0;
         mRotationY = 0;
         mRotationX = 0;
         mTransformationChanged = true;
      }
      
      override public function get transformationMatrix3D() : Matrix3D
      {
         if(mTransformationChanged)
         {
            updateMatrices();
            mTransformationChanged = false;
         }
         return mTransformationMatrix3D;
      }
      
      override public function set x(value:Number) : void
      {
         .super.x = value;
         mTransformationChanged = true;
      }
      
      override public function set y(value:Number) : void
      {
         .super.y = value;
         mTransformationChanged = true;
      }
      
      public function get z() : Number
      {
         return mZ;
      }
      
      public function set z(value:Number) : void
      {
         mZ = value;
         mTransformationChanged = true;
      }
      
      override public function set pivotX(value:Number) : void
      {
         .super.pivotX = value;
         mTransformationChanged = true;
      }
      
      override public function set pivotY(value:Number) : void
      {
         .super.pivotY = value;
         mTransformationChanged = true;
      }
      
      public function get pivotZ() : Number
      {
         return mPivotZ;
      }
      
      public function set pivotZ(value:Number) : void
      {
         mPivotZ = value;
         mTransformationChanged = true;
      }
      
      override public function set scaleX(value:Number) : void
      {
         .super.scaleX = value;
         mTransformationChanged = true;
      }
      
      override public function set scaleY(value:Number) : void
      {
         .super.scaleY = value;
         mTransformationChanged = true;
      }
      
      public function get scaleZ() : Number
      {
         return mScaleZ;
      }
      
      public function set scaleZ(value:Number) : void
      {
         mScaleZ = value;
         mTransformationChanged = true;
      }
      
      override public function set skewX(value:Number) : void
      {
         throw new Error("3D objects do not support skewing");
      }
      
      override public function set skewY(value:Number) : void
      {
         throw new Error("3D objects do not support skewing");
      }
      
      override public function set rotation(value:Number) : void
      {
         .super.rotation = value;
         mTransformationChanged = true;
      }
      
      public function get rotationX() : Number
      {
         return mRotationX;
      }
      
      public function set rotationX(value:Number) : void
      {
         mRotationX = MathUtil.normalizeAngle(value);
         mTransformationChanged = true;
      }
      
      public function get rotationY() : Number
      {
         return mRotationY;
      }
      
      public function set rotationY(value:Number) : void
      {
         mRotationY = MathUtil.normalizeAngle(value);
         mTransformationChanged = true;
      }
      
      public function get rotationZ() : Number
      {
         return rotation;
      }
      
      public function set rotationZ(value:Number) : void
      {
         rotation = value;
      }
   }
}
