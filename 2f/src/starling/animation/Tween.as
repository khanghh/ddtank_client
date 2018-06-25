package starling.animation{   import starling.events.EventDispatcher;      public class Tween extends EventDispatcher implements IAnimatable   {            private static const HINT_MARKER:String = "#";            private static var sTweenPool:Vector.<Tween> = new Vector.<Tween>(0);                   private var mTarget:Object;            private var mTransitionFunc:Function;            private var mTransitionName:String;            private var mProperties:Vector.<String>;            private var mStartValues:Vector.<Number>;            private var mEndValues:Vector.<Number>;            private var mUpdateFuncs:Vector.<Function>;            private var mOnStart:Function;            private var mOnUpdate:Function;            private var mOnRepeat:Function;            private var mOnComplete:Function;            private var mOnStartArgs:Array;            private var mOnUpdateArgs:Array;            private var mOnRepeatArgs:Array;            private var mOnCompleteArgs:Array;            private var mTotalTime:Number;            private var mCurrentTime:Number;            private var mProgress:Number;            private var mDelay:Number;            private var mRoundToInt:Boolean;            private var mNextTween:Tween;            private var mRepeatCount:int;            private var mRepeatDelay:Number;            private var mReverse:Boolean;            private var mCurrentCycle:int;            public function Tween(target:Object, time:Number, transition:Object = "linear") { super(); }
            static function getPropertyHint(property:String) : String { return null; }
            static function getPropertyName(property:String) : String { return null; }
            static function fromPool(target:Object, time:Number, transition:Object = "linear") : Tween { return null; }
            static function toPool(tween:Tween) : void { }
            public function reset(target:Object, time:Number, transition:Object = "linear") : Tween { return null; }
            public function animate(property:String, endValue:Number) : void { }
            public function scaleTo(factor:Number) : void { }
            public function moveTo(x:Number, y:Number) : void { }
            public function fadeTo(alpha:Number) : void { }
            public function rotateTo(angle:Number, type:String = "rad") : void { }
            public function advanceTime(time:Number) : void { }
            private function getUpdateFuncFromProperty(property:String) : Function { return null; }
            private function updateStandard(property:String, startValue:Number, endValue:Number) : void { }
            private function updateRgb(property:String, startValue:Number, endValue:Number) : void { }
            private function updateRad(property:String, startValue:Number, endValue:Number) : void { }
            private function updateDeg(property:String, startValue:Number, endValue:Number) : void { }
            private function updateAngle(pi:Number, property:String, startValue:Number, endValue:Number) : void { }
            public function getEndValue(property:String) : Number { return 0; }
            public function get isComplete() : Boolean { return false; }
            public function get target() : Object { return null; }
            public function get transition() : String { return null; }
            public function set transition(value:String) : void { }
            public function get transitionFunc() : Function { return null; }
            public function set transitionFunc(value:Function) : void { }
            public function get totalTime() : Number { return 0; }
            public function get currentTime() : Number { return 0; }
            public function get progress() : Number { return 0; }
            public function get delay() : Number { return 0; }
            public function set delay(value:Number) : void { }
            public function get repeatCount() : int { return 0; }
            public function set repeatCount(value:int) : void { }
            public function get repeatDelay() : Number { return 0; }
            public function set repeatDelay(value:Number) : void { }
            public function get reverse() : Boolean { return false; }
            public function set reverse(value:Boolean) : void { }
            public function get roundToInt() : Boolean { return false; }
            public function set roundToInt(value:Boolean) : void { }
            public function get onStart() : Function { return null; }
            public function set onStart(value:Function) : void { }
            public function get onUpdate() : Function { return null; }
            public function set onUpdate(value:Function) : void { }
            public function get onRepeat() : Function { return null; }
            public function set onRepeat(value:Function) : void { }
            public function get onComplete() : Function { return null; }
            public function set onComplete(value:Function) : void { }
            public function get onStartArgs() : Array { return null; }
            public function set onStartArgs(value:Array) : void { }
            public function get onUpdateArgs() : Array { return null; }
            public function set onUpdateArgs(value:Array) : void { }
            public function get onRepeatArgs() : Array { return null; }
            public function set onRepeatArgs(value:Array) : void { }
            public function get onCompleteArgs() : Array { return null; }
            public function set onCompleteArgs(value:Array) : void { }
            public function get nextTween() : Tween { return null; }
            public function set nextTween(value:Tween) : void { }
   }}