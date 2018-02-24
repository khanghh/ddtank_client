package gameCommon
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import road7th.StarlingMain;
   import starling.display.Image;
   
   public class BloodNumberCreater
   {
      
      private static var greenData:Vector.<BitmapData>;
      
      private static var redData:Vector.<BitmapData>;
       
      
      public function BloodNumberCreater(){super();}
      
      public static function setup() : void{}
      
      public static function createGreenNum(param1:int) : Bitmap{return null;}
      
      public static function createRedNum(param1:int) : Bitmap{return null;}
      
      public static function createGreenImageNum(param1:int) : Image{return null;}
      
      public static function createRedImageNum(param1:int) : Image{return null;}
      
      public static function createHPStrip(param1:int) : Image{return null;}
      
      public static function dispose() : void{}
   }
}
