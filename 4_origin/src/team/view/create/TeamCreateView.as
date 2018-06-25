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
         var createInfoView:TeamCreateInfoView = new TeamCreateInfoView();
         PositionUtils.setPos(createInfoView,"team.create.infoViewPos");
         LayerManager.Instance.addToLayer(createInfoView,3,false,1);
      }
   }
}
