package consortion.view.boss
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ConsortiaBossLevelCell extends Sprite implements Disposeable
   {
       
      
      private var _txt:FilterFrameText;
      
      private var _light:Bitmap;
      
      private var _level:int;
      
      public function ConsortiaBossLevelCell(level:int)
      {
         super();
         _level = level;
         this.buttonMode = true;
         _txt = ComponentFactory.Instance.creatComponentByStylename("consortion.bossFrame.levelShowTxt");
         PositionUtils.setPos(_txt,"consortiaBoss.levelView.cellTxtPos");
         addChild(_txt);
         _light = ComponentFactory.Instance.creatBitmap("asset.consortionBossFrame.levelCellLight");
         _light.visible = false;
         addChild(_light);
         addEventListener("mouseOver",overHandler,false,0,true);
         addEventListener("mouseOut",outHandler,false,0,true);
      }
      
      public function judgeMaxLevel(maxLevel:int) : void
      {
         if(_level > maxLevel)
         {
            this.mouseEnabled = false;
            this.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
      }
      
      public function update(langStr:String) : void
      {
         _txt.text = LanguageMgr.GetTranslation(langStr,_level);
      }
      
      public function changeLightSizePos(width:int, height:int, x:int, y:int) : void
      {
         _light.width = width;
         _light.height = height;
         _light.x = x;
         _light.y = y;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      private function overHandler(event:MouseEvent) : void
      {
         _light.visible = true;
      }
      
      private function outHandler(event:MouseEvent) : void
      {
         _light.visible = false;
      }
      
      public function dispose() : void
      {
      }
   }
}
