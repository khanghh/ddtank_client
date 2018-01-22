package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   
   public class LevelPicCreater
   {
      
      private static const pathTip:String = "asset.core.leveltip.";
      
      public static var LEVELTIPCLASSES:Array = ["Level_Tip_0","Level_Tip_1","Level_Tip_2","Level_Tip_3","Level_Tip_4","Level_Tip_5","Level_Tip_6","Level_Tip_7","Level_Tip_8","Level_Tip_9"];
       
      
      public function LevelPicCreater(){super();}
      
      public static function creatLelvePic(param1:int) : Sprite{return null;}
      
      public static function creatLevelPicInContainer(param1:DisplayObjectContainer, param2:int, param3:int, param4:int, param5:Boolean = true) : void{}
   }
}
