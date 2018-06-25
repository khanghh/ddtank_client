package dreamlandChallenge.view.mornui.ranking
{
   import dreamlandChallenge.view.logicView.ranking.DCPointRankingItemView;
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.View;
   import morn.core.ex.PageNavigaterEx;
   
   public class DCPointRankingViewUI extends View
   {
       
      
      public var btn_close:Button = null;
      
      public var btn_award:Button = null;
      
      public var btn_shop:Button = null;
      
      public var text1:Label = null;
      
      public var text2:Label = null;
      
      public var text3:Label = null;
      
      public var text4:Label = null;
      
      public var rank_list:List = null;
      
      public var page_change:PageNavigaterEx = null;
      
      public function DCPointRankingViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["dreamlandChallenge.view.logicView.ranking.DCPointRankingItemView"] = DCPointRankingItemView;
         super.createChildren();
         loadUI("ranking/DCPointRankingView.xml");
      }
   }
}