package ddt.view.academyCommon.recommend
{
   import academy.AcademyManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.AcademyFrameManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class RecommendMasterPlayerCellView extends RecommendPlayerCellView implements Disposeable
   {
       
      
      public function RecommendMasterPlayerCellView()
      {
         super();
      }
      
      override protected function initRecommendBtn() : void
      {
         _recommendBtn = ComponentFactory.Instance.creatComponentByStylename("academyCommon.RecommendPlayerCellView.apprentice");
         _recommendBtn.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.RecommendPlayerCellView.apprentice");
         addChild(_recommendBtn);
      }
      
      override protected function __recommendBtn(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!AcademyManager.Instance.compareState(_info.info,PlayerManager.Instance.Self))
         {
            return;
         }
         if(AcademyManager.Instance.isFreezes(false))
         {
            AcademyFrameManager.Instance.showAcademyRequestApprenticeFrame(_info.info);
         }
      }
   }
}
