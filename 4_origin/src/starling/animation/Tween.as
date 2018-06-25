package starling.animation
{
   import starling.events.EventDispatcher;
   
   public class Tween extends EventDispatcher implements IAnimatable
   {
      
      private static const HINT_MARKER:String = "#";
      
      private static var sTweenPool:Vector.<Tween> = new Vector.<Tween>(0);
       
      
      private var mTarget:Object;
      
      private var mTransitionFunc:Function;
      
      private var mTransitionName:String;
      
      private var mProperties:Vector.<String>;
      
      private var mStartValues:Vector.<Number>;
      
      private var mEndValues:Vector.<Number>;
      
      private var mUpdateFuncs:Vector.<Function>;
      
      private var mOnStart:Function;
      
      private var mOnUpdate:Function;
      
      private var mOnRepeat:Function;
      
      private var mOnComplete:Function;
      
      private var mOnStartArgs:Array;
      
      private var mOnUpdateArgs:Array;
      
      private var mOnRepeatArgs:Array;
      
      private var mOnCompleteArgs:Array;
      
      private var mTotalTime:Number;
      
      private var mCurrentTime:Number;
      
      private var mProgress:Number;
      
      private var mDelay:Number;
      
      private var mRoundToInt:Boolean;
      
      private var mNextTween:Tween;
      
      private var mRepeatCount:int;
      
      private var mRepeatDelay:Number;
      
      private var mReverse:Boolean;
      
      private var mCurrentCycle:int;
      
      public function Tween(target:Object, time:Number, transition:Object = "linear")
      {
         super();
         reset(target,time,transition);
      }
      
      static function getPropertyHint(property:String) : String
      {
         if(property.indexOf("color") != -1 || property.indexOf("Color") != -1)
         {
            return "rgb";
         }
         var hintMarkerIndex:int = property.indexOf("#");
         if(hintMarkerIndex != -1)
         {
            return property.substr(hintMarkerIndex + 1);
         }
         return null;
      }
      
      static function getPropertyName(property:String) : String
      {
         var hintMarkerIndex:int = property.indexOf("#");
         if(hintMarkerIndex != -1)
         {
            return property.substring(0,hintMarkerIndex);
         }
         return property;
      }
      
      static function fromPool(target:Object, time:Number, transition:Object = "linear") : Tween
      {
         if(sTweenPool.length)
         {
            return sTweenPool.pop().reset(target,time,transition);
         }
         return new Tween(target,time,transition);
      }
      
      static function toPool(tween:Tween) : void
      {
         var _loc2_:* = null;
         tween.mOnComplete = _loc2_;
         _loc2_ = _loc2_;
         tween.mOnRepeat = _loc2_;
         _loc2_ = _loc2_;
         tween.mOnUpdate = _loc2_;
         tween.mOnStart = _loc2_;
         _loc2_ = null;
         tween.mOnCompleteArgs = _loc2_;
         _loc2_ = _loc2_;
         tween.mOnRepeatArgs = _loc2_;
         _loc2_ = _loc2_;
         tween.mOnUpdateArgs = _loc2_;
         tween.mOnStartArgs = _loc2_;
         tween.mTarget = null;
         tween.mTransitionFunc = null;
         tween.removeEventListeners();
         sTweenPool.push(tween);
      }
      
      public function reset(target:Object, time:Number, transition:Object = "linear") : Tween
      {
         mTarget = target;
         mCurrentTime = 0;
         mTotalTime = Math.max(0.0001,time);
         mProgress = 0;
         mRepeatDelay = 0;
         mDelay = 0;
         mOnComplete = null;
         mOnRepeat = null;
         mOnUpdate = null;
         mOnStart = null;
         mOnCompleteArgs = null;
         mOnRepeatArgs = null;
         mOnUpdateArgs = null;
         mOnStartArgs = null;
         mReverse = false;
         mRoundToInt = false;
         mRepeatCount = 1;
         mCurrentCycle = -1;
         mNextTween = null;
         if(transition is String)
         {
            this.transition = transition as String;
         }
         else if(transition is Function)
         {
            this.transitionFunc = transition as Function;
         }
         else
         {
            throw new ArgumentError("Transition must be either a string or a function");
         }
         if(mProperties)
         {
            mProperties.length = 0;
         }
         else
         {
            mProperties = new Vector.<String>(0);
         }
         if(mStartValues)
         {
            mStartValues.length = 0;
         }
         else
         {
            mStartValues = new Vector.<Number>(0);
         }
         if(mEndValues)
         {
            mEndValues.length = 0;
         }
         else
         {
            mEndValues = new Vector.<Number>(0);
         }
         if(mUpdateFuncs)
         {
            mUpdateFuncs.length = 0;
         }
         else
         {
            mUpdateFuncs = new Vector.<Function>(0);
         }
         return this;
      }
      
      public function animate(property:String, endValue:Number) : void
      {
         if(mTarget == null)
         {
            return;
         }
         var pos:int = mProperties.length;
         var updateFunc:Function = getUpdateFuncFromProperty(property);
         mProperties[pos] = getPropertyName(property);
         mStartValues[pos] = NaN;
         mEndValues[pos] = endValue;
         mUpdateFuncs[pos] = updateFunc;
      }
      
      public function scaleTo(factor:Number) : void
      {
         animate("scaleX",factor);
         animate("scaleY",factor);
      }
      
      public function moveTo(x:Number, y:Number) : void
      {
         animate("x",x);
         animate("y",y);
      }
      
      public function fadeTo(alpha:Number) : void
      {
         animate("alpha",alpha);
      }
      
      public function rotateTo(angle:Number, type:String = "rad") : void
      {
         animate("rotation#" + type,angle);
      }
      
      public function advanceTime(time:Number) : void
      {
         var i:int = 0;
         var updateFunc:* = null;
         var onComplete:* = null;
         var onCompleteArgs:* = null;
         if(time == 0 || mRepeatCount == 1 && mCurrentTime == mTotalTime)
         {
            return;
         }
         var previousTime:Number = mCurrentTime;
         var restTime:Number = mTotalTime - mCurrentTime;
         var carryOverTime:Number = time > restTime?time - restTime:0;
         mCurrentTime = mCurrentTime + time;
         if(mCurrentTime <= 0)
         {
            return;
         }
         if(mCurrentTime > mTotalTime)
         {
            mCurrentTime = mTotalTime;
         }
         if(mCurrentCycle < 0 && previousTime <= 0 && mCurrentTime > 0)
         {
            mCurrentCycle = Number(mCurrentCycle) + 1;
            if(mOnStart != null)
            {
               mOnStart.apply(this,mOnStartArgs);
            }
         }
         var ratio:Number = mCurrentTime / mTotalTime;
         var reversed:Boolean = mReverse && mCurrentCycle % 2 == 1;
         var numProperties:int = mStartValues.length;
         mProgress = !!reversed?mTransitionFunc(1 - ratio):mTransitionFunc(ratio);
         for(i = 0; i < numProperties; )
         {
            if(mStartValues[i] != mStartValues[i])
            {
               mStartValues[i] = mTarget[mProperties[i]] as Number;
            }
            updateFunc = mUpdateFuncs[i] as Function;
            updateFunc(mProperties[i],mStartValues[i],mEndValues[i]);
            i++;
         }
         if(mOnUpdate != null)
         {
            mOnUpdate.apply(this,mOnUpdateArgs);
         }
         if(previousTime < mTotalTime && mCurrentTime >= mTotalTime)
         {
            if(mRepeatCount == 0 || mRepeatCount > 1)
            {
               mCurrentTime = -mRepeatDelay;
               mCurrentCycle = Number(mCurrentCycle) + 1;
               if(mRepeatCount > 1)
               {
                  mRepeatCount = Number(mRepeatCount) - 1;
               }
               if(mOnRepeat != null)
               {
                  mOnRepeat.apply(this,mOnRepeatArgs);
               }
            }
            else
            {
               onComplete = mOnComplete;
               onCompleteArgs = mOnCompleteArgs;
               dispatchEventWith("removeFromJuggler");
               if(onComplete != null)
               {
                  onComplete.apply(this,onCompleteArgs);
               }
            }
         }
         if(carryOverTime)
         {
            advanceTime(carryOverTime);
         }
      }
      
      private function getUpdateFuncFromProperty(property:String) : Function
      {
         var updateFunc:* = null;
         var hint:String = getPropertyHint(property);
         var _loc4_:* = hint;
         if(null !== _loc4_)
         {
            if("rgb" !== _loc4_)
            {
               if("rad" !== _loc4_)
               {
                  if("deg" !== _loc4_)
                  {
                     trace("[Starling] Ignoring unknown property hint:",hint);
                     updateFunc = updateStandard;
                  }
                  else
                  {
                     updateFunc = updateDeg;
                  }
               }
               else
               {
                  updateFunc = updateRad;
               }
            }
            else
            {
               updateFunc = updateRgb;
            }
         }
         else
         {
            updateFunc = updateStandard;
         }
         return updateFunc;
      }
      
      private function updateStandard(property:String, startValue:Number, endValue:Number) : void
      {
         var newValue:Number = startValue + mProgress * (endValue - startValue);
         if(mRoundToInt)
         {
            newValue = Math.round(newValue);
         }
         mTarget[property] = newValue;
      }
      
      private function updateRgb(property:String, startValue:Number, endValue:Number) : void
      {
         var startColor:uint = startValue;
         var endColor:uint = endValue;
         var startA:uint = startColor >> 24 & 255;
         var startR:uint = startColor >> 16 & 255;
         var startG:uint = startColor >> 8 & 255;
         var startB:uint = startColor & 255;
         var endA:uint = endColor >> 24 & 255;
         var endR:uint = endColor >> 16 & 255;
         var endG:uint = endColor >> 8 & 255;
         var endB:uint = endColor & 255;
         var newA:uint = startA + (endA - startA) * mProgress;
         var newR:uint = startR + (endR - startR) * mProgress;
         var newG:uint = startG + (endG - startG) * mProgress;
         var newB:uint = startB + (endB - startB) * mProgress;
         mTarget[property] = newA << 24 | newR << 16 | newG << 8 | newB;
      }
      
      private function updateRad(property:String, startValue:Number, endValue:Number) : void
      {
         updateAngle(3.14159265358979,property,startValue,endValue);
      }
      
      private function updateDeg(property:String, startValue:Number, endValue:Number) : void
      {
         updateAngle(180,property,startValue,endValue);
      }
      
      private function updateAngle(pi:Number, property:String, startValue:Number, endValue:Number) : void
      {
         while(Math.abs(endValue - startValue) > pi)
         {
            if(startValue < endValue)
            {
               endValue = endValue - 2 * pi;
            }
            else
            {
               endValue = endValue + 2 * pi;
            }
         }
         updateStandard(property,startValue,endValue);
      }
      
      public function getEndValue(property:String) : Number
      {
         var index:int = mProperties.indexOf(property);
         if(index == -1)
         {
            throw new ArgumentError("The property \'" + property + "\' is not animated");
         }
         return mEndValues[index] as Number;
      }
      
      public function get isComplete() : Boolean
      {
         return mCurrentTime >= mTotalTime && mRepeatCount == 1;
      }
      
      public function get target() : Object
      {
         return mTarget;
      }
      
      public function get transition() : String
      {
         return mTransitionName;
      }
      
      public function set transition(value:String) : void
      {
         mTransitionName = value;
         mTransitionFunc = Transitions.getTransition(value);
         if(mTransitionFunc == null)
         {
            throw new ArgumentError("Invalid transiton: " + value);
         }
      }
      
      public function get transitionFunc() : Function
      {
         return mTransitionFunc;
      }
      
      public function set transitionFunc(value:Function) : void
      {
         mTransitionName = "custom";
         mTransitionFunc = value;
      }
      
      public function get totalTime() : Number
      {
         return mTotalTime;
      }
      
      public function get currentTime() : Number
      {
         return mCurrentTime;
      }
      
      public function get progress() : Number
      {
         return mProgress;
      }
      
      public function get delay() : Number
      {
         return mDelay;
      }
      
      public function set delay(value:Number) : void
      {
         mCurrentTime = mCurrentTime + mDelay - value;
         mDelay = value;
      }
      
      public function get repeatCount() : int
      {
         return mRepeatCount;
      }
      
      public function set repeatCount(value:int) : void
      {
         mRepeatCount = value;
      }
      
      public function get repeatDelay() : Number
      {
         return mRepeatDelay;
      }
      
      public function set repeatDelay(value:Number) : void
      {
         mRepeatDelay = value;
      }
      
      public function get reverse() : Boolean
      {
         return mReverse;
      }
      
      public function set reverse(value:Boolean) : void
      {
         mReverse = value;
      }
      
      public function get roundToInt() : Boolean
      {
         return mRoundToInt;
      }
      
      public function set roundToInt(value:Boolean) : void
      {
         mRoundToInt = value;
      }
      
      public function get onStart() : Function
      {
         return mOnStart;
      }
      
      public function set onStart(value:Function) : void
      {
         mOnStart = value;
      }
      
      public function get onUpdate() : Function
      {
         return mOnUpdate;
      }
      
      public function set onUpdate(value:Function) : void
      {
         mOnUpdate = value;
      }
      
      public function get onRepeat() : Function
      {
         return mOnRepeat;
      }
      
      public function set onRepeat(value:Function) : void
      {
         mOnRepeat = value;
      }
      
      public function get onComplete() : Function
      {
         return mOnComplete;
      }
      
      public function set onComplete(value:Function) : void
      {
         mOnComplete = value;
      }
      
      public function get onStartArgs() : Array
      {
         return mOnStartArgs;
      }
      
      public function set onStartArgs(value:Array) : void
      {
         mOnStartArgs = value;
      }
      
      public function get onUpdateArgs() : Array
      {
         return mOnUpdateArgs;
      }
      
      public function set onUpdateArgs(value:Array) : void
      {
         mOnUpdateArgs = value;
      }
      
      public function get onRepeatArgs() : Array
      {
         return mOnRepeatArgs;
      }
      
      public function set onRepeatArgs(value:Array) : void
      {
         mOnRepeatArgs = value;
      }
      
      public function get onCompleteArgs() : Array
      {
         return mOnCompleteArgs;
      }
      
      public function set onCompleteArgs(value:Array) : void
      {
         mOnCompleteArgs = value;
      }
      
      public function get nextTween() : Tween
      {
         return mNextTween;
      }
      
      public function set nextTween(value:Tween) : void
      {
         mNextTween = value;
      }
   }
}
