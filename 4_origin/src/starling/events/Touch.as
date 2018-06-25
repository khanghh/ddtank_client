package starling.events
{
   import flash.geom.Point;
   import starling.display.DisplayObject;
   import starling.utils.formatString;
   
   public class Touch
   {
      
      private static var sHelperPoint:Point = new Point();
       
      
      private var mID:int;
      
      private var mGlobalX:Number;
      
      private var mGlobalY:Number;
      
      private var mPreviousGlobalX:Number;
      
      private var mPreviousGlobalY:Number;
      
      private var mTapCount:int;
      
      private var mPhase:String;
      
      private var mTarget:DisplayObject;
      
      private var mTimestamp:Number;
      
      private var mPressure:Number;
      
      private var mWidth:Number;
      
      private var mHeight:Number;
      
      private var mCancelled:Boolean;
      
      private var mBubbleChain:Vector.<EventDispatcher>;
      
      public function Touch(id:int)
      {
         super();
         mID = id;
         mTapCount = 0;
         mPhase = "hover";
         mHeight = 1;
         mWidth = 1;
         mPressure = 1;
         mBubbleChain = new Vector.<EventDispatcher>(0);
      }
      
      public function getLocation(space:DisplayObject, resultPoint:Point = null) : Point
      {
         sHelperPoint.setTo(mGlobalX,mGlobalY);
         return space.globalToLocal(sHelperPoint,resultPoint);
      }
      
      public function getPreviousLocation(space:DisplayObject, resultPoint:Point = null) : Point
      {
         sHelperPoint.setTo(mPreviousGlobalX,mPreviousGlobalY);
         return space.globalToLocal(sHelperPoint,resultPoint);
      }
      
      public function getMovement(space:DisplayObject, resultPoint:Point = null) : Point
      {
         if(resultPoint == null)
         {
            resultPoint = new Point();
         }
         getLocation(space,resultPoint);
         var x:Number = resultPoint.x;
         var y:Number = resultPoint.y;
         getPreviousLocation(space,resultPoint);
         resultPoint.setTo(x - resultPoint.x,y - resultPoint.y);
         return resultPoint;
      }
      
      public function isTouching(target:DisplayObject) : Boolean
      {
         return mBubbleChain.indexOf(target) != -1;
      }
      
      public function toString() : String
      {
         return formatString("Touch {0}: globalX={1}, globalY={2}, phase={3}",mID,mGlobalX,mGlobalY,mPhase);
      }
      
      public function clone() : Touch
      {
         var clone:Touch = new Touch(mID);
         clone.mGlobalX = mGlobalX;
         clone.mGlobalY = mGlobalY;
         clone.mPreviousGlobalX = mPreviousGlobalX;
         clone.mPreviousGlobalY = mPreviousGlobalY;
         clone.mPhase = mPhase;
         clone.mTapCount = mTapCount;
         clone.mTimestamp = mTimestamp;
         clone.mPressure = mPressure;
         clone.mWidth = mWidth;
         clone.mHeight = mHeight;
         clone.mCancelled = mCancelled;
         clone.target = mTarget;
         return clone;
      }
      
      private function updateBubbleChain() : void
      {
         var length:int = 0;
         var element:* = null;
         if(mTarget)
         {
            length = 1;
            element = mTarget;
            mBubbleChain.length = 1;
            mBubbleChain[0] = element;
            while(true)
            {
               element = element.parent;
               if(element.parent == null)
               {
                  break;
               }
               length++;
               mBubbleChain[int(length)] = element;
            }
         }
         else
         {
            mBubbleChain.length = 0;
         }
      }
      
      public function get id() : int
      {
         return mID;
      }
      
      public function get previousGlobalX() : Number
      {
         return mPreviousGlobalX;
      }
      
      public function get previousGlobalY() : Number
      {
         return mPreviousGlobalY;
      }
      
      public function get globalX() : Number
      {
         return mGlobalX;
      }
      
      public function set globalX(value:Number) : void
      {
         mPreviousGlobalX = mGlobalX != mGlobalX?value:Number(mGlobalX);
         mGlobalX = value;
      }
      
      public function get globalY() : Number
      {
         return mGlobalY;
      }
      
      public function set globalY(value:Number) : void
      {
         mPreviousGlobalY = mGlobalY != mGlobalY?value:Number(mGlobalY);
         mGlobalY = value;
      }
      
      public function get tapCount() : int
      {
         return mTapCount;
      }
      
      public function set tapCount(value:int) : void
      {
         mTapCount = value;
      }
      
      public function get phase() : String
      {
         return mPhase;
      }
      
      public function set phase(value:String) : void
      {
         mPhase = value;
      }
      
      public function get target() : DisplayObject
      {
         return mTarget;
      }
      
      public function set target(value:DisplayObject) : void
      {
         if(mTarget != value)
         {
            mTarget = value;
            updateBubbleChain();
         }
      }
      
      public function get timestamp() : Number
      {
         return mTimestamp;
      }
      
      public function set timestamp(value:Number) : void
      {
         mTimestamp = value;
      }
      
      public function get pressure() : Number
      {
         return mPressure;
      }
      
      public function set pressure(value:Number) : void
      {
         mPressure = value;
      }
      
      public function get width() : Number
      {
         return mWidth;
      }
      
      public function set width(value:Number) : void
      {
         mWidth = value;
      }
      
      public function get height() : Number
      {
         return mHeight;
      }
      
      public function set height(value:Number) : void
      {
         mHeight = value;
      }
      
      public function get cancelled() : Boolean
      {
         return mCancelled;
      }
      
      public function set cancelled(value:Boolean) : void
      {
         mCancelled = value;
      }
      
      function dispatchEvent(event:TouchEvent) : void
      {
         if(mTarget)
         {
            event.dispatch(mBubbleChain);
         }
      }
      
      function get bubbleChain() : Vector.<EventDispatcher>
      {
         return mBubbleChain.concat();
      }
   }
}
