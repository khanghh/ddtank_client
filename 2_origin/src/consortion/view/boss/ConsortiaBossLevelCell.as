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
      
      public function ConsortiaBossLevelCell(param1:int)
      {
         super();
         _level = param1;
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
      
      public function judgeMaxLevel(param1:int) : void
      {
         if(_level > param1)
         {
            this.mouseEnabled = false;
            this.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
      }
      
      public function update(param1:String) : void
      {
         _txt.text = LanguageMgr.GetTranslation(param1,_level);
      }
      
      public function changeLightSizePos(param1:int, param2:int, param3:int, param4:int) : void
      {
         _light.width = param1;
         _light.height = param2;
         _light.x = param3;
         _light.y = param4;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         _light.visible = true;
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         _light.visible = false;
      }
      
      public function dispose() : void
      {
      }
   }
}
