package dragonBones.fast.animation
{
   import dragonBones.fast.FastArmature;
   import dragonBones.fast.FastSlot;
   import dragonBones.objects.CurveData;
   import dragonBones.objects.Frame;
   import dragonBones.objects.SlotFrame;
   import dragonBones.objects.SlotTimeline;
   import dragonBones.utils.ColorTransformUtil;
   import dragonBones.utils.MathUtil;
   import flash.geom.ColorTransform;
   
   public final class FastSlotTimelineState
   {
      
      private static const HALF_PI:Number = 1.5707963267948966;
      
      private static const DOUBLE_PI:Number = 6.283185307179586;
      
      private static var _pool:Vector.<FastSlotTimelineState> = new Vector.<FastSlotTimelineState>();
       
      
      public var name:String;
      
      var _weight:Number;
      
      var _blendEnabled:Boolean;
      
      var _isComplete:Boolean;
      
      var _animationState:FastAnimationState;
      
      private var _totalTime:int;
      
      private var _currentTime:int;
      
      private var _currentFrameIndex:int;
      
      private var _currentFramePosition:int;
      
      private var _currentFrameDuration:int;
      
      private var _tweenEasing:Number;
      
      private var _tweenCurve:CurveData;
      
      private var _tweenColor:Boolean;
      
      private var _colorChanged:Boolean;
      
      private var _updateMode:int;
      
      private var _armature:FastArmature;
      
      private var _animation:FastAnimation;
      
      private var _slot:FastSlot;
      
      private var _timelineData:SlotTimeline;
      
      private var _durationColor:ColorTransform;
      
      public function FastSlotTimelineState(){super();}
      
      static function borrowObject() : FastSlotTimelineState{return null;}
      
      static function returnObject(param1:FastSlotTimelineState) : void{}
      
      static function clear() : void{}
      
      private function clear() : void{}
      
      function fadeIn(param1:FastSlot, param2:FastAnimationState, param3:SlotTimeline) : void{}
      
      function updateFade(param1:Number) : void{}
      
      function update(param1:Number) : void{}
      
      private function updateMultipleFrame(param1:Number) : void{}
      
      private function updateToNextFrame(param1:int) : void{}
      
      private function updateTween() : void{}
      
      private function updateSingleFrame() : void{}
   }
}
