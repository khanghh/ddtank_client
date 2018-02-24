package dragonBones.fast
{
   import dragonBones.cache.SlotFrameCache;
   import dragonBones.core.IArmature;
   import dragonBones.core.ISlotCacheGenerator;
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
      
      public function FastSlot(param1:FastSlot){super();}
      
      public function initWithSlotData(param1:SlotData) : void{}
      
      override public function dispose() : void{}
      
      override function updateByCache() : void{}

       protected function update() : void{}
      
      override protected function calculateRelativeParentTransform() : void{}

       protected function initDisplayList(param1:Array) : void{}
      
      private function clearCurrentDisplay() : int{return 0;}

       protected function changeDisplayIndex(param1:int) : void{}
      
      private function changeSlotDisplay(param1:Object) : void{}
      
      private function initCurrentDisplay(param1:int) : void{}
      
      override public function set visible(param1:Boolean) : void{}
      
      public function get displayList() : Array{return null;}
      
      public function set displayList(param1:Array) : void{}
      
      public function get display() : Object{return null;}
      
      public function set display(param1:Object) : void{}
      
      public function get childArmature() : Object{return null;}
      
      public function set childArmature(param1:Object) : void{}
      
      public function get zOrder() : Number{return 0;}
      
      public function set zOrder(param1:Number) : void{}
      
      public function get blendMode() : String{return null;}
      
      public function set blendMode(param1:String) : void{}
      
      public function get colorTransform() : ColorTransform{return null;}
      
      public function get displayIndex() : int{return 0;}
      
      public function get colorChanged() : Boolean{return false;}

       protected function updateDisplay(param1:Object) : void{}

       protected function getDisplayIndex() : int{return 0;}

       protected  function addDisplayToContainer(param1:Object, param2:int = -1) : void{}

       protected function removeDisplayFromContainer() : void{}

       protected function updateTransform() : void{}

       protected function updateDisplayVisible(param1:Boolean) : void{}

       protected function updateDisplayColor(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Boolean = false) : void{}

       protected function updateDisplayBlendMode(param1:String) : void{}

       protected function arriveAtFrame(param1:Frame, param2:FastAnimationState) : void{}

       protected function hideSlots() : void{}
      
      override protected function updateGlobal() : Object{return null;}
   }
}
