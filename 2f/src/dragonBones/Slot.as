package dragonBones
{
   import dragonBones.animation.AnimationState;
   import dragonBones.animation.SlotTimelineState;
   import dragonBones.core.DBObject;
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
      
      public function Slot(param1:Slot){super();}
      
      public function initWithSlotData(param1:SlotData) : void{}
      
      override public function dispose() : void{}
      
      override protected function setArmature(param1:Armature) : void{}

       protected function update() : void{}
      
      override protected function calculateRelativeParentTransform() : void{}
      
      private function updateChildArmatureAnimation() : void{}

       protected  function changeDisplay(param1:int) : void{}

       protected function updateSlotDisplay() : void{}
      
      override public function set visible(param1:Boolean) : void{}
      
      public function get displayList() : Array{return null;}
      
      public function set displayList(param1:Array) : void{}
      
      public function get display() : Object{return null;}
      
      public function set display(param1:Object) : void{}
      
      public function get childArmature() : Armature{return null;}
      
      public function set childArmature(param1:Armature) : void{}
      
      public function get zOrder() : Number{return 0;}
      
      public function set zOrder(param1:Number) : void{}
      
      public function get blendMode() : String{return null;}
      
      public function set blendMode(param1:String) : void{}

       protected function updateDisplay(param1:Object) : void{}

       protected function getDisplayIndex() : int{return 0;}

       protected function addDisplayToContainer(param1:Object, param2:int = -1) : void{}

       protected function removeDisplayFromContainer() : void{}

       protected function updateTransform() : void{}

       protected  function updateDisplayVisible(param1:Boolean) : void{}

       protected function updateDisplayColor(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Boolean = false) : void{}

       protected function updateDisplayBlendMode(param1:String) : void{}

       protected function arriveAtFrame(param1:Frame, param2:SlotTimelineState, param3:AnimationState, param4:Boolean) : void{}
      
      override protected function updateGlobal() : Object{return null;}
   }
}
