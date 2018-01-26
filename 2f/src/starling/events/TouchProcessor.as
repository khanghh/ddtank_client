package starling.events
{
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import starling.display.DisplayObject;
   import starling.display.Stage;
   
   public class TouchProcessor
   {
      
      private static var sUpdatedTouches:Vector.<Touch> = new Vector.<Touch>(0);
      
      private static var sHoveringTouchData:Vector.<Object> = new Vector.<Object>(0);
      
      private static var sHelperPoint:Point = new Point();
       
      
      private var mStage:Stage;
      
      private var mRoot:DisplayObject;
      
      private var mElapsedTime:Number;
      
      private var mTouchMarker:TouchMarker;
      
      private var mLastTaps:Vector.<Touch>;
      
      private var mShiftDown:Boolean = false;
      
      private var mCtrlDown:Boolean = false;
      
      private var mMultitapTime:Number = 0.3;
      
      private var mMultitapDistance:Number = 25;
      
      protected var mQueue:Vector.<Array>;
      
      protected var mCurrentTouches:Vector.<Touch>;
      
      public function TouchProcessor(param1:Stage){super();}
      
      public function dispose() : void{}
      
      public function advanceTime(param1:Number) : void{}
      
      protected function processTouches(param1:Vector.<Touch>, param2:Boolean, param3:Boolean) : void{}
      
      public function enqueue(param1:int, param2:String, param3:Number, param4:Number, param5:Number = 1.0, param6:Number = 1.0, param7:Number = 1.0) : void{}
      
      public function enqueueMouseLeftStage() : void{}
      
      public function cancelTouches() : void{}
      
      private function createOrUpdateTouch(param1:int, param2:String, param3:Number, param4:Number, param5:Number = 1.0, param6:Number = 1.0, param7:Number = 1.0) : Touch{return null;}
      
      private function updateTapCount(param1:Touch) : void{}
      
      private function addCurrentTouch(param1:Touch) : void{}
      
      private function getCurrentTouch(param1:int) : Touch{return null;}
      
      private function containsTouchWithID(param1:Vector.<Touch>, param2:int) : Boolean{return false;}
      
      public function get simulateMultitouch() : Boolean{return false;}
      
      public function set simulateMultitouch(param1:Boolean) : void{}
      
      public function get multitapTime() : Number{return 0;}
      
      public function set multitapTime(param1:Number) : void{}
      
      public function get multitapDistance() : Number{return 0;}
      
      public function set multitapDistance(param1:Number) : void{}
      
      public function get root() : DisplayObject{return null;}
      
      public function set root(param1:DisplayObject) : void{}
      
      public function get stage() : Stage{return null;}
      
      public function get numCurrentTouches() : int{return 0;}
      
      private function onKey(param1:KeyboardEvent) : void{}
      
      private function monitorInterruptions(param1:Boolean) : void{}
      
      private function onInterruption(param1:Object) : void{}
   }
}
