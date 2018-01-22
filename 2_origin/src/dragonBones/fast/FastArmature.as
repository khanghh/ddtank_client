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
      
      public function FastArmature(param1:Object)
      {
         super(this);
         _display = param1;
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
         var _loc1_:int = slotList.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            slotList[_loc1_].dispose();
         }
         _loc1_ = boneList.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            boneList[_loc1_].dispose();
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
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         _lockDispose = true;
         _animation.advanceTime(param1);
         if(_animation.animationState.isUseCache())
         {
            if(!useCache)
            {
               useCache = true;
            }
            _loc5_ = slotList.length;
            while(true)
            {
               _loc5_--;
               if(!_loc5_)
               {
                  break;
               }
               _loc4_ = slotList[_loc5_];
               _loc4_.updateByCache();
            }
         }
         else
         {
            if(useCache)
            {
               useCache = false;
               _loc5_ = slotList.length;
               while(true)
               {
                  _loc5_--;
                  if(!_loc5_)
                  {
                     break;
                  }
                  _loc4_ = slotList[_loc5_];
                  _loc4_.switchTransformToBackup();
               }
            }
            _loc5_ = boneList.length;
            while(true)
            {
               _loc5_--;
               if(!_loc5_)
               {
                  break;
               }
               _loc2_ = boneList[_loc5_];
               _loc2_.update();
            }
            _loc5_ = slotList.length;
            while(true)
            {
               _loc5_--;
               if(!_loc5_)
               {
                  break;
               }
               _loc4_ = slotList[_loc5_];
               _loc4_.update();
            }
         }
         _loc5_ = slotHasChildArmatureList.length;
         while(true)
         {
            _loc5_--;
            if(!_loc5_)
            {
               break;
            }
            _loc4_ = slotHasChildArmatureList[_loc5_];
            _loc3_ = _loc4_.childArmature as IArmature;
            if(_loc3_)
            {
               _loc3_.advanceTime(param1);
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
      
      public function enableAnimationCache(param1:int, param2:Array = null, param3:Boolean = true) : AnimationCacheManager
      {
         var _loc4_:AnimationCacheManager = AnimationCacheManager.initWithArmatureData(armatureData,param1);
         if(param2)
         {
            var _loc7_:int = 0;
            var _loc6_:* = param2;
            for each(var _loc5_ in param2)
            {
               _loc4_.initAnimationCache(_loc5_);
            }
         }
         else
         {
            _loc4_.initAllAnimationCache();
         }
         _loc4_.setCacheGeneratorArmature(this);
         _loc4_.generateAllAnimationCache(param3);
         _loc4_.bindCacheUserArmature(this);
         enableCache = true;
         return _loc4_;
      }
      
      public function getBone(param1:String) : FastBone
      {
         return _boneDic[param1];
      }
      
      public function getSlot(param1:String) : FastSlot
      {
         return _slotDic[param1];
      }
      
      public function getBoneByDisplay(param1:Object) : FastBone
      {
         var _loc2_:FastSlot = getSlotByDisplay(param1);
         return !!_loc2_?_loc2_.parent:null;
      }
      
      public function getSlotByDisplay(param1:Object) : FastSlot
      {
         if(param1)
         {
            var _loc4_:int = 0;
            var _loc3_:* = slotList;
            for each(var _loc2_ in slotList)
            {
               if(_loc2_.display == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function getSlots(param1:Boolean = true) : Vector.<FastSlot>
      {
         return !!param1?slotList.concat():slotList;
      }
      
      function _updateBonesByCache() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = boneList.length;
         while(true)
         {
            _loc2_--;
            if(!_loc2_)
            {
               break;
            }
            _loc1_ = boneList[_loc2_];
            _loc1_.update();
         }
      }
      
      function addBone(param1:FastBone, param2:String = null) : void
      {
         var _loc3_:* = null;
         if(param2)
         {
            _loc3_ = getBone(param2);
            _loc3_.boneList.push(param1);
         }
         param1.armature = this;
         param1.setParent(_loc3_);
         boneList.unshift(param1);
         _boneDic[param1.name] = param1;
      }
      
      function addSlot(param1:FastSlot, param2:String) : void
      {
         var _loc3_:FastBone = getBone(param2);
         if(_loc3_)
         {
            param1.armature = this;
            param1.setParent(_loc3_);
            _loc3_.slotList.push(param1);
            param1.addDisplayToContainer(display);
            slotList.push(param1);
            _slotDic[param1.name] = param1;
            if(param1.hasChildArmature)
            {
               slotHasChildArmatureList.push(param1);
            }
            return;
         }
         throw new ArgumentError();
      }
      
      function updateSlotsZOrder() : void
      {
         var _loc1_:* = null;
         slotList.fixed = false;
         slotList.sort(sortSlot);
         slotList.fixed = true;
         var _loc2_:int = slotList.length;
         while(true)
         {
            _loc2_--;
            if(!_loc2_)
            {
               break;
            }
            _loc1_ = slotList[_loc2_];
            if(_loc1_._frameCache && (_loc1_._frameCache as SlotFrameCache).displayIndex >= 0 || !_loc1_._frameCache && _loc1_.displayIndex >= 0)
            {
               _loc1_.addDisplayToContainer(_display);
            }
         }
         _slotsZOrderChanged = false;
      }
      
      private function sortBoneList() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc5_:int = boneList.length;
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
            _loc3_ = boneList[_loc5_];
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
         boneList.fixed = false;
         while(true)
         {
            _loc5_--;
            if(!_loc5_)
            {
               break;
            }
            boneList[_loc5_] = _loc4_[_loc5_][1];
         }
         boneList.fixed = true;
         _loc4_.length = 0;
      }
      
      function arriveAtFrame(param1:Frame, param2:FastAnimationState) : void
      {
         var _loc3_:* = null;
         if(param1.event && this.hasEventListener("animationFrameEvent"))
         {
            _loc3_ = new FrameEvent("animationFrameEvent");
            _loc3_.animationState = param2;
            _loc3_.frameLabel = param1.event;
            addEvent(_loc3_);
         }
         if(param1.action)
         {
            animation.gotoAndPlay(param1.action);
         }
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
            _loc3_ = boneList.length;
            while(true)
            {
               _loc3_--;
               if(!_loc3_)
               {
                  break;
               }
               boneList[_loc3_].invalidUpdate();
            }
         }
      }
      
      public function resetAnimation() : void
      {
         animation.animationState.resetTimelineStateList();
         var _loc3_:int = 0;
         var _loc2_:* = boneList;
         for each(var _loc1_ in boneList)
         {
            _loc1_._timelineState = null;
         }
         animation.stop();
      }
      
      private function sortSlot(param1:FastSlot, param2:FastSlot) : int
      {
         return param1.zOrder < param2.zOrder?1:-1;
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
      
      public function set enableCache(param1:Boolean) : void
      {
         _enableCache = param1;
      }
      
      public function get enableEventDispatch() : Boolean
      {
         return _enableEventDispatch;
      }
      
      public function set enableEventDispatch(param1:Boolean) : void
      {
         _enableEventDispatch = param1;
      }
      
      public function getSlotDic() : Object
      {
         return _slotDic;
      }
      
      function addEvent(param1:Event) : void
      {
         if(_enableEventDispatch)
         {
            _eventList.push(param1);
         }
      }
   }
}
