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
      
      private function __onUpdateTeamInfo(param1:TeamEvent) : void
      {
         if(_teamID == int(param1.data))
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
      
      private function getLastSeasonInfo(param1:int) : String
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _info.seasonInfo.length)
         {
            _loc2_ = String(_info.seasonInfo[_loc3_]).split(",");
            if(_loc2_.length > 1 && int(_loc2_[0]) == param1)
            {
               return LanguageMgr.GetTranslation("team.invite.honor",_loc2_[0],_loc2_[1]);
            }
            _loc3_++;
         }
         return LanguageMgr.GetTranslation("team.invite.nothonor");
      }
      
      private function __onClickEsc() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      public function update(param1:int, param2:int) : void
      {
         _userID = param1;
         _teamID = param2;
         SocketManager.Instance.out.sendTeamGetInfo(_teamID);
      }
      
      override public function dispose() : void
      {
         TeamManager.instance.removeEventListener("updateteaminfo",__onUpdateTeamInfo);
         super.dispose();
      }
   }
}
