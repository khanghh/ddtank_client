package particleSystem.extensions
{
   public class ColorArgb
   {
       
      
      public var red:Number;
      
      public var green:Number;
      
      public var blue:Number;
      
      public var alpha:Number;
      
      public function ColorArgb(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
      {
         super();
         this.red = param1;
         this.green = param2;
         this.blue = param3;
         this.alpha = param4;
      }
      
      public static function fromRgb(param1:uint) : ColorArgb
      {
         var _loc2_:ColorArgb = new ColorArgb();
         _loc2_.fromRgb(param1);
         return _loc2_;
      }
      
      public static function fromArgb(param1:uint) : ColorArgb
      {
         var _loc2_:ColorArgb = new ColorArgb();
         _loc2_.fromArgb(param1);
         return _loc2_;
      }
      
      public function toRgb() : uint
      {
         var _loc3_:* = Number(red);
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         else if(_loc3_ > 1)
         {
            _loc3_ = 1;
         }
         var _loc1_:* = Number(green);
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         else if(_loc1_ > 1)
         {
            _loc1_ = 1;
         }
         var _loc2_:* = Number(blue);
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         else if(_loc2_ > 1)
         {
            _loc2_ = 1;
         }
         return int(_loc3_ * 255) << 16 | int(_loc1_ * 255) << 8 | int(_loc2_ * 255);
      }
      
      public function toArgb() : uint
      {
         var _loc4_:* = Number(alpha);
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         else if(_loc4_ > 1)
         {
            _loc4_ = 1;
         }
         var _loc3_:* = Number(red);
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         else if(_loc3_ > 1)
         {
            _loc3_ = 1;
         }
         var _loc1_:* = Number(green);
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         else if(_loc1_ > 1)
         {
            _loc1_ = 1;
         }
         var _loc2_:* = Number(blue);
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         else if(_loc2_ > 1)
         {
            _loc2_ = 1;
         }
         return int(_loc4_ * 255) << 24 | int(_loc3_ * 255) << 16 | int(_loc1_ * 255) << 8 | int(_loc2_ * 255);
      }
      
      public function fromRgb(param1:uint) : void
      {
         red = (param1 >> 16 & 255) / 255;
         green = (param1 >> 8 & 255) / 255;
         blue = (param1 & 255) / 255;
      }
      
      public function fromArgb(param1:uint) : void
      {
         red = (param1 >> 16 & 255) / 255;
         green = (param1 >> 8 & 255) / 255;
         blue = (param1 & 255) / 255;
         alpha = (param1 >> 24 & 255) / 255;
      }
      
      public function copyFrom(param1:ColorArgb) : void
      {
         red = param1.red;
         green = param1.green;
         blue = param1.blue;
         alpha = param1.alpha;
      }
   }
}
