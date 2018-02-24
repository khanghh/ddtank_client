package dragonBones.fast
{
   import dragonBones.cache.AnimationCacheManager;
   import dragonBones.cache.SlotFrameCache;
   import dragonBones.core.IArmature;
   import dragonBones.core.ICacheableArmature;
   import dragonBones.events.FrameEvent;
   import dragonBones.fast.animation.FastAnimation;
   import dragonBones.fast.animation.FastAnimationState;
   import dragonBones.objects.ArmatureData;
   import dragonBones.objects.DragonBonesData;
   import dragonBones.objects.Frame;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   [Event(name="complete",type="dragonBones.events.AnimationEvent")]
   [Event(name="loopComplete",type="dragonBones.events.AnimationEvent")]
   [Event(name="animationFrameEvent",type="dragonBones.events.FrameEvent")]
   [Event(name="boneFrameEvent",type="dragonBones.events.FrameEvent")]
   public class FastArmature extends EventDispatcher implements ICacheableArmature
   {
       
      
      public var name:String;
      
      public var userData:Object;
      
      private var _enableCache:Boolean;
      
      public var isCacheManagerExclusive:Boolean = false;
      
      protected var _animation:FastAnimation;
      
      protected var _display:Object;
      
      public var boneList:Vector.<FastBone>;
      
      var _boneDic:Object;
      
      public var slotList:Vector.<FastSlot>;
      
      var _slotDic:Object;
      
      public var slotHasChildArmatureList:Vector.<FastSlot>;
      
      protected var _enableEventDispatch:Boolean = true;
      
      var __dragonBonesData:DragonBonesData;
      
      var _armatureData:ArmatureData;
      
      var _slotsZOrderChanged:Boolean;
      
      private var _eventList:Array;
      
      private var _delayDispose:Boolean;
      
      private var _lockDispose:Boolean;
      
      private var useCache:Boolean = true;
      
      public function FastArmature(param1:Object){super(null);}
      
      public function dispose() : void{}
      
      public function advanceTime(param1:Number) : void{}
      
      public function enableAnimationCache(param1:int, param2:Array = null, param3:Boolean = true) : AnimationCacheManager{return null;}
      
      public function getBone(param1:String) : FastBone{return null;}
      
      public function getSlot(param1:String) : FastSlot{return null;}
      
      public function getBoneByDisplay(param1:Object) : FastBone{return null;}
      
      public function getSlotByDisplay(param1:Object) : FastSlot{return null;}
      
      public function getSlots(param1:Boolean = true) : Vector.<FastSlot>{return null;}
      
      function _updateBonesByCache() : void{}
      
      function addBone(param1:FastBone, param2:String = null) : void{}
      
      function addSlot(param1:FastSlot, param2:String) : void{}
      
      function updateSlotsZOrder() : void{}
      
      private function sortBoneList() : void{}
      
      function arriveAtFrame(param1:Frame, param2:FastAnimationState) : void{}
      
      public function invalidUpdate(param1:String = null) : void{}
      
      public function resetAnimation() : void{}
      
      private function sortSlot(param1:FastSlot, param2:FastSlot) : int{return 0;}
      
      public function getAnimation() : Object{return null;}
      
      public function get armatureData() : ArmatureData{return null;}
      
      public function get animation() : FastAnimation{return null;}
      
      public function get display() : Object{return null;}
      
      public function get enableCache() : Boolean{return false;}
      
      public function set enableCache(param1:Boolean) : void{}
      
      public function get enableEventDispatch() : Boolean{return false;}
      
      public function set enableEventDispatch(param1:Boolean) : void{}
      
      public function getSlotDic() : Object{return null;}
      
      function addEvent(param1:Event) : void{}
   }
}
