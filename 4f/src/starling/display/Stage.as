package starling.display
{
   import flash.display.BitmapData;
   import flash.errors.IllegalOperationError;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Vector3D;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.events.EnterFrameEvent;
   import starling.filters.FragmentFilter;
   import starling.utils.MatrixUtil;
   
   [Event(name="resize",type="starling.events.ResizeEvent")]
   public class Stage extends DisplayObjectContainer
   {
      
      private static var sHelperMatrix:Matrix3D = new Matrix3D();
       
      
      private var mWidth:int;
      
      private var mHeight:int;
      
      private var mColor:uint;
      
      private var mFieldOfView:Number;
      
      private var mProjectionOffset:Point;
      
      private var mCameraPosition:Vector3D;
      
      private var mEnterFrameEvent:EnterFrameEvent;
      
      private var mEnterFrameListeners:Vector.<DisplayObject>;
      
      public function Stage(param1:int, param2:int, param3:uint = 0){super();}
      
      public function advanceTime(param1:Number) : void{}
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject{return null;}
      
      public function drawToBitmapData(param1:BitmapData = null, param2:Boolean = true) : BitmapData{return null;}
      
      public function getCameraPosition(param1:DisplayObject = null, param2:Vector3D = null) : Vector3D{return null;}
      
      function addEnterFrameListener(param1:DisplayObject) : void{}
      
      function removeEnterFrameListener(param1:DisplayObject) : void{}
      
      override function getChildEventListeners(param1:DisplayObject, param2:String, param3:Vector.<DisplayObject>) : void{}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      override public function set x(param1:Number) : void{}
      
      override public function set y(param1:Number) : void{}
      
      override public function set scaleX(param1:Number) : void{}
      
      override public function set scaleY(param1:Number) : void{}
      
      override public function set rotation(param1:Number) : void{}
      
      override public function set skewX(param1:Number) : void{}
      
      override public function set skewY(param1:Number) : void{}
      
      override public function set filter(param1:FragmentFilter) : void{}
      
      public function get color() : uint{return null;}
      
      public function set color(param1:uint) : void{}
      
      public function get stageWidth() : int{return 0;}
      
      public function set stageWidth(param1:int) : void{}
      
      public function get stageHeight() : int{return 0;}
      
      public function set stageHeight(param1:int) : void{}
      
      public function get focalLength() : Number{return 0;}
      
      public function set focalLength(param1:Number) : void{}
      
      public function get fieldOfView() : Number{return 0;}
      
      public function set fieldOfView(param1:Number) : void{}
      
      public function get projectionOffset() : Point{return null;}
      
      public function set projectionOffset(param1:Point) : void{}
      
      public function get cameraPosition() : Vector3D{return null;}
   }
}
