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
         btn_CaptainTransfer.label = LanguageMgr.GetTranslation("ddt.team.mainView.text1");
         btn_chat.clickHandler = new Handler(__onClickChat);
         btn_chat.label = LanguageMgr.GetTranslation("ddt.team.allView.text41");
         btn_exit.clickHandler = new Handler(__onClickExit);
         btn_exit.label = LanguageMgr.GetTranslation("ddt.team.allView.text40");
         btn_fight.clickHandler = new Handler(__onClickFight);
         list_member.renderHandler = new Handler(__onRenderMemeber);
         btn_CaptainTransfer.clickHandler = new Handler(__onClickCaptainTransfer);
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
         var i:int = 0;
         var levelInfo:* = null;
         var j:int = 0;
         var divisionInfo:* = null;
         var buffTips:String = LanguageMgr.GetTranslation("team.main.buffTip1") + "\n";
         var buffList:Array = TeamManager.instance.model.teamLevelList.list.concat();
         buffList.sortOn("Level",16);
         for(i = 0; i < buffList.length; )
         {
            levelInfo = buffList[i] as TeamLevelInfo;
            buffTips = buffTips + (LanguageMgr.GetTranslation("team.main.buffTip2",levelInfo.Level,levelInfo.BuffParam,levelInfo.BuffTwoParam) + "\n");
            i++;
         }
         btn_helpTips.tipData = buffTips;
         var levelTips:String = LanguageMgr.GetTranslation("team.main.divisionTip") + "\n";
         for(j = 1; j <= 5; )
         {
            divisionInfo = TeamManager.instance.model.getTeamBattleSegmentInfo(j);
            if(divisionInfo)
            {
               levelTips = levelTips + (LanguageMgr.GetTranslation("team.main.divisionTip" + j,divisionInfo.NeedScore) + "\n");
            }
            j++;
         }
         btn_fight.tipData = levelTips;
      }
      
      protected function __onUpdateTeamInfo(event:TeamEvent) : void
      {
         update();
      }
      
      protected function __onUpdateMmeber(event:TeamEvent) : void
      {
         updateMemberLit();
      }
      
      private function updateMemberLit() : void
      {
         var list:Array = TeamManager.instance.model.selfTeamMember.concat();
         var sort:int = 18;
         list.sortOn(["OffLineHour","day","minute"],[sort,sort,sort]);
         list_member.array = list.reverse();
      }
      
      private function __onClickCaptainTransfer() : void
      {
         SoundManager.instance.playButtonSound();
         var frame:TeamCaptainTransferView = new TeamCaptainTransferView();
         PositionUtils.setPos(frame,"team.info.captainTransferPos");
         LayerManager.Instance.addToLayer(frame,3,false,1);
      }
      
      private function __onRenderMemeber(item:Box, index:int) : void
      {
         var info:* = null;
         var name:NameTextEx = item.getChildByName("name") as NameTextEx;
         var score:Label = item.getChildByName("score") as Label;
         var active:Label = item.getChildByName("active") as Label;
         var date:Label = item.getChildByName("date") as Label;
         var img:Image = item.getChildByName("img_captain") as Image;
         if(index < list_member.array.length)
         {
            info = list_member.array[index] as TeamMemberInfo;
            name.textType = info && info.IsVIP?2:1;
            name.text = info.NickName;
            score.text = info.teamSocre.toString();
            active.text = info.totalActiveScore.toString();
            if(info.teamDuty == 1)
            {
               img.visible = true;
            }
            else
            {
               img.visible = false;
            }
            if(info.playerState.StateID != 0)
            {
               date.text = LanguageMgr.GetTranslation("tank.view.im.IMFriendList.online");
            }
            else if(info.playerState.StateID == 0)
            {
               if(info.OffLineHour == -1)
               {
                  date.text = info.minute + LanguageMgr.GetTranslation("minute");
               }
               else if(info.OffLineHour >= 1 && info.OffLineHour < 24)
               {
                  date.text = info.OffLineHour + LanguageMgr.GetTranslation("hour");
               }
               else if(info.OffLineHour >= 24 && info.OffLineHour < 720)
               {
                  date.text = info.day + LanguageMgr.GetTranslation("day");
               }
               else if(info.OffLineHour >= 720 && info.OffLineHour < 999)
               {
                  date.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberInfoItem.month");
               }
               else
               {
                  date.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberInfoItem.long");
               }
            }
         }
         else
         {
            name.text = "";
            score.text = "";
            active.text = "";
            date.text = "";
            img.visible = false;
         }
      }
      
      protected function __onClickExit() : void
      {
         SoundManager.instance.playButtonSound();
         var view:TeamQuitView = new TeamQuitView();
         PositionUtils.setPos(view,"team.main.quitViewPos");
         LayerManager.Instance.addToLayer(view,3,false,1);
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
         var info:TeamInfo = TeamManager.instance.model.selfTeamInfo;
         if(info)
         {
            clip_division.index = info.division;
            clip_divisionBig.index = info.division;
            clip_divisionTitle.index = info.division;
            clip_divisionEffect.index = info.division;
            label_name.text = info.name;
            label_tag.text = "(" + info.tag + ")";
            label_grade.text = "lv." + info.grade;
            label_createDate.text = LanguageMgr.GetTranslation("team.main.createDate",DateUtils.dateFormat6(info.createDate));
            label_score.text = info.socre.toString();
            label_rate.text = info.rate;
            ex_member.count = info.totalTime;
            progress_grade.tipData = info.active + "/" + info.maxActive;
            progress_grade.value = info.exp;
            progress_grade.label = int(info.exp * 10000) / 100 + "%";
            label_tag.x = label_name.x + label_name.width + 5;
            label_grade.x = label_tag.x + label_tag.width + 5;
            progress_grade.x = label_grade.x + label_grade.width + 5;
            btn_helpTips.x = progress_grade.x + progress_grade.width + 5;
            btn_CaptainTransfer.visible = PlayerManager.Instance.Self.teamDuty == 1;
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
