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
      
      public function Tween(param1:Object, param2:Number, param3:Object = "linear"){super();}
      
      static function getPropertyHint(param1:String) : String{return null;}
      
      static function getPropertyName(param1:String) : String{return null;}
      
      static function fromPool(param1:Object, param2:Number, param3:Object = "linear") : Tween{return null;}
      
      static function toPool(param1:Tween) : void{}
      
      public function reset(param1:Object, param2:Number, param3:Object = "linear") : Tween{return null;}
      
      public function animate(param1:String, param2:Number) : void{}
      
      public function scaleTo(param1:Number) : void{}
      
      public function moveTo(param1:Number, param2:Number) : void{}
      
      public function fadeTo(param1:Number) : void{}
      
      public function rotateTo(param1:Number, param2:String = "rad") : void{}
      
      public function advanceTime(param1:Number) : void{}
      
      private function getUpdateFuncFromProperty(param1:String) : Function{return null;}
      
      private function updateStandard(param1:String, param2:Number, param3:Number) : void{}
      
      private function updateRgb(param1:String, param2:Number, param3:Number) : void{}
      
      private function updateRad(param1:String, param2:Number, param3:Number) : void{}
      
      private function updateDeg(param1:String, param2:Number, param3:Number) : void{}
      
      private function updateAngle(param1:Number, param2:String, param3:Number, param4:Number) : void{}
      
      public function getEndValue(param1:String) : Number{return 0;}
      
      public function get isComplete() : Boolean{return false;}
      
      public function get target() : Object{return null;}
      
      public function get transition() : String{return null;}
      
      public function set transition(param1:String) : void{}
      
      public function get transitionFunc() : Function{return null;}
      
      public function set transitionFunc(param1:Function) : void{}
      
      public function get totalTime() : Number{return 0;}
      
      public function get currentTime() : Number{return 0;}
      
      public function get progress() : Number{return 0;}
      
      public function get delay() : Number{return 0;}
      
      public function set delay(param1:Number) : void{}
      
      public function get repeatCount() : int{return 0;}
      
      public function set repeatCount(param1:int) : void{}
      
      public function get repeatDelay() : Number{return 0;}
      
      public function set repeatDelay(param1:Number) : void{}
      
      public function get reverse() : Boolean{return false;}
      
      public function set reverse(param1:Boolean) : void{}
      
      public function get roundToInt() : Boolean{return false;}
      
      public function set roundToInt(param1:Boolean) : void{}
      
      public function get onStart() : Function{return null;}
      
      public function set onStart(param1:Function) : void{}
      
      public function get onUpdate() : Function{return null;}
      
      public function set onUpdate(param1:Function) : void{}
      
      public function get onRepeat() : Function{return null;}
      
      public function set onRepeat(param1:Function) : void{}
      
      public function get onComplete() : Function{return null;}
      
      public function set onComplete(param1:Function) : void{}
      
      public function get onStartArgs() : Array{return null;}
      
      public function set onStartArgs(param1:Array) : void{}
      
      public function get onUpdateArgs() : Array{return null;}
      
      public function set onUpdateArgs(param1:Array) : void{}
      
      public function get onRepeatArgs() : Array{return null;}
      
      public function set onRepeatArgs(param1:Array) : void{}
      
      public function get onCompleteArgs() : Array{return null;}
      
      public function set onCompleteArgs(param1:Array) : void{}
      
      public function get nextTween() : Tween{return null;}
      
      public function set nextTween(param1:Tween) : void{}
   }
}
