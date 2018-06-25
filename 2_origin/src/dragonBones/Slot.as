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
      
      public function Slot(self:Slot)
      {
         super();
         if(self != this)
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
      
      public function initWithSlotData(slotData:SlotData) : void
      {
         name = slotData.name;
         blendMode = slotData.blendMode;
         _originZOrder = slotData.zOrder;
         _displayDataList = slotData.displayDataList;
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
      
      override function setArmature(value:Armature) : void
      {
         if(_armature == value)
         {
            return;
         }
         if(_armature)
         {
            _armature.removeSlotFromSlotList(this);
         }
         _armature = value;
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
      
      function changeDisplay(displayIndex:int) : void
      {
         var length:* = 0;
         if(displayIndex < 0)
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
            length = uint(_displayList.length);
            if(displayIndex >= length)
            {
               displayIndex = length - 1;
            }
            if(_currentDisplayIndex != displayIndex)
            {
               _isShowDisplay = true;
               _currentDisplayIndex = displayIndex;
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
         var currentDisplayIndex:int = -1;
         if(_currentDisplay)
         {
            currentDisplayIndex = getDisplayIndex();
            removeDisplayFromContainer();
         }
         var displayObj:Object = _displayList[_currentDisplayIndex];
         if(displayObj)
         {
            if(displayObj is Armature)
            {
               _currentDisplay = (displayObj as Armature).display;
            }
            else
            {
               _currentDisplay = displayObj;
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
               if(currentDisplayIndex < 0)
               {
                  this._armature._slotsZOrderChanged = true;
                  addDisplayToContainer(this._armature.display);
               }
               else
               {
                  addDisplayToContainer(this._armature.display,currentDisplayIndex);
               }
            }
            updateDisplayBlendMode(_blendMode);
            updateDisplayColor(_colorTransform.alphaOffset,_colorTransform.redOffset,_colorTransform.greenOffset,_colorTransform.blueOffset,_colorTransform.alphaMultiplier,_colorTransform.redMultiplier,_colorTransform.greenMultiplier,_colorTransform.blueMultiplier);
            updateDisplayVisible(_visible);
            updateTransform();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(this._visible != value)
         {
            this._visible = value;
            updateDisplayVisible(this._visible);
         }
      }
      
      public function get displayList() : Array
      {
         return _displayList;
      }
      
      public function set displayList(value:Array) : void
      {
         if(!value)
         {
            throw new ArgumentError();
         }
         if(_currentDisplayIndex < 0)
         {
            _currentDisplayIndex = 0;
         }
         var _loc4_:* = value.length;
         _displayList.length = _loc4_;
         var i:int = _loc4_;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            _displayList[i] = value[i];
         }
         var displayIndexBackup:int = _currentDisplayIndex;
         _currentDisplayIndex = -1;
         changeDisplay(displayIndexBackup);
         updateTransform();
      }
      
      public function get display() : Object
      {
         return _currentDisplay;
      }
      
      public function set display(value:Object) : void
      {
         if(_currentDisplayIndex < 0)
         {
            _currentDisplayIndex = 0;
         }
         if(_displayList[_currentDisplayIndex] == value)
         {
            return;
         }
         _displayList[_currentDisplayIndex] = value;
         updateSlotDisplay();
         updateChildArmatureAnimation();
         updateTransform();
      }
      
      public function get childArmature() : Armature
      {
         return _displayList[_currentDisplayIndex] is Armature?_displayList[_currentDisplayIndex]:null;
      }
      
      public function set childArmature(value:Armature) : void
      {
         display = value;
      }
      
      public function get zOrder() : Number
      {
         return _originZOrder + _tweenZOrder + _offsetZOrder;
      }
      
      public function set zOrder(value:Number) : void
      {
         if(zOrder != value)
         {
            _offsetZOrder = value - _originZOrder - _tweenZOrder;
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
      
      public function set blendMode(value:String) : void
      {
         if(_blendMode != value)
         {
            _blendMode = value;
            updateDisplayBlendMode(_blendMode);
         }
      }
      
      function updateDisplay(value:Object) : void
      {
         throw new IllegalOperationError("Abstract method needs to be implemented in subclass!");
      }
      
      function getDisplayIndex() : int
      {
         throw new IllegalOperationError("Abstract method needs to be implemented in subclass!");
      }
      
      function addDisplayToContainer(container:Object, index:int = -1) : void
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
      
      function updateDisplayVisible(value:Boolean) : void
      {
         throw new IllegalOperationError("Abstract method needs to be implemented in subclass!");
      }
      
      function updateDisplayColor(aOffset:Number, rOffset:Number, gOffset:Number, bOffset:Number, aMultiplier:Number, rMultiplier:Number, gMultiplier:Number, bMultiplier:Number, colorChanged:Boolean = false) : void
      {
         _colorTransform.alphaOffset = aOffset;
         _colorTransform.redOffset = rOffset;
         _colorTransform.greenOffset = gOffset;
         _colorTransform.blueOffset = bOffset;
         _colorTransform.alphaMultiplier = aMultiplier;
         _colorTransform.redMultiplier = rMultiplier;
         _colorTransform.greenMultiplier = gMultiplier;
         _colorTransform.blueMultiplier = bMultiplier;
         _isColorChanged = colorChanged;
      }
      
      function updateDisplayBlendMode(value:String) : void
      {
         throw new IllegalOperationError("Abstract method needs to be implemented in subclass!");
      }
      
      function arriveAtFrame(frame:Frame, timelineState:SlotTimelineState, animationState:AnimationState, isCross:Boolean) : void
      {
         var slotFrame:* = null;
         var displayIndex:int = 0;
         var childSlot:* = null;
         var displayControl:Boolean = animationState.displayControl && animationState.containsBoneMask(parent.name);
         if(displayControl)
         {
            slotFrame = frame as SlotFrame;
            displayIndex = slotFrame.displayIndex;
            changeDisplay(displayIndex);
            updateDisplayVisible(slotFrame.visible);
            if(displayIndex >= 0)
            {
               if(!isNaN(slotFrame.zOrder) && slotFrame.zOrder != _tweenZOrder)
               {
                  _tweenZOrder = slotFrame.zOrder;
                  this._armature._slotsZOrderChanged = true;
               }
            }
            if(frame.action)
            {
               if(childArmature)
               {
                  childArmature.animation.gotoAndPlay(frame.action);
               }
            }
         }
      }
      
      override protected function updateGlobal() : Object
      {
         var parentMatrix:* = null;
         calculateRelativeParentTransform();
         TransformUtil.transformToMatrix(_global,_globalTransformMatrix);
         var output:Object = calculateParentTransform();
         if(output != null)
         {
            parentMatrix = output.parentGlobalTransformMatrix;
            _globalTransformMatrix.concat(parentMatrix);
         }
         TransformUtil.matrixToTransform(_globalTransformMatrix,_global,true,true);
         return output;
      }
   }
}
