package team.view.main
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import morn.core.handlers.Handler;
   import road7th.utils.DateUtils;
   import team.model.TeamInvitedMemberInfo;
   import team.view.mornui.item.TeamGovernInviteItemUI;
   
   public class TeamGovernInviteItem extends TeamGovernInviteItemUI
   {
       
      
      private var _info:TeamInvitedMemberInfo;
      
      public function TeamGovernInviteItem()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         btn_close.clickHandler = new Handler(__onClickClose);
         btn_right.clickHandler = new Handler(__onClickRight);
      }
      
      public function set info(value:TeamInvitedMemberInfo) : void
      {
         _info = value;
         btn_close.visible = _info != null;
         btn_right.visible = _info != null && PlayerManager.Instance.Self.teamDuty == 1;
         label_date.visible = _info != null;
         label_name.visible = _info != null;
         if(_info)
         {
            label_name.textType = !!_info.isVip?2:1;
            label_name.text = _info.name;
            label_date.text = DateUtils.dateFormat6(_info.date);
         }
      }
      
      public function get info() : TeamInvitedMemberInfo
      {
         return _info;
      }
      
      private function __onClickClose() : void
      {
         SoundManager.instance.playButtonSound();
         var tip:String = LanguageMgr.GetTranslation("team.govern.repeal",_info.name);
         var alertFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),tip,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1,null,"SimpleAlert",60,false);
         alertFrame.addEventListener("response",__onAlertRepeal);
      }
      
      private function __onAlertRepeal(e:FrameEvent) : void
      {
         var alertFrame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alertFrame.removeEventListener("response",__onAlertRepeal);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            SocketManager.Instance.out.sendTeamInviteRepeal(_info.id);
         }
         alertFrame.dispose();
      }
      
      private function __onClickRight() : void
      {
         SoundManager.instance.playButtonSound();
         var tip:String = LanguageMgr.GetTranslation("team.govern.ratify",_info.name);
         var alertFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),tip,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1,null,"SimpleAlert",60,false);
         alertFrame.addEventListener("response",__onAlertRatify);
      }
      
      private function __onAlertRatify(e:FrameEvent) : void
      {
         var alertFrame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alertFrame.removeEventListener("response",__onAlertRatify);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            SocketManager.Instance.out.sendTeamInviteApproval(_info.id);
         }
         alertFrame.dispose();
      }
   }
}
