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
      
      public function TouchProcessor(stage:Stage)
      {
         super();
         mStage = stage;
         mRoot = stage;
         mElapsedTime = 0;
         mCurrentTouches = new Vector.<Touch>(0);
         mQueue = new Vector.<Array>(0);
         mLastTaps = new Vector.<Touch>(0);
         mStage.addEventListener("keyDown",onKey);
         mStage.addEventListener("keyUp",onKey);
         monitorInterruptions(true);
      }
      
      public function dispose() : void
      {
         monitorInterruptions(false);
         mStage.removeEventListener("keyDown",onKey);
         mStage.removeEventListener("keyUp",onKey);
         if(mTouchMarker)
         {
            mTouchMarker.dispose();
         }
      }
      
      public function advanceTime(passedTime:Number) : void
      {
         var i:int = 0;
         var touch:* = null;
         var touchArgs:* = null;
         mElapsedTime = mElapsedTime + passedTime;
         sUpdatedTouches.length = 0;
         if(mLastTaps.length > 0)
         {
            for(i = mLastTaps.length - 1; i >= 0; )
            {
               if(mElapsedTime - mLastTaps[i].timestamp > mMultitapTime)
               {
                  mLastTaps.splice(i,1);
               }
               i--;
            }
         }
         while(mQueue.length > 0)
         {
            var _loc6_:int = 0;
            var _loc5_:* = mCurrentTouches;
            for each(touch in mCurrentTouches)
            {
               if(touch.phase == "began" || touch.phase == "moved")
               {
                  touch.phase = "stationary";
               }
            }
            while(mQueue.length > 0 && !containsTouchWithID(sUpdatedTouches,mQueue[mQueue.length - 1][0]))
            {
               touchArgs = mQueue.pop();
               touch = createOrUpdateTouch(touchArgs[0],touchArgs[1],touchArgs[2],touchArgs[3],touchArgs[4],touchArgs[5],touchArgs[6]);
               sUpdatedTouches[sUpdatedTouches.length] = touch;
            }
            processTouches(sUpdatedTouches,mShiftDown,mCtrlDown);
            for(i = mCurrentTouches.length - 1; i >= 0; )
            {
               if(mCurrentTouches[i].phase == "ended")
               {
                  mCurrentTouches.splice(i,1);
               }
               i--;
            }
            sUpdatedTouches.length = 0;
         }
      }
      
      protected function processTouches(touches:Vector.<Touch>, shiftDown:Boolean, ctrlDown:Boolean) : void
      {
         var touch:* = null;
         sHoveringTouchData.length = 0;
         var touchEvent:TouchEvent = new TouchEvent("touch",mCurrentTouches,shiftDown,ctrlDown);
         var _loc8_:int = 0;
         var _loc7_:* = touches;
         for each(touch in touches)
         {
            if(touch.phase == "hover" && touch.target)
            {
               sHoveringTouchData[sHoveringTouchData.length] = {
                  "touch":touch,
                  "target":touch.target,
                  "bubbleChain":touch.bubbleChain
               };
            }
            if(touch.phase == "hover" || touch.phase == "began")
            {
               sHelperPoint.setTo(touch.globalX,touch.globalY);
               touch.target = mRoot.hitTest(sHelperPoint,true);
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = sHoveringTouchData;
         for each(var touchData in sHoveringTouchData)
         {
            if(touchData.touch.target != touchData.target)
            {
               touchEvent.dispatch(touchData.bubbleChain);
            }
         }
         var _loc12_:int = 0;
         var _loc11_:* = touches;
         for each(touch in touches)
         {
            touch.dispatchEvent(touchEvent);
         }
      }
      
      public function enqueue(touchID:int, phase:String, globalX:Number, globalY:Number, pressure:Number = 1.0, width:Number = 1.0, height:Number = 1.0) : void
      {
         mQueue.unshift(arguments);
         if(mCtrlDown && simulateMultitouch && touchID == 0)
         {
            mTouchMarker.moveMarker(globalX,globalY,mShiftDown);
            mQueue.unshift([1,phase,mTouchMarker.mockX,mTouchMarker.mockY]);
         }
      }
      
      public function enqueueMouseLeftStage() : void
      {
         var mouse:Touch = getCurrentTouch(0);
         if(mouse == null || mouse.phase != "hover")
         {
            return;
         }
         var offset:int = 1;
         var exitX:Number = mouse.globalX;
         var exitY:Number = mouse.globalY;
         var distLeft:Number = mouse.globalX;
         var distRight:Number = mStage.stageWidth - distLeft;
         var distTop:Number = mouse.globalY;
         var distBottom:Number = mStage.stageHeight - distTop;
         var minDist:Number = Math.min(distLeft,distRight,distTop,distBottom);
         if(minDist == distLeft)
         {
            exitX = -offset;
         }
         else if(minDist == distRight)
         {
            exitX = mStage.stageWidth + offset;
         }
         else if(minDist == distTop)
         {
            exitY = -offset;
         }
         else
         {
            exitY = mStage.stageHeight + offset;
         }
         enqueue(0,"hover",exitX,exitY);
      }
      
      public function cancelTouches() : void
      {
         if(mCurrentTouches.length > 0)
         {
            var _loc3_:int = 0;
            var _loc2_:* = mCurrentTouches;
            for each(var touch in mCurrentTouches)
            {
               if(touch.phase == "began" || touch.phase == "moved" || touch.phase == "stationary")
               {
                  touch.phase = "ended";
                  touch.cancelled = true;
               }
            }
            processTouches(mCurrentTouches,mShiftDown,mCtrlDown);
         }
         mCurrentTouches.length = 0;
         mQueue.length = 0;
      }
      
      private function createOrUpdateTouch(touchID:int, phase:String, globalX:Number, globalY:Number, pressure:Number = 1.0, width:Number = 1.0, height:Number = 1.0) : Touch
      {
         var touch:Touch = getCurrentTouch(touchID);
         if(touch == null)
         {
            touch = new Touch(touchID);
            addCurrentTouch(touch);
         }
         touch.globalX = globalX;
         touch.globalY = globalY;
         touch.phase = phase;
         touch.timestamp = mElapsedTime;
         touch.pressure = pressure;
         touch.width = width;
         touch.height = height;
         if(phase == "began")
         {
            updateTapCount(touch);
         }
         return touch;
      }
      
      private function updateTapCount(touch:Touch) : void
      {
         var sqDist:Number = NaN;
         var nearbyTap:* = null;
         var minSqDist:Number = mMultitapDistance * mMultitapDistance;
         var _loc7_:int = 0;
         var _loc6_:* = mLastTaps;
         for each(var tap in mLastTaps)
         {
            sqDist = Math.pow(tap.globalX - touch.globalX,2) + Math.pow(tap.globalY - touch.globalY,2);
            if(sqDist <= minSqDist)
            {
               nearbyTap = tap;
               break;
            }
         }
         if(nearbyTap)
         {
            touch.tapCount = nearbyTap.tapCount + 1;
            mLastTaps.splice(mLastTaps.indexOf(nearbyTap),1);
         }
         else
         {
            touch.tapCount = 1;
         }
         mLastTaps.push(touch.clone());
      }
      
      private function addCurrentTouch(touch:Touch) : void
      {
         var i:int = 0;
         for(i = mCurrentTouches.length - 1; i >= 0; )
         {
            if(mCurrentTouches[i].id == touch.id)
            {
               mCurrentTouches.splice(i,1);
            }
            i--;
         }
         mCurrentTouches.push(touch);
      }
      
      private function getCurrentTouch(touchID:int) : Touch
      {
         var _loc4_:int = 0;
         var _loc3_:* = mCurrentTouches;
         for each(var touch in mCurrentTouches)
         {
            if(touch.id == touchID)
            {
               return touch;
            }
         }
         return null;
      }
      
      private function containsTouchWithID(touches:Vector.<Touch>, touchID:int) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:* = touches;
         for each(var touch in touches)
         {
            if(touch.id == touchID)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get simulateMultitouch() : Boolean
      {
         return mTouchMarker != null;
      }
      
      public function set simulateMultitouch(value:Boolean) : void
      {
         if(simulateMultitouch == value)
         {
            return;
         }
         if(value)
         {
            mTouchMarker = new TouchMarker();
            mTouchMarker.visible = false;
            mStage.addChild(mTouchMarker);
         }
         else
         {
            mTouchMarker.removeFromParent(true);
            mTouchMarker = null;
         }
      }
      
      public function get multitapTime() : Number
      {
         return mMultitapTime;
      }
      
      public function set multitapTime(value:Number) : void
      {
         mMultitapTime = value;
      }
      
      public function get multitapDistance() : Number
      {
         return mMultitapDistance;
      }
      
      public function set multitapDistance(value:Number) : void
      {
         mMultitapDistance = value;
      }
      
      public function get root() : DisplayObject
      {
         return mRoot;
      }
      
      public function set root(value:DisplayObject) : void
      {
         mRoot = value;
      }
      
      public function get stage() : Stage
      {
         return mStage;
      }
      
      public function get numCurrentTouches() : int
      {
         return mCurrentTouches.length;
      }
      
      private function onKey(event:KeyboardEvent) : void
      {
         var wasCtrlDown:Boolean = false;
         var mouseTouch:* = null;
         var mockedTouch:* = null;
         if(event.keyCode == 17 || event.keyCode == 15)
         {
            wasCtrlDown = mCtrlDown;
            mCtrlDown = event.type == "keyDown";
            if(simulateMultitouch && wasCtrlDown != mCtrlDown)
            {
               mTouchMarker.visible = mCtrlDown;
               mTouchMarker.moveCenter(mStage.stageWidth / 2,mStage.stageHeight / 2);
               mouseTouch = getCurrentTouch(0);
               mockedTouch = getCurrentTouch(1);
               if(mouseTouch)
               {
                  mTouchMarker.moveMarker(mouseTouch.globalX,mouseTouch.globalY);
               }
               if(wasCtrlDown && mockedTouch && mockedTouch.phase != "ended")
               {
                  mQueue.unshift([1,"ended",mockedTouch.globalX,mockedTouch.globalY]);
               }
               else if(mCtrlDown && mouseTouch)
               {
                  if(mouseTouch.phase == "hover" || mouseTouch.phase == "ended")
                  {
                     mQueue.unshift([1,"hover",mTouchMarker.mockX,mTouchMarker.mockY]);
                  }
                  else
                  {
                     mQueue.unshift([1,"began",mTouchMarker.mockX,mTouchMarker.mockY]);
                  }
               }
            }
         }
         else if(event.keyCode == 16)
         {
            mShiftDown = event.type == "keyDown";
         }
      }
      
      private function monitorInterruptions(enable:Boolean) : void
      {
         var nativeAppClass:* = null;
         var nativeApp:* = null;
         try
         {
            nativeAppClass = getDefinitionByName("flash.desktop::NativeApplication");
            nativeApp = nativeAppClass["nativeApplication"];
            if(enable)
            {
               nativeApp.addEventListener("deactivate",onInterruption,false,0,true);
            }
            else
            {
               nativeApp.removeEventListener("deactivate",onInterruption);
            }
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      private function onInterruption(event:Object) : void
      {
         cancelTouches();
      }
   }
}
