package dragonBones{   import dragonBones.animation.AnimationState;   import dragonBones.animation.SlotTimelineState;   import dragonBones.core.DBObject;   import dragonBones.objects.DisplayData;   import dragonBones.objects.Frame;   import dragonBones.objects.SlotData;   import dragonBones.objects.SlotFrame;   import dragonBones.utils.TransformUtil;   import flash.errors.IllegalOperationError;   import flash.geom.ColorTransform;   import flash.geom.Matrix;      public class Slot extends DBObject   {                   var _displayDataList:Vector.<DisplayData>;            var _originZOrder:Number;            var _tweenZOrder:Number;            protected var _offsetZOrder:Number;            protected var _displayList:Array;            protected var _currentDisplayIndex:int;            protected var _colorTransform:ColorTransform;            protected var _currentDisplay:Object;            var _isShowDisplay:Boolean;            protected var _blendMode:String;            var _isColorChanged:Boolean;            public function Slot(self:Slot) { super(); }
            public function initWithSlotData(slotData:SlotData) : void { }
            override public function dispose() : void { }
            override protected function setArmature(value:Armature) : void { }
            protected function update() : void { }
            override protected function calculateRelativeParentTransform() : void { }
            private function updateChildArmatureAnimation() : void { }
            protected function changeDisplay(displayIndex:int) : void { }
            function updateSlotDisplay() : void { }
            override public function set visible(value:Boolean) : void { }
            public function get displayList() : Array { return null; }
            public function set displayList(value:Array) : void { }
            public function get display() : Object { return null; }
            public function set display(value:Object) : void { }
            public function get childArmature() : Armature { return null; }
            public function set childArmature(value:Armature) : void { }
            public function get zOrder() : Number { return 0; }
            public function set zOrder(value:Number) : void { }
            public function get blendMode() : String { return null; }
            public function set blendMode(value:String) : void { }
            protected function updateDisplay(value:Object) : void { }
            protected function getDisplayIndex() : int { return 0; }
            protected function addDisplayToContainer(container:Object, index:int = -1) : void { }
            protected function removeDisplayFromContainer() : void { }
            protected function updateTransform() : void { }
            protected function updateDisplayVisible(value:Boolean) : void { }
            protected function updateDisplayColor(aOffset:Number, rOffset:Number, gOffset:Number, bOffset:Number, aMultiplier:Number, rMultiplier:Number, gMultiplier:Number, bMultiplier:Number, colorChanged:Boolean = false) : void { }
            protected function updateDisplayBlendMode(value:String) : void { }
            function arriveAtFrame(frame:Frame, timelineState:SlotTimelineState, animationState:AnimationState, isCross:Boolean) : void { }
            override protected function updateGlobal() : Object { return null; }
   }}