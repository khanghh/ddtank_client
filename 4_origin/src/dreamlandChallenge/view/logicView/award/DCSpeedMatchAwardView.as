package dreamlandChallenge.view.logicView.award
{
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import dreamlandChallenge.DreamlandChallengeControl;
   import dreamlandChallenge.DreamlandChallengeManager;
   import dreamlandChallenge.data.DCSpeedMatchRankMode;
   import dreamlandChallenge.view.mornui.award.DCSpeedMatchAwardViewUI;
   import morn.core.components.Component;
   import morn.core.handlers.Handler;
   
   public class DCSpeedMatchAwardView extends DCSpeedMatchAwardViewUI
   {
       
      
      private var _curDiffculty:int = -1;
      
      private var _control:DreamlandChallengeControl;
      
      private var _selfRank:int = 0;
      
      public function DCSpeedMatchAwardView(ctrl:DreamlandChallengeControl)
      {
         _control = ctrl;
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         text1.text = LanguageMgr.GetTranslation("ddt.dreamLand.view.text14");
         var temModel:DCSpeedMatchRankMode = DreamlandChallengeManager.instance.mode.rankModel;
         _selfRank = temModel != null?temModel.selfRanking:0;
         btn_close.clickHandler = new Handler(__closeView);
         tab_award.selectedIndex = 0;
         tab_award.selectHandler = new Handler(__tabChangeHandler);
         speedMatch_list.renderHandler = new Handler(__speedMatchListRender);
         curDiffculty = 1;
      }
      
      private function __tabChangeHandler(index:int) : void
      {
         SoundManager.instance.playButtonSound();
         curDiffculty = index + 1;
      }
      
      private function __speedMatchListRender(item:Component, index:int) : void
      {
         var render:DCAwardItemView = item as DCAwardItemView;
         if(index < speedMatch_list.length)
         {
            render.selfRank = _selfRank;
            render.isSpeedMatch = true;
            render.info = speedMatch_list.array[index];
         }
         else
         {
            render.selfRank = 0;
            render.info = null;
         }
      }
      
      public function get curDiffculty() : int
      {
         return _curDiffculty;
      }
      
      public function set curDiffculty(value:int) : void
      {
         _curDiffculty = value;
         initAwards();
      }
      
      private function initAwards() : void
      {
         speedMatch_list.array = _control.getAwardsByDiffcultyType(curDiffculty);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,false,1);
      }
      
      private function __closeView() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      override public function dispose() : void
      {
         _control = null;
         super.dispose();
      }
   }
}
