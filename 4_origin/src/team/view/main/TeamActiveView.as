package team.view.main
{
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import morn.core.components.Box;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.ex.NameTextEx;
   import morn.core.handlers.Handler;
   import road7th.utils.DateUtils;
   import team.TeamManager;
   import team.event.TeamEvent;
   import team.model.TeamInfo;
   import team.model.TeamMemberInfo;
   import team.view.mornui.TeamActiveViewUI;
   
   public class TeamActiveView extends TeamActiveViewUI
   {
       
      
      private var _timer:Timer;
      
      public function TeamActiveView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         btn_memberTips.tipData = LanguageMgr.GetTranslation("team.active.memberTips");
         list_member.renderHandler = new Handler(__onRenderMemeber);
         list_active.renderHandler = new Handler(__onRenderActive);
         btn_donate.clickHandler = new Handler(__onClickDonate);
         btn_activeAlert.clickHandler = new Handler(__onClickActiveAlert);
         TeamManager.instance.addEventListener("updateteaminfo",__onUpdateTeamInfo);
         TeamManager.instance.addEventListener("updateteammember",__onUpdateMmeber);
         TeamManager.instance.addEventListener("updateactivelist",__onUpdateActive);
         var time:Number = TimeManager.Instance.NowTime() - PlayerManager.Instance.Self.teamLoginDate.time;
         if(86400000 > time)
         {
            updateLoginTime(86400000 - time);
            label_date.tipData = LanguageMgr.GetTranslation("team.active.dateTips");
            label_date.visible = true;
            _timer = new Timer(1000);
            _timer.addEventListener("timer",__onTimer);
            _timer.start();
         }
         teamText1.text = LanguageMgr.GetTranslation("ddt.team.allView.text14");
         teamText2.text = LanguageMgr.GetTranslation("ddt.team.allView.text15");
      }
      
      private function __onClickDonate() : void
      {
         SoundManager.instance.playButtonSound();
         var view:TeamDonateView = new TeamDonateView();
         PositionUtils.setPos(view,"team.active.donatePos");
         LayerManager.Instance.addToLayer(view,3,false,1);
      }
      
      protected function __onTimer(event:TimerEvent) : void
      {
         var time:Number = TimeManager.Instance.NowTime() - PlayerManager.Instance.Self.teamLoginDate.time;
         if(86400000 > time)
         {
            updateLoginTime(86400000 - time);
         }
         else
         {
            label_date.visible = false;
            label_date.text = "";
            _timer.stop();
            _timer.removeEventListener("timer",__onTimer);
            _timer = null;
         }
      }
      
      private function updateLoginTime(time:Number) : void
      {
         var hours:int = time / 3600000;
         var min:int = (time - hours * 3600000) / 60 / 1000;
         var sec:int = (time - hours * 3600000 - min * 60000) / 1000;
         var hourss:String = hours < 10?"0" + hours:hours.toString();
         var mins:String = min < 10?"0" + min:min.toString();
         var secs:String = sec < 10?"0" + sec:sec.toString();
         label_date.text = hourss + ":" + mins + ":" + secs;
      }
      
      private function __onClickActiveAlert() : void
      {
         SoundManager.instance.playButtonSound();
         var frame:TeamActiveAlertView = new TeamActiveAlertView();
         PositionUtils.setPos(frame,"team.active.alertPos");
         LayerManager.Instance.addToLayer(frame,3,false,1);
      }
      
      private function __onRenderMemeber(item:Box, index:int) : void
      {
         var info:* = null;
         var name:NameTextEx = item.getChildByName("name") as NameTextEx;
         var active:Label = item.getChildByName("active") as Label;
         var img:Image = item.getChildByName("img_captain") as Image;
         if(index < list_member.array.length)
         {
            info = list_member.array[index] as TeamMemberInfo;
            name.textType = info && info.IsVIP?2:1;
            name.text = info.NickName;
            active.text = info.weekActiveScore.toString();
            if(info.teamDuty == 1)
            {
               img.visible = true;
            }
            else
            {
               img.visible = false;
            }
         }
         else
         {
            name.text = "";
            active.text = "";
            img.visible = false;
         }
      }
      
      private function __onRenderActive(item:Box, index:int) : void
      {
         var label:Label = item.getChildByName("label") as Label;
         if(index < list_active.array.length)
         {
            label.htmlText = convertString(list_active.array[index]);
         }
         else
         {
            label.text = "";
         }
      }
      
      private function convertString(value:String) : String
      {
         var str:* = value;
         str = str.replace("<tc1>","<font color=\'#FFFFFF\'/>");
         str = str.replace("</tc1>","</font>");
         str = str.replace("<tc2>","<font color=\'#FFD701\'/>");
         str = str.replace("</tc2>","</font>");
         return str;
      }
      
      protected function __onUpdateTeamInfo(event:TeamEvent) : void
      {
         updateView();
      }
      
      protected function __onUpdateMmeber(event:TeamEvent) : void
      {
         updateMemeberList();
      }
      
      protected function __onUpdateActive(e:TeamEvent) : void
      {
         list_active.array = TeamManager.instance.model.selfTeamActiveList.reverse();
      }
      
      public function update() : void
      {
         SocketManager.Instance.out.sendTeamGetActive(PlayerManager.Instance.Self.teamID);
         updateMemeberList();
         updateView();
      }
      
      public function updateView() : void
      {
         var info:TeamInfo = TeamManager.instance.model.selfTeamInfo;
         if(info)
         {
            clip_division.index = info.division;
            label_name.text = info.name;
            label_tag.text = "(" + info.tag + ")";
            label_grade.text = "lv." + info.grade;
            label_createDate.text = LanguageMgr.GetTranslation("team.main.createDate",DateUtils.dateFormat6(info.createDate));
            label_count.text = LanguageMgr.GetTranslation("team.active.member",info.member,info.totalMember);
            ex_active.count = info.totalActive;
            progress_grade.tipData = info.active + "/" + info.maxActive;
            progress_grade.value = info.exp;
            progress_grade.label = int(info.exp * 10000) / 100 + "%";
            label_tag.x = label_name.x + label_name.width + 5;
            label_grade.x = label_tag.x + label_tag.width + 5;
            progress_grade.x = label_grade.x + label_grade.width + 5;
         }
      }
      
      private function updateMemeberList() : void
      {
         var list:Array = TeamManager.instance.model.selfTeamMember.concat();
         list.sortOn("weekActiveScore",16 | 2);
         list_member.array = list;
      }
      
      override public function dispose() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimer);
            _timer = null;
         }
         TeamManager.instance.removeEventListener("updateteaminfo",__onUpdateTeamInfo);
         TeamManager.instance.removeEventListener("updateteammember",__onUpdateMmeber);
         TeamManager.instance.removeEventListener("updateactivelist",__onUpdateActive);
         super.dispose();
      }
   }
}
