package dragonBones.utils{   import flash.geom.ColorTransform;      public class ColorTransformUtil   {            public static var originalColor:ColorTransform = new ColorTransform();                   public function ColorTransformUtil() { super(); }
            public static function cloneColor(color:ColorTransform) : ColorTransform { return null; }
            public static function isEqual(color1:ColorTransform, color2:ColorTransform) : Boolean { return false; }
            public static function minus(color1:ColorTransform, color2:ColorTransform, outputColor:ColorTransform) : void { }
   }}