package dragonBones.fast.animation{   import dragonBones.cache.AnimationCacheManager;   import dragonBones.core.IArmature;   import dragonBones.fast.FastArmature;   import dragonBones.fast.FastSlot;   import dragonBones.objects.AnimationData;      public class FastAnimation   {                   public var animationList:Vector.<String>;            public var animationState:FastAnimationState;            public var animationCacheManager:AnimationCacheManager;            private var _armature:FastArmature;            private var _animationDataList:Vector.<AnimationData>;            private var _animationDataObj:Object;            private var _isPlaying:Boolean;            private var _timeScale:Number;            public function FastAnimation(armature:FastArmature) { super(); }
            public function dispose() : void { }
            public function gotoAndPlay(animationName:String, fadeInTime:Number = -1, duration:Number = -1, playTimes:Number = NaN) : FastAnimationState { return null; }
            public function gotoAndStop(animationName:String, time:Number, normalizedTime:Number = -1, fadeInTime:Number = 0, duration:Number = -1) : FastAnimationState { return null; }
            public function play() : void { }
            public function stop() : void { }
            protected function advanceTime(passedTime:Number) : void { }
            public function hasAnimation(animationName:String) : Boolean { return false; }
            public function get timeScale() : Number { return 0; }
            public function set timeScale(value:Number) : void { }
            public function get animationDataList() : Vector.<AnimationData> { return null; }
            public function set animationDataList(value:Vector.<AnimationData>) : void { }
            public function get movementList() : Vector.<String> { return null; }
            public function get movementID() : String { return null; }
            public function get isPlaying() : Boolean { return false; }
            public function get isComplete() : Boolean { return false; }
            public function get lastAnimationState() : FastAnimationState { return null; }
            public function get lastAnimationName() : String { return null; }
   }}