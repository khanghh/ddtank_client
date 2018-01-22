package consortion.rank
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   
   public class HelpFrame extends BaseAlerFrame
   {
       
      
      private var _mc:MovieClip;
      
      public function HelpFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("store.view.HelpButtonText"),"",LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"));
         info = _loc1_;
         _mc = ComponentFactory.Instance.creat("consortion.rank.descript");
         _mc.x = -7;
         _mc.y = -1;
         addToContent(_mc);
         initEvents();
      }
      
      private function initEvents() : void
      {
         addEventListener("response",frameHander);
      }
      
      private function frameHander(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",frameHander);
         ObjectUtils.disposeObject(_mc);
         super.dispose();
         _mc = null;
      }
   }
}
