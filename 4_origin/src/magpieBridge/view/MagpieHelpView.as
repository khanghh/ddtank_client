package magpieBridge.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.MovieClip;
   
   public class MagpieHelpView extends BaseAlerFrame
   {
       
      
      private var _mc:MovieClip;
      
      public function MagpieHelpView()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("store.view.HelpButtonText"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"));
         _loc1_.showCancel = false;
         info = _loc1_;
         _mc = ComponentFactory.Instance.creat("asset.magpieView.helpInfo");
         _mc.x = -7;
         _mc.y = 1;
         addToContent(_mc);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_mc);
         super.dispose();
      }
   }
}
