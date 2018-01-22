package team.view.main
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.data.player.FriendListPlayer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import morn.core.components.Box;
   import morn.core.components.Button;
   import morn.core.components.Clip;
   import morn.core.components.Component;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.ex.NameTextEx;
   import morn.core.handlers.Handler;
   import road7th.data.DictionaryData;
   import road7th.utils.DateUtils;
   import team.TeamManager;
   import team.event.TeamEvent;
   import team.model.TeamInfo;
   import team.model.TeamInvitedMemberInfo;
   import team.model.TeamMemberInfo;
   import team.view.mornui.TeamGovernViewUI;
   
   public class TeamGovernView extends TeamGovernViewUI
   {
       
      
      private var _invite:DictionaryData;
      
      public function TeamGovernView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         _invite = new DictionaryData();
         list_friend.renderHandler = new Handler(__onRenderFriend);
         list_friend.selectHandler = new Handler(__onSelectFriend);
         btn_online.clickHandler = new Handler(__onSelectOnline);
         btn_online.label = LanguageMgr.GetTranslation("ddt.team.allView.text36");
         list_member.renderHandler = new Handler(__onRenderMember);
         list_member.selectHandler = new Handler(__onSelectMember);
         TeamManager.instance.addEventListener("updateteaminfo",__onUpdateTeamInfo);
         TeamManager.instance.addEventListener("updateteammember",__onUpdateMmeber);
         TeamManager.instance.addEventListener("updateinvitelist",__onUpdateInvite);
         PlayerManager.Instance.addEventListener("friendListComplete",__onUpdateFriendList);
         list_invite.renderHandler = new Handler(__onRenderInvite);
         teamText1.text = LanguageMgr.GetTranslation("ddt.team.allView.text33");
         teamText2.text = LanguageMgr.GetTranslation("ddt.team.allView.text34");
      }
      
      private function __onSelectOnline() : void
      {
         SoundManager.instance.playButtonSound();
         updateFriendList();
      }
      
      private function __onUpdateFriendList(param1:Event) : void
      {
         updateFriendList();
      }
      
      private function __onRenderFriend(param1:Box, param2:int) : void
      {
         var _loc4_:* = null;
         var _loc5_:NameTextEx = param1.getChildByName("name") as NameTextEx;
         var _loc6_:Clip = param1.getChildByName("bg") as Clip;
         var _loc3_:Button = param1.getChildByName("invite") as Button;
         _loc3_.label = LanguageMgr.GetTranslation("ddt.team.allView.text35");
         _loc6_.index = param2 % 2;
         if(param2 < list_friend.array.length)
         {
            _loc4_ = list_friend.array[param2] as FriendListPlayer;
            _loc5_.textType = !!_loc4_.IsVIP?2:1;
            _loc5_.text = _loc4_.NickName;
            _loc3_.visible = _loc4_.playerState.StateID != 0;
            _loc3_.disabled = _invite.hasKey(_loc4_.ID);
         }
         else
         {
            _loc5_.text = "";
            _loc3_.visible = false;
         }
      }
      
      private function __onSelectFriend(param1:int) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc4_:Component = list_friend.selection;
         var _loc3_:Button = _loc4_.getChildByName("invite") as Button;
         _loc3_.disabled = true;
         _invite.add((list_friend.array[param1] as FriendListPlayer).ID,true);
         var _loc2_:FriendListPlayer = list_friend.array[param1] as FriendListPlayer;
         SocketManager.Instance.out.sendTeamInvite(_loc2_.ID);
      }
      
      private function __onRenderInvite(param1:Box, param2:int) : void
      {
         var _loc3_:TeamGovernInviteItem = param1 as TeamGovernInviteItem;
         if(param2 < list_invite.array.length)
         {
            _loc3_.info = list_invite.array[param2] as TeamInvitedMemberInfo;
         }
         else
         {
            _loc3_.info = null;
         }
      }
      
      private function __onRenderMember(param1:Box, param2:int) : void
      {
         var _loc7_:* = null;
         var _loc4_:NameTextEx = param1.getChildByName("name") as NameTextEx;
         var _loc6_:Label = param1.getChildByName("date") as Label;
         var _loc3_:Button = param1.getChildByName("close") as Button;
         var _loc5_:Image = param1.getChildByName("img_captain") as Image;
         if(param2 < list_member.array.length)
         {
            _loc7_ = list_member.array[param2] as TeamMemberInfo;
            _loc3_.visible = !_loc7_.isSelf && PlayerManager.Instance.Self.teamDuty == 1;
            _loc4_.textType = !!_loc7_.IsVIP?2:1;
            _loc4_.text = _loc7_.NickName;
            if(_loc7_.teamDuty == 1)
            {
               _loc5_.visible = true;
            }
            else
            {
               _loc5_.visible = false;
            }
            if(_loc7_.playerState.StateID != 0)
            {
               _loc6_.text = LanguageMgr.GetTranslation("tank.view.im.IMFriendList.online");
            }
            else if(_loc7_.playerState.StateID == 0)
            {
               if(_loc7_.OffLineHour == -1)
               {
                  _loc6_.text = _loc7_.minute + LanguageMgr.GetTranslation("minute");
               }
               else if(_loc7_.OffLineHour >= 1 && _loc7_.OffLineHour < 24)
               {
                  _loc6_.text = _loc7_.OffLineHour + LanguageMgr.GetTranslation("hour");
               }
               else if(_loc7_.OffLineHour >= 24 && _loc7_.OffLineHour < 720)
               {
                  _loc6_.text = _loc7_.day + LanguageMgr.GetTranslation("day");
               }
               else if(_loc7_.OffLineHour >= 720 && _loc7_.OffLineHour < 999)
               {
                  _loc6_.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberInfoItem.month");
               }
               else
               {
                  _loc6_.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberInfoItem.long");
               }
            }
         }
         else
         {
            _loc3_.visible = false;
            _loc4_.text = "";
            _loc6_.text = "";
            _loc5_.visible = false;
         }
      }
      
      private function __onSelectMember(param1:int) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc4_:TeamMemberInfo = list_member.array[list_member.selectedIndex] as TeamMemberInfo;
         var _loc3_:String = LanguageMgr.GetTranslation("team.govern.expel",_loc4_.NickName);
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc3_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1,null,"SimpleAlert",60,false);
         _loc2_.addEventListener("response",__onAlertExpel);
      }
      
      private function __onAlertExpel(param1:FrameEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onAlertExpel);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            _loc3_ = list_member.array[list_member.selectedIndex] as TeamMemberInfo;
            if(_loc3_)
            {
               SocketManager.Instance.out.sendTeamExpeleMember(_loc3_.ID);
            }
         }
         _loc2_.dispose();
      }
      
      protected function __onUpdateTeamInfo(param1:TeamEvent) : void
      {
         updateView();
      }
      
      protected function __onUpdateMmeber(param1:TeamEvent) : void
      {
         label_current.text = "（" + TeamManager.instance.model.selfTeamMember.length + "）";
         updateMemberList();
      }
      
      protected function __onUpdateInvite(param1:TeamEvent) : void
      {
         label_invite.text = "（" + TeamManager.instance.model.selfTeamInviteList.length + "）";
         list_invite.array = TeamManager.instance.model.selfTeamInviteList;
         updateFriendList();
      }
      
      public function update() : void
      {
         SocketManager.Instance.out.sendTeamGetInviteList(PlayerManager.Instance.Self.teamID);
         updateFriendList();
         updateMemberList();
         updateView();
      }
      
      private function updateView() : void
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
            ex_time.count = _loc1_.totalTime;
            label_invite.text = "（" + TeamManager.instance.model.selfTeamInviteList.length + "）";
            label_current.text = "（" + TeamManager.instance.model.selfTeamMember.length + "）";
            label_tag.x = label_name.x + label_name.width + 5;
            label_grade.x = label_tag.x + label_tag.width + 5;
         }
      }
      
      private function updateFriendList() : void
      {
         if(btn_online.selected)
         {
            list_friend.array = TeamManager.instance.model.teamFriendListOnline;
         }
         else
         {
            list_friend.array = TeamManager.instance.model.teamFriendList;
         }
      }
      
      private function updateMemberList() : void
      {
         var _loc2_:Array = TeamManager.instance.model.selfTeamMember.concat();
         var _loc1_:int = 18;
         _loc2_.sortOn(["OffLineHour","day","minute"],[_loc1_,_loc1_,_loc1_]);
         list_member.array = _loc2_.reverse();
      }
      
      override public function dispose() : void
      {
         _invite.clear();
         _invite = null;
         TeamManager.instance.removeEventListener("updateteaminfo",__onUpdateTeamInfo);
         TeamManager.instance.removeEventListener("updateteammember",__onUpdateMmeber);
         TeamManager.instance.removeEventListener("updateinvitelist",__onUpdateInvite);
         PlayerManager.Instance.removeEventListener("friendListComplete",__onUpdateFriendList);
         super.dispose();
      }
   }
}
