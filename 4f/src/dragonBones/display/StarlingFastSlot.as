package dragonBones.display
{
   import dragonBones.fast.FastArmature;
   import dragonBones.fast.FastSlot;
   import flash.geom.Matrix;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Quad;
   
   public class StarlingFastSlot extends FastSlot
   {
       
      
      private var _starlingDisplay:DisplayObject;
      
      public var updateMatrix:Boolean;
      
      public function StarlingFastSlot(){super(null);}
      
      override public function dispose() : void{}
      
      override protected function updateDisplay(param1:Object) : void{}
      
      override protected function getDisplayIndex() : int{return 0;}
      
      override protected function addDisplayToContainer(param1:Object, param2:int = -1) : void{}
      
      override protected function removeDisplayFromContainer() : void{}
      
      override protected function updateTransform() : void{}
      
      override protected function updateDisplayVisible(param1:Boolean) : void{}
      
      override protected function updateDisplayColor(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Boolean = false) : void{}
      
      override protected function updateDisplayBlendMode(param1:String) : void{}
   }
}
