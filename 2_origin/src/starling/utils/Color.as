package starling.utils
{
   import starling.errors.AbstractClassError;
   
   public class Color
   {
      
      public static const WHITE:uint = 16777215;
      
      public static const SILVER:uint = 12632256;
      
      public static const GRAY:uint = 8421504;
      
      public static const BLACK:uint = 0;
      
      public static const RED:uint = 16711680;
      
      public static const MAROON:uint = 8388608;
      
      public static const YELLOW:uint = 16776960;
      
      public static const OLIVE:uint = 8421376;
      
      public static const LIME:uint = 65280;
      
      public static const GREEN:uint = 32768;
      
      public static const AQUA:uint = 65535;
      
      public static const TEAL:uint = 32896;
      
      public static const BLUE:uint = 255;
      
      public static const NAVY:uint = 128;
      
      public static const FUCHSIA:uint = 16711935;
      
      public static const PURPLE:uint = 8388736;
       
      
      public function Color()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function getAlpha(color:uint) : int
      {
         return color >> 24 & 255;
      }
      
      public static function getRed(color:uint) : int
      {
         return color >> 16 & 255;
      }
      
      public static function getGreen(color:uint) : int
      {
         return color >> 8 & 255;
      }
      
      public static function getBlue(color:uint) : int
      {
         return color & 255;
      }
      
      public static function rgb(red:int, green:int, blue:int) : uint
      {
         return red << 16 | green << 8 | blue;
      }
      
      public static function argb(alpha:int, red:int, green:int, blue:int) : uint
      {
         return alpha << 24 | red << 16 | green << 8 | blue;
      }
   }
}
