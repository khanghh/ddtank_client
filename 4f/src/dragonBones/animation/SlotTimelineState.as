package dragonBones.animation
{
   import dragonBones.Armature;
   import dragonBones.Slot;
   import dragonBones.objects.CurveData;
   import dragonBones.objects.Frame;
   import dragonBones.objects.SlotFrame;
   import dragonBones.objects.SlotTimeline;
   import dragonBones.utils.MathUtil;
   import flash.geom.ColorTransform;
   
   public final class SlotTimelineState
   {
      
      private static const HALF_PI:Number = 1.5707963267948966;
      
      private static const DOUBLE_PI:Number = 6.283185307179586;
      
      private static var _pool:Vector.<SlotTimelineState> = new Vector.<SlotTimelineState>();
       
      
      public var name:String;
      
      var _weight:Number;
      
      var _blendEnabled:Boolean;
      
      var _isComplete:Boolean;
      
      var _animationState:AnimationState;
      
      private var _totalTime:int;
      
      private var _currentTime:int;
      
      private var _currentFrameIndex:int;
      
      private var _currentFramePosition:int;
      
      private var _currentFrameDuration:int;
      
      private var _tweenEasing:Number;
      
      private var _tweenCurve:CurveData;
      
      private var _tweenColor:Boolean;
      
      private var _rawAnimationScale:Number;
      
      private var _updateMode:int;
      
      private var _armature:Armature;
      
      private var _animation:Animation;
      
      private var _slot:Slot;
      
      private var _timelineData:SlotTimeline;
      
      private var _durationColor:ColorTransform;
      
      public function SlotTimelineState(){super();}
      
      static function borrowObject() : SlotTimelineState{return null;}
      
      static function returnObject(param1:SlotTimelineState) : void{}
      
      static function clear() : void{}
      
      private function clear() : void{}
      
      function fadeIn(param1:Slot, param2:AnimationState, param3:SlotTimeline) : void{}
      
      function update(param1:Number) : void{}
      
      private function updateMultipleFrame(param1:Number) : void{}
      
      private function updateToNextFrame(param1:int) : void{}
      
      private function updateTween() : void{}
      
      private function updateSingleFrame() : void{}
   }
}
