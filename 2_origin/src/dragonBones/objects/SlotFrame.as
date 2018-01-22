package dragonBones.objects
{
   import flash.geom.ColorTransform;
   
   public final class SlotFrame extends Frame
   {
       
      
      public var tweenEasing:Number;
      
      public var displayIndex:int;
      
      public var visible:Boolean;
      
      public var zOrder:Number;
      
      public var color:ColorTransform;
      
      public function SlotFrame()
      {
         super();
         tweenEasing = 10;
         displayIndex = 0;
         visible = true;
         zOrder = NaN;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         color = null;
      }
      
      public function get colorChanged() : Boolean
      {
         if(color && (color.alphaMultiplier != 1 || color.alphaOffset != 0 || color.blueMultiplier != 1 || color.blueOffset != 0 || color.greenMultiplier != 1 || color.greenOffset != 0 || color.redMultiplier != 1 || color.redOffset != 0))
         {
            return true;
         }
         return false;
      }
   }
}
