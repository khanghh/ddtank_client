package dragonBones.display{   import dragonBones.fast.FastSlot;   import flash.display.DisplayObject;   import flash.display.DisplayObjectContainer;      public class NativeFastSlot extends FastSlot   {                   private var _nativeDisplay:DisplayObject;            public function NativeFastSlot() { super(null); }
            override public function dispose() : void { }
            override protected function updateDisplay(value:Object) : void { }
            override protected function getDisplayIndex() : int { return 0; }
            override protected function addDisplayToContainer(container:Object, index:int = -1) : void { }
            override protected function removeDisplayFromContainer() : void { }
            override protected function updateTransform() : void { }
            override protected function updateDisplayVisible(value:Boolean) : void { }
            override protected function updateDisplayColor(aOffset:Number, rOffset:Number, gOffset:Number, bOffset:Number, aMultiplier:Number, rMultiplier:Number, gMultiplier:Number, bMultiplier:Number, colorChanged:Boolean = false) : void { }
            override protected function updateDisplayBlendMode(value:String) : void { }
   }}