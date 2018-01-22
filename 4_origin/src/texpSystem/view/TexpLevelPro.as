package texpSystem.view
{
   import bagAndInfo.info.LevelProgress;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.utils.PositionUtils;
   
   public class TexpLevelPro extends LevelProgress
   {
       
      
      public function TexpLevelPro()
      {
         super();
         _width = 141;
         _height = 10;
         initView();
         drawProgress();
      }
      
      override protected function initView() : void
      {
         _background = ComponentFactory.Instance.creatBitmap("texpSystem.Background_Progress2");
         PositionUtils.setPos(_background,"texpSystem.expBackground2Pos");
         addChild(_background);
         _thuck = ComponentFactory.Instance.creatComponentByStylename("texpSystem.expComponent");
         addChild(_thuck);
         _graphics_thuck = ComponentFactory.Instance.creatBitmapData("texpSystem.Bitmap_thuck");
         _progressLabel = ComponentFactory.Instance.creatComponentByStylename("texpSystem.info.LevelProgressText");
         addChild(_progressLabel);
      }
   }
}
