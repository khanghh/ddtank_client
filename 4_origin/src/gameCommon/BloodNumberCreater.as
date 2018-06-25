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
         var i:int = 0;
         redData = new Vector.<BitmapData>();
         greenData = new Vector.<BitmapData>();
         for(i = 0; i < 10; )
         {
            redData.push(ComponentFactory.Instance.creatBitmapData("asset.game.bloodNUm" + i + "Asset"));
            greenData.push(ComponentFactory.Instance.creatBitmapData("asset.game.bloodNUma" + i + "Asset"));
            i++;
         }
      }
      
      public static function createGreenNum(value:int) : Bitmap
      {
         var bitmap:Bitmap = new Bitmap(greenData[value]);
         return bitmap;
      }
      
      public static function createRedNum(value:int) : Bitmap
      {
         var bitmap:Bitmap = new Bitmap(redData[value]);
         return bitmap;
      }
      
      public static function createGreenImageNum(value:int) : Image
      {
         var image:Image = StarlingMain.instance.createImage("game_blood_gNum" + value);
         return image;
      }
      
      public static function createRedImageNum(value:int) : Image
      {
         var image:Image = StarlingMain.instance.createImage("game_blood_rNum" + value);
         return image;
      }
      
      public static function createHPStrip(team:int) : Image
      {
         if(team >= 5)
         {
            team = 9 - team;
         }
         var image:Image = StarlingMain.instance.createImage("game_HPStrip" + team);
         return image;
      }
      
      public static function dispose() : void
      {
         var i:int = 0;
         for(i = 0; i < 10; )
         {
            redData[i].dispose();
            redData[i] = null;
            greenData[i].dispose();
            greenData[i] = null;
            i++;
         }
      }
   }
}
