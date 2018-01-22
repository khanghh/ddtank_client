package dragonBones
{
   import dragonBones.animation.Animation;
   import dragonBones.animation.AnimationState;
   import dragonBones.animation.TimelineState;
   import dragonBones.core.IArmature;
   import dragonBones.events.ArmatureEvent;
   import dragonBones.events.FrameEvent;
   import dragonBones.events.SoundEvent;
   import dragonBones.events.SoundEventManager;
   import dragonBones.objects.ArmatureData;
   import dragonBones.objects.DragonBonesData;
   import dragonBones.objects.Frame;
   import dragonBones.objects.SkinData;
   import dragonBones.objects.SlotData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   [Event(name="zOrderUpdated",type="dragonBones.events.ArmatureEvent")]
   [Event(name="fadeIn",type="dragonBones.events.AnimationEvent")]
   [Event(name="fadeOut",type="dragonBones.events.AnimationEvent")]
   [Event(name="start",type="dragonBones.events.AnimationEvent")]
   [Event(name="complete",type="dragonBones.events.AnimationEvent")]
   [Event(name="loopComplete",type="dragonBones.events.AnimationEvent")]
   [Event(name="fadeInComplete",type="dragonBones.events.AnimationEvent")]
   [Event(name="fadeOutComplete",type="dragonBones.events.AnimationEvent")]
   [Event(name="animationFrameEvent",type="dragonBones.events.FrameEvent")]
   [Event(name="boneFrameEvent",type="dragonBones.events.FrameEvent")]
   public class Armature extends EventDispatcher implements IArmature
   {
      
      private static const _soundManager:SoundEventManager = SoundEventManager.getInstance();
       
      
      var __dragonBonesData:DragonBonesData;
      
      public var name:String;
      
      public var userData:Object;
      
      var _slotsZOrderChanged:Boolean;
      
      var _eventList:Vector.<Event>;
      
      protected var _slotList:Vector.<Slot>;
      
      protected var _boneList:Vector.<Bone>;
      
      private var _delayDispose:Boolean;
      
      private var _lockDispose:Boolean;
      
      var _armatureData:ArmatureData;
      
      protected var _display:Object;
      
      protected var _animation:Animation;
      
      var _skinLists:Object;
      
      public function Armature(param1:Object){super(null);}
      
      public function get armatureData() : ArmatureData{return null;}
      
      public function get display() : Object{return null;}
      
      public function get animation() : Animation{return null;}
      
      public function dispose() : void{}
      
      public function invalidUpdate(param1:String = null) : void{}
      
      public function advanceTime(param1:Number) : void{}
      
      public function resetAnimation() : void{}
      
      public function getSlots(param1:Boolean = true) : Vector.<Slot>{return null;}
      
      public function getSlot(param1:String) : Slot{return null;}
      
      public function getSlotByDisplay(param1:Object) : Slot{return null;}
      
      public function addSlot(param1:Slot, param2:String) : void{}
      
      public function removeSlot(param1:Slot) : void{}
      
      public function removeSlotByName(param1:String) : Slot{return null;}
      
      public function getBones(param1:Boolean = true) : Vector.<Bone>{return null;}
      
      public function getBone(param1:String) : Bone{return null;}
      
      public function getBoneByDisplay(param1:Object) : Bone{return null;}
      
      public function addBone(param1:Bone, param2:String = null, param3:Boolean = false) : void{}
      
      public function removeBone(param1:Bone, param2:Boolean = false) : void{}
      
      public function removeBoneByName(param1:String) : Bone{return null;}
      
      function addBoneToBoneList(param1:Bone) : void{}
      
      function removeBoneFromBoneList(param1:Bone) : void{}
      
      function addSlotToSlotList(param1:Slot) : void{}
      
      function removeSlotFromSlotList(param1:Slot) : void{}
      
      public function updateSlotsZOrder() : void{}
      
      function updateAnimationAfterBoneListChanged(param1:Boolean = true) : void{}
      
      private function sortBoneList() : void{}
      
      function arriveAtFrame(param1:Frame, param2:TimelineState, param3:AnimationState, param4:Boolean) : void{}
      
      private function sortSlot(param1:Slot, param2:Slot) : int{return 0;}
      
      public function addSkinList(param1:String, param2:Object) : void{}
      
      public function changeSkin(param1:String) : void{}
      
      public function getAnimation() : Object{return null;}
   }
}
