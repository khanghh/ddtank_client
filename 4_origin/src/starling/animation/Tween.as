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
      
      public function Tween(param1:Object, param2:Number, param3:Object = "linear")
      {
         super();
         reset(param1,param2,param3);
      }
      
      static function getPropertyHint(param1:String) : String
      {
         if(param1.indexOf("color") != -1 || param1.indexOf("Color") != -1)
         {
            return "rgb";
         }
         var _loc2_:int = param1.indexOf("#");
         if(_loc2_ != -1)
         {
            return param1.substr(_loc2_ + 1);
         }
         return null;
      }
      
      static function getPropertyName(param1:String) : String
      {
         var _loc2_:int = param1.indexOf("#");
         if(_loc2_ != -1)
         {
            return param1.substring(0,_loc2_);
         }
         return param1;
      }
      
      static function fromPool(param1:Object, param2:Number, param3:Object = "linear") : Tween
      {
         if(sTweenPool.length)
         {
            return sTweenPool.pop().reset(param1,param2,param3);
         }
         return new Tween(param1,param2,param3);
      }
      
      static function toPool(param1:Tween) : void
      {
         var _loc2_:* = null;
         param1.mOnComplete = _loc2_;
         _loc2_ = _loc2_;
         param1.mOnRepeat = _loc2_;
         _loc2_ = _loc2_;
         param1.mOnUpdate = _loc2_;
         param1.mOnStart = _loc2_;
         _loc2_ = null;
         param1.mOnCompleteArgs = _loc2_;
         _loc2_ = _loc2_;
         param1.mOnRepeatArgs = _loc2_;
         _loc2_ = _loc2_;
         param1.mOnUpdateArgs = _loc2_;
         param1.mOnStartArgs = _loc2_;
         param1.mTarget = null;
         param1.mTransitionFunc = null;
         param1.removeEventListeners();
         sTweenPool.push(param1);
      }
      
      public function reset(param1:Object, param2:Number, param3:Object = "linear") : Tween
      {
         mTarget = param1;
         mCurrentTime = 0;
         mTotalTime = Math.max(0.0001,param2);
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
         if(param3 is String)
         {
            this.transition = param3 as String;
         }
         else if(param3 is Function)
         {
            this.transitionFunc = param3 as Function;
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
      
      public function animate(param1:String, param2:Number) : void
      {
         if(mTarget == null)
         {
            return;
         }
         var _loc4_:int = mProperties.length;
         var _loc3_:Function = getUpdateFuncFromProperty(param1);
         mProperties[_loc4_] = getPropertyName(param1);
         mStartValues[_loc4_] = NaN;
         mEndValues[_loc4_] = param2;
         mUpdateFuncs[_loc4_] = _loc3_;
      }
      
      public function scaleTo(param1:Number) : void
      {
         animate("scaleX",param1);
         animate("scaleY",param1);
      }
      
      public function moveTo(param1:Number, param2:Number) : void
      {
         animate("x",param1);
         animate("y",param2);
      }
      
      public function fadeTo(param1:Number) : void
      {
         animate("alpha",param1);
      }
      
      public function rotateTo(param1:Number, param2:String = "rad") : void
      {
         animate("rotation#" + param2,param1);
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc11_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc9_:* = null;
         if(param1 == 0 || mRepeatCount == 1 && mCurrentTime == mTotalTime)
         {
            return;
         }
         var _loc8_:Number = mCurrentTime;
         var _loc6_:Number = mTotalTime - mCurrentTime;
         var _loc5_:Number = param1 > _loc6_?param1 - _loc6_:0;
         mCurrentTime = mCurrentTime + param1;
         if(mCurrentTime <= 0)
         {
            return;
         }
         if(mCurrentTime > mTotalTime)
         {
            mCurrentTime = mTotalTime;
         }
         if(mCurrentCycle < 0 && _loc8_ <= 0 && mCurrentTime > 0)
         {
            mCurrentCycle = Number(mCurrentCycle) + 1;
            if(mOnStart != null)
            {
               mOnStart.apply(this,mOnStartArgs);
            }
         }
         var _loc2_:Number = mCurrentTime / mTotalTime;
         var _loc7_:Boolean = mReverse && mCurrentCycle % 2 == 1;
         var _loc10_:int = mStartValues.length;
         mProgress = !!_loc7_?mTransitionFunc(1 - _loc2_):mTransitionFunc(_loc2_);
         _loc11_ = 0;
         while(_loc11_ < _loc10_)
         {
            if(mStartValues[_loc11_] != mStartValues[_loc11_])
            {
               mStartValues[_loc11_] = mTarget[mProperties[_loc11_]] as Number;
            }
            _loc4_ = mUpdateFuncs[_loc11_] as Function;
            _loc4_(mProperties[_loc11_],mStartValues[_loc11_],mEndValues[_loc11_]);
            _loc11_++;
         }
         if(mOnUpdate != null)
         {
            mOnUpdate.apply(this,mOnUpdateArgs);
         }
         if(_loc8_ < mTotalTime && mCurrentTime >= mTotalTime)
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
               _loc3_ = mOnComplete;
               _loc9_ = mOnCompleteArgs;
               dispatchEventWith("removeFromJuggler");
               if(_loc3_ != null)
               {
                  _loc3_.apply(this,_loc9_);
               }
            }
         }
         if(_loc5_)
         {
            advanceTime(_loc5_);
         }
      }
      
      private function getUpdateFuncFromProperty(param1:String) : Function
      {
         var _loc2_:* = null;
         var _loc3_:String = getPropertyHint(param1);
         var _loc4_:* = _loc3_;
         if(null !== _loc4_)
         {
            if("rgb" !== _loc4_)
            {
               if("rad" !== _loc4_)
               {
                  if("deg" !== _loc4_)
                  {
                     trace("[Starling] Ignoring unknown property hint:",_loc3_);
                     _loc2_ = updateStandard;
                  }
                  else
                  {
                     _loc2_ = updateDeg;
                  }
               }
               else
               {
                  _loc2_ = updateRad;
               }
            }
            else
            {
               _loc2_ = updateRgb;
            }
         }
         else
         {
            _loc2_ = updateStandard;
         }
         return _loc2_;
      }
      
      private function updateStandard(param1:String, param2:Number, param3:Number) : void
      {
         var _loc4_:Number = param2 + mProgress * (param3 - param2);
         if(mRoundToInt)
         {
            _loc4_ = Math.round(_loc4_);
         }
         mTarget[param1] = _loc4_;
      }
      
      private function updateRgb(param1:String, param2:Number, param3:Number) : void
      {
         var _loc13_:uint = param2;
         var _loc15_:uint = param3;
         var _loc14_:uint = _loc13_ >> 24 & 255;
         var _loc10_:uint = _loc13_ >> 16 & 255;
         var _loc4_:uint = _loc13_ >> 8 & 255;
         var _loc6_:uint = _loc13_ & 255;
         var _loc16_:uint = _loc15_ >> 24 & 255;
         var _loc7_:uint = _loc15_ >> 16 & 255;
         var _loc11_:uint = _loc15_ >> 8 & 255;
         var _loc17_:uint = _loc15_ & 255;
         var _loc8_:uint = _loc14_ + (_loc16_ - _loc14_) * mProgress;
         var _loc5_:uint = _loc10_ + (_loc7_ - _loc10_) * mProgress;
         var _loc12_:uint = _loc4_ + (_loc11_ - _loc4_) * mProgress;
         var _loc9_:uint = _loc6_ + (_loc17_ - _loc6_) * mProgress;
         mTarget[param1] = _loc8_ << 24 | _loc5_ << 16 | _loc12_ << 8 | _loc9_;
      }
      
      private function updateRad(param1:String, param2:Number, param3:Number) : void
      {
         updateAngle(3.14159265358979,param1,param2,param3);
      }
      
      private function updateDeg(param1:String, param2:Number, param3:Number) : void
      {
         updateAngle(180,param1,param2,param3);
      }
      
      private function updateAngle(param1:Number, param2:String, param3:Number, param4:Number) : void
      {
         while(Math.abs(param4 - param3) > param1)
         {
            if(param3 < param4)
            {
               param4 = param4 - 2 * param1;
            }
            else
            {
               param4 = param4 + 2 * param1;
            }
         }
         updateStandard(param2,param3,param4);
      }
      
      public function getEndValue(param1:String) : Number
      {
         var _loc2_:int = mProperties.indexOf(param1);
         if(_loc2_ == -1)
         {
            throw new ArgumentError("The property \'" + param1 + "\' is not animated");
         }
         return mEndValues[_loc2_] as Number;
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
      
      public function set transition(param1:String) : void
      {
         mTransitionName = param1;
         mTransitionFunc = Transitions.getTransition(param1);
         if(mTransitionFunc == null)
         {
            throw new ArgumentError("Invalid transiton: " + param1);
         }
      }
      
      public function get transitionFunc() : Function
      {
         return mTransitionFunc;
      }
      
      public function set transitionFunc(param1:Function) : void
      {
         mTransitionName = "custom";
         mTransitionFunc = param1;
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
      
      public function set delay(param1:Number) : void
      {
         mCurrentTime = mCurrentTime + mDelay - param1;
         mDelay = param1;
      }
      
      public function get repeatCount() : int
      {
         return mRepeatCount;
      }
      
      public function set repeatCount(param1:int) : void
      {
         mRepeatCount = param1;
      }
      
      public function get repeatDelay() : Number
      {
         return mRepeatDelay;
      }
      
      public function set repeatDelay(param1:Number) : void
      {
         mRepeatDelay = param1;
      }
      
      public function get reverse() : Boolean
      {
         return mReverse;
      }
      
      public function set reverse(param1:Boolean) : void
      {
         mReverse = param1;
      }
      
      public function get roundToInt() : Boolean
      {
         return mRoundToInt;
      }
      
      public function set roundToInt(param1:Boolean) : void
      {
         mRoundToInt = param1;
      }
      
      public function get onStart() : Function
      {
         return mOnStart;
      }
      
      public function set onStart(param1:Function) : void
      {
         mOnStart = param1;
      }
      
      public function get onUpdate() : Function
      {
         return mOnUpdate;
      }
      
      public function set onUpdate(param1:Function) : void
      {
         mOnUpdate = param1;
      }
      
      public function get onRepeat() : Function
      {
         return mOnRepeat;
      }
      
      public function set onRepeat(param1:Function) : void
      {
         mOnRepeat = param1;
      }
      
      public function get onComplete() : Function
      {
         return mOnComplete;
      }
      
      public function set onComplete(param1:Function) : void
      {
         mOnComplete = param1;
      }
      
      public function get onStartArgs() : Array
      {
         return mOnStartArgs;
      }
      
      public function set onStartArgs(param1:Array) : void
      {
         mOnStartArgs = param1;
      }
      
      public function get onUpdateArgs() : Array
      {
         return mOnUpdateArgs;
      }
      
      public function set onUpdateArgs(param1:Array) : void
      {
         mOnUpdateArgs = param1;
      }
      
      public function get onRepeatArgs() : Array
      {
         return mOnRepeatArgs;
      }
      
      public function set onRepeatArgs(param1:Array) : void
      {
         mOnRepeatArgs = param1;
      }
      
      public function get onCompleteArgs() : Array
      {
         return mOnCompleteArgs;
      }
      
      public function set onCompleteArgs(param1:Array) : void
      {
         mOnCompleteArgs = param1;
      }
      
      public function get nextTween() : Tween
      {
         return mNextTween;
      }
      
      public function set nextTween(param1:Tween) : void
      {
         mNextTween = param1;
      }
   }
}
