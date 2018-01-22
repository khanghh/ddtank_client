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
         var _loc1_:Number = TimeManager.Instance.NowTime() - PlayerManager.Instance.Self.teamLoginDate.time;
         if(86400000 > _loc1_)
         {
            updateLoginTime(86400000 - _loc1_);
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
         var _loc1_:TeamDonateView = new TeamDonateView();
         PositionUtils.setPos(_loc1_,"team.active.donatePos");
         LayerManager.Instance.addToLayer(_loc1_,3,false,1);
      }
      
      protected function __onTimer(param1:TimerEvent) : void
      {
         var _loc2_:Number = TimeManager.Instance.NowTime() - PlayerManager.Instance.Self.teamLoginDate.time;
         if(86400000 > _loc2_)
         {
            updateLoginTime(86400000 - _loc2_);
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
      
      private function updateLoginTime(param1:Number) : void
      {
         var _loc5_:int = param1 / 3600000;
         var _loc2_:int = (param1 - _loc5_ * 3600000) / 60 / 1000;
         var _loc4_:int = (param1 - _loc5_ * 3600000 - _loc2_ * 60000) / 1000;
         var _loc6_:String = _loc5_ < 10?"0" + _loc5_:_loc5_.toString();
         var _loc7_:String = _loc2_ < 10?"0" + _loc2_:_loc2_.toString();
         var _loc3_:String = _loc4_ < 10?"0" + _loc4_:_loc4_.toString();
         label_date.text = _loc6_ + ":" + _loc7_ + ":" + _loc3_;
      }
      
      private function __onClickActiveAlert() : void
      {
         SoundManager.instance.playButtonSound();
         var _loc1_:TeamActiveAlertView = new TeamActiveAlertView();
         PositionUtils.setPos(_loc1_,"team.active.alertPos");
         LayerManager.Instance.addToLayer(_loc1_,3,false,1);
      }
      
      private function __onRenderMemeber(param1:Box, param2:int) : void
      {
         var _loc6_:* = null;
         var _loc3_:NameTextEx = param1.getChildByName("name") as NameTextEx;
         var _loc5_:Label = param1.getChildByName("active") as Label;
         var _loc4_:Image = param1.getChildByName("img_captain") as Image;
         if(param2 < list_member.array.length)
         {
            _loc6_ = list_member.array[param2] as TeamMemberInfo;
            _loc3_.textType = _loc6_ && _loc6_.IsVIP?2:1;
            _loc3_.text = _loc6_.NickName;
            _loc5_.text = _loc6_.weekActiveScore.toString();
            if(_loc6_.teamDuty == 1)
            {
               _loc4_.visible = true;
            }
            else
            {
               _loc4_.visible = false;
            }
         }
         else
         {
            _loc3_.text = "";
            _loc5_.text = "";
            _loc4_.visible = false;
         }
      }
      
      private function __onRenderActive(param1:Box, param2:int) : void
      {
         var _loc3_:Label = param1.getChildByName("label") as Label;
         if(param2 < list_active.array.length)
         {
            _loc3_.htmlText = convertString(list_active.array[param2]);
         }
         else
         {
            _loc3_.text = "";
         }
      }
      
      private function convertString(param1:String) : String
      {
         var _loc2_:* = param1;
         _loc2_ = _loc2_.replace("<tc1>","<font color=\'#FFFFFF\'/>");
         _loc2_ = _loc2_.replace("</tc1>","</font>");
         _loc2_ = _loc2_.replace("<tc2>","<font color=\'#FFD701\'/>");
         _loc2_ = _loc2_.replace("</tc2>","</font>");
         return _loc2_;
      }
      
      protected function __onUpdateTeamInfo(param1:TeamEvent) : void
      {
         updateView();
      }
      
      protected function __onUpdateMmeber(param1:TeamEvent) : void
      {
         updateMemeberList();
      }
      
      protected function __onUpdateActive(param1:TeamEvent) : void
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
         var _loc1_:TeamInfo = TeamManager.instance.model.selfTeamInfo;
         if(_loc1_)
         {
            clip_division.index = _loc1_.division;
            label_name.text = _loc1_.name;
            label_tag.text = "(" + _loc1_.tag + ")";
            label_grade.text = "lv." + _loc1_.grade;
            label_createDate.text = LanguageMgr.GetTranslation("team.main.createDate",DateUtils.dateFormat6(_loc1_.createDate));
            label_count.text = LanguageMgr.GetTranslation("team.active.member",_loc1_.member,_loc1_.totalMember);
            ex_active.count = _loc1_.totalActive;
            progress_grade.tipData = _loc1_.active + "/" + _loc1_.maxActive;
            progress_grade.value = _loc1_.exp;
            progress_grade.label = int(_loc1_.exp * 10000) / 100 + "%";
            label_tag.x = label_name.x + label_name.width + 5;
            label_grade.x = label_tag.x + label_tag.width + 5;
            progress_grade.x = label_grade.x + label_grade.width + 5;
         }
      }
      
      private function updateMemeberList() : void
      {
         var _loc1_:Array = TeamManager.instance.model.selfTeamMember.concat();
         _loc1_.sortOn("weekActiveScore",16 | 2);
         list_member.array = _loc1_;
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
