package dragonBones
{
   import dragonBones.animation.AnimationState;
   import dragonBones.animation.SlotTimelineState;
   import dragonBones.core.DBObject;
   import dragonBones.§core:dragonBones_internal§._displayDataList;
   import dragonBones.§core:dragonBones_internal§._global;
   import dragonBones.§core:dragonBones_internal§._globalTransformMatrix;
   import dragonBones.§core:dragonBones_internal§._isColorChanged;
   import dragonBones.§core:dragonBones_internal§._isShowDisplay;
   import dragonBones.§core:dragonBones_internal§._originZOrder;
   import dragonBones.§core:dragonBones_internal§._tweenZOrder;
   import dragonBones.§core:dragonBones_internal§.addDisplayToContainer;
   import dragonBones.§core:dragonBones_internal§.changeDisplay;
   import dragonBones.§core:dragonBones_internal§.getDisplayIndex;
   import dragonBones.§core:dragonBones_internal§.removeDisplayFromContainer;
   import dragonBones.§core:dragonBones_internal§.updateDisplay;
   import dragonBones.§core:dragonBones_internal§.updateDisplayBlendMode;
   import dragonBones.§core:dragonBones_internal§.updateDisplayColor;
   import dragonBones.§core:dragonBones_internal§.updateDisplayVisible;
   import dragonBones.§core:dragonBones_internal§.updateSlotDisplay;
   import dragonBones.§core:dragonBones_internal§.updateTransform;
   import dragonBones.objects.DisplayData;
   import dragonBones.objects.Frame;
   import dragonBones.objects.SlotData;
   import dragonBones.objects.SlotFrame;
   import dragonBones.utils.TransformUtil;
   import flash.errors.IllegalOperationError;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   
   public class Slot extends DBObject
   {
       
      
      var _displayDataList:Vector.<DisplayData>;
      
      var _originZOrder:Number;
      
      var _tweenZOrder:Number;
      
      protected var _offsetZOrder:Number;
      
      protected var _displayList:Array;
      
      protected var _currentDisplayIndex:int;
      
      protected var _colorTransform:ColorTransform;
      
      protected var _currentDisplay:Object;
      
      var _isShowDisplay:Boolean;
      
      protected var _blendMode:String;
      
      var _isColorChanged:Boolean;
      
      public function Slot(param1:Slot)
      {
         super();
         if(param1 != this)
         {
            throw new IllegalOperationError("Abstract class can not be instantiated!");
         }
         _displayList = [];
         _currentDisplayIndex = -1;
         _originZOrder = 0;
         _tweenZOrder = 0;
         _offsetZOrder = 0;
         _isShowDisplay = false;
         _isColorChanged = false;
         _colorTransform = new ColorTransform();
         _displayDataList = null;
         _currentDisplay = null;
         this.inheritRotation = true;
         this.inheritScale = true;
      }
      
      public function initWithSlotData(param1:SlotData) : void
      {
         name = param1.name;
         blendMode = param1.blendMode;
         _originZOrder = param1.zOrder;
         _displayDataList = param1.displayDataList;
      }
      
      override public function dispose() : void
      {
         if(!_displayList)
         {
            return;
         }
         super.dispose();
         _displayList.length = 0;
         _displayDataList = null;
         _displayList = null;
         _currentDisplay = null;
      }
      
      override function setArmature(param1:Armature) : void
      {
         if(_armature == param1)
         {
            return;
         }
         if(_armature)
         {
            _armature.removeSlotFromSlotList(this);
         }
         _armature = param1;
         if(_armature)
         {
            _armature.addSlotToSlotList(this);
            _armature._slotsZOrderChanged = true;
            addDisplayToContainer(this._armature.display);
         }
         else
         {
            removeDisplayFromContainer();
         }
      }
      
      function update() : void
      {
         if(this._parent._needUpdate <= 0)
         {
            return;
         }
         updateGlobal();
         updateTransform();
      }
      
      override protected function calculateRelativeParentTransform() : void
      {
         _global.scaleX = this._origin.scaleX * this._offset.scaleX;
         _global.scaleY = this._origin.scaleY * this._offset.scaleY;
         _global.skewX = this._origin.skewX + this._offset.skewX;
         _global.skewY = this._origin.skewY + this._offset.skewY;
         _global.x = this._origin.x + this._offset.x + this._parent._tweenPivot.x;
         _global.y = this._origin.y + this._offset.y + this._parent._tweenPivot.y;
      }
      
      private function updateChildArmatureAnimation() : void
      {
         if(childArmature)
         {
            if(_isShowDisplay)
            {
               if(this._armature && this._armature.animation.lastAnimationState && childArmature.animation.hasAnimation(this._armature.animation.lastAnimationState.name))
               {
                  childArmature.animation.gotoAndPlay(this._armature.animation.lastAnimationState.name);
               }
               else
               {
                  childArmature.animation.play();
               }
            }
            else
            {
               childArmature.animation.stop();
               childArmature.animation._lastAnimationState = null;
            }
         }
      }
      
      function changeDisplay(param1:int) : void
      {
         var _loc2_:* = 0;
         if(param1 < 0)
         {
            if(_isShowDisplay)
            {
               _isShowDisplay = false;
               removeDisplayFromContainer();
               updateChildArmatureAnimation();
            }
         }
         else if(_displayList.length > 0)
         {
            _loc2_ = uint(_displayList.length);
            if(param1 >= _loc2_)
            {
               param1 = _loc2_ - 1;
            }
            if(_currentDisplayIndex != param1)
            {
               _isShowDisplay = true;
               _currentDisplayIndex = param1;
               updateSlotDisplay();
               updateChildArmatureAnimation();
               if(_displayDataList && _displayDataList.length > 0 && _currentDisplayIndex < _displayDataList.length)
               {
                  this._origin.copy(_displayDataList[_currentDisplayIndex].transform);
               }
            }
            else if(!_isShowDisplay)
            {
               _isShowDisplay = true;
               if(this._armature)
               {
                  this._armature._slotsZOrderChanged = true;
                  addDisplayToContainer(this._armature.display);
               }
               updateChildArmatureAnimation();
            }
         }
      }
      
      function updateSlotDisplay() : void
      {
         var _loc2_:int = -1;
         if(_currentDisplay)
         {
            _loc2_ = getDisplayIndex();
            removeDisplayFromContainer();
         }
         var _loc1_:Object = _displayList[_currentDisplayIndex];
         if(_loc1_)
         {
            if(_loc1_ is Armature)
            {
               _currentDisplay = (_loc1_ as Armature).display;
            }
            else
            {
               _currentDisplay = _loc1_;
            }
         }
         else
         {
            _currentDisplay = null;
         }
         updateDisplay(_currentDisplay);
         if(_currentDisplay)
         {
            if(this._armature && _isShowDisplay)
            {
               if(_loc2_ < 0)
               {
                  this._armature._slotsZOrderChanged = true;
                  addDisplayToContainer(this._armature.display);
               }
               else
               {
                  addDisplayToContainer(this._armature.display,_loc2_);
               }
            }
            updateDisplayBlendMode(_blendMode);
            updateDisplayColor(_colorTransform.alphaOffset,_colorTransform.redOffset,_colorTransform.greenOffset,_colorTransform.blueOffset,_colorTransform.alphaMultiplier,_colorTransform.redMultiplier,_colorTransform.greenMultiplier,_colorTransform.blueMultiplier);
            updateDisplayVisible(_visible);
            updateTransform();
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(this._visible != param1)
         {
            this._visible = param1;
            updateDisplayVisible(this._visible);
         }
      }
      
      public function get displayList() : Array
      {
         return _displayList;
      }
      
      public function set displayList(param1:Array) : void
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         if(_currentDisplayIndex < 0)
         {
            _currentDisplayIndex = 0;
         }
         var _loc4_:* = param1.length;
         _displayList.length = _loc4_;
         var _loc3_:int = _loc4_;
         while(true)
         {
            _loc3_--;
            if(!_loc3_)
            {
               break;
            }
            _displayList[_loc3_] = param1[_loc3_];
         }
         var _loc2_:int = _currentDisplayIndex;
         _currentDisplayIndex = -1;
         changeDisplay(_loc2_);
         updateTransform();
      }
      
      public function get display() : Object
      {
         return _currentDisplay;
      }
      
      public function set display(param1:Object) : void
      {
         if(_currentDisplayIndex < 0)
         {
            _currentDisplayIndex = 0;
         }
         if(_displayList[_currentDisplayIndex] == param1)
         {
            return;
         }
         _displayList[_currentDisplayIndex] = param1;
         updateSlotDisplay();
         updateChildArmatureAnimation();
         updateTransform();
      }
      
      public function get childArmature() : Armature
      {
         return _displayList[_currentDisplayIndex] is Armature?_displayList[_currentDisplayIndex]:null;
      }
      
      public function set childArmature(param1:Armature) : void
      {
         display = param1;
      }
      
      public function get zOrder() : Number
      {
         return _originZOrder + _tweenZOrder + _offsetZOrder;
      }
      
      public function set zOrder(param1:Number) : void
      {
         if(zOrder != param1)
         {
            _offsetZOrder = param1 - _originZOrder - _tweenZOrder;
            if(this._armature)
            {
               this._armature._slotsZOrderChanged = true;
            }
         }
      }
      
      public function get blendMode() : String
      {
         return _blendMode;
      }
      
      public function set blendMode(param1:String) : void
      {
         if(_blendMode != param1)
         {
            _blendMode = param1;
            updateDisplayBlendMode(_blendMode);
         }
      }
      
      function updateDisplay(param1:Object) : void
      {
         throw new IllegalOperationError("Abstract method needs to be implemented in subclass!");
      }
      
      function getDisplayIndex() : int
      {
         throw new IllegalOperationError("Abstract method needs to be implemented in subclass!");
      }
      
      function addDisplayToContainer(param1:Object, param2:int = -1) : void
      {
         throw new IllegalOperationError("Abstract method needs to be implemented in subclass!");
      }
      
      function removeDisplayFromContainer() : void
      {
         throw new IllegalOperationError("Abstract method needs to be implemented in subclass!");
      }
      
      function updateTransform() : void
      {
         throw new IllegalOperationError("Abstract method needs to be implemented in subclass!");
      }
      
      function updateDisplayVisible(param1:Boolean) : void
      {
         throw new IllegalOperationError("Abstract method needs to be implemented in subclass!");
      }
      
      function updateDisplayColor(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Boolean = false) : void
      {
         _colorTransform.alphaOffset = param1;
         _colorTransform.redOffset = param2;
         _colorTransform.greenOffset = param3;
         _colorTransform.blueOffset = param4;
         _colorTransform.alphaMultiplier = param5;
         _colorTransform.redMultiplier = param6;
         _colorTransform.greenMultiplier = param7;
         _colorTransform.blueMultiplier = param8;
         _isColorChanged = param9;
      }
      
      function updateDisplayBlendMode(param1:String) : void
      {
         throw new IllegalOperationError("Abstract method needs to be implemented in subclass!");
      }
      
      function arriveAtFrame(param1:Frame, param2:SlotTimelineState, param3:AnimationState, param4:Boolean) : void
      {
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc5_:Boolean = param3.displayControl && param3.containsBoneMask(parent.name);
         if(_loc5_)
         {
            _loc7_ = param1 as SlotFrame;
            _loc8_ = _loc7_.displayIndex;
            changeDisplay(_loc8_);
            updateDisplayVisible(_loc7_.visible);
            if(_loc8_ >= 0)
            {
               if(!isNaN(_loc7_.zOrder) && _loc7_.zOrder != _tweenZOrder)
               {
                  _tweenZOrder = _loc7_.zOrder;
                  this._armature._slotsZOrderChanged = true;
               }
            }
            if(param1.action)
            {
               if(childArmature)
               {
                  childArmature.animation.gotoAndPlay(param1.action);
               }
            }
         }
      }
      
      override protected function updateGlobal() : Object
      {
         var _loc1_:* = null;
         calculateRelativeParentTransform();
         TransformUtil.transformToMatrix(_global,_globalTransformMatrix);
         var _loc2_:Object = calculateParentTransform();
         if(_loc2_ != null)
         {
            _loc1_ = _loc2_.parentGlobalTransformMatrix;
            _globalTransformMatrix.concat(_loc1_);
         }
         TransformUtil.matrixToTransform(_globalTransformMatrix,_global,true,true);
         return _loc2_;
      }
   }
}
