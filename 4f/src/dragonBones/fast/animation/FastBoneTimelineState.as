package dragonBones.fast.animation{   import dragonBones.fast.FastBone;   import dragonBones.objects.CurveData;   import dragonBones.objects.DBTransform;   import dragonBones.objects.Frame;   import dragonBones.objects.TransformFrame;   import dragonBones.objects.TransformTimeline;   import dragonBones.utils.MathUtil;   import dragonBones.utils.TransformUtil;   import flash.geom.Point;      public class FastBoneTimelineState   {            private static var _pool:Vector.<FastBoneTimelineState> = new Vector.<FastBoneTimelineState>();                   public var name:String;            private var _totalTime:int;            private var _currentTime:int;            private var _lastTime:int;            private var _currentFrameIndex:int;            private var _currentFramePosition:int;            private var _currentFrameDuration:int;            private var _bone:FastBone;            private var _timelineData:TransformTimeline;            private var _durationTransform:DBTransform;            private var _tweenTransform:Boolean;            private var _tweenEasing:Number;            private var _tweenCurve:CurveData;            private var _updateMode:int;            private var _transformToFadein:DBTransform;            var _animationState:FastAnimationState;            var _isComplete:Boolean;            var _transform:DBTransform;            public function FastBoneTimelineState() { super(); }
            static function borrowObject() : FastBoneTimelineState { return null; }
            static function returnObject(timeline:FastBoneTimelineState) : void { }
            static function clear() : void { }
            private function clear() : void { }
            protected function fadeIn(bone:FastBone, animationState:FastAnimationState, timelineData:TransformTimeline) : void { }
            protected function updateFade(progress:Number) : void { }
            protected function update(progress:Number) : void { }
            private function updateSingleFrame() : void { }
            private function updateMultipleFrame(progress:Number) : void { }
            private function updateToNextFrame(currentPlayTimes:int) : void { }
            private function updateTween() : void { }
   }}