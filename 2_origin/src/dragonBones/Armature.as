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
      
      public function Armature(display:Object)
      {
         super(this);
         _display = display;
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
         var i:int = _slotList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            _slotList[i].dispose();
         }
         i = _boneList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            _boneList[i].dispose();
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
      
      public function invalidUpdate(boneName:String = null) : void
      {
         var bone:* = null;
         var i:int = 0;
         if(boneName)
         {
            bone = getBone(boneName);
            if(bone)
            {
               bone.invalidUpdate();
            }
         }
         else
         {
            i = _boneList.length;
            while(true)
            {
               i--;
               if(!i)
               {
                  break;
               }
               _boneList[i].invalidUpdate();
            }
         }
      }
      
      public function advanceTime(passedTime:Number) : void
      {
         var bone:* = null;
         var slot:* = null;
         var childArmature:* = null;
         _lockDispose = true;
         _animation.advanceTime(passedTime);
         passedTime = passedTime * _animation.timeScale;
         var isFading:Boolean = _animation._isFading;
         var i:int = _boneList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            bone = _boneList[i];
            bone.update(isFading);
         }
         i = _slotList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            slot = _slotList[i];
            slot.update();
            if(slot._isShowDisplay)
            {
               childArmature = slot.childArmature;
               if(childArmature)
               {
                  childArmature.advanceTime(passedTime);
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
            for each(var event in _eventList)
            {
               this.dispatchEvent(event);
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
         for each(var boneItem in _boneList)
         {
            boneItem.removeAllStates();
         }
      }
      
      public function getSlots(returnCopy:Boolean = true) : Vector.<Slot>
      {
         return !!returnCopy?_slotList.concat():_slotList;
      }
      
      public function getSlot(slotName:String) : Slot
      {
         var _loc4_:int = 0;
         var _loc3_:* = _slotList;
         for each(var slot in _slotList)
         {
            if(slot.name == slotName)
            {
               return slot;
            }
         }
         return null;
      }
      
      public function getSlotByDisplay(displayObj:Object) : Slot
      {
         if(displayObj)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _slotList;
            for each(var slot in _slotList)
            {
               if(slot.display == displayObj)
               {
                  return slot;
               }
            }
         }
         return null;
      }
      
      public function addSlot(slot:Slot, boneName:String) : void
      {
         var bone:Bone = getBone(boneName);
         if(bone)
         {
            bone.addSlot(slot);
            return;
         }
         throw new ArgumentError();
      }
      
      public function removeSlot(slot:Slot) : void
      {
         if(!slot || slot.armature != this)
         {
            throw new ArgumentError();
         }
         slot.parent.removeSlot(slot);
      }
      
      public function removeSlotByName(slotName:String) : Slot
      {
         var slot:Slot = getSlot(slotName);
         if(slot)
         {
            removeSlot(slot);
         }
         return slot;
      }
      
      public function getBones(returnCopy:Boolean = true) : Vector.<Bone>
      {
         return !!returnCopy?_boneList.concat():_boneList;
      }
      
      public function getBone(boneName:String) : Bone
      {
         var _loc4_:int = 0;
         var _loc3_:* = _boneList;
         for each(var bone in _boneList)
         {
            if(bone.name == boneName)
            {
               return bone;
            }
         }
         return null;
      }
      
      public function getBoneByDisplay(display:Object) : Bone
      {
         var slot:Slot = getSlotByDisplay(display);
         return !!slot?slot.parent:null;
      }
      
      public function addBone(bone:Bone, parentName:String = null, updateLater:Boolean = false) : void
      {
         var parentBone:* = null;
         if(parentName)
         {
            parentBone = getBone(parentName);
            if(!parentBone)
            {
               throw new ArgumentError();
            }
         }
         if(parentBone)
         {
            parentBone.addChildBone(bone,updateLater);
         }
         else
         {
            if(bone.parent)
            {
               bone.parent.removeChildBone(bone,updateLater);
            }
            bone.setArmature(this);
            if(!updateLater)
            {
               updateAnimationAfterBoneListChanged();
            }
         }
      }
      
      public function removeBone(bone:Bone, updateLater:Boolean = false) : void
      {
         if(!bone || bone.armature != this)
         {
            throw new ArgumentError();
         }
         if(bone.parent)
         {
            bone.parent.removeChildBone(bone,updateLater);
         }
         else
         {
            bone.setArmature(null);
            if(!updateLater)
            {
               updateAnimationAfterBoneListChanged(false);
            }
         }
      }
      
      public function removeBoneByName(boneName:String) : Bone
      {
         var bone:Bone = getBone(boneName);
         if(bone)
         {
            removeBone(bone);
         }
         return bone;
      }
      
      function addBoneToBoneList(bone:Bone) : void
      {
         if(_boneList.indexOf(bone) < 0)
         {
            _boneList.fixed = false;
            _boneList[_boneList.length] = bone;
            _boneList.fixed = true;
         }
      }
      
      function removeBoneFromBoneList(bone:Bone) : void
      {
         var index:int = _boneList.indexOf(bone);
         if(index >= 0)
         {
            _boneList.fixed = false;
            _boneList.splice(index,1);
            _boneList.fixed = true;
         }
      }
      
      function addSlotToSlotList(slot:Slot) : void
      {
         if(_slotList.indexOf(slot) < 0)
         {
            _slotList.fixed = false;
            _slotList[_slotList.length] = slot;
            _slotList.fixed = true;
         }
      }
      
      function removeSlotFromSlotList(slot:Slot) : void
      {
         var index:int = _slotList.indexOf(slot);
         if(index >= 0)
         {
            _slotList.fixed = false;
            _slotList.splice(index,1);
            _slotList.fixed = true;
         }
      }
      
      public function updateSlotsZOrder() : void
      {
         var slot:* = null;
         _slotList.fixed = false;
         _slotList.sort(sortSlot);
         _slotList.fixed = true;
         var i:int = _slotList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            slot = _slotList[i];
            if(slot._isShowDisplay)
            {
               slot.addDisplayToContainer(_display);
            }
         }
         _slotsZOrderChanged = false;
      }
      
      function updateAnimationAfterBoneListChanged(ifNeedSortBoneList:Boolean = true) : void
      {
         if(ifNeedSortBoneList)
         {
            sortBoneList();
         }
         _animation.updateAnimationStates();
      }
      
      private function sortBoneList() : void
      {
         var level:int = 0;
         var bone:* = null;
         var boneParent:* = null;
         var i:int = _boneList.length;
         if(i == 0)
         {
            return;
         }
         var helpArray:Array = [];
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            level = 0;
            bone = _boneList[i];
            boneParent = bone;
            while(boneParent)
            {
               level++;
               boneParent = boneParent.parent;
            }
            helpArray[i] = [level,bone];
         }
         helpArray.sortOn("0",16 | 2);
         i = helpArray.length;
         _boneList.fixed = false;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            _boneList[i] = helpArray[i][1];
         }
         _boneList.fixed = true;
         helpArray.length = 0;
      }
      
      function arriveAtFrame(frame:Frame, timelineState:TimelineState, animationState:AnimationState, isCross:Boolean) : void
      {
         var frameEvent:* = null;
         var soundEvent:* = null;
         if(frame.event && this.hasEventListener("animationFrameEvent"))
         {
            frameEvent = new FrameEvent("animationFrameEvent");
            frameEvent.animationState = animationState;
            frameEvent.frameLabel = frame.event;
            _eventList.push(frameEvent);
         }
         if(frame.sound && _soundManager.hasEventListener("sound"))
         {
            soundEvent = new SoundEvent("sound");
            soundEvent.armature = this;
            soundEvent.animationState = animationState;
            soundEvent.sound = frame.sound;
            _soundManager.dispatchEvent(soundEvent);
         }
         if(frame.action)
         {
            if(animationState.displayControl)
            {
               animation.gotoAndPlay(frame.action);
            }
         }
      }
      
      private function sortSlot(slot1:Slot, slot2:Slot) : int
      {
         return slot1.zOrder < slot2.zOrder?1:-1;
      }
      
      public function addSkinList(skinName:String, list:Object) : void
      {
         if(!skinName)
         {
            skinName = "default";
         }
         if(!_skinLists[skinName])
         {
            _skinLists[skinName] = list;
         }
      }
      
      public function changeSkin(skinName:String) : void
      {
         var slotData:* = null;
         var slot:* = null;
         var bone:* = null;
         var i:int = 0;
         var skinData:SkinData = armatureData.getSkinData(skinName);
         if(!skinData || !_skinLists[skinName])
         {
            return;
         }
         armatureData.setSkinData(skinName);
         var displayList:Array = [];
         var slotDataList:Vector.<SlotData> = armatureData.slotDataList;
         for(i = 0; i < slotDataList.length; )
         {
            slotData = slotDataList[i];
            displayList = _skinLists[skinName][slotData.name];
            bone = getBone(slotData.parent);
            if(!(!bone || !displayList))
            {
               slot = getSlot(slotData.name);
               slot.initWithSlotData(slotData);
               slot.displayList = displayList;
               slot.changeDisplay(0);
            }
            i++;
         }
      }
      
      public function getAnimation() : Object
      {
         return _animation;
      }
   }
}
