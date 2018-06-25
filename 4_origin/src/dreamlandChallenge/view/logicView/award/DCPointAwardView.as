package dreamlandChallenge.view.logicView.award
{
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import dreamlandChallenge.DreamlandChallengeControl;
   import dreamlandChallenge.DreamlandChallengeManager;
   import dreamlandChallenge.data.DCSpeedMatchRankMode;
   import dreamlandChallenge.view.mornui.award.DCPointAwardViewUI;
   import morn.core.components.Component;
   import morn.core.handlers.Handler;
   
   public class DCPointAwardView extends DCPointAwardViewUI
   {
       
      
      private var _control:DreamlandChallengeControl;
      
      private var _selfRank:int = 0;
      
      public function DCPointAwardView(ctrl:DreamlandChallengeControl)
      {
         _control = ctrl;
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         text1.text = LanguageMgr.GetTranslation("ddt.dreamLand.view.text12");
         text2.text = LanguageMgr.GetTranslation("ddt.dreamLand.view.text13");
         var temModel:DCSpeedMatchRankMode = DreamlandChallengeManager.instance.mode.rankModel;
         _selfRank = temModel != null?temModel.selfRanking:0;
         btn_close.clickHandler = new Handler(__closeView);
         point_list.renderHandler = new Handler(__pointAwardListRender);
         lbl_myRanking.text = _selfRank.toString();
         initAwards();
      }
      
      private function initAwards() : void
      {
         point_list.array = _control.getAwardsByDiffcultyType(5);
      }
      
      private function __pointAwardListRender(item:Component, index:int) : void
      {
         var render:DCAwardItemView = item as DCAwardItemView;
         if(index < point_list.length)
         {
            render.selfRank = _selfRank;
            render.info = point_list.array[index];
         }
         else
         {
            render.selfRank = 0;
            render.info = null;
         }
      }
      
      private function __closeView() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,false,1);
      }
      
      override public function dispose() : void
      {
         _control = null;
         super.dispose();
      }
   }
}
