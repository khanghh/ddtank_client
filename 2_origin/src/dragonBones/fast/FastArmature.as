package dragonBones.fast
{
   import dragonBones.cache.AnimationCacheManager;
   import dragonBones.cache.SlotFrameCache;
   import dragonBones.core.IArmature;
   import dragonBones.core.ICacheableArmature;
   import dragonBones.§core:dragonBones_internal§._armatureData;
   import dragonBones.§core:dragonBones_internal§._boneDic;
   import dragonBones.§core:dragonBones_internal§._slotDic;
   import dragonBones.§core:dragonBones_internal§._slotsZOrderChanged;
   import dragonBones.§core:dragonBones_internal§.addEvent;
   import dragonBones.§core:dragonBones_internal§.updateSlotsZOrder;
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
      
      public function FastArmature(display:Object)
      {
         super(this);
         _display = display;
         _animation = new FastAnimation(this);
         _slotsZOrderChanged = false;
         _armatureData = null;
         boneList = new Vector.<FastBone>();
         _boneDic = {};
         slotList = new Vector.<FastSlot>();
         _slotDic = {};
         slotHasChildArmatureList = new Vector.<FastSlot>();
         _eventList = [];
         _delayDispose = false;
         _lockDispose = false;
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
         var i:int = slotList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            slotList[i].dispose();
         }
         i = boneList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            boneList[i].dispose();
         }
         slotList.fixed = false;
         slotList.length = 0;
         boneList.fixed = false;
         boneList.length = 0;
         _armatureData = null;
         _animation = null;
         slotList = null;
         boneList = null;
         _eventList = null;
      }
      
      public function advanceTime(passedTime:Number) : void
      {
         var bone:* = null;
         var slot:* = null;
         var i:int = 0;
         var childArmature:* = null;
         _lockDispose = true;
         _animation.advanceTime(passedTime);
         if(_animation.animationState.isUseCache())
         {
            if(!useCache)
            {
               useCache = true;
            }
            i = slotList.length;
            while(true)
            {
               i--;
               if(!i)
               {
                  break;
               }
               slot = slotList[i];
               slot.updateByCache();
            }
         }
         else
         {
            if(useCache)
            {
               useCache = false;
               i = slotList.length;
               while(true)
               {
                  i--;
                  if(!i)
                  {
                     break;
                  }
                  slot = slotList[i];
                  slot.switchTransformToBackup();
               }
            }
            i = boneList.length;
            while(true)
            {
               i--;
               if(!i)
               {
                  break;
               }
               bone = boneList[i];
               bone.update();
            }
            i = slotList.length;
            while(true)
            {
               i--;
               if(!i)
               {
                  break;
               }
               slot = slotList[i];
               slot.update();
            }
         }
         i = slotHasChildArmatureList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            slot = slotHasChildArmatureList[i];
            childArmature = slot.childArmature as IArmature;
            if(childArmature)
            {
               childArmature.advanceTime(passedTime);
            }
         }
         if(_slotsZOrderChanged)
         {
            updateSlotsZOrder();
         }
         while(_eventList.length > 0)
         {
            this.dispatchEvent(_eventList.shift());
         }
         _lockDispose = false;
         if(_delayDispose)
         {
            dispose();
         }
      }
      
      public function enableAnimationCache(frameRate:int, animationList:Array = null, loop:Boolean = true) : AnimationCacheManager
      {
         var animationCacheManager:AnimationCacheManager = AnimationCacheManager.initWithArmatureData(armatureData,frameRate);
         if(animationList)
         {
            var _loc7_:int = 0;
            var _loc6_:* = animationList;
            for each(var animationName in animationList)
            {
               animationCacheManager.initAnimationCache(animationName);
            }
         }
         else
         {
            animationCacheManager.initAllAnimationCache();
         }
         animationCacheManager.setCacheGeneratorArmature(this);
         animationCacheManager.generateAllAnimationCache(loop);
         animationCacheManager.bindCacheUserArmature(this);
         enableCache = true;
         return animationCacheManager;
      }
      
      public function getBone(boneName:String) : FastBone
      {
         return _boneDic[boneName];
      }
      
      public function getSlot(slotName:String) : FastSlot
      {
         return _slotDic[slotName];
      }
      
      public function getBoneByDisplay(display:Object) : FastBone
      {
         var slot:FastSlot = getSlotByDisplay(display);
         return !!slot?slot.parent:null;
      }
      
      public function getSlotByDisplay(displayObj:Object) : FastSlot
      {
         if(displayObj)
         {
            var _loc4_:int = 0;
            var _loc3_:* = slotList;
            for each(var slot in slotList)
            {
               if(slot.display == displayObj)
               {
                  return slot;
               }
            }
         }
         return null;
      }
      
      public function getSlots(returnCopy:Boolean = true) : Vector.<FastSlot>
      {
         return !!returnCopy?slotList.concat():slotList;
      }
      
      function _updateBonesByCache() : void
      {
         var bone:* = null;
         var i:int = boneList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            bone = boneList[i];
            bone.update();
         }
      }
      
      function addBone(bone:FastBone, parentName:String = null) : void
      {
         var parentBone:* = null;
         if(parentName)
         {
            parentBone = getBone(parentName);
            parentBone.boneList.push(bone);
         }
         bone.armature = this;
         bone.setParent(parentBone);
         boneList.unshift(bone);
         _boneDic[bone.name] = bone;
      }
      
      function addSlot(slot:FastSlot, parentBoneName:String) : void
      {
         var bone:FastBone = getBone(parentBoneName);
         if(bone)
         {
            slot.armature = this;
            slot.setParent(bone);
            bone.slotList.push(slot);
            slot.addDisplayToContainer(display);
            slotList.push(slot);
            _slotDic[slot.name] = slot;
            if(slot.hasChildArmature)
            {
               slotHasChildArmatureList.push(slot);
            }
            return;
         }
         throw new ArgumentError();
      }
      
      function updateSlotsZOrder() : void
      {
         var slot:* = null;
         slotList.fixed = false;
         slotList.sort(sortSlot);
         slotList.fixed = true;
         var i:int = slotList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            slot = slotList[i];
            if(slot._frameCache && (slot._frameCache as SlotFrameCache).displayIndex >= 0 || !slot._frameCache && slot.displayIndex >= 0)
            {
               slot.addDisplayToContainer(_display);
            }
         }
         _slotsZOrderChanged = false;
      }
      
      private function sortBoneList() : void
      {
         var level:int = 0;
         var bone:* = null;
         var boneParent:* = null;
         var i:int = boneList.length;
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
            bone = boneList[i];
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
         boneList.fixed = false;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            boneList[i] = helpArray[i][1];
         }
         boneList.fixed = true;
         helpArray.length = 0;
      }
      
      function arriveAtFrame(frame:Frame, animationState:FastAnimationState) : void
      {
         var frameEvent:* = null;
         if(frame.event && this.hasEventListener("animationFrameEvent"))
         {
            frameEvent = new FrameEvent("animationFrameEvent");
            frameEvent.animationState = animationState;
            frameEvent.frameLabel = frame.event;
            addEvent(frameEvent);
         }
         if(frame.action)
         {
            animation.gotoAndPlay(frame.action);
         }
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
            i = boneList.length;
            while(true)
            {
               i--;
               if(!i)
               {
                  break;
               }
               boneList[i].invalidUpdate();
            }
         }
      }
      
      public function resetAnimation() : void
      {
         animation.animationState.resetTimelineStateList();
         var _loc3_:int = 0;
         var _loc2_:* = boneList;
         for each(var boneItem in boneList)
         {
            boneItem._timelineState = null;
         }
         animation.stop();
      }
      
      private function sortSlot(slot1:FastSlot, slot2:FastSlot) : int
      {
         return slot1.zOrder < slot2.zOrder?1:-1;
      }
      
      public function getAnimation() : Object
      {
         return _animation;
      }
      
      public function get armatureData() : ArmatureData
      {
         return _armatureData;
      }
      
      public function get animation() : FastAnimation
      {
         return _animation;
      }
      
      public function get display() : Object
      {
         return _display;
      }
      
      public function get enableCache() : Boolean
      {
         return _enableCache;
      }
      
      public function set enableCache(value:Boolean) : void
      {
         _enableCache = value;
      }
      
      public function get enableEventDispatch() : Boolean
      {
         return _enableEventDispatch;
      }
      
      public function set enableEventDispatch(value:Boolean) : void
      {
         _enableEventDispatch = value;
      }
      
      public function getSlotDic() : Object
      {
         return _slotDic;
      }
      
      function addEvent(event:Event) : void
      {
         if(_enableEventDispatch)
         {
            _eventList.push(event);
         }
      }
   }
}
