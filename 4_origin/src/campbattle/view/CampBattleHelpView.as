package campbattle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   
   public class CampBattleHelpView extends BaseAlerFrame
   {
       
      
      private var _mc:MovieClip;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _back:Bitmap;
      
      public function CampBattleHelpView()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         var alerInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("store.view.HelpButtonText"),"",LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"));
         info = alerInfo;
         _back = ComponentFactory.Instance.creat("camp.battle.back");
         addToContent(_back);
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.views.helpViewScroll");
         addToContent(_scrollPanel);
         _mc = ComponentFactory.Instance.creat("camp.battle.helpdes");
         _scrollPanel.setView(_mc);
         _scrollPanel.invalidateViewport();
      }
      
      override public function dispose() : void
      {
         while(_mc.numChildren)
         {
            ObjectUtils.disposeObject(_mc.getChildAt(0));
         }
         ObjectUtils.disposeObject(_mc);
         super.dispose();
         _mc = null;
      }
   }
}
