package starling.display
{
   import flash.errors.IllegalOperationError;
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   import flash.system.Capabilities;
   import flash.ui.Mouse;
   import flash.utils.getQualifiedClassName;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.errors.AbstractClassError;
   import starling.errors.AbstractMethodError;
   import starling.events.Event;
   import starling.events.EventDispatcher;
   import starling.events.TouchEvent;
   import starling.filters.FragmentFilter;
   import starling.utils.MathUtil;
   import starling.utils.MatrixUtil;
   
   [Event(name="added",type="starling.events.Event")]
   [Event(name="addedToStage",type="starling.events.Event")]
   [Event(name="removed",type="starling.events.Event")]
   [Event(name="removedFromStage",type="starling.events.Event")]
   [Event(name="enterFrame",type="starling.events.EnterFrameEvent")]
   [Event(name="touch",type="starling.events.TouchEvent")]
   [Event(name="keyUp",type="starling.events.KeyboardEvent")]
   [Event(name="keyDown",type="starling.events.KeyboardEvent")]
   public class DisplayObject extends EventDispatcher
   {
      
      private static var sAncestors:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sHelperPoint3D:Vector3D = new Vector3D();
      
      private static var sHelperRect:Rectangle = new Rectangle();
      
      private static var sHelperMatrix:Matrix = new Matrix();
      
      private static var sHelperMatrixAlt:Matrix = new Matrix();
      
      private static var sHelperMatrix3D:Matrix3D = new Matrix3D();
      
      private static var sHelperMatrixAlt3D:Matrix3D = new Matrix3D();
       
      
      private var mX:Number;
      
      private var mY:Number;
      
      private var mPivotX:Number;
      
      private var mPivotY:Number;
      
      private var mScaleX:Number;
      
      private var mScaleY:Number;
      
      private var mSkewX:Number;
      
      private var mSkewY:Number;
      
      private var mRotation:Number;
      
      private var mAlpha:Number;
      
      private var mVisible:Boolean;
      
      private var mTouchable:Boolean;
      
      private var mBlendMode:String;
      
      private var mName:String;
      
      private var mUseHandCursor:Boolean;
      
      private var mParent:DisplayObjectContainer;
      
      private var mTransformationMatrix:Matrix;
      
      private var mTransformationMatrix3D:Matrix3D;
      
      private var mOrientationChanged:Boolean;
      
      private var mFilter:FragmentFilter;
      
      private var mIs3D:Boolean;
      
      private var mMask:DisplayObject;
      
      private var mIsMask:Boolean;
      
      protected var _laySortY:Number;
      
      public function DisplayObject()
      {
         super();
         if(Capabilities.isDebugger && getQualifiedClassName(this) == "starling.display::DisplayObject")
         {
            throw new AbstractClassError();
         }
         mSkewY = 0;
         mSkewX = 0;
         mRotation = 0;
         mPivotY = 0;
         mPivotX = 0;
         mY = 0;
         mX = 0;
         mAlpha = 1;
         mScaleY = 1;
         mScaleX = 1;
         mTouchable = true;
         mVisible = true;
         mBlendMode = "auto";
         mTransformationMatrix = new Matrix();
         mUseHandCursor = false;
         mOrientationChanged = false;
      }
      
      public function dispose() : void
      {
         if(mFilter)
         {
            mFilter.dispose();
         }
         if(mMask)
         {
            mMask.dispose();
         }
         removeEventListeners();
         mask = null;
      }
      
      public function removeFromParent(dispose:Boolean = false) : void
      {
         if(mParent)
         {
            mParent.removeChild(this,dispose);
         }
         else if(dispose)
         {
            this.dispose();
         }
      }
      
      public function getTransformationMatrix(targetSpace:DisplayObject, resultMatrix:Matrix = null) : Matrix
      {
         var commonParent:* = null;
         var currentObject:* = null;
         if(resultMatrix)
         {
            resultMatrix.identity();
         }
         else
         {
            resultMatrix = new Matrix();
         }
         if(targetSpace == this)
         {
            return resultMatrix;
         }
         if(targetSpace == mParent || targetSpace == null && mParent == null)
         {
            resultMatrix.copyFrom(transformationMatrix);
            return resultMatrix;
         }
         if(targetSpace == null || targetSpace == base)
         {
            currentObject = this;
            while(currentObject != targetSpace)
            {
               resultMatrix.concat(currentObject.transformationMatrix);
               currentObject = currentObject.mParent;
            }
            return resultMatrix;
         }
         if(targetSpace.mParent == this)
         {
            targetSpace.getTransformationMatrix(this,resultMatrix);
            resultMatrix.invert();
            return resultMatrix;
         }
         commonParent = findCommonParent(this,targetSpace);
         currentObject = this;
         while(currentObject != commonParent)
         {
            resultMatrix.concat(currentObject.transformationMatrix);
            currentObject = currentObject.mParent;
         }
         if(commonParent == targetSpace)
         {
            return resultMatrix;
         }
         sHelperMatrix.identity();
         currentObject = targetSpace;
         while(currentObject != commonParent)
         {
            sHelperMatrix.concat(currentObject.transformationMatrix);
            currentObject = currentObject.mParent;
         }
         sHelperMatrix.invert();
         resultMatrix.concat(sHelperMatrix);
         return resultMatrix;
      }
      
      public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle
      {
         throw new AbstractMethodError();
      }
      
      public function hitTest(localPoint:Point, forTouch:Boolean = false) : DisplayObject
      {
         if(forTouch && (!mVisible || !mTouchable))
         {
            return null;
         }
         if(mMask && !hitTestMask(localPoint))
         {
            return null;
         }
         if(getBounds(this,sHelperRect).containsPoint(localPoint))
         {
            return this;
         }
         return null;
      }
      
      public function hitTestMask(localPoint:Point) : Boolean
      {
         if(mMask)
         {
            if(mMask.stage)
            {
               getTransformationMatrix(mMask,sHelperMatrixAlt);
            }
            else
            {
               sHelperMatrixAlt.copyFrom(mMask.transformationMatrix);
               sHelperMatrixAlt.invert();
            }
            MatrixUtil.transformPoint(sHelperMatrixAlt,localPoint,sHelperPoint);
            return mMask.hitTest(sHelperPoint,true) != null;
         }
         return true;
      }
      
      public function localToGlobal(localPoint:Point, resultPoint:Point = null) : Point
      {
         if(is3D)
         {
            sHelperPoint3D.setTo(localPoint.x,localPoint.y,0);
            return local3DToGlobal(sHelperPoint3D,resultPoint);
         }
         getTransformationMatrix(base,sHelperMatrixAlt);
         return MatrixUtil.transformPoint(sHelperMatrixAlt,localPoint,resultPoint);
      }
      
      public function globalToLocal(globalPoint:Point, resultPoint:Point = null) : Point
      {
         if(is3D)
         {
            globalToLocal3D(globalPoint,sHelperPoint3D);
            return MathUtil.intersectLineWithXYPlane(stage.cameraPosition,sHelperPoint3D,resultPoint);
         }
         getTransformationMatrix(base,sHelperMatrixAlt);
         sHelperMatrixAlt.invert();
         return MatrixUtil.transformPoint(sHelperMatrixAlt,globalPoint,resultPoint);
      }
      
      public function render(support:RenderSupport, parentAlpha:Number) : void
      {
         throw new AbstractMethodError();
      }
      
      public function get hasVisibleArea() : Boolean
      {
         return mAlpha != 0 && mVisible && !mIsMask && mScaleX != 0 && mScaleY != 0;
      }
      
      public function alignPivot(hAlign:String = "center", vAlign:String = "center") : void
      {
         var bounds:Rectangle = getBounds(this);
         mOrientationChanged = true;
         if(hAlign == "left")
         {
            mPivotX = bounds.x;
         }
         else if(hAlign == "center")
         {
            mPivotX = bounds.x + bounds.width / 2;
         }
         else if(hAlign == "right")
         {
            mPivotX = bounds.x + bounds.width;
         }
         else
         {
            throw new ArgumentError("Invalid horizontal alignment: " + hAlign);
         }
         if(vAlign == "top")
         {
            mPivotY = bounds.y;
         }
         else if(vAlign == "center")
         {
            mPivotY = bounds.y + bounds.height / 2;
         }
         else if(vAlign == "bottom")
         {
            mPivotY = bounds.y + bounds.height;
         }
         else
         {
            throw new ArgumentError("Invalid vertical alignment: " + vAlign);
         }
      }
      
      public function getTransformationMatrix3D(targetSpace:DisplayObject, resultMatrix:Matrix3D = null) : Matrix3D
      {
         var commonParent:* = null;
         var currentObject:* = null;
         if(resultMatrix)
         {
            resultMatrix.identity();
         }
         else
         {
            resultMatrix = new Matrix3D();
         }
         if(targetSpace == this)
         {
            return resultMatrix;
         }
         if(targetSpace == mParent || targetSpace == null && mParent == null)
         {
            resultMatrix.copyFrom(transformationMatrix3D);
            return resultMatrix;
         }
         if(targetSpace == null || targetSpace == base)
         {
            currentObject = this;
            while(currentObject != targetSpace)
            {
               resultMatrix.append(currentObject.transformationMatrix3D);
               currentObject = currentObject.mParent;
            }
            return resultMatrix;
         }
         if(targetSpace.mParent == this)
         {
            targetSpace.getTransformationMatrix3D(this,resultMatrix);
            resultMatrix.invert();
            return resultMatrix;
         }
         commonParent = findCommonParent(this,targetSpace);
         currentObject = this;
         while(currentObject != commonParent)
         {
            resultMatrix.append(currentObject.transformationMatrix3D);
            currentObject = currentObject.mParent;
         }
         if(commonParent == targetSpace)
         {
            return resultMatrix;
         }
         sHelperMatrix3D.identity();
         currentObject = targetSpace;
         while(currentObject != commonParent)
         {
            sHelperMatrix3D.append(currentObject.transformationMatrix3D);
            currentObject = currentObject.mParent;
         }
         sHelperMatrix3D.invert();
         resultMatrix.append(sHelperMatrix3D);
         return resultMatrix;
      }
      
      public function local3DToGlobal(localPoint:Vector3D, resultPoint:Point = null) : Point
      {
         var stage:Stage = this.stage;
         if(stage == null)
         {
            throw new IllegalOperationError("Object not connected to stage");
         }
         getTransformationMatrix3D(stage,sHelperMatrixAlt3D);
         MatrixUtil.transformPoint3D(sHelperMatrixAlt3D,localPoint,sHelperPoint3D);
         return MathUtil.intersectLineWithXYPlane(stage.cameraPosition,sHelperPoint3D,resultPoint);
      }
      
      public function globalToLocal3D(globalPoint:Point, resultPoint:Vector3D = null) : Vector3D
      {
         var stage:Stage = this.stage;
         if(stage == null)
         {
            throw new IllegalOperationError("Object not connected to stage");
         }
         getTransformationMatrix3D(stage,sHelperMatrixAlt3D);
         sHelperMatrixAlt3D.invert();
         return MatrixUtil.transformCoords3D(sHelperMatrixAlt3D,globalPoint.x,globalPoint.y,0,resultPoint);
      }
      
      function setParent(value:DisplayObjectContainer) : void
      {
         var ancestor:DisplayObject = value;
         while(ancestor != this && ancestor != null)
         {
            ancestor = ancestor.mParent;
         }
         if(ancestor == this)
         {
            throw new ArgumentError("An object cannot be added as a child to itself or one of its children (or children\'s children, etc.)");
         }
         mParent = value;
      }
      
      function setIs3D(value:Boolean) : void
      {
         mIs3D = value;
      }
      
      function get isMask() : Boolean
      {
         return mIsMask;
      }
      
      private final function isEquivalent(a:Number, b:Number, epsilon:Number = 1.0E-4) : Boolean
      {
         return a - epsilon < b && a + epsilon > b;
      }
      
      private final function findCommonParent(object1:DisplayObject, object2:DisplayObject) : DisplayObject
      {
         var currentObject:* = object1;
         while(currentObject)
         {
            sAncestors[sAncestors.length] = currentObject;
            currentObject = currentObject.mParent;
         }
         currentObject = object2;
         while(currentObject && sAncestors.indexOf(currentObject) == -1)
         {
            currentObject = currentObject.mParent;
         }
         sAncestors.length = 0;
         if(currentObject)
         {
            return currentObject;
         }
         throw new ArgumentError("Object not connected to target");
      }
      
      public function set angle(value:Number) : void
      {
         rotation = value * 3.14159265358979 / 180;
      }
      
      public function get angle() : Number
      {
         return rotation * 180 / 3.14159265358979;
      }
      
      override public function dispatchEvent(event:Event) : void
      {
         if(event.type == "removedFromStage" && stage == null)
         {
            return;
         }
         super.dispatchEvent(event);
      }
      
      override public function addEventListener(type:String, listener:Function) : void
      {
         if(type == "enterFrame" && !hasEventListener(type))
         {
            addEventListener("addedToStage",addEnterFrameListenerToStage);
            addEventListener("removedFromStage",removeEnterFrameListenerFromStage);
            if(this.stage)
            {
               addEnterFrameListenerToStage();
            }
         }
         super.addEventListener(type,listener);
      }
      
      override public function removeEventListener(type:String, listener:Function) : void
      {
         super.removeEventListener(type,listener);
         if(type == "enterFrame" && !hasEventListener(type))
         {
            removeEventListener("addedToStage",addEnterFrameListenerToStage);
            removeEventListener("removedFromStage",removeEnterFrameListenerFromStage);
            removeEnterFrameListenerFromStage();
         }
      }
      
      override public function removeEventListeners(type:String = null) : void
      {
         if((type == null || type == "enterFrame") && hasEventListener("enterFrame"))
         {
            removeEventListener("addedToStage",addEnterFrameListenerToStage);
            removeEventListener("removedFromStage",removeEnterFrameListenerFromStage);
            removeEnterFrameListenerFromStage();
         }
         super.removeEventListeners(type);
      }
      
      private function addEnterFrameListenerToStage() : void
      {
         Starling.current.stage.addEnterFrameListener(this);
      }
      
      private function removeEnterFrameListenerFromStage() : void
      {
         Starling.current.stage.removeEnterFrameListener(this);
      }
      
      public function get transformationMatrix() : Matrix
      {
         var cos:Number = NaN;
         var sin:Number = NaN;
         var a:Number = NaN;
         var b:Number = NaN;
         var c:Number = NaN;
         var d:Number = NaN;
         var tx:Number = NaN;
         var ty:Number = NaN;
         if(mOrientationChanged)
         {
            mOrientationChanged = false;
            if(mSkewX == 0 && mSkewY == 0)
            {
               if(mRotation == 0)
               {
                  mTransformationMatrix.setTo(mScaleX,0,0,mScaleY,mX - mPivotX * mScaleX,mY - mPivotY * mScaleY);
               }
               else
               {
                  cos = Math.cos(mRotation);
                  sin = Math.sin(mRotation);
                  a = mScaleX * cos;
                  b = mScaleX * sin;
                  c = mScaleY * -sin;
                  d = mScaleY * cos;
                  tx = mX - mPivotX * a - mPivotY * c;
                  ty = mY - mPivotX * b - mPivotY * d;
                  mTransformationMatrix.setTo(a,b,c,d,tx,ty);
               }
            }
            else
            {
               mTransformationMatrix.identity();
               mTransformationMatrix.scale(mScaleX,mScaleY);
               MatrixUtil.skew(mTransformationMatrix,mSkewX,mSkewY);
               mTransformationMatrix.rotate(mRotation);
               mTransformationMatrix.translate(mX,mY);
               if(mPivotX != 0 || mPivotY != 0)
               {
                  mTransformationMatrix.tx = mX - mTransformationMatrix.a * mPivotX - mTransformationMatrix.c * mPivotY;
                  mTransformationMatrix.ty = mY - mTransformationMatrix.b * mPivotX - mTransformationMatrix.d * mPivotY;
               }
            }
         }
         return mTransformationMatrix;
      }
      
      public function set transformationMatrix(matrix:Matrix) : void
      {
         var _loc2_:* = NaN;
         _loc2_ = 0.785398163397448;
         mOrientationChanged = false;
         mTransformationMatrix.copyFrom(matrix);
         mPivotY = 0;
         mPivotX = 0;
         mX = matrix.tx;
         mY = matrix.ty;
         mSkewX = Math.atan(-matrix.c / matrix.d);
         mSkewY = Math.atan(matrix.b / matrix.a);
         if(mSkewX != mSkewX)
         {
            mSkewX = 0;
         }
         if(mSkewY != mSkewY)
         {
            mSkewY = 0;
         }
         mScaleY = mSkewX > -0.785398163397448 && mSkewX < 0.785398163397448?matrix.d / Math.cos(mSkewX):Number(-matrix.c / Math.sin(mSkewX));
         mScaleX = mSkewY > -0.785398163397448 && mSkewY < 0.785398163397448?matrix.a / Math.cos(mSkewY):Number(matrix.b / Math.sin(mSkewY));
         if(isEquivalent(mSkewX,mSkewY))
         {
            mRotation = mSkewX;
            mSkewY = 0;
            mSkewX = 0;
         }
         else
         {
            mRotation = 0;
         }
      }
      
      public function get transformationMatrix3D() : Matrix3D
      {
         if(mTransformationMatrix3D == null)
         {
            mTransformationMatrix3D = new Matrix3D();
         }
         return MatrixUtil.convertTo3D(transformationMatrix,mTransformationMatrix3D);
      }
      
      public function get is3D() : Boolean
      {
         return mIs3D;
      }
      
      public function get useHandCursor() : Boolean
      {
         return mUseHandCursor;
      }
      
      public function set useHandCursor(value:Boolean) : void
      {
         if(value == mUseHandCursor)
         {
            return;
         }
         mUseHandCursor = value;
         if(mUseHandCursor)
         {
            addEventListener("touch",onTouch);
         }
         else
         {
            removeEventListener("touch",onTouch);
         }
      }
      
      private function onTouch(event:TouchEvent) : void
      {
         Mouse.cursor = !!event.interactsWith(this)?"button":"auto";
      }
      
      public function get bounds() : Rectangle
      {
         return getBounds(mParent);
      }
      
      public function get width() : Number
      {
         return getBounds(mParent,sHelperRect).width;
      }
      
      public function set width(value:Number) : void
      {
         scaleX = 1;
         var actualWidth:Number = width;
         if(actualWidth != 0)
         {
            scaleX = value / actualWidth;
         }
      }
      
      public function get height() : Number
      {
         return getBounds(mParent,sHelperRect).height;
      }
      
      public function set height(value:Number) : void
      {
         scaleY = 1;
         var actualHeight:Number = height;
         if(actualHeight != 0)
         {
            scaleY = value / actualHeight;
         }
      }
      
      public function get x() : Number
      {
         return mX;
      }
      
      public function set x(value:Number) : void
      {
         if(mX != value)
         {
            mX = value;
            mOrientationChanged = true;
         }
      }
      
      public function get y() : Number
      {
         return mY;
      }
      
      public function set y(value:Number) : void
      {
         if(mY != value)
         {
            mY = value;
            mOrientationChanged = true;
         }
      }
      
      public function get pivotX() : Number
      {
         return mPivotX;
      }
      
      public function set pivotX(value:Number) : void
      {
         if(mPivotX != value)
         {
            mPivotX = value;
            mOrientationChanged = true;
         }
      }
      
      public function get pivotY() : Number
      {
         return mPivotY;
      }
      
      public function set pivotY(value:Number) : void
      {
         if(mPivotY != value)
         {
            mPivotY = value;
            mOrientationChanged = true;
         }
      }
      
      public function get scaleX() : Number
      {
         return mScaleX;
      }
      
      public function set scaleX(value:Number) : void
      {
         if(mScaleX != value)
         {
            mScaleX = value;
            mOrientationChanged = true;
         }
      }
      
      public function get scaleY() : Number
      {
         return mScaleY;
      }
      
      public function set scaleY(value:Number) : void
      {
         if(mScaleY != value)
         {
            mScaleY = value;
            mOrientationChanged = true;
         }
      }
      
      public function get skewX() : Number
      {
         return mSkewX;
      }
      
      public function set skewX(value:Number) : void
      {
         value = MathUtil.normalizeAngle(value);
         if(mSkewX != value)
         {
            mSkewX = value;
            mOrientationChanged = true;
         }
      }
      
      public function get skewY() : Number
      {
         return mSkewY;
      }
      
      public function set skewY(value:Number) : void
      {
         value = MathUtil.normalizeAngle(value);
         if(mSkewY != value)
         {
            mSkewY = value;
            mOrientationChanged = true;
         }
      }
      
      public function get rotation() : Number
      {
         return mRotation;
      }
      
      public function set rotation(value:Number) : void
      {
         value = MathUtil.normalizeAngle(value);
         if(mRotation != value)
         {
            mRotation = value;
            mOrientationChanged = true;
         }
      }
      
      public function get alpha() : Number
      {
         return mAlpha;
      }
      
      public function set alpha(value:Number) : void
      {
         mAlpha = value < 0?0:Number(value > 1?1:Number(value));
      }
      
      public function get visible() : Boolean
      {
         return mVisible;
      }
      
      public function set visible(value:Boolean) : void
      {
         mVisible = value;
      }
      
      public function get touchable() : Boolean
      {
         return mTouchable;
      }
      
      public function set touchable(value:Boolean) : void
      {
         mTouchable = value;
      }
      
      public function get blendMode() : String
      {
         return mBlendMode;
      }
      
      public function set blendMode(value:String) : void
      {
         mBlendMode = value;
      }
      
      public function get name() : String
      {
         return mName;
      }
      
      public function set name(value:String) : void
      {
         mName = value;
      }
      
      public function get filter() : FragmentFilter
      {
         return mFilter;
      }
      
      public function set filter(value:FragmentFilter) : void
      {
         mFilter = value;
      }
      
      public function get mask() : DisplayObject
      {
         return mMask;
      }
      
      public function set mask(value:DisplayObject) : void
      {
         if(mMask != value)
         {
            if(mMask)
            {
               mMask.mIsMask = false;
            }
            if(value)
            {
               value.mIsMask = true;
            }
            mMask = value;
         }
      }
      
      public function get parent() : DisplayObjectContainer
      {
         return mParent;
      }
      
      public function get base() : DisplayObject
      {
         var currentObject:* = this;
         while(currentObject.mParent)
         {
            currentObject = currentObject.mParent;
         }
         return currentObject;
      }
      
      public function get root() : DisplayObject
      {
         var currentObject:* = this;
         while(currentObject.mParent)
         {
            if(currentObject.mParent is Stage)
            {
               return currentObject;
            }
            currentObject = currentObject.parent;
         }
         return null;
      }
      
      public function get stage() : Stage
      {
         return this.base as Stage;
      }
      
      public function get laySortY() : Number
      {
         if(isNaN(_laySortY))
         {
            return this.y;
         }
         return _laySortY;
      }
      
      public function set laySortY(value:Number) : void
      {
         _laySortY = value;
      }
   }
}
