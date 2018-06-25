package dragonBones.fast
{
   import dragonBones.cache.SlotFrameCache;
   import dragonBones.core.IArmature;
   import dragonBones.core.ISlotCacheGenerator;
   import dragonBones.§core:dragonBones_internal§._colorTransform;
   import dragonBones.§core:dragonBones_internal§._displayDataList;
   import dragonBones.§core:dragonBones_internal§._frameCache;
   import dragonBones.§core:dragonBones_internal§._global;
   import dragonBones.§core:dragonBones_internal§._globalTransformMatrix;
   import dragonBones.§core:dragonBones_internal§._isColorChanged;
   import dragonBones.§core:dragonBones_internal§._originZOrder;
   import dragonBones.§core:dragonBones_internal§._tweenZOrder;
   import dragonBones.§core:dragonBones_internal§.addDisplayToContainer;
   import dragonBones.§core:dragonBones_internal§.changeDisplayIndex;
   import dragonBones.§core:dragonBones_internal§.getDisplayIndex;
   import dragonBones.§core:dragonBones_internal§.removeDisplayFromContainer;
   import dragonBones.§core:dragonBones_internal§.updateDisplay;
   import dragonBones.§core:dragonBones_internal§.updateDisplayBlendMode;
   import dragonBones.§core:dragonBones_internal§.updateDisplayColor;
   import dragonBones.§core:dragonBones_internal§.updateDisplayVisible;
   import dragonBones.§core:dragonBones_internal§.updateTransform;
   import dragonBones.fast.animation.FastAnimationState;
   import dragonBones.objects.DisplayData;
   import dragonBones.objects.Frame;
   import dragonBones.objects.SlotData;
   import dragonBones.objects.SlotFrame;
   import dragonBones.utils.ColorTransformUtil;
   import dragonBones.utils.TransformUtil;
   import flash.errors.IllegalOperationError;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   
   public class FastSlot extends FastDBObject implements ISlotCacheGenerator
   {
       
      
      var _displayDataList:Vector.<DisplayData>;
      
      var _originZOrder:Number;
      
      var _tweenZOrder:Number;
      
      protected var _offsetZOrder:Number;
      
      protected var _displayList:Array;
      
      protected var _currentDisplayIndex:int;
      
      var _colorTransform:ColorTransform;
      
      var _isColorChanged:Boolean;
      
      protected var _currentDisplay:Object;
      
      protected var _blendMode:String;
      
      public var hasChildArmature:Boolean;
      
      public function FastSlot(self:FastSlot)
      {
         super();
         if(self != this)
         {
            throw new IllegalOperationError("Abstract class can not be instantiated!");
         }
         hasChildArmature = false;
         _currentDisplayIndex = -1;
         _originZOrder = 0;
         _tweenZOrder = 0;
         _offsetZOrder = 0;
         _colorTransform = new ColorTransform();
         _isColorChanged = false;
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
         _displayDataList = null;
         _displayList = null;
         _currentDisplay = null;
      }
      
      override function updateByCache() : void
      {
         super.updateByCache();
         updateTransform();
         var cacheColor:ColorTransform = (this._frameCache as SlotFrameCache).colorTransform;
         var cacheColorChanged:* = cacheColor != null;
         if(this.colorChanged != cacheColorChanged || this.colorChanged && cacheColorChanged && !ColorTransformUtil.isEqual(_colorTransform,cacheColor))
         {
            cacheColor = cacheColor || ColorTransformUtil.originalColor;
            updateDisplayColor(cacheColor.alphaOffset,cacheColor.redOffset,cacheColor.greenOffset,cacheColor.blueOffset,cacheColor.alphaMultiplier,cacheColor.redMultiplier,cacheColor.greenMultiplier,cacheColor.blueMultiplier,cacheColorChanged);
         }
         changeDisplayIndex((this._frameCache as SlotFrameCache).displayIndex);
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
         _global.copy(this._origin);
      }
      
      function initDisplayList(newDisplayList:Array) : void
      {
         this._displayList = newDisplayList;
      }
      
      private function clearCurrentDisplay() : int
      {
         var targetArmature:* = null;
         if(hasChildArmature)
         {
            targetArmature = this.childArmature as IArmature;
            if(targetArmature)
            {
               targetArmature.resetAnimation();
            }
         }
         if(_isColorChanged)
         {
            updateDisplayColor(0,0,0,0,1,1,1,1,true);
         }
         var slotIndex:int = getDisplayIndex();
         removeDisplayFromContainer();
         return slotIndex;
      }
      
      function changeDisplayIndex(displayIndex:int) : void
      {
         if(_currentDisplayIndex == displayIndex)
         {
            return;
         }
         var slotIndex:int = -1;
         if(_currentDisplayIndex >= 0)
         {
            slotIndex = clearCurrentDisplay();
         }
         _currentDisplayIndex = displayIndex;
         if(_displayDataList.length > 0 && _currentDisplayIndex >= 0)
         {
            this._origin.copy(_displayDataList[_currentDisplayIndex].transform);
            this.initCurrentDisplay(slotIndex);
         }
      }
      
      private function changeSlotDisplay(value:Object) : void
      {
         var slotIndex:int = clearCurrentDisplay();
         _displayList[_currentDisplayIndex] = value;
         this.initCurrentDisplay(slotIndex);
      }
      
      private function initCurrentDisplay(slotIndex:int) : void
      {
         var targetArmature:* = null;
         var display:Object = _displayList[_currentDisplayIndex];
         if(display)
         {
            if(display is FastArmature)
            {
               _currentDisplay = (display as FastArmature).display;
            }
            else
            {
               _currentDisplay = display;
            }
         }
         else
         {
            _currentDisplay = null;
         }
         updateDisplay(_currentDisplay);
         if(_currentDisplay)
         {
            if(slotIndex != -1)
            {
               addDisplayToContainer(this.armature.display,slotIndex);
            }
            else
            {
               this.armature._slotsZOrderChanged = true;
               addDisplayToContainer(this.armature.display);
            }
            if(_blendMode)
            {
               updateDisplayBlendMode(_blendMode);
            }
            if(_isColorChanged)
            {
               updateDisplayColor(_colorTransform.alphaOffset,_colorTransform.redOffset,_colorTransform.greenOffset,_colorTransform.blueOffset,_colorTransform.alphaMultiplier,_colorTransform.redMultiplier,_colorTransform.greenMultiplier,_colorTransform.blueMultiplier,true);
            }
            updateTransform();
            if(display is FastArmature)
            {
               targetArmature = display as FastArmature;
               if(this.armature && this.armature.animation.animationState && targetArmature.animation.hasAnimation(this.armature.animation.animationState.name))
               {
                  targetArmature.animation.gotoAndPlay(this.armature.animation.animationState.name);
               }
               else
               {
                  targetArmature.animation.play();
               }
            }
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
         var newDisplay:Object = value[_currentDisplayIndex];
         var displayChanged:Boolean = _currentDisplayIndex >= 0 && _displayList[_currentDisplayIndex] != newDisplay;
         _displayList = value;
         if(displayChanged)
         {
            changeSlotDisplay(newDisplay);
         }
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
         changeSlotDisplay(value);
      }
      
      public function get childArmature() : Object
      {
         return _displayList[_currentDisplayIndex] is IArmature?_displayList[_currentDisplayIndex]:null;
      }
      
      public function set childArmature(value:Object) : void
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
            if(this.armature)
            {
               this.armature._slotsZOrderChanged = true;
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
      
      public function get colorTransform() : ColorTransform
      {
         return _colorTransform;
      }
      
      public function get displayIndex() : int
      {
         return _currentDisplayIndex;
      }
      
      public function get colorChanged() : Boolean
      {
         return _isColorChanged;
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
      
      function arriveAtFrame(frame:Frame, animationState:FastAnimationState) : void
      {
         var targetArmature:* = null;
         var slotFrame:SlotFrame = frame as SlotFrame;
         var displayIndex:int = slotFrame.displayIndex;
         changeDisplayIndex(displayIndex);
         updateDisplayVisible(slotFrame.visible);
         if(displayIndex >= 0)
         {
            if(!isNaN(slotFrame.zOrder) && slotFrame.zOrder != _tweenZOrder)
            {
               _tweenZOrder = slotFrame.zOrder;
               this.armature._slotsZOrderChanged = true;
            }
         }
         if(frame.action)
         {
            targetArmature = childArmature as IArmature;
            if(targetArmature)
            {
               targetArmature.getAnimation().gotoAndPlay(frame.action);
            }
         }
      }
      
      function hideSlots() : void
      {
         changeDisplayIndex(-1);
         removeDisplayFromContainer();
         if(_frameCache)
         {
            this._frameCache.clear();
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
