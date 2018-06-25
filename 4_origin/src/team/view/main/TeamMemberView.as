package team.view.main
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import morn.core.components.Box;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.ex.NameTextEx;
   import morn.core.handlers.Handler;
   import team.TeamManager;
   import team.model.TeamMemberInfo;
   import team.view.mornui.TeamMemberViewUI;
   
   public class TeamMemberView extends TeamMemberViewUI
   {
       
      
      private const NAME:int = 1;
      
      private const RANK:int = 2;
      
      private const SESSION:int = 3;
      
      private const TOTAL_ACTIVE:int = 4;
      
      private const WEEK_ACTIVE:int = 5;
      
      private const DATE:int = 6;
      
      private var _sortType:int;
      
      private const SORT_ARRAY:int = 18;
      
      private var _memberList:Array;
      
      public function TeamMemberView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         list_member.renderHandler = new Handler(__onRenderMemeber);
         TeamManager.instance.addEventListener("updateteammember",__onUpdateMmeber);
         socreBtn.clickHandler = new Handler(__onClickScore);
         sessionBtn.clickHandler = new Handler(__onClickSession);
         memberBtn.clickHandler = new Handler(__onClickMember);
         totalActiveBtn.clickHandler = new Handler(__onClickTotalActive);
         weekActiveBtn.clickHandler = new Handler(__onClickWeekActive);
         dateBtn.clickHandler = new Handler(__onClickDate);
         memberBtn.label = LanguageMgr.GetTranslation("ddt.team.allView.text43");
         socreBtn.label = LanguageMgr.GetTranslation("ddt.team.allView.text37");
         sessionBtn.label = LanguageMgr.GetTranslation("ddt.team.allView.text42");
         totalActiveBtn.label = LanguageMgr.GetTranslation("ddt.team.allView.text44");
         weekActiveBtn.label = LanguageMgr.GetTranslation("ddt.team.allView.text15");
         dateBtn.label = LanguageMgr.GetTranslation("ddt.team.allView.text39");
      }
      
      protected function __onUpdateMmeber(event:Event) : void
      {
         update();
      }
      
      private function __onRenderMemeber(item:Box, index:int) : void
      {
         var info:* = null;
         var name:NameTextEx = item.getChildByName("name") as NameTextEx;
         var score:Label = item.getChildByName("score") as Label;
         var time:Label = item.getChildByName("time") as Label;
         var totalActive:Label = item.getChildByName("totalActive") as Label;
         var weekActive:Label = item.getChildByName("weekActive") as Label;
         var date:Label = item.getChildByName("date") as Label;
         var img:Image = item.getChildByName("img_captain") as Image;
         if(index < list_member.array.length)
         {
            info = list_member.array[index] as TeamMemberInfo;
            name.textType = info && info.IsVIP?2:1;
            name.text = info.NickName;
            score.text = info.teamSocre.toString();
            time.text = info.totalTiems.toString();
            totalActive.text = info.seasonActiveScore.toString();
            weekActive.text = info.weekActiveScore.toString();
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
            time.text = "";
            totalActive.text = "";
            weekActive.text = "";
            date.text = "";
            img.visible = false;
         }
      }
      
      public function update() : void
      {
         _sortType = -1;
         sort(5);
      }
      
      private function __onClickMember() : void
      {
         SoundManager.instance.playButtonSound();
         sort(1);
      }
      
      private function __onClickScore() : void
      {
         SoundManager.instance.playButtonSound();
         sort(2);
      }
      
      private function __onClickSession() : void
      {
         SoundManager.instance.playButtonSound();
         sort(3);
      }
      
      private function __onClickTotalActive() : void
      {
         SoundManager.instance.playButtonSound();
         sort(4);
      }
      
      private function __onClickWeekActive() : void
      {
         SoundManager.instance.playButtonSound();
         sort(5);
      }
      
      private function __onClickDate() : void
      {
         SoundManager.instance.playButtonSound();
         sort(6);
      }
      
      private function sort(type:int) : void
      {
         if(_sortType == type)
         {
            _memberList = _memberList.reverse();
         }
         else
         {
            _sortType = type;
            _memberList = TeamManager.instance.model.selfTeamMember.concat();
            switch(int(_sortType) - 1)
            {
               case 0:
                  _memberList.sortOn("NickName");
                  break;
               case 1:
                  _memberList.sortOn("teamSocre",18);
                  break;
               case 2:
                  _memberList.sortOn("totalTiems",18);
                  break;
               case 3:
                  _memberList.sortOn("totalActiveScore",18);
                  break;
               case 4:
                  _memberList.sortOn("weekActiveScore",18);
                  break;
               case 5:
                  _memberList.sortOn(["OffLineHour","day","minute"],[18,18,18]);
            }
         }
         list_member.array = _memberList;
      }
      
      override public function dispose() : void
      {
         TeamManager.instance.removeEventListener("updateteammember",__onUpdateMmeber);
         super.dispose();
      }
   }
}
