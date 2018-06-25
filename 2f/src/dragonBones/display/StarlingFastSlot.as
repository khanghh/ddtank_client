package dragonBones.display{   import dragonBones.fast.FastArmature;   import dragonBones.fast.FastSlot;   import flash.geom.Matrix;   import starling.display.DisplayObject;   import starling.display.DisplayObjectContainer;   import starling.display.Quad;      public class StarlingFastSlot extends FastSlot   {                   private var _starlingDisplay:DisplayObject;            public var updateMatrix:Boolean;            public function StarlingFastSlot() { super(null); }
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