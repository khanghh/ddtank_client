package particleSystem.extensions
{
   public class ColorArgb
   {
       
      
      public var red:Number;
      
      public var green:Number;
      
      public var blue:Number;
      
      public var alpha:Number;
      
      public function ColorArgb(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0){super();}
      
      public static function fromRgb(param1:uint) : ColorArgb{return null;}
      
      public static function fromArgb(param1:uint) : ColorArgb{return null;}
      
      public function toRgb() : uint{return null;}
      
      public function toArgb() : uint{return null;}
      
      public function fromRgb(param1:uint) : void{}
      
      public function fromArgb(param1:uint) : void{}
      
      public function copyFrom(param1:ColorArgb) : void{}
   }
}
