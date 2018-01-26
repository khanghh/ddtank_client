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
      
      public function DisplayObject(){super();}
      
      public function dispose() : void{}
      
      public function removeFromParent(param1:Boolean = false) : void{}
      
      public function getTransformationMatrix(param1:DisplayObject, param2:Matrix = null) : Matrix{return null;}
      
      public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle{return null;}
      
      public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject{return null;}
      
      public function hitTestMask(param1:Point) : Boolean{return false;}
      
      public function localToGlobal(param1:Point, param2:Point = null) : Point{return null;}
      
      public function globalToLocal(param1:Point, param2:Point = null) : Point{return null;}
      
      public function render(param1:RenderSupport, param2:Number) : void{}
      
      public function get hasVisibleArea() : Boolean{return false;}
      
      public function alignPivot(param1:String = "center", param2:String = "center") : void{}
      
      public function getTransformationMatrix3D(param1:DisplayObject, param2:Matrix3D = null) : Matrix3D{return null;}
      
      public function local3DToGlobal(param1:Vector3D, param2:Point = null) : Point{return null;}
      
      public function globalToLocal3D(param1:Point, param2:Vector3D = null) : Vector3D{return null;}
      
      function setParent(param1:DisplayObjectContainer) : void{}
      
      function setIs3D(param1:Boolean) : void{}
      
      function get isMask() : Boolean{return false;}
      
      private final function isEquivalent(param1:Number, param2:Number, param3:Number = 1.0E-4) : Boolean{return false;}
      
      private final function findCommonParent(param1:DisplayObject, param2:DisplayObject) : DisplayObject{return null;}
      
      public function set angle(param1:Number) : void{}
      
      public function get angle() : Number{return 0;}
      
      override public function dispatchEvent(param1:Event) : void{}
      
      override public function addEventListener(param1:String, param2:Function) : void{}
      
      override public function removeEventListener(param1:String, param2:Function) : void{}
      
      override public function removeEventListeners(param1:String = null) : void{}
      
      private function addEnterFrameListenerToStage() : void{}
      
      private function removeEnterFrameListenerFromStage() : void{}
      
      public function get transformationMatrix() : Matrix{return null;}
      
      public function set transformationMatrix(param1:Matrix) : void{}
      
      public function get transformationMatrix3D() : Matrix3D{return null;}
      
      public function get is3D() : Boolean{return false;}
      
      public function get useHandCursor() : Boolean{return false;}
      
      public function set useHandCursor(param1:Boolean) : void{}
      
      private function onTouch(param1:TouchEvent) : void{}
      
      public function get bounds() : Rectangle{return null;}
      
      public function get width() : Number{return 0;}
      
      public function set width(param1:Number) : void{}
      
      public function get height() : Number{return 0;}
      
      public function set height(param1:Number) : void{}
      
      public function get x() : Number{return 0;}
      
      public function set x(param1:Number) : void{}
      
      public function get y() : Number{return 0;}
      
      public function set y(param1:Number) : void{}
      
      public function get pivotX() : Number{return 0;}
      
      public function set pivotX(param1:Number) : void{}
      
      public function get pivotY() : Number{return 0;}
      
      public function set pivotY(param1:Number) : void{}
      
      public function get scaleX() : Number{return 0;}
      
      public function set scaleX(param1:Number) : void{}
      
      public function get scaleY() : Number{return 0;}
      
      public function set scaleY(param1:Number) : void{}
      
      public function get skewX() : Number{return 0;}
      
      public function set skewX(param1:Number) : void{}
      
      public function get skewY() : Number{return 0;}
      
      public function set skewY(param1:Number) : void{}
      
      public function get rotation() : Number{return 0;}
      
      public function set rotation(param1:Number) : void{}
      
      public function get alpha() : Number{return 0;}
      
      public function set alpha(param1:Number) : void{}
      
      public function get visible() : Boolean{return false;}
      
      public function set visible(param1:Boolean) : void{}
      
      public function get touchable() : Boolean{return false;}
      
      public function set touchable(param1:Boolean) : void{}
      
      public function get blendMode() : String{return null;}
      
      public function set blendMode(param1:String) : void{}
      
      public function get name() : String{return null;}
      
      public function set name(param1:String) : void{}
      
      public function get filter() : FragmentFilter{return null;}
      
      public function set filter(param1:FragmentFilter) : void{}
      
      public function get mask() : DisplayObject{return null;}
      
      public function set mask(param1:DisplayObject) : void{}
      
      public function get parent() : DisplayObjectContainer{return null;}
      
      public function get base() : DisplayObject{return null;}
      
      public function get root() : DisplayObject{return null;}
      
      public function get stage() : Stage{return null;}
      
      public function get laySortY() : Number{return 0;}
      
      public function set laySortY(param1:Number) : void{}
   }
}
