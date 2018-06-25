package uigeneral.team
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import morn.core.handlers.Handler;
   import team.TeamManager;
   import team.event.TeamEvent;
   import team.model.TeamInfo;
   import uigeneral.mornui.TeamInviteViewUI;
   
   public class TeamInviteView extends TeamInviteViewUI
   {
       
      
      private var _info:TeamInfo;
      
      private var _userID:int;
      
      private var _teamID:int;
      
      public function TeamInviteView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         btn_esc.clickHandler = new Handler(__onClickEsc);
         TeamManager.instance.addEventListener("updateteaminfo",__onUpdateTeamInfo);
         teamText1.text = LanguageMgr.GetTranslation("ddt.team.allView.text56");
         teamText2.text = LanguageMgr.GetTranslation("ddt.team.allView.text51");
         teamText3.text = LanguageMgr.GetTranslation("ddt.team.allView.text52");
         teamText4.text = LanguageMgr.GetTranslation("ddt.team.allView.text53");
         teamText5.text = LanguageMgr.GetTranslation("ddt.team.allView.text54");
         teamText6.text = LanguageMgr.GetTranslation("ddt.team.allView.text55");
         teamText7.text = LanguageMgr.GetTranslation("ddt.team.allView.text50");
      }
      
      private function __onUpdateTeamInfo(e:TeamEvent) : void
      {
         if(_teamID == int(e.data))
         {
            _info = TeamManager.instance.model.getTeamInfoByID(_teamID);
            if(_info)
            {
               clip_division.index = _info.division;
               label_count.text = _info.totalTime.toString();
               label_level.text = "Lv." + _info.grade;
               label_name.text = _info.name;
               label_num.text = _info.member + "/" + _info.totalMember;
               label_rank.text = getLastSeasonInfo(_info.season - 1);
               label_rate.text = _info.rate;
               label_tag.text = _info.tag;
            }
         }
      }
      
      private function getLastSeasonInfo(season:int) : String
      {
         var i:int = 0;
         var data:* = null;
         for(i = 0; i < _info.seasonInfo.length; )
         {
            data = String(_info.seasonInfo[i]).split(",");
            if(data.length > 1 && int(data[0]) == season)
            {
               return LanguageMgr.GetTranslation("team.invite.honor",data[0],data[1]);
            }
            i++;
         }
         return LanguageMgr.GetTranslation("team.invite.nothonor");
      }
      
      private function __onClickEsc() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      public function update(userID:int, teamID:int) : void
      {
         _userID = userID;
         _teamID = teamID;
         SocketManager.Instance.out.sendTeamGetInfo(_teamID);
      }
      
      override public function dispose() : void
      {
         TeamManager.instance.removeEventListener("updateteaminfo",__onUpdateTeamInfo);
         super.dispose();
      }
   }
}
