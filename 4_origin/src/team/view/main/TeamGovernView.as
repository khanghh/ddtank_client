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
      
      private function __onUpdateFriendList(e:Event) : void
      {
         updateFriendList();
      }
      
      private function __onRenderFriend(item:Box, index:int) : void
      {
         var player:* = null;
         var name:NameTextEx = item.getChildByName("name") as NameTextEx;
         var bg:Clip = item.getChildByName("bg") as Clip;
         var btn:Button = item.getChildByName("invite") as Button;
         btn.label = LanguageMgr.GetTranslation("ddt.team.allView.text35");
         bg.index = index % 2;
         if(index < list_friend.array.length)
         {
            player = list_friend.array[index] as FriendListPlayer;
            name.textType = !!player.IsVIP?2:1;
            name.text = player.NickName;
            btn.visible = player.playerState.StateID != 0;
            btn.disabled = _invite.hasKey(player.ID);
         }
         else
         {
            name.text = "";
            btn.visible = false;
         }
      }
      
      private function __onSelectFriend(index:int) : void
      {
         SoundManager.instance.playButtonSound();
         var box:Component = list_friend.selection;
         var button:Button = box.getChildByName("invite") as Button;
         button.disabled = true;
         _invite.add((list_friend.array[index] as FriendListPlayer).ID,true);
         var player:FriendListPlayer = list_friend.array[index] as FriendListPlayer;
         SocketManager.Instance.out.sendTeamInvite(player.ID);
      }
      
      private function __onRenderInvite(item:Box, index:int) : void
      {
         var view:TeamGovernInviteItem = item as TeamGovernInviteItem;
         if(index < list_invite.array.length)
         {
            view.info = list_invite.array[index] as TeamInvitedMemberInfo;
         }
         else
         {
            view.info = null;
         }
      }
      
      private function __onRenderMember(item:Box, index:int) : void
      {
         var info:* = null;
         var name:NameTextEx = item.getChildByName("name") as NameTextEx;
         var date:Label = item.getChildByName("date") as Label;
         var btn:Button = item.getChildByName("close") as Button;
         var img:Image = item.getChildByName("img_captain") as Image;
         if(index < list_member.array.length)
         {
            info = list_member.array[index] as TeamMemberInfo;
            btn.visible = !info.isSelf && PlayerManager.Instance.Self.teamDuty == 1;
            name.textType = !!info.IsVIP?2:1;
            name.text = info.NickName;
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
            btn.visible = false;
            name.text = "";
            date.text = "";
            img.visible = false;
         }
      }
      
      private function __onSelectMember(index:int) : void
      {
         SoundManager.instance.playButtonSound();
         var info:TeamMemberInfo = list_member.array[list_member.selectedIndex] as TeamMemberInfo;
         var tip:String = LanguageMgr.GetTranslation("team.govern.expel",info.NickName);
         var alertFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),tip,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1,null,"SimpleAlert",60,false);
         alertFrame.addEventListener("response",__onAlertExpel);
      }
      
      private function __onAlertExpel(e:FrameEvent) : void
      {
         var info:* = null;
         var alertFrame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alertFrame.removeEventListener("response",__onAlertExpel);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            info = list_member.array[list_member.selectedIndex] as TeamMemberInfo;
            if(info)
            {
               SocketManager.Instance.out.sendTeamExpeleMember(info.ID);
            }
         }
         alertFrame.dispose();
      }
      
      protected function __onUpdateTeamInfo(event:TeamEvent) : void
      {
         updateView();
      }
      
      protected function __onUpdateMmeber(event:TeamEvent) : void
      {
         label_current.text = "（" + TeamManager.instance.model.selfTeamMember.length + "）";
         updateMemberList();
      }
      
      protected function __onUpdateInvite(event:TeamEvent) : void
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
         var info:TeamInfo = TeamManager.instance.model.selfTeamInfo;
         if(info)
         {
            clip_division.index = info.division;
            label_name.text = info.name;
            label_tag.text = "(" + info.tag + ")";
            label_grade.text = "lv." + info.grade;
            label_createDate.text = LanguageMgr.GetTranslation("team.main.createDate",DateUtils.dateFormat6(info.createDate));
            label_count.text = LanguageMgr.GetTranslation("team.active.member",info.member,info.totalMember);
            ex_time.count = info.totalTime;
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
         var list:Array = TeamManager.instance.model.selfTeamMember.concat();
         var sort:int = 18;
         list.sortOn(["OffLineHour","day","minute"],[sort,sort,sort]);
         list_member.array = list.reverse();
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
