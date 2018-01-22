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
      
      public function FastSlot(param1:FastSlot)
      {
         super();
         if(param1 != this)
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
         _displayDataList = null;
         _displayList = null;
         _currentDisplay = null;
      }
      
      override function updateByCache() : void
      {
         super.updateByCache();
         updateTransform();
         var _loc1_:ColorTransform = (this._frameCache as SlotFrameCache).colorTransform;
         var _loc2_:* = _loc1_ != null;
         if(this.colorChanged != _loc2_ || this.colorChanged && _loc2_ && !ColorTransformUtil.isEqual(_colorTransform,_loc1_))
         {
            _loc1_ = _loc1_ || ColorTransformUtil.originalColor;
            updateDisplayColor(_loc1_.alphaOffset,_loc1_.redOffset,_loc1_.greenOffset,_loc1_.blueOffset,_loc1_.alphaMultiplier,_loc1_.redMultiplier,_loc1_.greenMultiplier,_loc1_.blueMultiplier,_loc2_);
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
      
      function initDisplayList(param1:Array) : void
      {
         this._displayList = param1;
      }
      
      private function clearCurrentDisplay() : int
      {
         var _loc2_:* = null;
         if(hasChildArmature)
         {
            _loc2_ = this.childArmature as IArmature;
            if(_loc2_)
            {
               _loc2_.resetAnimation();
            }
         }
         if(_isColorChanged)
         {
            updateDisplayColor(0,0,0,0,1,1,1,1,true);
         }
         var _loc1_:int = getDisplayIndex();
         removeDisplayFromContainer();
         return _loc1_;
      }
      
      function changeDisplayIndex(param1:int) : void
      {
         if(_currentDisplayIndex == param1)
         {
            return;
         }
         var _loc2_:int = -1;
         if(_currentDisplayIndex >= 0)
         {
            _loc2_ = clearCurrentDisplay();
         }
         _currentDisplayIndex = param1;
         if(_displayDataList.length > 0 && _currentDisplayIndex >= 0)
         {
            this._origin.copy(_displayDataList[_currentDisplayIndex].transform);
            this.initCurrentDisplay(_loc2_);
         }
      }
      
      private function changeSlotDisplay(param1:Object) : void
      {
         var _loc2_:int = clearCurrentDisplay();
         _displayList[_currentDisplayIndex] = param1;
         this.initCurrentDisplay(_loc2_);
      }
      
      private function initCurrentDisplay(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc3_:Object = _displayList[_currentDisplayIndex];
         if(_loc3_)
         {
            if(_loc3_ is FastArmature)
            {
               _currentDisplay = (_loc3_ as FastArmature).display;
            }
            else
            {
               _currentDisplay = _loc3_;
            }
         }
         else
         {
            _currentDisplay = null;
         }
         updateDisplay(_currentDisplay);
         if(_currentDisplay)
         {
            if(param1 != -1)
            {
               addDisplayToContainer(this.armature.display,param1);
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
            if(_loc3_ is FastArmature)
            {
               _loc2_ = _loc3_ as FastArmature;
               if(this.armature && this.armature.animation.animationState && _loc2_.animation.hasAnimation(this.armature.animation.animationState.name))
               {
                  _loc2_.animation.gotoAndPlay(this.armature.animation.animationState.name);
               }
               else
               {
                  _loc2_.animation.play();
               }
            }
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
         var _loc2_:Object = param1[_currentDisplayIndex];
         var _loc3_:Boolean = _currentDisplayIndex >= 0 && _displayList[_currentDisplayIndex] != _loc2_;
         _displayList = param1;
         if(_loc3_)
         {
            changeSlotDisplay(_loc2_);
         }
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
         changeSlotDisplay(param1);
      }
      
      public function get childArmature() : Object
      {
         return _displayList[_currentDisplayIndex] is IArmature?_displayList[_currentDisplayIndex]:null;
      }
      
      public function set childArmature(param1:Object) : void
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
      
      public function set blendMode(param1:String) : void
      {
         if(_blendMode != param1)
         {
            _blendMode = param1;
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
      
      function arriveAtFrame(param1:Frame, param2:FastAnimationState) : void
      {
         var _loc3_:* = null;
         var _loc4_:SlotFrame = param1 as SlotFrame;
         var _loc5_:int = _loc4_.displayIndex;
         changeDisplayIndex(_loc5_);
         updateDisplayVisible(_loc4_.visible);
         if(_loc5_ >= 0)
         {
            if(!isNaN(_loc4_.zOrder) && _loc4_.zOrder != _tweenZOrder)
            {
               _tweenZOrder = _loc4_.zOrder;
               this.armature._slotsZOrderChanged = true;
            }
         }
         if(param1.action)
         {
            _loc3_ = childArmature as IArmature;
            if(_loc3_)
            {
               _loc3_.getAnimation().gotoAndPlay(param1.action);
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
