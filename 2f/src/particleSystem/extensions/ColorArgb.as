package particleSystem.extensions{   public class ColorArgb   {                   public var red:Number;            public var green:Number;            public var blue:Number;            public var alpha:Number;            public function ColorArgb(red:Number = 0, green:Number = 0, blue:Number = 0, alpha:Number = 0) { super(); }
            public static function fromRgb(color:uint) : ColorArgb { return null; }
            public static function fromArgb(color:uint) : ColorArgb { return null; }
            public function toRgb() : uint { return null; }
            public function toArgb() : uint { return null; }
            public function fromRgb(color:uint) : void { }
            public function fromArgb(color:uint) : void { }
            public function copyFrom(argb:ColorArgb) : void { }
   }}