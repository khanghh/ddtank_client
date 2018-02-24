package dragonBones.fast.animation
{
   import dragonBones.cache.AnimationCache;
   import dragonBones.core.IAnimationState;
   import dragonBones.events.AnimationEvent;
   import dragonBones.fast.FastArmature;
   import dragonBones.fast.FastBone;
   import dragonBones.fast.FastSlot;
   import dragonBones.objects.AnimationData;
   import dragonBones.objects.Frame;
   import dragonBones.objects.SlotTimeline;
   import dragonBones.objects.TransformTimeline;
   
   public class FastAnimationState implements IAnimationState
   {
       
      
      public var animationCache:AnimationCache;
      
      public var autoTween:Boolean;
      
      private var _progress:Number;
      
      var _armature:FastArmature;
      
      private var _boneTimelineStateList:Vector.<FastBoneTimelineState>;
      
      private var _slotTimelineStateList:Vector.<FastSlotTimelineState>;
      
      public var animationData:AnimationData;
      
      public var name:String;
      
      private var _time:Number;
      
      private var _currentFrameIndex:int;
      
      private var _currentFramePosition:int;
      
      private var _currentFrameDuration:int;
      
      private var _currentPlayTimes:int;
      
      private var _totalTime:int;
      
      private var _currentTime:int;
      
      private var _lastTime:int;
      
      private var _isComplete:Boolean;
      
      private var _isPlaying:Boolean;
      
      private var _timeScale:Number;
      
      private var _playTimes:int;
      
      private var _fading:Boolean = false;
      
      private var _listenCompleteEvent:Boolean;
      
      private var _listenLoopCompleteEvent:Boolean;
      
      var _fadeTotalTime:Number;
      
      public function FastAnimationState(){super();}
      
      public function dispose() : void{}
      
      public function play() : FastAnimationState{return null;}
      
      public function stop() : FastAnimationState{return null;}
      
      public function setCurrentTime(param1:Number) : FastAnimationState{return null;}
      
      function resetTimelineStateList() : void{}
      
      function fadeIn(param1:AnimationData, param2:Number, param3:Number, param4:Number) : void{}
      
      function updateTimelineStateList() : void{}
      
      function advanceTime(param1:Number) : void{}
      
      private function advanceTimelinesTime(param1:Number) : void{}
      
      private function updateTransformTimeline(param1:Number) : void{}
      
      private function updateMainTimeline(param1:Boolean) : void{}
      
      private function hideBones() : void{}
      
      public function setTimeScale(param1:Number) : FastAnimationState{return null;}
      
      public function setPlayTimes(param1:int) : FastAnimationState{return null;}
      
      public function get playTimes() : int{return 0;}
      
      public function get currentPlayTimes() : int{return 0;}
      
      public function get isComplete() : Boolean{return false;}
      
      public function get isPlaying() : Boolean{return false;}
      
      public function get totalTime() : Number{return 0;}
      
      public function get currentTime() : Number{return 0;}
      
      public function isUseCache() : Boolean{return false;}
      
      public function get progress() : Number{return 0;}
   }
}
