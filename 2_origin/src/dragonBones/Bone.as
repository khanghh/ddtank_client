package dragonBones
{
   import dragonBones.animation.AnimationState;
   import dragonBones.animation.TimelineState;
   import dragonBones.core.DBObject;
   import dragonBones.§core:dragonBones_internal§._global;
   import dragonBones.§core:dragonBones_internal§._globalTransformForChild;
   import dragonBones.§core:dragonBones_internal§._globalTransformMatrix;
   import dragonBones.§core:dragonBones_internal§._globalTransformMatrixForChild;
   import dragonBones.§core:dragonBones_internal§._needUpdate;
   import dragonBones.§core:dragonBones_internal§._tween;
   import dragonBones.§core:dragonBones_internal§._tweenPivot;
   import dragonBones.events.FrameEvent;
   import dragonBones.events.SoundEvent;
   import dragonBones.events.SoundEventManager;
   import dragonBones.objects.BoneData;
   import dragonBones.objects.DBTransform;
   import dragonBones.objects.Frame;
   import dragonBones.utils.TransformUtil;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class Bone extends DBObject
   {
      
      private static const _soundManager:SoundEventManager = SoundEventManager.getInstance();
       
      
      public var applyOffsetTranslationToChild:Boolean = true;
      
      public var applyOffsetRotationToChild:Boolean = true;
      
      public var applyOffsetScaleToChild:Boolean = false;
      
      public var displayController:String;
      
      protected var _boneList:Vector.<Bone>;
      
      protected var _slotList:Vector.<Slot>;
      
      protected var _timelineStateList:Vector.<TimelineState>;
      
      var _tween:DBTransform;
      
      var _tweenPivot:Point;
      
      var _needUpdate:int;
      
      var _globalTransformForChild:DBTransform;
      
      var _globalTransformMatrixForChild:Matrix;
      
      private var _tempGlobalTransformForChild:DBTransform;
      
      private var _tempGlobalTransformMatrixForChild:Matrix;
      
      public function Bone()
      {
         super();
         _tween = new DBTransform();
         _tweenPivot = new Point();
         var _loc1_:int = 1;
         _tween.scaleY = _loc1_;
         _tween.scaleX = _loc1_;
         _boneList = new Vector.<Bone>();
         _boneList.fixed = true;
         _slotList = new Vector.<Slot>();
         _slotList.fixed = true;
         _timelineStateList = new Vector.<TimelineState>();
         _needUpdate = 2;
      }
      
      public static function initWithBoneData(boneData:BoneData) : Bone
      {
         var outputBone:Bone = new Bone();
         outputBone.name = boneData.name;
         outputBone.inheritRotation = boneData.inheritRotation;
         outputBone.inheritScale = boneData.inheritScale;
         outputBone.origin.copy(boneData.transform);
         return outputBone;
      }
      
      override public function dispose() : void
      {
         if(!_boneList)
         {
            return;
         }
         super.dispose();
         var i:int = _boneList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            _boneList[i].dispose();
         }
         i = _slotList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            _slotList[i].dispose();
         }
         _boneList.fixed = false;
         _boneList.length = 0;
         _slotList.fixed = false;
         _slotList.length = 0;
         _timelineStateList.length = 0;
         _tween = null;
         _tweenPivot = null;
         _boneList = null;
         _slotList = null;
         _timelineStateList = null;
      }
      
      public function contains(child:DBObject) : Boolean
      {
         if(!child)
         {
            throw new ArgumentError();
         }
         if(child == this)
         {
            return false;
         }
         var ancestor:* = child;
         while(!(ancestor == this || ancestor == null))
         {
            ancestor = ancestor.parent;
         }
         return ancestor == this;
      }
      
      public function addChildBone(childBone:Bone, updateLater:Boolean = false) : void
      {
         if(!childBone)
         {
            throw new ArgumentError();
         }
         if(childBone == this || childBone.contains(this))
         {
            throw new ArgumentError("An Bone cannot be added as a child to itself or one of its children (or children\'s children, etc.)");
         }
         if(childBone.parent == this)
         {
            return;
         }
         if(childBone.parent)
         {
            childBone.parent.removeChildBone(childBone);
         }
         _boneList.fixed = false;
         _boneList[_boneList.length] = childBone;
         _boneList.fixed = true;
         childBone.setParent(this);
         childBone.setArmature(_armature);
         if(_armature && !updateLater)
         {
            _armature.updateAnimationAfterBoneListChanged();
         }
      }
      
      public function removeChildBone(childBone:Bone, updateLater:Boolean = false) : void
      {
         if(!childBone)
         {
            throw new ArgumentError();
         }
         var index:int = _boneList.indexOf(childBone);
         if(index < 0)
         {
            throw new ArgumentError();
         }
         _boneList.fixed = false;
         _boneList.splice(index,1);
         _boneList.fixed = true;
         childBone.setParent(null);
         childBone.setArmature(null);
         if(_armature && !updateLater)
         {
            _armature.updateAnimationAfterBoneListChanged(false);
         }
      }
      
      public function addSlot(childSlot:Slot) : void
      {
         if(!childSlot)
         {
            throw new ArgumentError();
         }
         if(childSlot.parent)
         {
            childSlot.parent.removeSlot(childSlot);
         }
         _slotList.fixed = false;
         _slotList[_slotList.length] = childSlot;
         _slotList.fixed = true;
         childSlot.setParent(this);
         childSlot.setArmature(this._armature);
      }
      
      public function removeSlot(childSlot:Slot) : void
      {
         if(!childSlot)
         {
            throw new ArgumentError();
         }
         var index:int = _slotList.indexOf(childSlot);
         if(index < 0)
         {
            throw new ArgumentError();
         }
         _slotList.fixed = false;
         _slotList.splice(index,1);
         _slotList.fixed = true;
         childSlot.setParent(null);
         childSlot.setArmature(null);
      }
      
      override function setArmature(value:Armature) : void
      {
         if(_armature == value)
         {
            return;
         }
         if(_armature)
         {
            _armature.removeBoneFromBoneList(this);
            _armature.updateAnimationAfterBoneListChanged(false);
         }
         _armature = value;
         if(_armature)
         {
            _armature.addBoneToBoneList(this);
         }
         var i:int = _boneList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            _boneList[i].setArmature(this._armature);
         }
         i = _slotList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            _slotList[i].setArmature(this._armature);
         }
      }
      
      public function getBones(returnCopy:Boolean = true) : Vector.<Bone>
      {
         return !!returnCopy?_boneList.concat():_boneList;
      }
      
      public function getSlots(returnCopy:Boolean = true) : Vector.<Slot>
      {
         return !!returnCopy?_slotList.concat():_slotList;
      }
      
      public function invalidUpdate() : void
      {
         _needUpdate = 2;
      }
      
      override protected function calculateRelativeParentTransform() : void
      {
         _global.scaleX = this._origin.scaleX * _tween.scaleX * this._offset.scaleX;
         _global.scaleY = this._origin.scaleY * _tween.scaleY * this._offset.scaleY;
         _global.skewX = this._origin.skewX + _tween.skewX + this._offset.skewX;
         _global.skewY = this._origin.skewY + _tween.skewY + this._offset.skewY;
         _global.x = this._origin.x + _tween.x + this._offset.x;
         _global.y = this._origin.y + _tween.y + this._offset.y;
      }
      
      function update(needUpdate:Boolean = false) : void
      {
         _needUpdate = Number(_needUpdate) - 1;
         if(needUpdate || _needUpdate > 0 || this._parent && this._parent._needUpdate > 0)
         {
            _needUpdate = 1;
            blendingTimeline();
            var result:Object = updateGlobal();
            var parentGlobalTransform:DBTransform = !!result?result.parentGlobalTransform:null;
            var parentGlobalTransformMatrix:Matrix = !!result?result.parentGlobalTransformMatrix:null;
            var ifExistOffsetTranslation:Boolean = _offset.x != 0 || _offset.y != 0;
            var ifExistOffsetScale:Boolean = _offset.scaleX != 1 || _offset.scaleY != 1;
            var ifExistOffsetRotation:Boolean = _offset.skewX != 0 || _offset.skewY != 0;
            if((!ifExistOffsetTranslation || applyOffsetTranslationToChild) && (!ifExistOffsetScale || applyOffsetScaleToChild) && (!ifExistOffsetRotation || applyOffsetRotationToChild))
            {
               _globalTransformForChild = _global;
               _globalTransformMatrixForChild = _globalTransformMatrix;
            }
            else
            {
               if(!_tempGlobalTransformForChild)
               {
                  _tempGlobalTransformForChild = new DBTransform();
               }
               _globalTransformForChild = _tempGlobalTransformForChild;
               if(!_tempGlobalTransformMatrixForChild)
               {
                  _tempGlobalTransformMatrixForChild = new Matrix();
               }
               _globalTransformMatrixForChild = _tempGlobalTransformMatrixForChild;
               _globalTransformForChild.x = this._origin.x + _tween.x;
               _globalTransformForChild.y = this._origin.y + _tween.y;
               _globalTransformForChild.scaleX = this._origin.scaleX * _tween.scaleX;
               _globalTransformForChild.scaleY = this._origin.scaleY * _tween.scaleY;
               _globalTransformForChild.skewX = this._origin.skewX + _tween.skewX;
               _globalTransformForChild.skewY = this._origin.skewY + _tween.skewY;
               if(applyOffsetTranslationToChild)
               {
                  _globalTransformForChild.x = _globalTransformForChild.x + this._offset.x;
                  _globalTransformForChild.y = _globalTransformForChild.y + this._offset.y;
               }
               if(applyOffsetScaleToChild)
               {
                  _globalTransformForChild.scaleX = _globalTransformForChild.scaleX * this._offset.scaleX;
                  _globalTransformForChild.scaleY = _globalTransformForChild.scaleY * this._offset.scaleY;
               }
               if(applyOffsetRotationToChild)
               {
                  _globalTransformForChild.skewX = _globalTransformForChild.skewX + this._offset.skewX;
                  _globalTransformForChild.skewY = _globalTransformForChild.skewY + this._offset.skewY;
               }
               TransformUtil.transformToMatrix(_globalTransformForChild,_globalTransformMatrixForChild);
               if(parentGlobalTransformMatrix)
               {
                  _globalTransformMatrixForChild.concat(parentGlobalTransformMatrix);
                  TransformUtil.matrixToTransform(_globalTransformMatrixForChild,_globalTransformForChild,_globalTransformForChild.scaleX * parentGlobalTransform.scaleX >= 0,_globalTransformForChild.scaleY * parentGlobalTransform.scaleY >= 0);
               }
            }
            return;
         }
      }
      
      function hideSlots() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _slotList;
         for each(var childSlot in _slotList)
         {
            childSlot.changeDisplay(-1);
         }
      }
      
      function arriveAtFrame(frame:Frame, timelineState:TimelineState, animationState:AnimationState, isCross:Boolean) : void
      {
         var childSlot:* = null;
         var frameEvent:* = null;
         var soundEvent:* = null;
         var childArmature:* = null;
         var displayControl:Boolean = animationState.displayControl && (!displayController || displayController == animationState.name) && animationState.containsBoneMask(name);
         if(displayControl)
         {
            if(frame.event && this._armature.hasEventListener("boneFrameEvent"))
            {
               frameEvent = new FrameEvent("boneFrameEvent");
               frameEvent.bone = this;
               frameEvent.animationState = animationState;
               frameEvent.frameLabel = frame.event;
               this._armature._eventList.push(frameEvent);
            }
            if(frame.sound && _soundManager.hasEventListener("sound"))
            {
               soundEvent = new SoundEvent("sound");
               soundEvent.armature = this._armature;
               soundEvent.animationState = animationState;
               soundEvent.sound = frame.sound;
               _soundManager.dispatchEvent(soundEvent);
            }
            if(frame.action)
            {
               var _loc11_:int = 0;
               var _loc10_:* = _slotList;
               for each(childSlot in _slotList)
               {
                  childArmature = childSlot.childArmature;
                  if(childArmature)
                  {
                     childArmature.animation.gotoAndPlay(frame.action);
                  }
               }
            }
         }
      }
      
      function addState(timelineState:TimelineState) : void
      {
         if(_timelineStateList.indexOf(timelineState) < 0)
         {
            _timelineStateList.push(timelineState);
            _timelineStateList.sort(sortState);
         }
      }
      
      function removeState(timelineState:TimelineState) : void
      {
         var index:int = _timelineStateList.indexOf(timelineState);
         if(index >= 0)
         {
            _timelineStateList.splice(index,1);
         }
      }
      
      function removeAllStates() : void
      {
         _timelineStateList.length = 0;
      }
      
      private function blendingTimeline() : void
      {
         var timelineState:* = null;
         var transform:* = null;
         var pivot:* = null;
         var weight:Number = NaN;
         var x:* = NaN;
         var y:* = NaN;
         var skewX:* = NaN;
         var skewY:* = NaN;
         var scaleX:* = NaN;
         var scaleY:* = NaN;
         var pivotX:* = NaN;
         var pivotY:* = NaN;
         var weigthLeft:* = NaN;
         var layerTotalWeight:* = NaN;
         var prevLayer:* = 0;
         var currentLayer:int = 0;
         var i:int = _timelineStateList.length;
         if(i == 1)
         {
            timelineState = _timelineStateList[0];
            weight = timelineState._animationState.weight * timelineState._animationState.fadeWeight;
            timelineState._weight = weight;
            transform = timelineState._transform;
            pivot = timelineState._pivot;
            _tween.x = transform.x * weight;
            _tween.y = transform.y * weight;
            _tween.skewX = transform.skewX * weight;
            _tween.skewY = transform.skewY * weight;
            _tween.scaleX = 1 + (transform.scaleX - 1) * weight;
            _tween.scaleY = 1 + (transform.scaleY - 1) * weight;
            _tweenPivot.x = pivot.x * weight;
            _tweenPivot.y = pivot.y * weight;
         }
         else if(i > 1)
         {
            x = 0;
            y = 0;
            skewX = 0;
            skewY = 0;
            scaleX = 1;
            scaleY = 1;
            pivotX = 0;
            pivotY = 0;
            weigthLeft = 1;
            layerTotalWeight = 0;
            prevLayer = int(_timelineStateList[i - 1]._animationState.layer);
            while(true)
            {
               i--;
               if(i)
               {
                  timelineState = _timelineStateList[i];
                  currentLayer = timelineState._animationState.layer;
                  if(prevLayer != currentLayer)
                  {
                     if(layerTotalWeight >= weigthLeft)
                     {
                        timelineState._weight = 0;
                        break;
                     }
                     weigthLeft = Number(weigthLeft - layerTotalWeight);
                  }
                  prevLayer = currentLayer;
                  weight = timelineState._animationState.weight * timelineState._animationState.fadeWeight * weigthLeft;
                  timelineState._weight = weight;
                  if(weight && timelineState._blendEnabled)
                  {
                     transform = timelineState._transform;
                     pivot = timelineState._pivot;
                     x = Number(x + transform.x * weight);
                     y = Number(y + transform.y * weight);
                     skewX = Number(skewX + transform.skewX * weight);
                     skewY = Number(skewY + transform.skewY * weight);
                     scaleX = Number(scaleX + (transform.scaleX - 1) * weight);
                     scaleY = Number(scaleY + (transform.scaleY - 1) * weight);
                     pivotX = Number(pivotX + pivot.x * weight);
                     pivotY = Number(pivotY + pivot.y * weight);
                     layerTotalWeight = Number(layerTotalWeight + weight);
                  }
                  continue;
               }
               break;
            }
            _tween.x = x;
            _tween.y = y;
            _tween.skewX = skewX;
            _tween.skewY = skewY;
            _tween.scaleX = scaleX;
            _tween.scaleY = scaleY;
            _tweenPivot.x = pivotX;
            _tweenPivot.y = pivotY;
         }
      }
      
      private function sortState(state1:TimelineState, state2:TimelineState) : int
      {
         return state1._animationState.layer < state2._animationState.layer?-1:1;
      }
      
      public function get childArmature() : Armature
      {
         if(slot)
         {
            return slot.childArmature;
         }
         return null;
      }
      
      public function get display() : Object
      {
         if(slot)
         {
            return slot.display;
         }
         return null;
      }
      
      public function set display(value:Object) : void
      {
         if(slot)
         {
            slot.display = value;
         }
      }
      
      public function get node() : DBTransform
      {
         return _offset;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(this._visible != value)
         {
            this._visible = value;
            var _loc4_:int = 0;
            var _loc3_:* = _slotList;
            for each(var childSlot in _slotList)
            {
               childSlot.updateDisplayVisible(this._visible);
            }
         }
      }
      
      public function get slot() : Slot
      {
         return _slotList.length > 0?_slotList[0]:null;
      }
   }
}
