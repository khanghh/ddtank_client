package dragonBones.utils
{
   import flash.geom.ColorTransform;
   
   public class ColorTransformUtil
   {
      
      public static var originalColor:ColorTransform = new ColorTransform();
       
      
      public function ColorTransformUtil()
      {
         super();
      }
      
      public static function cloneColor(param1:ColorTransform) : ColorTransform
      {
         return new ColorTransform(param1.redMultiplier,param1.greenMultiplier,param1.blueMultiplier,param1.alphaMultiplier,param1.redOffset,param1.greenOffset,param1.blueOffset,param1.alphaOffset);
      }
      
      public static function isEqual(param1:ColorTransform, param2:ColorTransform) : Boolean
      {
         return param1.alphaOffset == param2.alphaOffset && param1.redOffset == param2.redOffset && param1.greenOffset == param2.greenOffset && param1.blueOffset == param2.blueOffset && param1.alphaMultiplier == param2.alphaMultiplier && param1.redMultiplier == param2.redMultiplier && param1.greenMultiplier == param2.greenMultiplier && param1.blueMultiplier == param2.blueMultiplier;
      }
      
      public static function minus(param1:ColorTransform, param2:ColorTransform, param3:ColorTransform) : void
      {
         param3.alphaOffset = param1.alphaOffset - param2.alphaOffset;
         param3.redOffset = param1.redOffset - param2.redOffset;
         param3.greenOffset = param1.greenOffset - param2.greenOffset;
         param3.blueOffset = param1.blueOffset - param2.blueOffset;
         param3.alphaMultiplier = param1.alphaMultiplier - param2.alphaMultiplier;
         param3.redMultiplier = param1.redMultiplier - param2.redMultiplier;
         param3.greenMultiplier = param1.greenMultiplier - param2.greenMultiplier;
         param3.blueMultiplier = param1.blueMultiplier - param2.blueMultiplier;
      }
   }
}
