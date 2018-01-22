package team.view.main
{
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import morn.core.components.Box;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.ex.NameTextEx;
   import morn.core.handlers.Handler;
   import road7th.utils.DateUtils;
   import team.TeamManager;
   import team.event.TeamEvent;
   import team.model.TeamBattleSegmentInfo;
   import team.model.TeamInfo;
   import team.model.TeamLevelInfo;
   import team.model.TeamMemberInfo;
   import team.view.mornui.TeamInfoViewUI;
   
   public class TeamInfoView extends TeamInfoViewUI
   {
       
      
      public function TeamInfoView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         btn_chat.clickHandler = new Handler(__onClickChat);
         btn_chat.label = LanguageMgr.GetTranslation("ddt.team.allView.text41");
         btn_exit.clickHandler = new Handler(__onClickExit);
         btn_exit.label = LanguageMgr.GetTranslation("ddt.team.allView.text40");
         btn_fight.clickHandler = new Handler(__onClickFight);
         list_member.renderHandler = new Handler(__onRenderMemeber);
         updateMemberLit();
         TeamManager.instance.addEventListener("updateteaminfo",__onUpdateTeamInfo);
         TeamManager.instance.addEventListener("updateteammember",__onUpdateMmeber);
         createHelpTips();
         teamText1.text = LanguageMgr.GetTranslation("ddt.team.allView.text14");
         teamText2.text = LanguageMgr.GetTranslation("ddt.team.allView.text37");
         teamText3.text = LanguageMgr.GetTranslation("ddt.team.allView.text38");
         teamText4.text = LanguageMgr.GetTranslation("ddt.team.allView.text39");
      }
      
      private function createHelpTips() : void
      {
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc1_:* = null;
         var _loc3_:String = LanguageMgr.GetTranslation("team.main.buffTip1") + "\n";
         var _loc4_:Array = TeamManager.instance.model.teamLevelList.list.concat();
         _loc4_.sortOn("Level",16);
         _loc7_ = 0;
         while(_loc7_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc7_] as TeamLevelInfo;
            _loc3_ = _loc3_ + (LanguageMgr.GetTranslation("team.main.buffTip2",_loc2_.Level,_loc2_.BuffParam,_loc2_.BuffTwoParam) + "\n");
            _loc7_++;
         }
         btn_helpTips.tipData = _loc3_;
         var _loc5_:String = LanguageMgr.GetTranslation("team.main.divisionTip") + "\n";
         _loc6_ = 1;
         while(_loc6_ <= 5)
         {
            _loc1_ = TeamManager.instance.model.getTeamBattleSegmentInfo(_loc6_);
            if(_loc1_)
            {
               _loc5_ = _loc5_ + (LanguageMgr.GetTranslation("team.main.divisionTip" + _loc6_,_loc1_.NeedScore) + "\n");
            }
            _loc6_++;
         }
         btn_fight.tipData = _loc5_;
      }
      
      protected function __onUpdateTeamInfo(param1:TeamEvent) : void
      {
         update();
      }
      
      protected function __onUpdateMmeber(param1:TeamEvent) : void
      {
         updateMemberLit();
      }
      
      private function updateMemberLit() : void
      {
         var _loc2_:Array = TeamManager.instance.model.selfTeamMember.concat();
         var _loc1_:int = 18;
         _loc2_.sortOn(["OffLineHour","day","minute"],[_loc1_,_loc1_,_loc1_]);
         list_member.array = _loc2_.reverse();
      }
      
      private function __onRenderMemeber(param1:Box, param2:int) : void
      {
         var _loc8_:* = null;
         var _loc3_:NameTextEx = param1.getChildByName("name") as NameTextEx;
         var _loc5_:Label = param1.getChildByName("score") as Label;
         var _loc6_:Label = param1.getChildByName("active") as Label;
         var _loc7_:Label = param1.getChildByName("date") as Label;
         var _loc4_:Image = param1.getChildByName("img_captain") as Image;
         if(param2 < list_member.array.length)
         {
            _loc8_ = list_member.array[param2] as TeamMemberInfo;
            _loc3_.textType = _loc8_ && _loc8_.IsVIP?2:1;
            _loc3_.text = _loc8_.NickName;
            _loc5_.text = _loc8_.teamSocre.toString();
            _loc6_.text = _loc8_.totalActiveScore.toString();
            if(_loc8_.teamDuty == 1)
            {
               _loc4_.visible = true;
            }
            else
            {
               _loc4_.visible = false;
            }
            if(_loc8_.playerState.StateID != 0)
            {
               _loc7_.text = LanguageMgr.GetTranslation("tank.view.im.IMFriendList.online");
            }
            else if(_loc8_.playerState.StateID == 0)
            {
               if(_loc8_.OffLineHour == -1)
               {
                  _loc7_.text = _loc8_.minute + LanguageMgr.GetTranslation("minute");
               }
               else if(_loc8_.OffLineHour >= 1 && _loc8_.OffLineHour < 24)
               {
                  _loc7_.text = _loc8_.OffLineHour + LanguageMgr.GetTranslation("hour");
               }
               else if(_loc8_.OffLineHour >= 24 && _loc8_.OffLineHour < 720)
               {
                  _loc7_.text = _loc8_.day + LanguageMgr.GetTranslation("day");
               }
               else if(_loc8_.OffLineHour >= 720 && _loc8_.OffLineHour < 999)
               {
                  _loc7_.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberInfoItem.month");
               }
               else
               {
                  _loc7_.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberInfoItem.long");
               }
            }
         }
         else
         {
            _loc3_.text = "";
            _loc5_.text = "";
            _loc6_.text = "";
            _loc7_.text = "";
            _loc4_.visible = false;
         }
      }
      
      protected function __onClickExit() : void
      {
         SoundManager.instance.playButtonSound();
         var _loc1_:TeamQuitView = new TeamQuitView();
         PositionUtils.setPos(_loc1_,"team.main.quitViewPos");
         LayerManager.Instance.addToLayer(_loc1_,3,false,1);
      }
      
      protected function __onClickFight() : void
      {
         SoundManager.instance.playButtonSound();
         TeamManager.instance.showTeamBattleFrame();
      }
      
      protected function __onClickChat() : void
      {
         SoundManager.instance.playButtonSound();
         IMManager.Instance.alertTeamChatFrame(PlayerManager.Instance.Self.teamID);
      }
      
      public function update() : void
      {
         var _loc1_:TeamInfo = TeamManager.instance.model.selfTeamInfo;
         if(_loc1_)
         {
            clip_division.index = _loc1_.division;
            clip_divisionBig.index = _loc1_.division;
            clip_divisionTitle.index = _loc1_.division;
            clip_divisionEffect.index = _loc1_.division;
            label_name.text = _loc1_.name;
            label_tag.text = "(" + _loc1_.tag + ")";
            label_grade.text = "lv." + _loc1_.grade;
            label_createDate.text = LanguageMgr.GetTranslation("team.main.createDate",DateUtils.dateFormat6(_loc1_.createDate));
            label_score.text = _loc1_.socre.toString();
            label_rate.text = _loc1_.rate;
            ex_member.count = _loc1_.totalTime;
            progress_grade.tipData = _loc1_.active + "/" + _loc1_.maxActive;
            progress_grade.value = _loc1_.exp;
            progress_grade.label = int(_loc1_.exp * 10000) / 100 + "%";
            label_tag.x = label_name.x + label_name.width + 5;
            label_grade.x = label_tag.x + label_tag.width + 5;
            progress_grade.x = label_grade.x + label_grade.width + 5;
            btn_helpTips.x = progress_grade.x + progress_grade.width + 5;
         }
      }
      
      override public function dispose() : void
      {
         TeamManager.instance.removeEventListener("updateteaminfo",__onUpdateTeamInfo);
         TeamManager.instance.removeEventListener("updateteammember",__onUpdateMmeber);
         super.dispose();
      }
   }
}
