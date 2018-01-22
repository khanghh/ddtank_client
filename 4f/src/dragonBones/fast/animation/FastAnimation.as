package dragonBones.fast.animation
{
   import dragonBones.cache.AnimationCacheManager;
   import dragonBones.core.IArmature;
   import dragonBones.fast.FastArmature;
   import dragonBones.fast.FastSlot;
   import dragonBones.objects.AnimationData;
   
   public class FastAnimation
   {
       
      
      public var animationList:Vector.<String>;
      
      public var animationState:FastAnimationState;
      
      public var animationCacheManager:AnimationCacheManager;
      
      private var _armature:FastArmature;
      
      private var _animationDataList:Vector.<AnimationData>;
      
      private var _animationDataObj:Object;
      
      private var _isPlaying:Boolean;
      
      private var _timeScale:Number;
      
      public function FastAnimation(param1:FastArmature){super();}
      
      public function dispose() : void{}
      
      public function gotoAndPlay(param1:String, param2:Number = -1, param3:Number = -1, param4:Number = NaN) : FastAnimationState{return null;}
      
      public function gotoAndStop(param1:String, param2:Number, param3:Number = -1, param4:Number = 0, param5:Number = -1) : FastAnimationState{return null;}
      
      public function play() : void{}
      
      public function stop() : void{}
      
      function advanceTime(param1:Number) : void{}
      
      public function hasAnimation(param1:String) : Boolean{return false;}
      
      public function get timeScale() : Number{return 0;}
      
      public function set timeScale(param1:Number) : void{}
      
      public function get animationDataList() : Vector.<AnimationData>{return null;}
      
      public function set animationDataList(param1:Vector.<AnimationData>) : void{}
      
      public function get movementList() : Vector.<String>{return null;}
      
      public function get movementID() : String{return null;}
      
      public function get isPlaying() : Boolean{return false;}
      
      public function get isComplete() : Boolean{return false;}
      
      public function get lastAnimationState() : FastAnimationState{return null;}
      
      public function get lastAnimationName() : String{return null;}
   }
}
