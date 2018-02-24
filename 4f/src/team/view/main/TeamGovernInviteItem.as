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
      
      public function TeamGovernInviteItem(){super();}
      
      override protected function initialize() : void{}
      
      public function set info(param1:TeamInvitedMemberInfo) : void{}
      
      public function get info() : TeamInvitedMemberInfo{return null;}
      
      private function __onClickClose() : void{}
      
      private function __onAlertRepeal(param1:FrameEvent) : void{}
      
      private function __onClickRight() : void{}
      
      private function __onAlertRatify(param1:FrameEvent) : void{}
   }
}
