package dragonBones.animation{   import dragonBones.Armature;   import dragonBones.Bone;   import dragonBones.Slot;   import dragonBones.events.AnimationEvent;   import dragonBones.objects.AnimationData;   import dragonBones.objects.Frame;   import dragonBones.objects.SlotTimeline;   import dragonBones.objects.TransformTimeline;      public final class AnimationState   {            private static var _pool:Vector.<AnimationState> = new Vector.<AnimationState>();                   public var displayControl:Boolean;            public var additiveBlending:Boolean;            public var autoFadeOut:Boolean;            public var fadeOutTime:Number;            public var weight:Number;            public var autoTween:Boolean;            public var lastFrameAutoTween:Boolean;            var _layer:int;            var _group:String;            private var _armature:Armature;            private var _timelineStateList:Vector.<TimelineState>;            private var _slotTimelineStateList:Vector.<SlotTimelineState>;            private var _boneMasks:Vector.<String>;            private var _isPlaying:Boolean;            private var _time:Number;            private var _currentFrameIndex:int;            private var _currentFramePosition:int;            private var _currentFrameDuration:int;            private var _pausePlayheadInFade:Boolean;            private var _isFadeOut:Boolean;            private var _fadeTotalWeight:Number;            private var _fadeWeight:Number;            private var _fadeCurrentTime:Number;            private var _fadeBeginTime:Number;            private var _name:String;            private var _clip:AnimationData;            private var _isComplete:Boolean;            private var _currentPlayTimes:int;            private var _totalTime:int;            private var _currentTime:int;            private var _lastTime:int;            private var _fadeState:int;            private var _fadeTotalTime:Number;            private var _timeScale:Number;            private var _playTimes:int;            public function AnimationState() { super(); }
            static function borrowObject() : AnimationState { return null; }
            static function returnObject(animationState:AnimationState) : void { }
            static function clear() : void { }
            private function clear() : void { }
            protected function resetTimelineStateList() : void { }
            public function containsBoneMask(boneName:String) : Boolean { return false; }
            public function addBoneMask(boneName:String, ifInvolveChildBones:Boolean = true) : AnimationState { return null; }
            public function removeBoneMask(boneName:String, ifInvolveChildBones:Boolean = true) : AnimationState { return null; }
            public function removeAllMixingTransform() : AnimationState { return null; }
            private function addBoneToBoneMask(boneName:String) : void { }
            private function removeBoneFromBoneMask(boneName:String) : void { }
            protected function updateTimelineStates() : void { }
            private function addTimelineState(timelineName:String) : void { }
            private function removeTimelineState(timelineState:TimelineState) : void { }
            private function addSlotTimelineState(timelineName:String) : void { }
            private function removeSlotTimelineState(timelineState:SlotTimelineState) : void { }
            public function play() : AnimationState { return null; }
            public function stop() : AnimationState { return null; }
            function fadeIn(armature:Armature, clip:AnimationData, fadeTotalTime:Number, timeScale:Number, playTimes:Number, pausePlayhead:Boolean) : AnimationState { return null; }
            public function fadeOut(fadeTotalTime:Number, pausePlayhead:Boolean) : AnimationState { return null; }
            protected function advanceTime(passedTime:Number) : Boolean { return false; }
            private function advanceFadeTime(passedTime:Number) : void { }
            private function advanceTimelinesTime(passedTime:Number) : void { }
            private function updateMainTimeline(isThisComplete:Boolean) : void { }
            private function hideBones() : void { }
            public function setAdditiveBlending(value:Boolean) : AnimationState { return null; }
            public function setAutoFadeOut(value:Boolean, fadeOutTime:Number = -1) : AnimationState { return null; }
            public function setWeight(value:Number) : AnimationState { return null; }
            public function setFrameTween(autoTween:Boolean, lastFrameAutoTween:Boolean) : AnimationState { return null; }
            public function setCurrentTime(value:Number) : AnimationState { return null; }
            public function setTimeScale(value:Number) : AnimationState { return null; }
            public function setPlayTimes(value:int) : AnimationState { return null; }
            public function get name() : String { return null; }
            public function get layer() : int { return 0; }
            public function get group() : String { return null; }
            public function get clip() : AnimationData { return null; }
            public function get isComplete() : Boolean { return false; }
            public function get isPlaying() : Boolean { return false; }
            public function get currentPlayTimes() : int { return 0; }
            public function get totalTime() : Number { return 0; }
            public function get currentTime() : Number { return 0; }
            public function get fadeWeight() : Number { return 0; }
            public function get fadeState() : int { return 0; }
            public function get fadeTotalTime() : Number { return 0; }
            public function get timeScale() : Number { return 0; }
            public function get playTimes() : int { return 0; }
   }}