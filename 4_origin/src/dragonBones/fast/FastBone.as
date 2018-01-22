package dragonBones.fast
{
   import dragonBones.§core:dragonBones_internal§._frameCache;
   import dragonBones.§core:dragonBones_internal§._global;
   import dragonBones.§core:dragonBones_internal§._globalTransformMatrix;
   import dragonBones.§core:dragonBones_internal§._needUpdate;
   import dragonBones.§core:dragonBones_internal§._timelineState;
   import dragonBones.events.FrameEvent;
   import dragonBones.fast.animation.FastAnimationState;
   import dragonBones.fast.animation.FastBoneTimelineState;
   import dragonBones.objects.BoneData;
   import dragonBones.objects.Frame;
   
   public class FastBone extends FastDBObject
   {
       
      
      public var slotList:Vector.<FastSlot>;
      
      public var boneList:Vector.<FastBone>;
      
      var _timelineState:FastBoneTimelineState;
      
      var _needUpdate:int;
      
      public function FastBone()
      {
         slotList = new Vector.<FastSlot>();
         boneList = new Vector.<FastBone>();
         super();
         _needUpdate = 2;
      }
      
      public static function initWithBoneData(param1:BoneData) : FastBone
      {
         var _loc2_:FastBone = new FastBone();
         _loc2_.name = param1.name;
         _loc2_.inheritRotation = param1.inheritRotation;
         _loc2_.inheritScale = param1.inheritScale;
         _loc2_.origin.copy(param1.transform);
         return _loc2_;
      }
      
      public function getBones(param1:Boolean = true) : Vector.<FastBone>
      {
         return !!param1?boneList.concat():boneList;
      }
      
      public function getSlots(param1:Boolean = true) : Vector.<FastSlot>
      {
         return !!param1?slotList.concat():slotList;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _timelineState = null;
      }
      
      public function invalidUpdate() : void
      {
         _needUpdate = 2;
      }
      
      override protected function calculateRelativeParentTransform() : void
      {
         _global.copy(this._origin);
         if(_timelineState)
         {
            _global.add(_timelineState._transform);
         }
      }
      
      override function updateByCache() : void
      {
         super.updateByCache();
         _global = _frameCache.globalTransform;
         _globalTransformMatrix = _frameCache.globalTransformMatrix;
      }
      
      function update(param1:Boolean = false) : void
      {
         _needUpdate = Number(_needUpdate) - 1;
         if(param1 || _needUpdate > 0 || this._parent && this._parent._needUpdate > 0)
         {
            _needUpdate = 1;
            updateGlobal();
            return;
         }
      }
      
      function arriveAtFrame(param1:Frame, param2:FastAnimationState) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(param1.event && this.armature.hasEventListener("boneFrameEvent"))
         {
            _loc3_ = new FrameEvent("boneFrameEvent");
            _loc3_.bone = this;
            _loc3_.animationState = param2;
            _loc3_.frameLabel = param1.event;
            this.armature.addEvent(_loc3_);
         }
      }
      
      public function get childArmature() : Object
      {
         var _loc1_:FastSlot = slot;
         if(_loc1_)
         {
            return _loc1_.childArmature;
         }
         return null;
      }
      
      public function get display() : Object
      {
         var _loc1_:FastSlot = slot;
         if(_loc1_)
         {
            return _loc1_.display;
         }
         return null;
      }
      
      public function set display(param1:Object) : void
      {
         var _loc2_:FastSlot = slot;
         if(_loc2_)
         {
            _loc2_.display = param1;
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(this._visible != param1)
         {
            this._visible = param1;
            var _loc4_:int = 0;
            var _loc3_:* = armature.slotList;
            for each(var _loc2_ in armature.slotList)
            {
               if(_loc2_.parent == this)
               {
                  _loc2_.updateDisplayVisible(this._visible);
               }
            }
         }
      }
      
      public function get slot() : FastSlot
      {
         return slotList.length > 0?slotList[0]:null;
      }
   }
}
