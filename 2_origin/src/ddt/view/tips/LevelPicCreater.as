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
       
      
      public function LevelPicCreater()
      {
         super();
      }
      
      public static function creatLelvePic(level:int) : Sprite
      {
         var units:int = 0;
         var tens:int = 0;
         var ub:* = null;
         var tb:* = null;
         var result:Sprite = new Sprite();
         if(level < 10)
         {
            result.addChild(ComponentFactory.Instance.creatBitmap("asset.core.leveltip." + LEVELTIPCLASSES[level]));
         }
         else if(level > 9)
         {
            units = level / 10;
            tens = level % 10;
            ub = ComponentFactory.Instance.creatBitmap("asset.core.leveltip." + LEVELTIPCLASSES[units]);
            tb = ComponentFactory.Instance.creatBitmap("asset.core.leveltip." + LEVELTIPCLASSES[tens]);
            tb.x = ub.width;
            result.addChild(ub);
            result.addChild(tb);
         }
         return result;
      }
      
      public static function creatLevelPicInContainer(parentObj:DisplayObjectContainer, _level:int, dx:int, dy:int, zeroPro:Boolean = true) : void
      {
         var _tmp:* = 0;
         var _lt1:* = null;
         var _lt2:* = null;
         if(_level > 9)
         {
            _tmp = uint(Math.floor(_level / 10));
            _lt1 = ComponentFactory.Instance.creat("asset.core.leveltip." + LEVELTIPCLASSES[_tmp]);
            _lt1.x = dx - 4;
            _lt1.y = dy;
            parentObj.addChild(_lt1);
            _tmp = uint(_level % 10);
            _lt2 = ComponentFactory.Instance.creat("asset.core.leveltip." + LEVELTIPCLASSES[_tmp]);
            _lt2.x = _lt1.x + _lt1.width - 3;
            _lt2.y = _lt1.y;
            parentObj.addChild(_lt2);
         }
         else if(zeroPro)
         {
            _tmp = uint(0);
            _lt1 = ComponentFactory.Instance.creat("asset.core.leveltip." + LEVELTIPCLASSES[_tmp]);
            _lt1.x = dx - 4;
            _lt1.y = dy;
            parentObj.addChild(_lt1);
            _tmp = uint(_level);
            _lt2 = ComponentFactory.Instance.creat("asset.core.leveltip." + LEVELTIPCLASSES[_tmp]);
            _lt2.x = _lt1.x + _lt1.width - 3;
            _lt2.y = _lt1.y;
            parentObj.addChild(_lt2);
         }
         else
         {
            _tmp = uint(_level);
            _lt2 = ComponentFactory.Instance.creat("asset.core.leveltip." + LEVELTIPCLASSES[_tmp]);
            _lt2.x = dx;
            _lt2.y = dy;
            parentObj.addChild(_lt2);
         }
      }
   }
}
