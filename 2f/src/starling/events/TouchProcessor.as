package starling.events{   import flash.geom.Point;   import flash.utils.getDefinitionByName;   import starling.display.DisplayObject;   import starling.display.Stage;      public class TouchProcessor   {            private static var sUpdatedTouches:Vector.<Touch> = new Vector.<Touch>(0);            private static var sHoveringTouchData:Vector.<Object> = new Vector.<Object>(0);            private static var sHelperPoint:Point = new Point();                   private var mStage:Stage;            private var mRoot:DisplayObject;            private var mElapsedTime:Number;            private var mTouchMarker:TouchMarker;            private var mLastTaps:Vector.<Touch>;            private var mShiftDown:Boolean = false;            private var mCtrlDown:Boolean = false;            private var mMultitapTime:Number = 0.3;            private var mMultitapDistance:Number = 25;            protected var mQueue:Vector.<Array>;            protected var mCurrentTouches:Vector.<Touch>;            public function TouchProcessor(stage:Stage) { super(); }
            public function dispose() : void { }
            public function advanceTime(passedTime:Number) : void { }
            protected function processTouches(touches:Vector.<Touch>, shiftDown:Boolean, ctrlDown:Boolean) : void { }
            public function enqueue(touchID:int, phase:String, globalX:Number, globalY:Number, pressure:Number = 1.0, width:Number = 1.0, height:Number = 1.0) : void { }
            public function enqueueMouseLeftStage() : void { }
            public function cancelTouches() : void { }
            private function createOrUpdateTouch(touchID:int, phase:String, globalX:Number, globalY:Number, pressure:Number = 1.0, width:Number = 1.0, height:Number = 1.0) : Touch { return null; }
            private function updateTapCount(touch:Touch) : void { }
            private function addCurrentTouch(touch:Touch) : void { }
            private function getCurrentTouch(touchID:int) : Touch { return null; }
            private function containsTouchWithID(touches:Vector.<Touch>, touchID:int) : Boolean { return false; }
            public function get simulateMultitouch() : Boolean { return false; }
            public function set simulateMultitouch(value:Boolean) : void { }
            public function get multitapTime() : Number { return 0; }
            public function set multitapTime(value:Number) : void { }
            public function get multitapDistance() : Number { return 0; }
            public function set multitapDistance(value:Number) : void { }
            public function get root() : DisplayObject { return null; }
            public function set root(value:DisplayObject) : void { }
            public function get stage() : Stage { return null; }
            public function get numCurrentTouches() : int { return 0; }
            private function onKey(event:KeyboardEvent) : void { }
            private function monitorInterruptions(enable:Boolean) : void { }
            private function onInterruption(event:Object) : void { }
   }}