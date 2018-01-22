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
      
      public static function initWithBoneData(param1:BoneData) : Bone
      {
         var _loc2_:Bone = new Bone();
         _loc2_.name = param1.name;
         _loc2_.inheritRotation = param1.inheritRotation;
         _loc2_.inheritScale = param1.inheritScale;
         _loc2_.origin.copy(param1.transform);
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         if(!_boneList)
         {
            return;
         }
         super.dispose();
         var _loc1_:int = _boneList.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            _boneList[_loc1_].dispose();
         }
         _loc1_ = _slotList.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            _slotList[_loc1_].dispose();
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
      
      public function contains(param1:DBObject) : Boolean
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         if(param1 == this)
         {
            return false;
         }
         var _loc2_:* = param1;
         while(!(_loc2_ == this || _loc2_ == null))
         {
            _loc2_ = _loc2_.parent;
         }
         return _loc2_ == this;
      }
      
      public function addChildBone(param1:Bone, param2:Boolean = false) : void
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         if(param1 == this || param1.contains(this))
         {
            throw new ArgumentError("An Bone cannot be added as a child to itself or one of its children (or children\'s children, etc.)");
         }
         if(param1.parent == this)
         {
            return;
         }
         if(param1.parent)
         {
            param1.parent.removeChildBone(param1);
         }
         _boneList.fixed = false;
         _boneList[_boneList.length] = param1;
         _boneList.fixed = true;
         param1.setParent(this);
         param1.setArmature(_armature);
         if(_armature && !param2)
         {
            _armature.updateAnimationAfterBoneListChanged();
         }
      }
      
      public function removeChildBone(param1:Bone, param2:Boolean = false) : void
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         var _loc3_:int = _boneList.indexOf(param1);
         if(_loc3_ < 0)
         {
            throw new ArgumentError();
         }
         _boneList.fixed = false;
         _boneList.splice(_loc3_,1);
         _boneList.fixed = true;
         param1.setParent(null);
         param1.setArmature(null);
         if(_armature && !param2)
         {
            _armature.updateAnimationAfterBoneListChanged(false);
         }
      }
      
      public function addSlot(param1:Slot) : void
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         if(param1.parent)
         {
            param1.parent.removeSlot(param1);
         }
         _slotList.fixed = false;
         _slotList[_slotList.length] = param1;
         _slotList.fixed = true;
         param1.setParent(this);
         param1.setArmature(this._armature);
      }
      
      public function removeSlot(param1:Slot) : void
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         var _loc2_:int = _slotList.indexOf(param1);
         if(_loc2_ < 0)
         {
            throw new ArgumentError();
         }
         _slotList.fixed = false;
         _slotList.splice(_loc2_,1);
         _slotList.fixed = true;
         param1.setParent(null);
         param1.setArmature(null);
      }
      
      override function setArmature(param1:Armature) : void
      {
         if(_armature == param1)
         {
            return;
         }
         if(_armature)
         {
            _armature.removeBoneFromBoneList(this);
            _armature.updateAnimationAfterBoneListChanged(false);
         }
         _armature = param1;
         if(_armature)
         {
            _armature.addBoneToBoneList(this);
         }
         var _loc2_:int = _boneList.length;
         while(true)
         {
            _loc2_--;
            if(!_loc2_)
            {
               break;
            }
            _boneList[_loc2_].setArmature(this._armature);
         }
         _loc2_ = _slotList.length;
         while(true)
         {
            _loc2_--;
            if(!_loc2_)
            {
               break;
            }
            _slotList[_loc2_].setArmature(this._armature);
         }
      }
      
      public function getBones(param1:Boolean = true) : Vector.<Bone>
      {
         return !!param1?_boneList.concat():_boneList;
      }
      
      public function getSlots(param1:Boolean = true) : Vector.<Slot>
      {
         return !!param1?_slotList.concat():_slotList;
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
      
      function update(param1:Boolean = false) : void
      {
         _needUpdate = Number(_needUpdate) - 1;
         if(param1 || _needUpdate > 0 || this._parent && this._parent._needUpdate > 0)
         {
            _needUpdate = 1;
            blendingTimeline();
            var _loc2_:Object = updateGlobal();
            var _loc5_:DBTransform = !!_loc2_?_loc2_.parentGlobalTransform:null;
            var _loc6_:Matrix = !!_loc2_?_loc2_.parentGlobalTransformMatrix:null;
            var _loc7_:Boolean = _offset.x != 0 || _offset.y != 0;
            var _loc3_:Boolean = _offset.scaleX != 1 || _offset.scaleY != 1;
            var _loc4_:Boolean = _offset.skewX != 0 || _offset.skewY != 0;
            if((!_loc7_ || applyOffsetTranslationToChild) && (!_loc3_ || applyOffsetScaleToChild) && (!_loc4_ || applyOffsetRotationToChild))
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
               if(_loc6_)
               {
                  _globalTransformMatrixForChild.concat(_loc6_);
                  TransformUtil.matrixToTransform(_globalTransformMatrixForChild,_globalTransformForChild,_globalTransformForChild.scaleX * _loc5_.scaleX >= 0,_globalTransformForChild.scaleY * _loc5_.scaleY >= 0);
               }
            }
            return;
         }
      }
      
      function hideSlots() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _slotList;
         for each(var _loc1_ in _slotList)
         {
            _loc1_.changeDisplay(-1);
         }
      }
      
      function arriveAtFrame(param1:Frame, param2:TimelineState, param3:AnimationState, param4:Boolean) : void
      {
         var _loc9_:* = null;
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc8_:Boolean = param3.displayControl && (!displayController || displayController == param3.name) && param3.containsBoneMask(name);
         if(_loc8_)
         {
            if(param1.event && this._armature.hasEventListener("boneFrameEvent"))
            {
               _loc5_ = new FrameEvent("boneFrameEvent");
               _loc5_.bone = this;
               _loc5_.animationState = param3;
               _loc5_.frameLabel = param1.event;
               this._armature._eventList.push(_loc5_);
            }
            if(param1.sound && _soundManager.hasEventListener("sound"))
            {
               _loc7_ = new SoundEvent("sound");
               _loc7_.armature = this._armature;
               _loc7_.animationState = param3;
               _loc7_.sound = param1.sound;
               _soundManager.dispatchEvent(_loc7_);
            }
            if(param1.action)
            {
               var _loc11_:int = 0;
               var _loc10_:* = _slotList;
               for each(_loc9_ in _slotList)
               {
                  _loc6_ = _loc9_.childArmature;
                  if(_loc6_)
                  {
                     _loc6_.animation.gotoAndPlay(param1.action);
                  }
               }
            }
         }
      }
      
      function addState(param1:TimelineState) : void
      {
         if(_timelineStateList.indexOf(param1) < 0)
         {
            _timelineStateList.push(param1);
            _timelineStateList.sort(sortState);
         }
      }
      
      function removeState(param1:TimelineState) : void
      {
         var _loc2_:int = _timelineStateList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            _timelineStateList.splice(_loc2_,1);
         }
      }
      
      function removeAllStates() : void
      {
         _timelineStateList.length = 0;
      }
      
      private function blendingTimeline() : void
      {
         var _loc8_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc5_:Number = NaN;
         var _loc17_:* = NaN;
         var _loc16_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc6_:* = NaN;
         var _loc15_:* = NaN;
         var _loc1_:* = NaN;
         var _loc7_:* = 0;
         var _loc9_:int = 0;
         var _loc12_:int = _timelineStateList.length;
         if(_loc12_ == 1)
         {
            _loc8_ = _timelineStateList[0];
            _loc5_ = _loc8_._animationState.weight * _loc8_._animationState.fadeWeight;
            _loc8_._weight = _loc5_;
            _loc13_ = _loc8_._transform;
            _loc14_ = _loc8_._pivot;
            _tween.x = _loc13_.x * _loc5_;
            _tween.y = _loc13_.y * _loc5_;
            _tween.skewX = _loc13_.skewX * _loc5_;
            _tween.skewY = _loc13_.skewY * _loc5_;
            _tween.scaleX = 1 + (_loc13_.scaleX - 1) * _loc5_;
            _tween.scaleY = 1 + (_loc13_.scaleY - 1) * _loc5_;
            _tweenPivot.x = _loc14_.x * _loc5_;
            _tweenPivot.y = _loc14_.y * _loc5_;
         }
         else if(_loc12_ > 1)
         {
            _loc17_ = 0;
            _loc16_ = 0;
            _loc10_ = 0;
            _loc11_ = 0;
            _loc2_ = 1;
            _loc3_ = 1;
            _loc4_ = 0;
            _loc6_ = 0;
            _loc15_ = 1;
            _loc1_ = 0;
            _loc7_ = int(_timelineStateList[_loc12_ - 1]._animationState.layer);
            while(true)
            {
               _loc12_--;
               if(_loc12_)
               {
                  _loc8_ = _timelineStateList[_loc12_];
                  _loc9_ = _loc8_._animationState.layer;
                  if(_loc7_ != _loc9_)
                  {
                     if(_loc1_ >= _loc15_)
                     {
                        _loc8_._weight = 0;
                        break;
                     }
                     _loc15_ = Number(_loc15_ - _loc1_);
                  }
                  _loc7_ = _loc9_;
                  _loc5_ = _loc8_._animationState.weight * _loc8_._animationState.fadeWeight * _loc15_;
                  _loc8_._weight = _loc5_;
                  if(_loc5_ && _loc8_._blendEnabled)
                  {
                     _loc13_ = _loc8_._transform;
                     _loc14_ = _loc8_._pivot;
                     _loc17_ = Number(_loc17_ + _loc13_.x * _loc5_);
                     _loc16_ = Number(_loc16_ + _loc13_.y * _loc5_);
                     _loc10_ = Number(_loc10_ + _loc13_.skewX * _loc5_);
                     _loc11_ = Number(_loc11_ + _loc13_.skewY * _loc5_);
                     _loc2_ = Number(_loc2_ + (_loc13_.scaleX - 1) * _loc5_);
                     _loc3_ = Number(_loc3_ + (_loc13_.scaleY - 1) * _loc5_);
                     _loc4_ = Number(_loc4_ + _loc14_.x * _loc5_);
                     _loc6_ = Number(_loc6_ + _loc14_.y * _loc5_);
                     _loc1_ = Number(_loc1_ + _loc5_);
                  }
                  continue;
               }
               break;
            }
            _tween.x = _loc17_;
            _tween.y = _loc16_;
            _tween.skewX = _loc10_;
            _tween.skewY = _loc11_;
            _tween.scaleX = _loc2_;
            _tween.scaleY = _loc3_;
            _tweenPivot.x = _loc4_;
            _tweenPivot.y = _loc6_;
         }
      }
      
      private function sortState(param1:TimelineState, param2:TimelineState) : int
      {
         return param1._animationState.layer < param2._animationState.layer?-1:1;
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
      
      public function set display(param1:Object) : void
      {
         if(slot)
         {
            slot.display = param1;
         }
      }
      
      public function get node() : DBTransform
      {
         return _offset;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(this._visible != param1)
         {
            this._visible = param1;
            var _loc4_:int = 0;
            var _loc3_:* = _slotList;
            for each(var _loc2_ in _slotList)
            {
               _loc2_.updateDisplayVisible(this._visible);
            }
         }
      }
      
      public function get slot() : Slot
      {
         return _slotList.length > 0?_slotList[0]:null;
      }
   }
}
