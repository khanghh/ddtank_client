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
      
      public function Touch(param1:int){super();}
      
      public function getLocation(param1:DisplayObject, param2:Point = null) : Point{return null;}
      
      public function getPreviousLocation(param1:DisplayObject, param2:Point = null) : Point{return null;}
      
      public function getMovement(param1:DisplayObject, param2:Point = null) : Point{return null;}
      
      public function isTouching(param1:DisplayObject) : Boolean{return false;}
      
      public function toString() : String{return null;}
      
      public function clone() : Touch{return null;}
      
      private function updateBubbleChain() : void{}
      
      public function get id() : int{return 0;}
      
      public function get previousGlobalX() : Number{return 0;}
      
      public function get previousGlobalY() : Number{return 0;}
      
      public function get globalX() : Number{return 0;}
      
      public function set globalX(param1:Number) : void{}
      
      public function get globalY() : Number{return 0;}
      
      public function set globalY(param1:Number) : void{}
      
      public function get tapCount() : int{return 0;}
      
      public function set tapCount(param1:int) : void{}
      
      public function get phase() : String{return null;}
      
      public function set phase(param1:String) : void{}
      
      public function get target() : DisplayObject{return null;}
      
      public function set target(param1:DisplayObject) : void{}
      
      public function get timestamp() : Number{return 0;}
      
      public function set timestamp(param1:Number) : void{}
      
      public function get pressure() : Number{return 0;}
      
      public function set pressure(param1:Number) : void{}
      
      public function get width() : Number{return 0;}
      
      public function set width(param1:Number) : void{}
      
      public function get height() : Number{return 0;}
      
      public function set height(param1:Number) : void{}
      
      public function get cancelled() : Boolean{return false;}
      
      public function set cancelled(param1:Boolean) : void{}
      
      function dispatchEvent(param1:TouchEvent) : void{}
      
      function get bubbleChain() : Vector.<EventDispatcher>{return null;}
   }
}
