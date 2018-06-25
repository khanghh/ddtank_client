package starling.display{   import flash.errors.IllegalOperationError;   import flash.geom.Matrix;   import flash.geom.Matrix3D;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.geom.Vector3D;   import flash.system.Capabilities;   import flash.ui.Mouse;   import flash.utils.getQualifiedClassName;   import starling.core.RenderSupport;   import starling.core.Starling;   import starling.errors.AbstractClassError;   import starling.errors.AbstractMethodError;   import starling.events.Event;   import starling.events.EventDispatcher;   import starling.events.TouchEvent;   import starling.filters.FragmentFilter;   import starling.utils.MathUtil;   import starling.utils.MatrixUtil;      [Event(name="added",type="starling.events.Event")]   [Event(name="addedToStage",type="starling.events.Event")]   [Event(name="removed",type="starling.events.Event")]   [Event(name="removedFromStage",type="starling.events.Event")]   [Event(name="enterFrame",type="starling.events.EnterFrameEvent")]   [Event(name="touch",type="starling.events.TouchEvent")]   [Event(name="keyUp",type="starling.events.KeyboardEvent")]   [Event(name="keyDown",type="starling.events.KeyboardEvent")]   public class DisplayObject extends EventDispatcher   {            private static var sAncestors:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);            private static var sHelperPoint:Point = new Point();            private static var sHelperPoint3D:Vector3D = new Vector3D();            private static var sHelperRect:Rectangle = new Rectangle();            private static var sHelperMatrix:Matrix = new Matrix();            private static var sHelperMatrixAlt:Matrix = new Matrix();            private static var sHelperMatrix3D:Matrix3D = new Matrix3D();            private static var sHelperMatrixAlt3D:Matrix3D = new Matrix3D();                   private var mX:Number;            private var mY:Number;            private var mPivotX:Number;            private var mPivotY:Number;            private var mScaleX:Number;            private var mScaleY:Number;            private var mSkewX:Number;            private var mSkewY:Number;            private var mRotation:Number;            private var mAlpha:Number;            private var mVisible:Boolean;            private var mTouchable:Boolean;            private var mBlendMode:String;            private var mName:String;            private var mUseHandCursor:Boolean;            private var mParent:DisplayObjectContainer;            private var mTransformationMatrix:Matrix;            private var mTransformationMatrix3D:Matrix3D;            private var mOrientationChanged:Boolean;            private var mFilter:FragmentFilter;            private var mIs3D:Boolean;            private var mMask:DisplayObject;            private var mIsMask:Boolean;            protected var _laySortY:Number;            public function DisplayObject() { super(); }
            public function dispose() : void { }
            public function removeFromParent(dispose:Boolean = false) : void { }
            public function getTransformationMatrix(targetSpace:DisplayObject, resultMatrix:Matrix = null) : Matrix { return null; }
            public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle { return null; }
            public function hitTest(localPoint:Point, forTouch:Boolean = false) : DisplayObject { return null; }
            public function hitTestMask(localPoint:Point) : Boolean { return false; }
            public function localToGlobal(localPoint:Point, resultPoint:Point = null) : Point { return null; }
            public function globalToLocal(globalPoint:Point, resultPoint:Point = null) : Point { return null; }
            public function render(support:RenderSupport, parentAlpha:Number) : void { }
            public function get hasVisibleArea() : Boolean { return false; }
            public function alignPivot(hAlign:String = "center", vAlign:String = "center") : void { }
            public function getTransformationMatrix3D(targetSpace:DisplayObject, resultMatrix:Matrix3D = null) : Matrix3D { return null; }
            public function local3DToGlobal(localPoint:Vector3D, resultPoint:Point = null) : Point { return null; }
            public function globalToLocal3D(globalPoint:Point, resultPoint:Vector3D = null) : Vector3D { return null; }
            function setParent(value:DisplayObjectContainer) : void { }
            protected function setIs3D(value:Boolean) : void { }
            protected function get isMask() : Boolean { return false; }
            private final function isEquivalent(a:Number, b:Number, epsilon:Number = 1.0E-4) : Boolean { return false; }
            private final function findCommonParent(object1:DisplayObject, object2:DisplayObject) : DisplayObject { return null; }
            public function set angle(value:Number) : void { }
            public function get angle() : Number { return 0; }
            override public function dispatchEvent(event:Event) : void { }
            override public function addEventListener(type:String, listener:Function) : void { }
            override public function removeEventListener(type:String, listener:Function) : void { }
            override public function removeEventListeners(type:String = null) : void { }
            private function addEnterFrameListenerToStage() : void { }
            private function removeEnterFrameListenerFromStage() : void { }
            public function get transformationMatrix() : Matrix { return null; }
            public function set transformationMatrix(matrix:Matrix) : void { }
            public function get transformationMatrix3D() : Matrix3D { return null; }
            public function get is3D() : Boolean { return false; }
            public function get useHandCursor() : Boolean { return false; }
            public function set useHandCursor(value:Boolean) : void { }
            private function onTouch(event:TouchEvent) : void { }
            public function get bounds() : Rectangle { return null; }
            public function get width() : Number { return 0; }
            public function set width(value:Number) : void { }
            public function get height() : Number { return 0; }
            public function set height(value:Number) : void { }
            public function get x() : Number { return 0; }
            public function set x(value:Number) : void { }
            public function get y() : Number { return 0; }
            public function set y(value:Number) : void { }
            public function get pivotX() : Number { return 0; }
            public function set pivotX(value:Number) : void { }
            public function get pivotY() : Number { return 0; }
            public function set pivotY(value:Number) : void { }
            public function get scaleX() : Number { return 0; }
            public function set scaleX(value:Number) : void { }
            public function get scaleY() : Number { return 0; }
            public function set scaleY(value:Number) : void { }
            public function get skewX() : Number { return 0; }
            public function set skewX(value:Number) : void { }
            public function get skewY() : Number { return 0; }
            public function set skewY(value:Number) : void { }
            public function get rotation() : Number { return 0; }
            public function set rotation(value:Number) : void { }
            public function get alpha() : Number { return 0; }
            public function set alpha(value:Number) : void { }
            public function get visible() : Boolean { return false; }
            public function set visible(value:Boolean) : void { }
            public function get touchable() : Boolean { return false; }
            public function set touchable(value:Boolean) : void { }
            public function get blendMode() : String { return null; }
            public function set blendMode(value:String) : void { }
            public function get name() : String { return null; }
            public function set name(value:String) : void { }
            public function get filter() : FragmentFilter { return null; }
            public function set filter(value:FragmentFilter) : void { }
            public function get mask() : DisplayObject { return null; }
            public function set mask(value:DisplayObject) : void { }
            public function get parent() : DisplayObjectContainer { return null; }
            public function get base() : DisplayObject { return null; }
            public function get root() : DisplayObject { return null; }
            public function get stage() : Stage { return null; }
            public function get laySortY() : Number { return 0; }
            public function set laySortY(value:Number) : void { }
   }}