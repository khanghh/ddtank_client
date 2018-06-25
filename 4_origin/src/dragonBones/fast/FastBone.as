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
      
      public static function initWithBoneData(boneData:BoneData) : FastBone
      {
         var outputBone:FastBone = new FastBone();
         outputBone.name = boneData.name;
         outputBone.inheritRotation = boneData.inheritRotation;
         outputBone.inheritScale = boneData.inheritScale;
         outputBone.origin.copy(boneData.transform);
         return outputBone;
      }
      
      public function getBones(returnCopy:Boolean = true) : Vector.<FastBone>
      {
         return !!returnCopy?boneList.concat():boneList;
      }
      
      public function getSlots(returnCopy:Boolean = true) : Vector.<FastSlot>
      {
         return !!returnCopy?slotList.concat():slotList;
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
      
      function update(needUpdate:Boolean = false) : void
      {
         _needUpdate = Number(_needUpdate) - 1;
         if(needUpdate || _needUpdate > 0 || this._parent && this._parent._needUpdate > 0)
         {
            _needUpdate = 1;
            updateGlobal();
            return;
         }
      }
      
      function arriveAtFrame(frame:Frame, animationState:FastAnimationState) : void
      {
         var childSlot:* = null;
         var frameEvent:* = null;
         if(frame.event && this.armature.hasEventListener("boneFrameEvent"))
         {
            frameEvent = new FrameEvent("boneFrameEvent");
            frameEvent.bone = this;
            frameEvent.animationState = animationState;
            frameEvent.frameLabel = frame.event;
            this.armature.addEvent(frameEvent);
         }
      }
      
      public function get childArmature() : Object
      {
         var s:FastSlot = slot;
         if(s)
         {
            return s.childArmature;
         }
         return null;
      }
      
      public function get display() : Object
      {
         var s:FastSlot = slot;
         if(s)
         {
            return s.display;
         }
         return null;
      }
      
      public function set display(value:Object) : void
      {
         var s:FastSlot = slot;
         if(s)
         {
            s.display = value;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(this._visible != value)
         {
            this._visible = value;
            var _loc4_:int = 0;
            var _loc3_:* = armature.slotList;
            for each(var childSlot in armature.slotList)
            {
               if(childSlot.parent == this)
               {
                  childSlot.updateDisplayVisible(this._visible);
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
