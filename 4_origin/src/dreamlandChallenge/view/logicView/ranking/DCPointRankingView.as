package dreamlandChallenge.view.logicView.ranking
{
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import dreamlandChallenge.DreamlandChallengeControl;
   import dreamlandChallenge.data.DCSpeedMatchRankMode;
   import dreamlandChallenge.data.DreamLandModel;
   import dreamlandChallenge.view.logicView.award.DCPointAwardView;
   import dreamlandChallenge.view.logicView.shop.DCPointShopView;
   import dreamlandChallenge.view.mornui.ranking.DCPointRankingViewUI;
   import flash.events.Event;
   import morn.core.components.Component;
   import morn.core.handlers.Handler;
   
   public class DCPointRankingView extends DCPointRankingViewUI
   {
       
      
      private var _rankModel:DreamLandModel;
      
      private var _curPageNum:int = -1;
      
      private var _control:DreamlandChallengeControl;
      
      public function DCPointRankingView(mode:DreamLandModel)
      {
         _rankModel = mode;
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         text1.text = LanguageMgr.GetTranslation("ddt.dreamLand.view.text6");
         text2.text = LanguageMgr.GetTranslation("ddt.dreamLand.view.text7");
         text3.text = LanguageMgr.GetTranslation("ddt.dreamLand.view.text8");
         text4.text = LanguageMgr.GetTranslation("ddt.dreamLand.view.text11");
         btn_close.clickHandler = new Handler(__closeView);
         btn_award.clickHandler = new Handler(__openAward);
         btn_shop.clickHandler = new Handler(__openShop);
         if(_rankModel)
         {
            _rankModel.addEventListener("refreshRanking",__refreshRankingHandler);
         }
         page_change.selectHandler = new Handler(__changePageHandler);
         rank_list.renderHandler = new Handler(__listRankRender);
      }
      
      private function __refreshRankingHandler(evt:Event) : void
      {
         var rankInfo:DCSpeedMatchRankMode = _rankModel.rankModel;
         var len:int = rankInfo.rankItems.length;
         page_change.maxPage = rankInfo.totalPage;
         rank_list.array = rankInfo.rankItems;
      }
      
      private function __listRankRender(item:Component, index:int) : void
      {
         var render:DCPointRankingItemView = item as DCPointRankingItemView;
         render.rowIndex = index;
         if(index < rank_list.length)
         {
            render.info = rank_list.array[index];
         }
         else
         {
            render.info = null;
         }
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
      
      private function requestData() : void
      {
         if(_control)
         {
            _control.getRankData(_curPageNum,5);
         }
      }
      
      public function set control(ctrl:DreamlandChallengeControl) : void
      {
         _control = ctrl;
      }
      
      private function __closeView() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      private function __openAward() : void
      {
         SoundManager.instance.playButtonSound();
         var awardView:DCPointAwardView = new DCPointAwardView(_control);
         awardView.show();
      }
      
      private function __openShop() : void
      {
         var shopView:DCPointShopView = new DCPointShopView(_rankModel);
         shopView.show();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override public function dispose() : void
      {
         if(_rankModel)
         {
            _rankModel.removeEventListener("refreshRanking",__refreshRankingHandler);
         }
         super.dispose();
         _control = null;
         _rankModel = null;
      }
   }
}
