package dragonBones.animation{   import dragonBones.Armature;   import dragonBones.Slot;   import dragonBones.objects.AnimationData;      public class Animation   {            public static const NONE:String = "none";            public static const SAME_LAYER:String = "sameLayer";            public static const SAME_GROUP:String = "sameGroup";            public static const SAME_LAYER_AND_GROUP:String = "sameLayerAndGroup";            public static const ALL:String = "all";                   public var tweenEnabled:Boolean;            private var _armature:Armature;            private var _animationStateList:Vector.<AnimationState>;            private var _animationDataList:Vector.<AnimationData>;            private var _animationList:Vector.<String>;            private var _isPlaying:Boolean;            private var _timeScale:Number;            var _lastAnimationState:AnimationState;            var _isFading:Boolean;            var _animationStateCount:int;            public function Animation(armature:Armature) { super(); }
            public function dispose() : void { }
            function resetAnimationStateList() : void { }
            public function gotoAndPlay(animationName:String, fadeInTime:Number = -1, duration:Number = -1, playTimes:Number = NaN, layer:int = 0, group:String = null, fadeOutMode:String = "sameLayerAndGroup", pauseFadeOut:Boolean = true, pauseFadeIn:Boolean = true) : AnimationState { return null; }
            public function gotoAndStop(animationName:String, time:Number, normalizedTime:Number = -1, fadeInTime:Number = 0, duration:Number = -1, layer:int = 0, group:String = null, fadeOutMode:String = "all") : AnimationState { return null; }
            public function play() : void { }
            public function stop() : void { }
            public function getState(name:String, layer:int = 0) : AnimationState { return null; }
            public function hasAnimation(animationName:String) : Boolean { return false; }
            protected function advanceTime(passedTime:Number) : void { }
            function updateAnimationStates() : void { }
            private function addState(animationState:AnimationState) : void { }
            private function removeState(animationState:AnimationState) : void { }
            public function get movementList() : Vector.<String> { return null; }
            public function get movementID() : String { return null; }
            public function get lastAnimationState() : AnimationState { return null; }
            public function get lastAnimationName() : String { return null; }
            public function get animationList() : Vector.<String> { return null; }
            public function get isPlaying() : Boolean { return false; }
            public function get isComplete() : Boolean { return false; }
            public function get timeScale() : Number { return 0; }
            public function set timeScale(value:Number) : void { }
            public function get animationDataList() : Vector.<AnimationData> { return null; }
            public function set animationDataList(value:Vector.<AnimationData>) : void { }
   }}