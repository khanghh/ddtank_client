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
      
      public function Stage(width:int, height:int, color:uint = 0)
      {
         super();
         mWidth = width;
         mHeight = height;
         mColor = color;
         mFieldOfView = 1;
         mProjectionOffset = new Point();
         mCameraPosition = new Vector3D();
         mEnterFrameEvent = new EnterFrameEvent("enterFrame",0);
         mEnterFrameListeners = new Vector.<DisplayObject>(0);
      }
      
      public function advanceTime(passedTime:Number) : void
      {
         mEnterFrameEvent.reset("enterFrame",false,passedTime);
         broadcastEvent(mEnterFrameEvent);
      }
      
      override public function hitTest(localPoint:Point, forTouch:Boolean = false) : DisplayObject
      {
         if(forTouch && (!visible || !touchable))
         {
            return null;
         }
         if(localPoint.x < 0 || localPoint.x > mWidth || localPoint.y < 0 || localPoint.y > mHeight)
         {
            return null;
         }
         var target:DisplayObject = super.hitTest(localPoint,forTouch);
         if(target == null)
         {
            target = this;
         }
         return target;
      }
      
      public function drawToBitmapData(destination:BitmapData = null, transparent:Boolean = true) : BitmapData
      {
         var width:int = 0;
         var height:int = 0;
         var support:RenderSupport = new RenderSupport();
         var star:Starling = Starling.current;
         if(destination == null)
         {
            width = star.backBufferWidth * star.backBufferPixelsPerPoint;
            height = star.backBufferHeight * star.backBufferPixelsPerPoint;
            destination = new BitmapData(width,height,transparent);
         }
         support.renderTarget = null;
         support.setProjectionMatrix(0,0,mWidth,mHeight,mWidth,mHeight,cameraPosition);
         if(transparent)
         {
            support.clear();
         }
         else
         {
            support.clear(mColor,1);
         }
         render(support,1);
         support.finishQuadBatch();
         support.dispose();
         Starling.current.context.drawToBitmapData(destination);
         Starling.current.context.present();
         return destination;
      }
      
      public function getCameraPosition(space:DisplayObject = null, result:Vector3D = null) : Vector3D
      {
         getTransformationMatrix3D(space,sHelperMatrix);
         return MatrixUtil.transformCoords3D(sHelperMatrix,mWidth / 2 + mProjectionOffset.x,mHeight / 2 + mProjectionOffset.y,-focalLength,result);
      }
      
      function addEnterFrameListener(listener:DisplayObject) : void
      {
         mEnterFrameListeners.push(listener);
      }
      
      function removeEnterFrameListener(listener:DisplayObject) : void
      {
         var index:int = mEnterFrameListeners.indexOf(listener);
         if(index >= 0)
         {
            mEnterFrameListeners.splice(index,1);
         }
      }
      
      override function getChildEventListeners(object:DisplayObject, eventType:String, listeners:Vector.<DisplayObject>) : void
      {
         var i:int = 0;
         var length:int = 0;
         if(eventType == "enterFrame" && object == this)
         {
            for(i = 0,length = mEnterFrameListeners.length; i < length; )
            {
               listeners[listeners.length] = mEnterFrameListeners[i];
               i++;
            }
         }
         else
         {
            super.getChildEventListeners(object,eventType,listeners);
         }
      }
      
      override public function set width(value:Number) : void
      {
         throw new IllegalOperationError("Cannot set width of stage");
      }
      
      override public function set height(value:Number) : void
      {
         throw new IllegalOperationError("Cannot set height of stage");
      }
      
      override public function set x(value:Number) : void
      {
         throw new IllegalOperationError("Cannot set x-coordinate of stage");
      }
      
      override public function set y(value:Number) : void
      {
         throw new IllegalOperationError("Cannot set y-coordinate of stage");
      }
      
      override public function set scaleX(value:Number) : void
      {
         throw new IllegalOperationError("Cannot scale stage");
      }
      
      override public function set scaleY(value:Number) : void
      {
         throw new IllegalOperationError("Cannot scale stage");
      }
      
      override public function set rotation(value:Number) : void
      {
         throw new IllegalOperationError("Cannot rotate stage");
      }
      
      override public function set skewX(value:Number) : void
      {
         throw new IllegalOperationError("Cannot skew stage");
      }
      
      override public function set skewY(value:Number) : void
      {
         throw new IllegalOperationError("Cannot skew stage");
      }
      
      override public function set filter(value:FragmentFilter) : void
      {
         throw new IllegalOperationError("Cannot add filter to stage. Add it to \'root\' instead!");
      }
      
      public function get color() : uint
      {
         return mColor;
      }
      
      public function set color(value:uint) : void
      {
         mColor = value;
      }
      
      public function get stageWidth() : int
      {
         return mWidth;
      }
      
      public function set stageWidth(value:int) : void
      {
         mWidth = value;
      }
      
      public function get stageHeight() : int
      {
         return mHeight;
      }
      
      public function set stageHeight(value:int) : void
      {
         mHeight = value;
      }
      
      public function get focalLength() : Number
      {
         return mWidth / (2 * Math.tan(mFieldOfView / 2));
      }
      
      public function set focalLength(value:Number) : void
      {
         mFieldOfView = 2 * Math.atan(stageWidth / (2 * value));
      }
      
      public function get fieldOfView() : Number
      {
         return mFieldOfView;
      }
      
      public function set fieldOfView(value:Number) : void
      {
         mFieldOfView = value;
      }
      
      public function get projectionOffset() : Point
      {
         return mProjectionOffset;
      }
      
      public function set projectionOffset(value:Point) : void
      {
         mProjectionOffset.setTo(value.x,value.y);
      }
      
      public function get cameraPosition() : Vector3D
      {
         return getCameraPosition(null,mCameraPosition);
      }
   }
}
