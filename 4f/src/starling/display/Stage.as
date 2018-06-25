package starling.display{   import flash.display.BitmapData;   import flash.errors.IllegalOperationError;   import flash.geom.Matrix3D;   import flash.geom.Point;   import flash.geom.Vector3D;   import starling.core.RenderSupport;   import starling.core.Starling;   import starling.events.EnterFrameEvent;   import starling.filters.FragmentFilter;   import starling.utils.MatrixUtil;      [Event(name="resize",type="starling.events.ResizeEvent")]   public class Stage extends DisplayObjectContainer   {            private static var sHelperMatrix:Matrix3D = new Matrix3D();                   private var mWidth:int;            private var mHeight:int;            private var mColor:uint;            private var mFieldOfView:Number;            private var mProjectionOffset:Point;            private var mCameraPosition:Vector3D;            private var mEnterFrameEvent:EnterFrameEvent;            private var mEnterFrameListeners:Vector.<DisplayObject>;            public function Stage(width:int, height:int, color:uint = 0) { super(); }
            public function advanceTime(passedTime:Number) : void { }
            override public function hitTest(localPoint:Point, forTouch:Boolean = false) : DisplayObject { return null; }
            public function drawToBitmapData(destination:BitmapData = null, transparent:Boolean = true) : BitmapData { return null; }
            public function getCameraPosition(space:DisplayObject = null, result:Vector3D = null) : Vector3D { return null; }
            protected function addEnterFrameListener(listener:DisplayObject) : void { }
            protected function removeEnterFrameListener(listener:DisplayObject) : void { }
            override protected function getChildEventListeners(object:DisplayObject, eventType:String, listeners:Vector.<DisplayObject>) : void { }
            override public function set width(value:Number) : void { }
            override public function set height(value:Number) : void { }
            override public function set x(value:Number) : void { }
            override public function set y(value:Number) : void { }
            override public function set scaleX(value:Number) : void { }
            override public function set scaleY(value:Number) : void { }
            override public function set rotation(value:Number) : void { }
            override public function set skewX(value:Number) : void { }
            override public function set skewY(value:Number) : void { }
            override public function set filter(value:FragmentFilter) : void { }
            public function get color() : uint { return null; }
            public function set color(value:uint) : void { }
            public function get stageWidth() : int { return 0; }
            public function set stageWidth(value:int) : void { }
            public function get stageHeight() : int { return 0; }
            public function set stageHeight(value:int) : void { }
            public function get focalLength() : Number { return 0; }
            public function set focalLength(value:Number) : void { }
            public function get fieldOfView() : Number { return 0; }
            public function set fieldOfView(value:Number) : void { }
            public function get projectionOffset() : Point { return null; }
            public function set projectionOffset(value:Point) : void { }
            public function get cameraPosition() : Vector3D { return null; }
   }}