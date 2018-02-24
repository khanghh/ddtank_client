package dragonBones.animation
{
   import dragonBones.Armature;
   import dragonBones.Bone;
   import dragonBones.Slot;
   import dragonBones.events.AnimationEvent;
   import dragonBones.objects.AnimationData;
   import dragonBones.objects.Frame;
   import dragonBones.objects.SlotTimeline;
   import dragonBones.objects.TransformTimeline;
   
   public final class AnimationState
   {
      
      private static var _pool:Vector.<AnimationState> = new Vector.<AnimationState>();
       
      
      public var displayControl:Boolean;
      
      public var additiveBlending:Boolean;
      
      public var autoFadeOut:Boolean;
      
      public var fadeOutTime:Number;
      
      public var weight:Number;
      
      public var autoTween:Boolean;
      
      public var lastFrameAutoTween:Boolean;
      
      var _layer:int;
      
      var _group:String;
      
      private var _armature:Armature;
      
      private var _timelineStateList:Vector.<TimelineState>;
      
      private var _slotTimelineStateList:Vector.<SlotTimelineState>;
      
      private var _boneMasks:Vector.<String>;
      
      private var _isPlaying:Boolean;
      
      private var _time:Number;
      
      private var _currentFrameIndex:int;
      
      private var _currentFramePosition:int;
      
      private var _currentFrameDuration:int;
      
      private var _pausePlayheadInFade:Boolean;
      
      private var _isFadeOut:Boolean;
      
      private var _fadeTotalWeight:Number;
      
      private var _fadeWeight:Number;
      
      private var _fadeCurrentTime:Number;
      
      private var _fadeBeginTime:Number;
      
      private var _name:String;
      
      private var _clip:AnimationData;
      
      private var _isComplete:Boolean;
      
      private var _currentPlayTimes:int;
      
      private var _totalTime:int;
      
      private var _currentTime:int;
      
      private var _lastTime:int;
      
      private var _fadeState:int;
      
      private var _fadeTotalTime:Number;
      
      private var _timeScale:Number;
      
      private var _playTimes:int;
      
      public function AnimationState(){super();}
      
      static function borrowObject() : AnimationState{return null;}
      
      static function returnObject(param1:AnimationState) : void{}
      
      static function clear() : void{}
      
      private function clear() : void{}
      
      function resetTimelineStateList() : void{}
      
      public function containsBoneMask(param1:String) : Boolean{return false;}
      
      public function addBoneMask(param1:String, param2:Boolean = true) : AnimationState{return null;}
      
      public function removeBoneMask(param1:String, param2:Boolean = true) : AnimationState{return null;}
      
      public function removeAllMixingTransform() : AnimationState{return null;}
      
      private function addBoneToBoneMask(param1:String) : void{}
      
      private function removeBoneFromBoneMask(param1:String) : void{}
      
      function updateTimelineStates() : void{}
      
      private function addTimelineState(param1:String) : void{}
      
      private function removeTimelineState(param1:TimelineState) : void{}
      
      private function addSlotTimelineState(param1:String) : void{}
      
      private function removeSlotTimelineState(param1:SlotTimelineState) : void{}
      
      public function play() : AnimationState{return null;}
      
      public function stop() : AnimationState{return null;}
      
      function fadeIn(param1:Armature, param2:AnimationData, param3:Number, param4:Number, param5:Number, param6:Boolean) : AnimationState{return null;}
      
      public function fadeOut(param1:Number, param2:Boolean) : AnimationState{return null;}
      
      function advanceTime(param1:Number) : Boolean{return false;}
      
      private function advanceFadeTime(param1:Number) : void{}
      
      private function advanceTimelinesTime(param1:Number) : void{}
      
      private function updateMainTimeline(param1:Boolean) : void{}
      
      private function hideBones() : void{}
      
      public function setAdditiveBlending(param1:Boolean) : AnimationState{return null;}
      
      public function setAutoFadeOut(param1:Boolean, param2:Number = -1) : AnimationState{return null;}
      
      public function setWeight(param1:Number) : AnimationState{return null;}
      
      public function setFrameTween(param1:Boolean, param2:Boolean) : AnimationState{return null;}
      
      public function setCurrentTime(param1:Number) : AnimationState{return null;}
      
      public function setTimeScale(param1:Number) : AnimationState{return null;}
      
      public function setPlayTimes(param1:int) : AnimationState{return null;}
      
      public function get name() : String{return null;}
      
      public function get layer() : int{return 0;}
      
      public function get group() : String{return null;}
      
      public function get clip() : AnimationData{return null;}
      
      public function get isComplete() : Boolean{return false;}
      
      public function get isPlaying() : Boolean{return false;}
      
      public function get currentPlayTimes() : int{return 0;}
      
      public function get totalTime() : Number{return 0;}
      
      public function get currentTime() : Number{return 0;}
      
      public function get fadeWeight() : Number{return 0;}
      
      public function get fadeState() : int{return 0;}
      
      public function get fadeTotalTime() : Number{return 0;}
      
      public function get timeScale() : Number{return 0;}
      
      public function get playTimes() : int{return 0;}
   }
}
