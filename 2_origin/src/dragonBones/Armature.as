package dragonBones
{
   import dragonBones.animation.Animation;
   import dragonBones.animation.AnimationState;
   import dragonBones.animation.TimelineState;
   import dragonBones.core.IArmature;
   import dragonBones.§core:dragonBones_internal§._armatureData;
   import dragonBones.§core:dragonBones_internal§._eventList;
   import dragonBones.§core:dragonBones_internal§._skinLists;
   import dragonBones.§core:dragonBones_internal§._slotsZOrderChanged;
   import dragonBones.§core:dragonBones_internal§.updateAnimationAfterBoneListChanged;
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
      
      public function Armature(param1:Object)
      {
         super(this);
         _display = param1;
         _animation = new Animation(this);
         _slotsZOrderChanged = false;
         _slotList = new Vector.<Slot>();
         _slotList.fixed = true;
         _boneList = new Vector.<Bone>();
         _boneList.fixed = true;
         _eventList = new Vector.<Event>();
         _skinLists = {};
         _delayDispose = false;
         _lockDispose = false;
         _armatureData = null;
      }
      
      public function get armatureData() : ArmatureData
      {
         return _armatureData;
      }
      
      public function get display() : Object
      {
         return _display;
      }
      
      public function get animation() : Animation
      {
         return _animation;
      }
      
      public function dispose() : void
      {
         _delayDispose = true;
         if(!_animation || _lockDispose)
         {
            return;
         }
         userData = null;
         _animation.dispose();
         var _loc1_:int = _slotList.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            _slotList[_loc1_].dispose();
         }
         _loc1_ = _boneList.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            _boneList[_loc1_].dispose();
         }
         _slotList.fixed = false;
         _slotList.length = 0;
         _boneList.fixed = false;
         _boneList.length = 0;
         _eventList.length = 0;
         _armatureData = null;
         _animation = null;
         _slotList = null;
         _boneList = null;
         _eventList = null;
      }
      
      public function invalidUpdate(param1:String = null) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc2_ = getBone(param1);
            if(_loc2_)
            {
               _loc2_.invalidUpdate();
            }
         }
         else
         {
            _loc3_ = _boneList.length;
            while(true)
            {
               _loc3_--;
               if(!_loc3_)
               {
                  break;
               }
               _boneList[_loc3_].invalidUpdate();
            }
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         _lockDispose = true;
         _animation.advanceTime(param1);
         param1 = param1 * _animation.timeScale;
         var _loc4_:Boolean = _animation._isFading;
         var _loc7_:int = _boneList.length;
         while(true)
         {
            _loc7_--;
            if(!_loc7_)
            {
               break;
            }
            _loc3_ = _boneList[_loc7_];
            _loc3_.update(_loc4_);
         }
         _loc7_ = _slotList.length;
         while(true)
         {
            _loc7_--;
            if(!_loc7_)
            {
               break;
            }
            _loc6_ = _slotList[_loc7_];
            _loc6_.update();
            if(_loc6_._isShowDisplay)
            {
               _loc5_ = _loc6_.childArmature;
               if(_loc5_)
               {
                  _loc5_.advanceTime(param1);
               }
            }
         }
         if(_slotsZOrderChanged)
         {
            updateSlotsZOrder();
            if(this.hasEventListener("zOrderUpdated"))
            {
               this.dispatchEvent(new ArmatureEvent("zOrderUpdated"));
            }
         }
         if(_eventList.length)
         {
            var _loc9_:int = 0;
            var _loc8_:* = _eventList;
            for each(var _loc2_ in _eventList)
            {
               this.dispatchEvent(_loc2_);
            }
            _eventList.length = 0;
         }
         _lockDispose = false;
         if(_delayDispose)
         {
            dispose();
         }
      }
      
      public function resetAnimation() : void
      {
         animation.stop();
         animation.resetAnimationStateList();
         var _loc3_:int = 0;
         var _loc2_:* = _boneList;
         for each(var _loc1_ in _boneList)
         {
            _loc1_.removeAllStates();
         }
      }
      
      public function getSlots(param1:Boolean = true) : Vector.<Slot>
      {
         return !!param1?_slotList.concat():_slotList;
      }
      
      public function getSlot(param1:String) : Slot
      {
         var _loc4_:int = 0;
         var _loc3_:* = _slotList;
         for each(var _loc2_ in _slotList)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getSlotByDisplay(param1:Object) : Slot
      {
         if(param1)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _slotList;
            for each(var _loc2_ in _slotList)
            {
               if(_loc2_.display == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function addSlot(param1:Slot, param2:String) : void
      {
         var _loc3_:Bone = getBone(param2);
         if(_loc3_)
         {
            _loc3_.addSlot(param1);
            return;
         }
         throw new ArgumentError();
      }
      
      public function removeSlot(param1:Slot) : void
      {
         if(!param1 || param1.armature != this)
         {
            throw new ArgumentError();
         }
         param1.parent.removeSlot(param1);
      }
      
      public function removeSlotByName(param1:String) : Slot
      {
         var _loc2_:Slot = getSlot(param1);
         if(_loc2_)
         {
            removeSlot(_loc2_);
         }
         return _loc2_;
      }
      
      public function getBones(param1:Boolean = true) : Vector.<Bone>
      {
         return !!param1?_boneList.concat():_boneList;
      }
      
      public function getBone(param1:String) : Bone
      {
         var _loc4_:int = 0;
         var _loc3_:* = _boneList;
         for each(var _loc2_ in _boneList)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getBoneByDisplay(param1:Object) : Bone
      {
         var _loc2_:Slot = getSlotByDisplay(param1);
         return !!_loc2_?_loc2_.parent:null;
      }
      
      public function addBone(param1:Bone, param2:String = null, param3:Boolean = false) : void
      {
         var _loc4_:* = null;
         if(param2)
         {
            _loc4_ = getBone(param2);
            if(!_loc4_)
            {
               throw new ArgumentError();
            }
         }
         if(_loc4_)
         {
            _loc4_.addChildBone(param1,param3);
         }
         else
         {
            if(param1.parent)
            {
               param1.parent.removeChildBone(param1,param3);
            }
            param1.setArmature(this);
            if(!param3)
            {
               updateAnimationAfterBoneListChanged();
            }
         }
      }
      
      public function removeBone(param1:Bone, param2:Boolean = false) : void
      {
         if(!param1 || param1.armature != this)
         {
            throw new ArgumentError();
         }
         if(param1.parent)
         {
            param1.parent.removeChildBone(param1,param2);
         }
         else
         {
            param1.setArmature(null);
            if(!param2)
            {
               updateAnimationAfterBoneListChanged(false);
            }
         }
      }
      
      public function removeBoneByName(param1:String) : Bone
      {
         var _loc2_:Bone = getBone(param1);
         if(_loc2_)
         {
            removeBone(_loc2_);
         }
         return _loc2_;
      }
      
      function addBoneToBoneList(param1:Bone) : void
      {
         if(_boneList.indexOf(param1) < 0)
         {
            _boneList.fixed = false;
            _boneList[_boneList.length] = param1;
            _boneList.fixed = true;
         }
      }
      
      function removeBoneFromBoneList(param1:Bone) : void
      {
         var _loc2_:int = _boneList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            _boneList.fixed = false;
            _boneList.splice(_loc2_,1);
            _boneList.fixed = true;
         }
      }
      
      function addSlotToSlotList(param1:Slot) : void
      {
         if(_slotList.indexOf(param1) < 0)
         {
            _slotList.fixed = false;
            _slotList[_slotList.length] = param1;
            _slotList.fixed = true;
         }
      }
      
      function removeSlotFromSlotList(param1:Slot) : void
      {
         var _loc2_:int = _slotList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            _slotList.fixed = false;
            _slotList.splice(_loc2_,1);
            _slotList.fixed = true;
         }
      }
      
      public function updateSlotsZOrder() : void
      {
         var _loc1_:* = null;
         _slotList.fixed = false;
         _slotList.sort(sortSlot);
         _slotList.fixed = true;
         var _loc2_:int = _slotList.length;
         while(true)
         {
            _loc2_--;
            if(!_loc2_)
            {
               break;
            }
            _loc1_ = _slotList[_loc2_];
            if(_loc1_._isShowDisplay)
            {
               _loc1_.addDisplayToContainer(_display);
            }
         }
         _slotsZOrderChanged = false;
      }
      
      function updateAnimationAfterBoneListChanged(param1:Boolean = true) : void
      {
         if(param1)
         {
            sortBoneList();
         }
         _animation.updateAnimationStates();
      }
      
      private function sortBoneList() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc5_:int = _boneList.length;
         if(_loc5_ == 0)
         {
            return;
         }
         var _loc4_:Array = [];
         while(true)
         {
            _loc5_--;
            if(!_loc5_)
            {
               break;
            }
            _loc2_ = 0;
            _loc3_ = _boneList[_loc5_];
            _loc1_ = _loc3_;
            while(_loc1_)
            {
               _loc2_++;
               _loc1_ = _loc1_.parent;
            }
            _loc4_[_loc5_] = [_loc2_,_loc3_];
         }
         _loc4_.sortOn("0",16 | 2);
         _loc5_ = _loc4_.length;
         _boneList.fixed = false;
         while(true)
         {
            _loc5_--;
            if(!_loc5_)
            {
               break;
            }
            _boneList[_loc5_] = _loc4_[_loc5_][1];
         }
         _boneList.fixed = true;
         _loc4_.length = 0;
      }
      
      function arriveAtFrame(param1:Frame, param2:TimelineState, param3:AnimationState, param4:Boolean) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(param1.event && this.hasEventListener("animationFrameEvent"))
         {
            _loc5_ = new FrameEvent("animationFrameEvent");
            _loc5_.animationState = param3;
            _loc5_.frameLabel = param1.event;
            _eventList.push(_loc5_);
         }
         if(param1.sound && _soundManager.hasEventListener("sound"))
         {
            _loc6_ = new SoundEvent("sound");
            _loc6_.armature = this;
            _loc6_.animationState = param3;
            _loc6_.sound = param1.sound;
            _soundManager.dispatchEvent(_loc6_);
         }
         if(param1.action)
         {
            if(param3.displayControl)
            {
               animation.gotoAndPlay(param1.action);
            }
         }
      }
      
      private function sortSlot(param1:Slot, param2:Slot) : int
      {
         return param1.zOrder < param2.zOrder?1:-1;
      }
      
      public function addSkinList(param1:String, param2:Object) : void
      {
         if(!param1)
         {
            param1 = "default";
         }
         if(!_skinLists[param1])
         {
            _skinLists[param1] = param2;
         }
      }
      
      public function changeSkin(param1:String) : void
      {
         var _loc2_:* = null;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc8_:int = 0;
         var _loc6_:SkinData = armatureData.getSkinData(param1);
         if(!_loc6_ || !_skinLists[param1])
         {
            return;
         }
         armatureData.setSkinData(param1);
         var _loc4_:Array = [];
         var _loc5_:Vector.<SlotData> = armatureData.slotDataList;
         _loc8_ = 0;
         while(_loc8_ < _loc5_.length)
         {
            _loc2_ = _loc5_[_loc8_];
            _loc4_ = _skinLists[param1][_loc2_.name];
            _loc3_ = getBone(_loc2_.parent);
            if(!(!_loc3_ || !_loc4_))
            {
               _loc7_ = getSlot(_loc2_.name);
               _loc7_.initWithSlotData(_loc2_);
               _loc7_.displayList = _loc4_;
               _loc7_.changeDisplay(0);
            }
            _loc8_++;
         }
      }
      
      public function getAnimation() : Object
      {
         return _animation;
      }
   }
}
