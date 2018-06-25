package starling.animation
{
   import starling.events.EventDispatcher;
   
   public class DelayedCall extends EventDispatcher implements IAnimatable
   {
      
      private static var sPool:Vector.<DelayedCall> = new Vector.<DelayedCall>(0);
       
      
      private var mCurrentTime:Number;
      
      private var mTotalTime:Number;
      
      private var mCall:Function;
      
      private var mArgs:Array;
      
      private var mRepeatCount:int;
      
      public function DelayedCall(call:Function, delay:Number, args:Array = null)
      {
         super();
         reset(call,delay,args);
      }
      
      static function fromPool(call:Function, delay:Number, args:Array = null) : DelayedCall
      {
         if(sPool.length)
         {
            return sPool.pop().reset(call,delay,args);
         }
         return new DelayedCall(call,delay,args);
      }
      
      static function toPool(delayedCall:DelayedCall) : void
      {
         delayedCall.mCall = null;
         delayedCall.mArgs = null;
         delayedCall.removeEventListeners();
         sPool.push(delayedCall);
      }
      
      public function reset(call:Function, delay:Number, args:Array = null) : DelayedCall
      {
         mCurrentTime = 0;
         mTotalTime = Math.max(delay,0.0001);
         mCall = call;
         mArgs = args;
         mRepeatCount = 1;
         return this;
      }
      
      public function advanceTime(time:Number) : void
      {
         var call:* = null;
         var args:* = null;
         var previousTime:Number = mCurrentTime;
         mCurrentTime = mCurrentTime + time;
         if(mCurrentTime > mTotalTime)
         {
            mCurrentTime = mTotalTime;
         }
         if(previousTime < mTotalTime && mCurrentTime >= mTotalTime)
         {
            if(mRepeatCount == 0 || mRepeatCount > 1)
            {
               mCall.apply(null,mArgs);
               if(mRepeatCount > 0)
               {
                  mRepeatCount = mRepeatCount - 1;
               }
               mCurrentTime = 0;
               advanceTime(previousTime + time - mTotalTime);
            }
            else
            {
               call = mCall;
               args = mArgs;
               dispatchEventWith("removeFromJuggler");
               call.apply(null,args);
            }
         }
      }
      
      public function complete() : void
      {
         var restTime:Number = mTotalTime - mCurrentTime;
         if(restTime > 0)
         {
            advanceTime(restTime);
         }
      }
      
      public function get isComplete() : Boolean
      {
         return mRepeatCount == 1 && mCurrentTime >= mTotalTime;
      }
      
      public function get totalTime() : Number
      {
         return mTotalTime;
      }
      
      public function get currentTime() : Number
      {
         return mCurrentTime;
      }
      
      public function get repeatCount() : int
      {
         return mRepeatCount;
      }
      
      public function set repeatCount(value:int) : void
      {
         mRepeatCount = value;
      }
   }
}
