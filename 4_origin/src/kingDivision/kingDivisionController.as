package kingDivision
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import kingDivision.view.KingDivisionFrame;
   
   public class kingDivisionController extends EventDispatcher
   {
      
      private static var _instance:kingDivisionController;
       
      
      public var _kingDivFrame:KingDivisionFrame;
      
      public function kingDivisionController(pct:PrivateClass)
      {
         super();
      }
      
      public static function get Instance() : kingDivisionController
      {
         if(kingDivisionController._instance == null)
         {
            kingDivisionController._instance = new kingDivisionController(new PrivateClass());
         }
         return kingDivisionController._instance;
      }
      
      public function setup() : void
      {
         KingDivisionManager.Instance.addEventListener("kingdivision_openframe",__onKingDivisionOpenFrame);
         KingDivisionManager.Instance.addEventListener("matcharearankinfo",__onMatchAreaRankInfo);
         KingDivisionManager.Instance.addEventListener("matcharearank",__onMatchAreaRank);
         KingDivisionManager.Instance.addEventListener("matchrank",__onMatchRank);
         KingDivisionManager.Instance.addEventListener("matchscore",__onMatchScore);
         KingDivisionManager.Instance.addEventListener("matchinfo",__onMatchInfo);
         KingDivisionManager.Instance.addEventListener("searchResult",__onSearchResult);
      }
      
      private function __onSearchResult(evt:Event) : void
      {
         if(_kingDivFrame != null && _kingDivFrame.rankingRoundView != null)
         {
            _kingDivFrame.rankingRoundView.zone = 0;
         }
      }
      
      private function __onMatchInfo(evt:Event) : void
      {
         if(_kingDivFrame != null)
         {
            if(_kingDivFrame.qualificationsFrame != null)
            {
               _kingDivFrame.qualificationsFrame.cancelMatch();
               _kingDivFrame.qualificationsFrame.updateMessage(KingDivisionManager.Instance.points,KingDivisionManager.Instance.gameNum);
            }
            else if(_kingDivFrame.rankingRoundView != null)
            {
               _kingDivFrame.rankingRoundView.cancelMatch();
               _kingDivFrame.rankingRoundView.updateMessage(KingDivisionManager.Instance.points,KingDivisionManager.Instance.gameNum);
            }
         }
      }
      
      private function __onMatchScore(evt:Event) : void
      {
         if(_kingDivFrame != null && _kingDivFrame.qualificationsFrame != null)
         {
            _kingDivFrame.qualificationsFrame.updateConsortiaMessage();
         }
      }
      
      private function __onMatchRank(evt:Event) : void
      {
         if(_kingDivFrame != null && _kingDivFrame.rankingRoundView != null)
         {
            _kingDivFrame.rankingRoundView.zone = 0;
         }
      }
      
      private function __onMatchAreaRank(evt:Event) : void
      {
         if(_kingDivFrame != null && _kingDivFrame.qualificationsFrame != null)
         {
            _kingDivFrame.qualificationsFrame.updateConsortiaMessage();
         }
      }
      
      private function __onMatchAreaRankInfo(evt:Event) : void
      {
         if(_kingDivFrame != null && _kingDivFrame.rankingRoundView != null)
         {
            _kingDivFrame.rankingRoundView.zone = 1;
         }
      }
      
      private function __onKingDivisionOpenFrame(evt:Event) : void
      {
         _kingDivFrame = ComponentFactory.Instance.creatComponentByStylename("kingdivision.frame");
         LayerManager.Instance.addToLayer(_kingDivFrame,3,true,1);
      }
   }
}

class PrivateClass
{
    
   
   function PrivateClass()
   {
      super();
   }
}
