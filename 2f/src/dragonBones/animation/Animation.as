package dragonBones.animation
{
   import dragonBones.Armature;
   import dragonBones.Slot;
   import dragonBones.objects.AnimationData;
   
   public class Animation
   {
      
      public static const NONE:String = "none";
      
      public static const SAME_LAYER:String = "sameLayer";
      
      public static const SAME_GROUP:String = "sameGroup";
      
      public static const SAME_LAYER_AND_GROUP:String = "sameLayerAndGroup";
      
      public static const ALL:String = "all";
       
      
      public var tweenEnabled:Boolean;
      
      private var _armature:Armature;
      
      private var _animationStateList:Vector.<AnimationState>;
      
      private var _animationDataList:Vector.<AnimationData>;
      
      private var _animationList:Vector.<String>;
      
      private var _isPlaying:Boolean;
      
      private var _timeScale:Number;
      
      var _lastAnimationState:AnimationState;
      
      var _isFading:Boolean;
      
      var _animationStateCount:int;
      
      public function Animation(param1:Armature){super();}
      
      public function dispose() : void{}
      
      function resetAnimationStateList() : void{}
      
      public function gotoAndPlay(param1:String, param2:Number = -1, param3:Number = -1, param4:Number = NaN, param5:int = 0, param6:String = null, param7:String = "sameLayerAndGroup", param8:Boolean = true, param9:Boolean = true) : AnimationState{return null;}
      
      public function gotoAndStop(param1:String, param2:Number, param3:Number = -1, param4:Number = 0, param5:Number = -1, param6:int = 0, param7:String = null, param8:String = "all") : AnimationState{return null;}
      
      public function play() : void{}
      
      public function stop() : void{}
      
      public function getState(param1:String, param2:int = 0) : AnimationState{return null;}
      
      public function hasAnimation(param1:String) : Boolean{return false;}
      
      function advanceTime(param1:Number) : void{}
      
      function updateAnimationStates() : void{}
      
      private function addState(param1:AnimationState) : void{}
      
      private function removeState(param1:AnimationState) : void{}
      
      public function get movementList() : Vector.<String>{return null;}
      
      public function get movementID() : String{return null;}
      
      public function get lastAnimationState() : AnimationState{return null;}
      
      public function get lastAnimationName() : String{return null;}
      
      public function get animationList() : Vector.<String>{return null;}
      
      public function get isPlaying() : Boolean{return false;}
      
      public function get isComplete() : Boolean{return false;}
      
      public function get timeScale() : Number{return 0;}
      
      public function set timeScale(param1:Number) : void{}
      
      public function get animationDataList() : Vector.<AnimationData>{return null;}
      
      public function set animationDataList(param1:Vector.<AnimationData>) : void{}
   }
}
