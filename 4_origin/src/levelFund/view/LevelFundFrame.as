package levelFund.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   
   public class LevelFundFrame extends Frame
   {
       
      
      private var _levelFundBg:Bitmap;
      
      private var _levelFundView:LevelFundView;
      
      public function LevelFundFrame()
      {
         super();
         this.escEnable = true;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("levelFund.levelFundFrame.title");
         _levelFundBg = ComponentFactory.Instance.creatBitmap("levelFund.levelFundFrame.bg");
         _levelFundView = new LevelFundView();
         PositionUtils.setPos(_levelFundView,"levelFund.levelFundViewPos");
         addToContent(_levelFundBg);
         addToContent(_levelFundView);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
      }
      
      private function __responseHandler(event:FrameEvent) : void
      {
         if(event.responseCode == 0 || event.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_levelFundBg);
         _levelFundBg = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
