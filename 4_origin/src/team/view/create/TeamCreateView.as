package team.view.create
{
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import morn.core.handlers.Handler;
   import team.TeamManager;
   import team.view.mornui.TeamCreateViewUI;
   
   public class TeamCreateView extends TeamCreateViewUI
   {
       
      
      public function TeamCreateView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         btn_create.clickHandler = new Handler(__onClickCreate);
         btn_rank.clickHandler = new Handler(__onClickRank);
      }
      
      private function __onClickRank() : void
      {
         SoundManager.instance.playButtonSound();
         TeamManager.instance.showTeamRankFrame();
      }
      
      private function __onClickCreate() : void
      {
         SoundManager.instance.playButtonSound();
         var _loc1_:TeamCreateInfoView = new TeamCreateInfoView();
         PositionUtils.setPos(_loc1_,"team.create.infoViewPos");
         LayerManager.Instance.addToLayer(_loc1_,3,false,1);
      }
   }
}
