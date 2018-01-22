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
       
      
      public function BloodNumberCreater()
      {
         super();
      }
      
      public static function setup() : void
      {
         var _loc1_:int = 0;
         redData = new Vector.<BitmapData>();
         greenData = new Vector.<BitmapData>();
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            redData.push(ComponentFactory.Instance.creatBitmapData("asset.game.bloodNUm" + _loc1_ + "Asset"));
            greenData.push(ComponentFactory.Instance.creatBitmapData("asset.game.bloodNUma" + _loc1_ + "Asset"));
            _loc1_++;
         }
      }
      
      public static function createGreenNum(param1:int) : Bitmap
      {
         var _loc2_:Bitmap = new Bitmap(greenData[param1]);
         return _loc2_;
      }
      
      public static function createRedNum(param1:int) : Bitmap
      {
         var _loc2_:Bitmap = new Bitmap(redData[param1]);
         return _loc2_;
      }
      
      public static function createGreenImageNum(param1:int) : Image
      {
         var _loc2_:Image = StarlingMain.instance.createImage("game_blood_gNum" + param1);
         return _loc2_;
      }
      
      public static function createRedImageNum(param1:int) : Image
      {
         var _loc2_:Image = StarlingMain.instance.createImage("game_blood_rNum" + param1);
         return _loc2_;
      }
      
      public static function createHPStrip(param1:int) : Image
      {
         if(param1 >= 5)
         {
            param1 = 9 - param1;
         }
         var _loc2_:Image = StarlingMain.instance.createImage("game_HPStrip" + param1);
         return _loc2_;
      }
      
      public static function dispose() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            redData[_loc1_].dispose();
            redData[_loc1_] = null;
            greenData[_loc1_].dispose();
            greenData[_loc1_] = null;
            _loc1_++;
         }
      }
   }
}
