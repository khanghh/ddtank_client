package dreamlandChallenge.view.logicView.ranking
{
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import dreamlandChallenge.DreamlandChallengeControl;
   import dreamlandChallenge.data.DCSpeedMatchRankMode;
   import dreamlandChallenge.data.DreamLandModel;
   import dreamlandChallenge.view.logicView.award.DCSpeedMatchAwardView;
   import dreamlandChallenge.view.mornui.ranking.DCSpeedMatchRankingViewUI;
   import flash.events.Event;
   import morn.core.components.Component;
   import morn.core.handlers.Handler;
   
   public class DCSpeedMatchRankingView extends DCSpeedMatchRankingViewUI
   {
      
      private static const PAGE_SIZE:int = 5;
       
      
      private var _curSelectedIndex:int;
      
      private var _curPageNum:int = -1;
      
      private var _rankModel:DreamLandModel;
      
      private var _control:DreamlandChallengeControl;
      
      private var _selfRank:int = 0;
      
      public function DCSpeedMatchRankingView(mode:DreamLandModel)
      {
         _rankModel = mode;
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         rank_table.text1.text = LanguageMgr.GetTranslation("ddt.dreamLand.view.text6");
         rank_table.text2.text = LanguageMgr.GetTranslation("ddt.dreamLand.view.text7");
         rank_table.text3.text = LanguageMgr.GetTranslation("ddt.dreamLand.view.text8");
         rank_table.text4.text = LanguageMgr.GetTranslation("ddt.dreamLand.view.text9");
         rank_table.text5.text = LanguageMgr.GetTranslation("ddt.dreamLand.view.text10");
         btn_close.clickHandler = new Handler(__closeView);
         tab_ranking.selectedIndex = 0;
         tab_ranking.selectHandler = new Handler(__changeTableHandler);
         rank_table.page_change.selectHandler = new Handler(__changePageHandler);
         if(_rankModel)
         {
            _rankModel.addEventListener("refreshRanking",__refreshRankingHandler);
         }
         rank_table.rank_list.renderHandler = new Handler(__listRankRender);
         btn_award.clickHandler = new Handler(__openAward);
      }
      
      private function __refreshRankingHandler(evt:Event) : void
      {
         _selfRank = _rankModel.rankModel.selfRanking;
         var rankInfo:DCSpeedMatchRankMode = _rankModel.rankModel;
         var len:int = rankInfo.rankItems.length;
         rank_table.page_change.maxPage = rankInfo.totalPage;
         rank_table.rank_list.array = rankInfo.rankItems;
      }
      
      private function __openAward() : void
      {
         SoundManager.instance.playButtonSound();
         var awardView:DCSpeedMatchAwardView = new DCSpeedMatchAwardView(_control);
         awardView.show();
      }
      
      private function __changePageHandler(index:int) : void
      {
         SoundManager.instance.playButtonSound();
         if(_curPageNum == index)
         {
            return;
         }
         _curPageNum = index;
         requestData();
      }
      
      private function __listRankRender(item:Component, index:int) : void
      {
         var render:DCRankingItemView = item as DCRankingItemView;
         render.rowIndex = index;
         if(index < rank_table.rank_list.length)
         {
            render.info = rank_table.rank_list.array[index];
         }
         else
         {
            render.info = null;
         }
      }
      
      private function __changeTableHandler(index:int) : void
      {
         _curSelectedIndex = index;
         _curPageNum = -1;
         rank_table.page_change.currentPage = 1;
      }
      
      private function requestData() : void
      {
         if(_control)
         {
            _control.getRankData(_curPageNum,_curSelectedIndex + 1);
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
      
      public function set control(ctrl:DreamlandChallengeControl) : void
      {
         _control = ctrl;
      }
      
      override public function dispose() : void
      {
         if(_rankModel)
         {
            _rankModel.removeEventListener("refreshRanking",__refreshRankingHandler);
         }
         _rankModel = null;
         _control = null;
         super.dispose();
      }
   }
}
