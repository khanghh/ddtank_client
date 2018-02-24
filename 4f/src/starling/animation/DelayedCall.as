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
      
      public function DelayedCall(param1:Function, param2:Number, param3:Array = null){super();}
      
      static function fromPool(param1:Function, param2:Number, param3:Array = null) : DelayedCall{return null;}
      
      static function toPool(param1:DelayedCall) : void{}
      
      public function reset(param1:Function, param2:Number, param3:Array = null) : DelayedCall{return null;}
      
      public function advanceTime(param1:Number) : void{}
      
      public function complete() : void{}
      
      public function get isComplete() : Boolean{return false;}
      
      public function get totalTime() : Number{return 0;}
      
      public function get currentTime() : Number{return 0;}
      
      public function get repeatCount() : int{return 0;}
      
      public function set repeatCount(param1:int) : void{}
   }
}
