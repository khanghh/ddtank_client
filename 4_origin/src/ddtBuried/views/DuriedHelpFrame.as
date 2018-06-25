package ddtBuried.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.MovieClip;
   
   public class DuriedHelpFrame extends BaseAlerFrame
   {
       
      
      private var _mc:MovieClip;
      
      public function DuriedHelpFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         var alerInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("store.view.HelpButtonText"),"",LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"));
         info = alerInfo;
         _mc = ComponentFactory.Instance.creat("buried.shaizi.descript");
         _mc.x = -7;
         _mc.y = -1;
         addToContent(_mc);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_mc);
         super.dispose();
      }
   }
}
