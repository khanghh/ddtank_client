package dragonBones.animation
{
   import dragonBones.Armature;
   import dragonBones.Bone;
   import dragonBones.objects.CurveData;
   import dragonBones.objects.DBTransform;
   import dragonBones.objects.Frame;
   import dragonBones.objects.TransformFrame;
   import dragonBones.objects.TransformTimeline;
   import dragonBones.utils.MathUtil;
   import dragonBones.utils.TransformUtil;
   import flash.geom.Point;
   
   public final class TimelineState
   {
      
      private static const HALF_PI:Number = 1.5707963267948966;
      
      private static const DOUBLE_PI:Number = 6.283185307179586;
      
      private static var _pool:Vector.<TimelineState> = new Vector.<TimelineState>();
       
      
      public var name:String;
      
      var _weight:Number;
      
      var _transform:DBTransform;
      
      var _pivot:Point;
      
      var _blendEnabled:Boolean;
      
      var _isComplete:Boolean;
      
      var _animationState:AnimationState;
      
      private var _totalTime:int;
      
      private var _currentTime:int;
      
      private var _lastTime:int;
      
      private var _currentFrameIndex:int;
      
      private var _currentFramePosition:int;
      
      private var _currentFrameDuration:int;
      
      private var _tweenEasing:Number;
      
      private var _tweenCurve:CurveData;
      
      private var _tweenTransform:Boolean;
      
      private var _tweenScale:Boolean;
      
      private var _rawAnimationScale:Number;
      
      private var _updateMode:int;
      
      private var _armature:Armature;
      
      private var _animation:Animation;
      
      private var _bone:Bone;
      
      private var _timelineData:TransformTimeline;
      
      private var _originTransform:DBTransform;
      
      private var _originPivot:Point;
      
      private var _durationTransform:DBTransform;
      
      private var _durationPivot:Point;
      
      public function TimelineState(){super();}
      
      static function borrowObject() : TimelineState{return null;}
      
      static function returnObject(param1:TimelineState) : void{}
      
      static function clear() : void{}
      
      private function clear() : void{}
      
      function fadeIn(param1:Bone, param2:AnimationState, param3:TransformTimeline) : void{}
      
      function fadeOut() : void{}
      
      function update(param1:Number) : void{}
      
      private function updateMultipleFrame(param1:Number) : void{}
      
      private function updateToNextFrame(param1:int) : void{}
      
      private function updateTween() : void{}
      
      private function updateSingleFrame() : void{}
   }
}
